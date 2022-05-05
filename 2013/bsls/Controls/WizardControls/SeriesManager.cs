#region Copyright (C) 1994-2009, Johnson & Johnson PRD, LLC.
//---------------------------------------------------------------------------*
//
//    SeriesControl.cs: Control responsible for defining a Series.
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
using System.Drawing;
using System.Data;
using System.Text;
using System.Windows.Forms;
using Syncfusion.Windows.Forms.Tools;
using Syncfusion.Windows.Forms.Grid;
using Jnj.ThirdDimension.Data.BarcodeSeries;
using Jnj.ThirdDimension.Utils.BarcodeSeries;
using Jnj.ThirdDimension.BusinessLayer.BarcodeSeries;
using Jnj.ThirdDimension.Instruments;

namespace Jnj.ThirdDimension.Controls.BarcodeSeries
{
   /// <summary>
   /// Control responsible for defining a barcode range.
   /// The control does not depend on data layer or typed tables.
   /// </summary>
   public partial class SeriesManager : BaseWizardControl
   {

      #region Declarations

      private SeriesManagerController controller;
      private bool editMode;
      private DBSettingsDialog dbOptions;
      private SeriesDataLayer dataLayer;

      #endregion


      #region Initialization
      public SeriesManager()
      {
         InitializeComponent();

         reservationTabPage.Enabled = false;
      }

      #endregion


      #region Wizard integration

      /// <summary>
      /// Saves Label Series props to database.
      /// </summary>
      public override bool Save()
      {
         reservationGridDataBoundGrid.CurrentCell.ConfirmChanges();
         reservationGridDataBoundGrid.CurrentCell.EndEdit();
         reservationGridDataBoundGrid.Binder.EndEdit();

         string errorMessage = string.Empty;
         DBOptionsDialog.SeriesName = RangeName;
         SeriesDefinition sd = controller.GetSeriesDefinition();
         
         if (!controller.Validate(out errorMessage))
         {
            MessagesHelper.ShowError(errorMessage, WizardHelper.FindParentHeaderText(this));
            return false;
         }

         bool newRange = false;

         using (DataLayer.Connect())
         using (DataLayer.BeginTransaction())
         {
            try
            {
               // get label series info
               BSDataSet.SeriesDataTable lsdt = controller.GetSeriesDataTable(sd, out newRange);

               // commit label series
               DataLayer.SeriesDB.Commit(lsdt);
               
               // set Label_Series_Id
               if (newRange) controller.UpdateSeriesId(sd, ((BSDataSet.SeriesRow)lsdt.Rows[0]).ID);

               // prepare event info
               BSDataSet.SeriesEventDataTable events = controller.GetSeriesEventDataTable(sd);

               // commit event
               DataLayer.SeriesDB.Commit(events);

               // change series definition state, as it should be updated on next Save method call.
               sd.State = SeriesDefinition.RangeState.Update;

               // get reservations
               BSDataSet.ReservationDataTable reservations = (BSDataSet.ReservationDataTable)sd.ReservationsDT;
               
               if (reservations != null)
               {
                  // commit reservations
                  DataLayer.SeriesDB.Commit(reservations);

                  // create reservations events
                  BSDataSet.SeriesEventDataTable resEvents =
                     controller.GetSeriesEventDataTableForReservation(reservations);

                  // commit reservation events
                  DataLayer.SeriesDB.Commit(resEvents);
               }
               
               // commit transaction
               DataLayer.Commit();

               if (!newRange && seriesTabControl.SelectedIndex == 1)
               {
                  MessagesHelper.ShowInformation("Reservations were successfully updated.", WizardHelper.FindParentHeaderText(this));
               }
               else
               {
                  MessagesHelper.ShowInformation("Label Series was successfully saved.", WizardHelper.FindParentHeaderText(this));
               }

               reservations.AcceptChanges();
               EditMode = true;
            }
            catch (Exception ex)
            {
               if (newRange)
               {
                  // rollback state on failed commit
                  sd.State = SeriesDefinition.RangeState.Insert;
               }

               MessagesHelper.ReportError(ex, true);

               if (DataLayer.InTransaction)
               {
                  DataLayer.Rollback();
               }
               return false;
            }
         }
         return true;
      }

      /// <summary>
      /// Loads initial values.
      /// </summary>
      /// <param name="dataLayer"></param>
      public override void Init(SeriesDataLayer dl)
      {
         DataLayer = dl;
         controller = new SeriesManagerController(this, new BSDataSet.ReservationDataTable(), reservationGridDataBoundGrid);

         dbOptions = new DBSettingsDialog(dataLayer);
         dbOptions.TestSequence += dbOptions_TestSequence;
         dbOptions.TestTargetTable += dbOptions_TestTargetTable;


         using (dl.Connect())
         {
            controller.SetReservationStatusDT(dl.SeriesDB.RangeReservationStatusDT,
               dl.DataSet.ReservationStatus.NAMEColumn.ColumnName,
               dl.DataSet.ReservationStatus.IDColumn.ColumnName);
         }

         UpdateRangeStart();
      }      

      /// <summary>
      /// Resets the control.
      /// </summary>
      public override void Reset()
      {
         EditMode = false;
         DBOptionsDialog.Reset();
         controller.Reset();
         DesktopPanel.Controls.Clear();

         DesktopPanel.Enabled = false;
         seriesNameTextBox.Enabled = false;
         reservationTabPage.Enabled = false;
         reservationGridDataBoundGrid.CurrentCell.CancelEdit();
         expirationPanel.Enabled = false;
         dbGroupBox.Enabled = false;
         templateGroupBox.Enabled = false;
         
         Day = false;
         Month = false;
         Year = false;
         Never = true;
         ExampleLabel.Text = string.Empty;
         RangeName = string.Empty;
         RangeStart = 1;
         TemplateEditor.RangeStart = 1;
         SequenceNameText = string.Empty;
         SqlQueryText = string.Empty;
         seqRSTextBox.Text = string.Empty;
         seqAccTextBox.Text = string.Empty;
         tableRSTextBox.Text = string.Empty;
         tableAccTextBox.Text = string.Empty;

         controller.Reset();
      }

      #endregion


      #region Accessors

      public SeriesTemplateEditor TemplateEditor
      {
         get { return seriesTemplateEditor; }
      }


      /// <summary>
      /// Locks some controls in edit mode.
      /// </summary>
      public bool EditMode {
         get { return editMode; }
         set
         {
            editMode = value;
            seriesTemplateEditor.EditMode = value;            
            startRangeTextBox.Enabled = !value;
            seriesNameTextBox.Enabled = value;
         }
      }

      /// <summary>
      /// Connection string options.
      /// </summary>
      public DBSettingsDialog DBOptionsDialog
      {
         get { return dbOptions; }
      }

      /// <summary>
      /// Accessor for sequenceTextBox.
      /// </summary>
      public string SequenceNameText
      {
         get { return sequenceTextBox.Text; }
         set { sequenceTextBox.Text = value; }
      }      

      /// <summary>
      /// Accessor for queryTextBox.
      /// </summary>
      public string SqlQueryText
      {
         get { return queryTextBox.Text; }
         set { queryTextBox.Text = value; }         
      }

      /// <summary>
      /// Accessor for tableRSTextBox.
      /// </summary>
      public string TableResourceText
      {
         get { return tableRSTextBox.Text; }
         set { tableRSTextBox.Text = value; }
      }

      /// <summary>
      /// Accessor for seqRSTextBox.
      /// </summary>
      public string SequenceResourceText
      {
         get { return seqRSTextBox.Text; }
         set { seqRSTextBox.Text = value; }
      }

      /// <summary>
      /// Accessor for tableAccTextBox.
      /// </summary>
      public string TableAccountText
      {
         get { return tableAccTextBox.Text; }
         set { tableAccTextBox.Text = value; }
      }

      /// <summary>
      /// Accessor for seqAccTextBox.
      /// </summary>
      public string SequenceAccountText
      {
         get { return seqAccTextBox.Text; }
         set { seqAccTextBox.Text = value; }
      }
      
      /// <summary>
      /// Accessor for main working area for filter creation.
      /// </summary>
      public Panel DesktopPanel { get { return seriesTemplateEditor.DesktopPanel; } }

      /// <summary>
      /// Accessor for label displaying a barcode example.
      /// </summary>
      public RichTextBox ExampleLabel { get { return seriesTemplateEditor.ExampleLabel; } }

      /// <summary>
      /// Accessor for textbox with a range initial value.
      /// </summary>
      public long RangeStart
      {
         get { return startRangeTextBox.IntegerValue; }
         set { startRangeTextBox.IntegerValue = value;}
      }

      /// <summary>
      /// Range name textbox.
      /// </summary>
      public string RangeName
      {
         get { return seriesNameTextBox.Text; }
         set { seriesNameTextBox.Text = value; }
      }

      /// <summary>
      /// Never radiobutton.
      /// </summary>
      public bool Never
      {
         get { return neverRadioButton.Checked; }
         set { neverRadioButton.Checked = value; }
      }

      /// <summary>
      /// Year radiobutton.
      /// </summary>
      public bool Year
      {
         get { return yearRadioButton.Checked; }
         set { yearRadioButton.Checked = value; }
      }

      /// <summary>
      /// Month radiobuton.
      /// </summary>
      public bool Month
      {
         get { return monthRadioButton.Checked; }
         set { monthRadioButton.Checked = value; }
      }

      /// <summary>
      /// Week radiobutton.
      /// </summary>
      public bool Week
      {
         get { return weekNumRadioButton.Checked; }
         set { weekNumRadioButton.Checked = value; }
      }

      /// <summary>
      /// Day radiobutton.
      /// </summary>
      public bool Day
      {
         get { return dayRadioButton.Checked; }
         set
         {
            dayRadioButton.Checked = value;
         }
      }

      public override SeriesDataLayer DataLayer
      {
         get { return dataLayer; }
         set { dataLayer = value; }
      }


      internal void EnableForm()
      {
         reservationTabPage.Enabled = true;
         expirationPanel.Enabled = true;
         templateGroupBox.Enabled = true;
         dbGroupBox.Enabled = true;
      }

      internal void EnableReservations()
      {
         reservationTabPage.Enabled = true;
      }

      /// <summary>
      /// Sets the data source of Status column.
      /// </summary>
      /// <param name="source">The source.</param>
      public void SetReservationStatusDataSource(DataTable source, string displayMember, string valueMember)
      {
         statusGridBoundColumn.StyleInfo.DataSource = source;
         statusGridBoundColumn.StyleInfo.DisplayMember = displayMember;
         statusGridBoundColumn.StyleInfo.ValueMember = valueMember;
      }

      #endregion


      #region Public methods
      
      /// <summary>
      /// Initializes the user data.
      /// </summary>
      /// <param name="fullName">The user full name.</param>
      /// <param name="personID">The person ID.</param>
      public void SetUser(string fullName, decimal personID)
      {
         DataLayer.SecurityContext.User.FullName = fullName;
         DataLayer.SecurityContext.User.PersonID = personID;
      }

      #endregion


      #region Private methods

      /// <summary>
      /// Loads Series properties.
      /// </summary>
      /// <param name="range">The range.</param>
      /// <param name="editMode">if set to <c>true</c> [edit mode].</param>
      /// <param name="locks">The locks.</param>
      private void LoadSeries(SeriesDefinition range, bool editMode)
      {
         controller.SetSeries(range);
         EditMode = editMode;
         EnableReservations();
      }

      private void UpdateRangeStart()
      {
         int start = TemplateEditor.RangeStart;
         int.TryParse(startRangeTextBox.Text, out start);
         TemplateEditor.RangeStart = start;
      }

      #endregion


      #region UI events handlers

      /// <summary>
      /// Handles the TestSequence event of the Mediator.
      /// </summary>
      internal void dbOptions_TestSequence(object sender, TestConnectionEventArgs e)
      {
         controller.TestSequence(sender as DBSettingsDialog, e);
      }

      void dbOptions_TestTargetTable(object sender, TestConnectionEventArgs e)
      {
         controller.TestTargetTable(sender as DBSettingsDialog, e);
      }

      #endregion

      
      #region Event handlers

      private void dbButton_Click(object sender, EventArgs e)
      {
         try
         {
            controller.OpenDBDialog();
         }
         catch (Exception ex)
         {
            MessagesHelper.ReportError(ex, true);
         }
      }


      private void findButton_Click(object sender, EventArgs e)
      {
         try
         {
            SeriesSearchDialog search = new SeriesSearchDialog(seriesNameTextBox.Text, dataLayer);
            if (search.ShowDialog() == DialogResult.OK)
            {
               BSDataSet.SeriesDataTable dt = search.Series;
               if (dt.Rows.Count > 0)
               {
                  BSDataSet.SeriesRow row = dt.Rows[0] as BSDataSet.SeriesRow;

                  using (WaitDialog("Loading..."))
                  using (DataLayer.Connect())
                  {
                     SeriesGenerator generator = new SeriesGenerator(DataLayer, row);
                     BSDataSet.ReservationDataTable rt = controller.GetRangeReservation(row.ID);
                     LoadSeries(generator.LoadRange(rt), true);
                  }
               }

               EnableForm();
            }
         }
         catch (Exception ex)
         {
            MessagesHelper.ReportError(ex, true);
         }
      }

      private void newSeriesButton_Click(object sender, EventArgs e)
      {
         try
         {
            Reset();
            seriesNameTextBox.Enabled = true;
            DesktopPanel.Enabled = true;
            EnableForm();
         }
         catch (Exception ex)
         {
            MessagesHelper.ReportError(ex, true);
         }
      }

      private void seriesTabControl_SelectedIndexChanging(object sender, SelectedIndexChangingEventArgs args)
      {
         args.Cancel = seriesTabControl.TabPages[args.NewSelectedIndex] == reservationTabPage
            && !reservationTabPage.Enabled;
      }

      private void seriesTabControl_SelectedIndexChanged(object sender, EventArgs e)
      {
         if (seriesTabControl.SelectedIndex == 1)
         {
            seriesNameLabel.Text = seriesNameTextBox.Text + "  -  " + ExampleLabel.Text;
         }
      }

      private void startRangeTextBox_TextChanged(object sender, EventArgs e)
      {
         UpdateRangeStart();
      }
      
      #endregion

   }
}