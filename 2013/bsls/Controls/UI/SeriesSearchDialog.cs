#region Copyright (C) 1994-2009, Johnson & Johnson PRD, LLC.
//---------------------------------------------------------------------------*
//
//    SeriesSearchDialog.cs: Dialog to search for Series by name. 
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
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using System.Windows.Forms;
using Jnj.ThirdDimension.Base;
using Jnj.ThirdDimension.Util.UsageLog;
using Syncfusion.Windows.Forms.Grid;
using Jnj.ThirdDimension.Data;
using Jnj.ThirdDimension.Controls.Grid;
using Jnj.ThirdDimension.Data.BarcodeSeries;
using Jnj.ThirdDimension.Arms.Model;
using Jnj.ThirdDimension.Utils.BarcodeSeries;
using Jnj.ThirdDimension.BusinessLayer.BarcodeSeries;

namespace Jnj.ThirdDimension.Controls.BarcodeSeries
{
   /// <summary>
   /// Dialog to search for Series by name.
   /// </summary>
   public partial class SeriesSearchDialog : Form
   {
      private BSDataSet.SeriesDataTable seriesDT;
      private DataView gridDataView = new DataView();
      private SeriesDataLayer dataLayer;

      /// <summary>
      /// Initializes a new instance of the <see cref="SeriesSearchDialog"/> class.
      /// </summary>
      public SeriesSearchDialog()
      {
         InitializeComponent();
      }

      /// <summary>
      /// Initializes a new instance of the <see cref="SeriesSearchDialog"/> class.
      /// </summary>
      /// <param name="connInfo">The conn info.</param>
      /// <param name="searchFor">User's search input.</param>
      public SeriesSearchDialog(string searchFor, SeriesDataLayer dl)
         : this()
      {
         dataLayer = dl;
         PerformSearch(searchFor);
      }

      /// <summary>
      /// Performs the Label Series search.
      /// </summary>
      /// <param name="searchFor">The value to search for.</param>
      public void PerformSearch(string searchFor)
      {
         nameTextBoxExt.Text = searchFor;

         if (!string.IsNullOrEmpty(searchFor))
         {
            findButton_Click(null, EventArgs.Empty);
         }
      }

      /// <summary>
      /// Found and selected Label Series.
      /// </summary>
      public BSDataSet.SeriesDataTable Series
      {
         get { return seriesDT; }
      }

      /// <summary>
      /// An array of all the currently selected rows in the result DataTable.
      /// </summary>
      protected int[] SelectedRows
      {
         get
         {
            if (gridDataView.Count == 0)
               return new int[0];

            GridRangeInfoList gridRangeInfoList = gridDataBoundGrid.Selections.GetSelectedRows(false, true);

            int numSelectedRows = 0;

            foreach (GridRangeInfo gri in gridRangeInfoList)
            {
               int selectedRange;

               if (gri.RangeType == GridRangeInfoType.Table)
                  selectedRange = gridDataBoundGrid.Model.RowCount;
               else if (gri.RangeType == GridRangeInfoType.Rows)
                  selectedRange = gri.Height;
               else
                  continue;


               numSelectedRows += selectedRange;
            }

            int[] returnValue = new int[numSelectedRows];

            int currentRow = 0;
            foreach (GridRangeInfo gri in gridRangeInfoList)
            {
               if (gri.RangeType == GridRangeInfoType.Table)
               {
                  for (int i = 0; i < gridDataBoundGrid.Model.RowCount; i++)
                  {
                     returnValue[currentRow++] = i;
                  }
               }
               else if (gri.RangeType == GridRangeInfoType.Rows)
               {
                  for (int i = gri.Top; i <= gri.Bottom; i++)
                  {
                     returnValue[currentRow++] = i;
                  }
               }
            }

            return returnValue;
         }
      }

      /// <summary>
      /// Constructs a filter by Name column with typed text.
      /// </summary>
      /// <returns></returns>
      private string GetNameFilter()
      {
         string name = nameTextBoxExt.Text.Replace("'", "''");
         return string.Format("UPPER({0}) LIKE UPPER('{1}%')", dataLayer.DataSet.Series.NAMEColumn.ColumnName, name);
      }

      private bool IsSearchByUser
      {
         get
         {
            return (
                      !firstNameTextBox.Text.IsEmpty() ||
                      !lastNameTextBox.Text.IsEmpty() ||
                      !userNameTextBox.Text.IsEmpty() ||
                      !wwidTextBox.Text.IsEmpty()
                   );
         }
      }

      /// <summary>
      /// Handles the Click event of the findButton.
      /// </summary>
      /// <param name="sender">The source of the event.</param>
      /// <param name="e">The <see cref="System.EventArgs"/> instance containing the event data.</param>
      private void findButton_Click(object sender, EventArgs e)
      {
         using (new SmartCursor(Cursors.WaitCursor))
         using (dataLayer.Connect())
         {
            try
            {
               string filter = "";

               if (nameTextBoxExt.Text.Trim().Length > 0)
               {
                  filter = GetNameFilter();
               }
               
               if (IsSearchByUser)
               {
                  List<decimal> users = ArmsAccessor.Instance.GetPersonIds(
                     firstNameTextBox.Text, 
                     lastNameTextBox.Text, 
                     userNameTextBox.Text,
                     wwidTextBox.Text.ToNullablePrimitive<decimal>(decimal.TryParse)
                     );
                  filter = CreateUserFilter(filter, users);
               }

               BSDataSet.SeriesDataTable series = dataLayer.SeriesDB.GetSeries(filter);
               SeriesAccessor.AddTemplateColumn(series);

               gridDataBoundGrid.DataSource = null;

               gridDataView.BeginInit();
               gridDataView.Table = series;
               gridDataView.RowFilter = String.Empty;
               gridDataView.Sort = series.NAMEColumn.ColumnName;
               gridDataView.RowStateFilter = DataViewRowState.CurrentRows;
               gridDataView.EndInit();
               
               if (series.Rows.Count < 1)
               {
                  ConfirmationDialog.Show("Query did not return any records.", "Query Information",
                        MessageBoxButtons.OK, MessageBoxIcon.Information);
                  return;
               }

               gridDataBoundGrid.DataSource = gridDataView;
               GridHelper.FitColWidth(gridDataBoundGrid);

               tabControl.SelectedIndex = tabControl.TabPages.IndexOf(resultTabPage);
            }
            catch (Exception ex)
            {
               MessagesHelper.ReportError(ex, true);
            }
         }
      }

      private string CreateUserFilter(string filter, List<decimal> users)
      {
         string f = filter;
         f += filter.IsEmpty() ? "" : " AND ";
         f += Sql.MakeInList(users, dataLayer.DataSet.Series.OWNER_IDColumn.ColumnName);

         return f;
      }

      /// <summary>
      /// Handles the Click event of the resetButton control.
      /// </summary>
      /// <param name="sender">The source of the event.</param>
      /// <param name="e">The <see cref="System.EventArgs"/> instance containing the event data.</param>
      private void resetButton_Click(object sender, EventArgs e)
      {
         nameTextBoxExt.Text = string.Empty;
         gridDataBoundGrid.DataSource = null;
      }

      /// <summary>
      /// Handles the Click event of the okButton control.
      /// </summary>
      /// <param name="sender">The source of the event.</param>
      /// <param name="e">The <see cref="System.EventArgs"/> instance containing the event data.</param>
      private void okButton_Click(object sender, EventArgs e)
      {
         try
         {
            int[] selectedRows = SelectedRows;

            if (gridDataView.Count == 1)
            {
               int row = 0;
               seriesDT = gridDataView.Table.Clone() as BSDataSet.SeriesDataTable;
               if (seriesDT == null)
                  throw new ApplicationException("Grid DataSource is not of the expected type!");
               seriesDT.ImportRow(gridDataView[row].Row);
            }
            else if (selectedRows.Length == 0) // no rows were selected
            {
               seriesDT = null;
               string errorMessage = "You must select a single row or cell first.";

               ConfirmationDialog.Show(errorMessage, "Invalid Selection", MessageBoxButtons.OK, MessageBoxIcon.Exclamation);
               return;
            }
            else // some rows have been selected
            {
               if (selectedRows.Length > 1)
               {
                  seriesDT = null;

                  ConfirmationDialog.Show("Multiple selection is not allowed.", "Invalid Selection",
                                          MessageBoxButtons.OK, MessageBoxIcon.Exclamation);
                  return;
               }

               // If we've made it this far, it means that either:
               // a) only a single row is selected, or
               // b) multiple rows are selected, and AllowMultiSelect is true.
               // Either way, that's fine.

               seriesDT = gridDataView.Table.Clone() as BSDataSet.SeriesDataTable;
               if (seriesDT == null)
                  throw new ApplicationException("Grid DataSource is not of the expected type!");

               foreach (int selectedRow in selectedRows)
               {
                  seriesDT.ImportRow(gridDataView[selectedRow - 1].Row);
               }
            }

            DialogResult = DialogResult.OK;
            Close();
         }
         catch (Exception ex)
         {
            Reporter.ReportError(new ApplicationException("Error returning from Label Series Search.", ex), true);
         }
      }

      /// <summary>
      /// Handles the CurrentRecordChanged event of the gridRecordNavigationControl control.
      /// </summary>
      /// <param name="sender">The source of the event.</param>
      /// <param name="e">The <see cref="Syncfusion.Windows.Forms.CurrentRecordEventArgs"/> instance containing the event data.</param>
      private void gridRecordNavigationControl_CurrentRecordChanged(object sender, Syncfusion.Windows.Forms.CurrentRecordEventArgs e)
      {
         try
         {
            GridRecordNavigationControl grnc = sender as GridRecordNavigationControl;
            if (grnc != null)
            {
               if (grnc.CurrentRecord > grnc.MaxRecord)
               {
                  grnc.MaxLabel = "*";
               }
               else
               {
                  grnc.Label = (grnc.GridControl.Model.RowCount > 999) ? "Rec." : "Record";
                  grnc.MaxLabel = "of " + (grnc.GridControl.Model.RowCount - ((grnc.AllowAddNew) ? 1 : 0));
               }
            }
         }
         catch (Exception ex)
         {
            Reporter.ReportError(ex, true);
         }
      }

      /// <summary>
      /// Handles the Load event of the SeriesSearchDialog control.
      /// </summary>
      /// <param name="sender">The source of the event.</param>
      /// <param name="e">The <see cref="System.EventArgs"/> instance containing the event data.</param>
      private void SeriesSearch_Load(object sender, EventArgs e)
      {
         seriesDT = null;
         tabControl.SelectedIndex = (gridDataView.Count > 0)
                                       ? tabControl.TabPages.IndexOf(resultTabPage)
                                       : tabControl.TabPages.IndexOf(queryTabPage);
      }

      /// <summary>
      /// Handles the Click event of the cancel2Button control.
      /// </summary>
      /// <param name="sender">The source of the event.</param>
      /// <param name="e">The <see cref="System.EventArgs"/> instance containing the event data.</param>
      private void cancel2Button_Click(object sender, EventArgs e)
      {
         this.Close();
      }

   }
}
