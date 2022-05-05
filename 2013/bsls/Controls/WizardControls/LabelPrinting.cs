#region Copyright (C) 1994-2009, Johnson & Johnson PRD, LLC.
//---------------------------------------------------------------------------*
//
//    LabelPrinting.cs: User control for printing lables.
//
//---
//
//    Copyright (C) 1994-2009, Johnson & Johnson PRD, LLC.
//    All Rights Reserved.
//
//    Vitaly Chupaev, 11/2009
//
//---------------------------------------------------------------------------*/
#endregion

using System;
using System.Collections.Generic;
using System.Data;
using System.Windows.Forms;
using Jnj.Windows.Forms;
using Syncfusion.Windows.Forms.Grid;
using Jnj.ThirdDimension.Controls.Grid;
using Jnj.ThirdDimension.Instruments;
using System.Diagnostics;
using Jnj.ThirdDimension.Util.UsageLog;
using Jnj.ThirdDimension.Data;
using System.Net.Sockets;
using Jnj.ThirdDimension.Utils.BarcodeSeries;
using Jnj.ThirdDimension.Data.BarcodeSeries;
using Jnj.ThirdDimension.BusinessLayer.BarcodeSeries;
using Jnj.ThirdDimension.Controls.BarcodeSeries.Properties;
using Jnj.ThirdDimension.Util;
using System.IO;
using Jnj.ThirdDimension.Mt.Data;
using Jnj.ThirdDimension.Gt;
using Jnj.ThirdDimension.Mt.Chem;
using Jnj.ThirdDimension.Base;
using System.Linq;

namespace Jnj.ThirdDimension.Controls.BarcodeSeries
{

   /// <summary>
   /// This user interface allows to print labels with selected printer and template.
   /// </summary>
   public partial class LabelPrinting : BaseWizardControl
   {

      #region Private members

      private MapTemplateDialog mapper;   // Template mapping dialog
      private LabelPrintingController controller;   // Controller
      private DataTable dataSourceTable;   // grid datasource table
      private decimal lastPrinterId;   // stands for last connected printer ID
      private ICLBarcodePrinter lastPrinter;   // stands for last connected printer
      private GetSeriesDialog chooseColumn;   // Dialog to choose column for generated values
      private DataColumn barcodeColumn;   // Column used for generated barcodes
      private SeriesDataLayer dataLayer;
      
      private const int PRINT_DELAY = 500;
      private const string SHOW_ALL_COMMAND = "<Show all>";
      private const string GENERATE_COLUMN = "<Generate Column>";

      #endregion


      #region Constructor
      public LabelPrinting()
      {
         InitializeComponent();
      }

      #endregion

      #region Initialization

      /// <summary>
      /// Default initialization method.
      /// </summary>
      public override void Init(SeriesDataLayer dl)
      {
         controller = LabelPrintingController.CreateController(this);
         dataLayer = dl;
         chooseColumn = new GetSeriesDialog(dl);
         mapper = new MapTemplateDialog();

         LoadPrinters();
      }

      /// <summary>
      /// Sets grid data source.
      /// </summary>
      /// <param name="dataSource"></param>
      private void SetDataSource(DataTable dataSource)
      {
         dataSourceTable = dataSource;
         printGrid.SimpleGridBoundColumns.Clear();
         SetDataSource();
      }

      /// <summary>
      /// Sets grid data source.
      /// </summary>
      private void SetDataSource()
      {
         List<string> moleculeColumns = new List<string>();

         foreach (DataColumn col in DataSourceTable.Columns)
         {
            if (col.DataType == typeof(Mt.Chem.Molecule))
            {
               moleculeColumns.Add(col.ColumnName);
               AddStructureColumn(printGrid, col);
            }
            else if (col.DataType == typeof(PictureData))
            {
               AddPictureColumn(printGrid, col);
            }
            else
            {
               AddStringColumn(printGrid, col);
            }
         }

         foreach (string moleculeColumn in moleculeColumns)
         {
            string newName = "_" + moleculeColumn;
            dataSourceTable.Columns.Add(newName, typeof(string));
            dataSourceTable.AsEnumerable().Foreach(r => r[newName] = r[moleculeColumn]);
            dataSourceTable.Columns.Remove(moleculeColumn);
            dataSourceTable.Columns[newName].ColumnName = moleculeColumn;
         }

         printGrid.DataSource = null;
         printGrid.DataSource = DataSourceTable;

         EnableTemplates = (DataSourceTable.Rows.Count > 0);

         GridHelper.FitRowHColW(printGrid);
         printGrid.Refresh();

      }

      private void AddStringColumn(SimpleGrid printGrid, DataColumn col)
      {
         SimpleGridBoundColumn stringCol = new SimpleGridBoundColumn();
         stringCol.EnableFilter = true;
         stringCol.HeaderText = col.ColumnName;
         stringCol.MappingName = col.ColumnName;
         stringCol.StyleInfo.CellType = "TextBox";
         stringCol.StyleInfo.CellValueType = typeof(string);

         AddGridColumn(stringCol);
      }

      private void AddPictureColumn(SimpleGrid printGrid, DataColumn col)
      {
         PictureSimpleGridColumn picCol = new PictureSimpleGridColumn();
         picCol.EnableFilter = false;
         picCol.HeaderText = col.ColumnName;
         picCol.MappingName = col.ColumnName;
         picCol.StyleInfo.CellValueType = typeof(PictureData);

         AddGridColumn(picCol);
      }

      private void AddStructureColumn(SimpleGrid printGrid, DataColumn col)
      {
         
         StructureSimpleGridColumn strucCol = new StructureSimpleGridColumn();
         strucCol.EnableFilter = false;
         strucCol.HeaderText = col.ColumnName;
         strucCol.MappingName = col.ColumnName;
         strucCol.ReadOnly = false;
         strucCol.StyleInfo.CellValueType = typeof(string);

         AddGridColumn(strucCol);
      }


      private void AddGridColumn(SimpleGridBoundColumn column)
      {
         if (printGrid.SimpleGridBoundColumns.Contains(column.MappingName)) return;

         printGrid.SimpleGridBoundColumns.Add((SimpleGridBoundColumn)column);

         var iCol = column as ICustomGridColumn;
         if (iCol != null)
         {
            iCol.RegisterColumn();
         }
      }

      /// <summary>
      /// Loads printers from database.
      /// </summary>
      private void LoadPrinters()
      {
         LoadPrinters(true);
      }

      /// <summary>
      /// Loads printers from database.
      /// </summary>
      private void LoadPrinters(bool forUserSiteOnly)
      {
         printerComboBox.SelectedIndexChanged -= printerComboBox_SelectedIndexChanged;

         try
         {
            string[] printers = controller.GetPrintersList(forUserSiteOnly);
            if (forUserSiteOnly)
            {
               printers = controller.AddCommandRow(printers, SHOW_ALL_COMMAND);
            }

            printers = controller.AddCommandRow(printers, string.Empty, 0);

            printerComboBox.DataSource = printers;
            printerComboBox.SelectedIndex = 0;
         }
         finally
         {
            printerComboBox.SelectedIndexChanged += printerComboBox_SelectedIndexChanged;
         }

      }

      #endregion

      #region Accessors for controller

      /// <summary>
      /// Returns grid.
      /// </summary>
      public SimpleGrid Grid { get { return printGrid; } }

      /// <summary>
      /// Enable property of 'Choose template' button.
      /// </summary>
      public bool EnableTemplates
      {
         get { return templateButton.Enabled; }
         set { templateButton.Enabled = value; }
      }

      /// <summary>
      /// Gets or creates a table for grid DataSource.
      /// </summary>
      /// <returns></returns>
      public DataTable DataSourceTable
      {
         get
         {
            if (dataSourceTable == null)
            {
               dataSourceTable = new DataTable();
               SetDataSource();
            }

            return dataSourceTable;
         }
      }
      #endregion

      #region Stuff

      /// <summary>
      /// Returns instance of currently selected printer.
      /// </summary>
      private ICLBarcodePrinter BarcodePrinter
      {
         get
         {
            if (printerComboBox.SelectedItem == null) return null;

            string printerName = (string)printerComboBox.SelectedItem;
            PrinterAccessor pa = new PrinterAccessor(dataLayer);
            PrinterInfo p = pa.GetPrinterInfo(printerName);

            if (p == null) return null;

            if (p.Id != lastPrinterId)
            {
               lastPrinter = controller.InitializePrinter(p);
               lastPrinterId = p.Id;
            }
            return lastPrinter;
         }
      }

      /// <summary>
      /// Tries to connect to the printer and returns true on success and false on failure.
      /// </summary>
      internal bool IsBarcodePrinterAvailable
      {
         get
         {
            try
            {
               ICLBarcodePrinter p = BarcodePrinter;
               return p == null ? false : true;
            }
            catch
            {
               return false;
            }
         }
      }

      /// <summary>
      /// Returns selected printer's template name.
      /// </summary>
      private string Template
      {
         get { return templateComboBox.SelectedItem as string; }
      }

      public SeriesDataLayer DataLayer
      {
         get { return dataLayer; }
         set { dataLayer = value; }
      }

      #endregion


      #region Wizard methods and proprs

      /// <summary>
      /// Resets the form.
      /// </summary>
      public override void Reset()
      {
         printGrid.DataSource = null;
         printGrid.Binder.InternalColumns.Clear();
         printGrid.Model.Refresh();
         dataSourceTable = null;
         mapper = new MapTemplateDialog();
         templateComboBox.DataSource = null;
         templateComboBox.Text = string.Empty;
         templateComboBox.Enabled = true;
         templateButton.Enabled = false;
         lastPrinter = null;
         lastPrinterId = -1;
         barcodeColumn = null;
         chooseColumn = new GetSeriesDialog(dataLayer);

         if (printerComboBox.Items.Count > 0)
         {
            printerComboBox.SelectedIndex = 0;
         }

         recordNavigationControl1_CurrentRecordChanged(gridRecordNavigationControl1, null);
         printGrid.Refresh();
      }

      /// <summary>
      /// Imports data from csv file.
      /// </summary>
      public override void Import()
      {
         ImportEventArgs args = new ImportEventArgs();
         bool printerOn = IsBarcodePrinterAvailable;

         if (printerOn)
         {
            args.CurrentColumnsNames = BarcodePrinter.GetTemplateVariables(Template);
         }

         OnImportRequest(args);

         if (!args.Cancel)
         {
            var table = new DataTable();

            if (args.IsFileImport)
            {
               using (var stream = new StreamReader(args.FileName))
               {
                  CsvUtility.Load(stream, table, ',');
               }
            }
            else
            {
               table = args.Table;
            }

            SetDataSource(table);
            templateButton.Enabled = (templateComboBox.SelectedItem != null && dataSourceTable != null && dataSourceTable.Rows.Count > 0);
         }

         if (printerOn)
         {
            AutoMapTemplate();
         }
      }

      /// <summary>
      /// Saves data to csv file.
      /// </summary>
      public override bool Save()
      {
         if (dataSourceTable == null || dataSourceTable.Rows.Count == 0)
         {
            MessagesHelper.ShowInformation("Nothing to import.", WizardHelper.FindParentHeaderText(this));
            return false;
         }

         OnTdxExport(GetExportingArguments());
         MessagesHelper.ShowInformation("Data was successfully exported to 3DX.", WizardHelper.FindParentHeaderText(this));
         return true;
      }

      /// <summary>
      /// Prints labels.
      /// </summary>
      public void Print()
      {
         PrintAsIs();
      }

      /// <summary>
      /// Prints grid as is.
      /// </summary>
      private void PrintAsIs()
      {
         using (InstrumentLock il = new InstrumentLock(BarcodePrinter, 0))
         using (var progressDialog = WaitDialog("Printing barcodes", true))
         {
            ICLBarcodePrinter printer = BarcodePrinter;

            bool printed = true;
            int k = 1;

            foreach (DataRow row in DataSourceTable.Rows)
            {
               if (progressDialog.IsCancelled) break;

            PrintRow:

               SetProgressDialogTitle(progressDialog, row, k++);
               printed = printer.Print(il.ClientID, Template, controller.GetLabelValues(row, mapper.MappedColumns));
               //WaitForUser(PRINT_DELAY);

               if (!printed)
               {
                  DialogResult answer =
                     MessagesHelper.ShowWarningQuestion(GetPrintingErrorMessage(row),
                                                            WizardHelper.FindParentHeaderText(this),
                                                            MessageBoxButtons.AbortRetryIgnore);
                  bool ignoreChosen = false;

                  if (answer == DialogResult.Abort) return;
                  if (answer == DialogResult.Ignore && !ignoreChosen)
                  {
                     ignoreChosen = true;
                     continue;
                  }
                  if (answer == DialogResult.Retry) goto PrintRow;
               }
            }

            if (progressDialog.IsCancelled)
            {
               MessagesHelper.ShowInformation("The process was canceled by user.",
                                              WizardHelper.FindParentHeaderText(this));
            }
            else
            {
               MessagesHelper.ShowInformation("All records were successfully sent to printer.",
                                              WizardHelper.FindParentHeaderText(this));
            }
         }
      }

      private void SetProgressDialogTitle(AsynchronousWaitDialog progressDialog, DataRow row, int rowNum)
      {
         if (barcodeColumn != null)
         {
            progressDialog.TaskName = "Printing " + row[barcodeColumn].ToString();
         }
         else
         {
            progressDialog.TaskName = "Printing row #" + rowNum;
         }
      }

      /// <summary>
      /// Allows user to cancel printing, it doesn't really slow the process, because printer has a longer delay.
      /// </summary>
      /// <param name="delay"></param>
      private void WaitForUser(int delay)
      {
         System.Threading.Thread.Sleep(delay);
      }

      /// <summary>
      /// Clears the generated barcodes.
      /// </summary>
      private void ClearGeneratedBarcodes()
      {
         foreach (DataRow row in DataSourceTable.Rows)
         {
            if (row.Table.Columns.Contains(barcodeColumn.ColumnName))
            {
               row[barcodeColumn] = string.Empty;
            }
         }
      }

      /// <summary>
      /// Gets the printing error message.
      /// </summary>
      /// <param name="row">The source row for label.</param>
      /// <returns></returns>
      private string GetPrintingErrorMessage(DataRow row)
      {
         int k = DataSourceTable.Rows.IndexOf(row) + 1;
         return string.Format("Label for the row #{0}, was not printed.\r\nPress Abort to stop printing,\r\nRetry to try this label again,\r\nIgnore to ignore all errors and continue.", k);
      }

      /// <summary>
      /// Generates barcodes in specific field.
      /// </summary>
      public void GenerateBarcodes()
      {
         chooseColumn.SpecifyNumberOfValues = (DataSourceTable.DefaultView.Count == 0);

         if (DataSourceTable.Columns.Count > 0)
         {
            chooseColumn.DataSource = GetColumns(dataSourceTable.Columns);
            chooseColumn.DisplayMember = "ColumnName";

            if (barcodeColumn != null)
            {
               chooseColumn.SelectedColumn = barcodeColumn;
            }
         }

         chooseColumn.NumberOfValues = DataSourceTable.Rows.Count;
         if (chooseColumn.ShowDialog() == DialogResult.OK)
         {
            barcodeColumn = GetColumnForGeneration();

            using (WaitDialog("Generating new values"))
            {
               int valuesNum = chooseColumn.NumberOfValues;

               List<string> values = controller.GenerateSeriesValues(chooseColumn.SelectedSeries, valuesNum);

               for (int k = 0; k < valuesNum; k++)
               {
                  if (k >= dataSourceTable.Rows.Count)
                  {
                     dataSourceTable.Rows.Add(dataSourceTable.NewRow());
                  }
                  dataSourceTable.DefaultView[k][barcodeColumn.ColumnName] = values[k];
               }

               if (values.Count > 0 && templateComboBox.SelectedItem != null)
               {
                  templateButton.Enabled = true;
               }
            }

            GridHelper.FitRowHColW(printGrid);
         }
      }

      private DataColumn GetColumnForGeneration()
      {
         if (chooseColumn.SelectedColumn == null || chooseColumn.SelectedColumn.ColumnName == GENERATE_COLUMN)
         {
            if (!dataSourceTable.Columns.Contains(chooseColumn.NewColumnName))
            {
               DataSourceTable.Columns.Add(chooseColumn.NewColumnName, typeof(string));
            }
            return DataSourceTable.Columns[chooseColumn.NewColumnName];
         }
         else
         {
            return chooseColumn.SelectedColumn;
         }
      }


      /// <summary>
      /// Converts DataColumnCollection to List<DataColumn>
      /// </summary>
      /// <param name="dataColumnCollection"></param>
      /// <returns></returns>
      private List<DataColumn> GetColumns(DataColumnCollection dataColumnCollection)
      {
         List<DataColumn> cols = new List<DataColumn>(dataColumnCollection.Count + 1);
         cols.Add(new DataColumn(GENERATE_COLUMN));
         foreach (DataColumn column in dataColumnCollection)
         {
            cols.Add(column);
         }
         return cols;
      }

      /// <summary>
      /// Tries to do mapping of template and grid columns.
      /// </summary>
      /// <returns></returns>
      private void AutoMapTemplate()
      {
         if (templateComboBox.DataSource == null) return;

         mapper.LeftColumns = BarcodePrinter.GetTemplateVariables(Template);
         mapper.RightColumns = controller.GetColumnNamesForTemplateMapping();
         mapper.AutoMap();

         templateButton.Enabled = (templateComboBox.SelectedItem != null && dataSourceTable != null && dataSourceTable.Rows.Count > 0);

         if (mapper.MappedColumns.IsValid())
         {
            OnSomeWorkOccured(Work.EnablePrint);
         }
         else
         {
            OnSomeWorkOccured(Work.DisablePrint);
         }
      }

      #endregion

      #region Event handlers

      /// <summary>
      /// Handles the Click event of the templateButton control.
      /// </summary>
      /// <param name="sender">The source of the event.</param>
      /// <param name="e">The <see cref="System.EventArgs"/> instance containing the event data.</param>
      private void templateButton_Click(object sender, EventArgs e)
      {
         try
         {
            bool needRemap = mapper.MappedColumns != null && !mapper.MappedColumns.IsValid();
            needRemap |= mapper.RightColumns.Length != printGrid.Binder.InternalColumns.Count;

            if (needRemap)
            {
               mapper.LeftColumns = BarcodePrinter.GetTemplateVariables(Template);
               mapper.RightColumns = controller.GetColumnNamesForTemplateMapping();
               mapper.AutoMap();
            }

            mapper.ShowDialog();

            if (mapper.MappedColumns.IsValid())
            {
               OnSomeWorkOccured(Work.EnablePrint);
            }
         }
         catch (Exception ex)
         {
            MessagesHelper.ReportError(ex, true);
         }
      }


      /// <summary>
      /// Handles the SelectedIndexChanged event of the printerComboBox control.
      /// </summary>
      /// <param name="sender">The source of the event.</param>
      /// <param name="e">The <see cref="System.EventArgs"/> instance containing the event data.</param>
      private void printerComboBox_SelectedIndexChanged(object sender, EventArgs e)
      {
         try
         {
            string command = (string)printerComboBox.SelectedItem ?? string.Empty;
            if (command == SHOW_ALL_COMMAND)
            {
               LoadPrinters(false);
               printerComboBox.DroppedDown = true;

               templateComboBox.DataSource = null;
               templateButton.Enabled = false;
            }
            else if (BarcodePrinter != null)
            {
               if (BarcodePrinter.Templates != null)
               {
                  templateComboBox.DataSource = BarcodePrinter.Templates;
                  templateComboBox.Enabled = true;
               }
            }
         }
         catch (SocketException socketException)
         {
            templateButton.Enabled = false;
            templateComboBox.DataSource = null;
            templateComboBox.Enabled = false;
            templateComboBox.Text = "Printer is unavailable.";
            MessagesHelper.ReportError(socketException, false);
         }
         catch (Exception ex)
         {
            MessagesHelper.ReportError(ex, true);
         }
      }

      private void templateComboBox_SelectedIndexChanged(object sender, EventArgs e)
      {
         try
         {
            AutoMapTemplate();
         }
         catch (Exception ex)
         {
            MessagesHelper.ReportError(ex, true);
         }
      }

      /// <summary>
      /// Handles the CurrentRecordChanged event of the recordNavigationControl1 control.
      /// </summary>
      /// <param name="sender">The source of the event.</param>
      /// <param name="e">The <see cref="Syncfusion.Windows.Forms.CurrentRecordEventArgs"/> instance containing the event data.</param>
      private void recordNavigationControl1_CurrentRecordChanged(object sender, Syncfusion.Windows.Forms.CurrentRecordEventArgs e)
      {
         try
         {
            GridRecordNavigationControl grnc = sender as GridRecordNavigationControl;
            if (grnc != null)
            {
               WizardHelper.UpdateGridNavigationLabel(grnc);
            }
         }
         catch (Exception ex)
         {
            Reporter.ReportError(ex, true);
         }
      }

      #endregion

      #region Base methods implementation

      protected override BaseWizardControl.TdxExportEventArgs GetExportingArguments()
      {
         TdxExportEventArgs args = new TdxExportEventArgs
         {
            GridColumns = printGrid.Binder.InternalColumns,
            SourceTable = DataSourceTable,
            TdxViewName = "Print Labels"
         };

         return args;
      }

      #endregion

   }
}
