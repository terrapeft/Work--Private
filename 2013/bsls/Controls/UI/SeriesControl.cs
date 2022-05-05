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

namespace Jnj.ThirdDimension.Controls.BarcodeSeries
{
   /// <summary>
   /// Control responsible for defining a barcode range.
   /// The control does not depend on data layer or typed tables.
   /// </summary>
   public partial class SeriesControl : UserControl
   {

      #region Declarations
      private SeriesControlMediator mediator;   // Mediator
      private bool editMode;
      private DBSettingsDialog dbOptions;
      #endregion

      #region Initialization
      public SeriesControl()
      {
         InitializeComponent();

         textDragLabel.Tag = SeriesControlMediator.FilterType.Text;
         seriesDragLabel.Tag = SeriesControlMediator.FilterType.Sequence;
         yearDragLabel.Tag = SeriesControlMediator.FilterType.Year;
         monthDragLabel.Tag = SeriesControlMediator.FilterType.Month;
         weekDragLabel.Tag = SeriesControlMediator.FilterType.Week;
         dayDragLabel.Tag = SeriesControlMediator.FilterType.Day;

         dbOptions = new DBSettingsDialog();
         dbOptions.TestConnection += new EventHandler<TestConnectionEventArgs>(dbOptions_TestConnection);
      }

      void dbOptions_TestConnection(object sender, TestConnectionEventArgs e)
      {
         mediator.OnTestConnection(sender, e);
      }

      #endregion

      #region Accessors for Mediator

      /// <summary>
      /// Locks some controls in edit mode.
      /// </summary>
      public bool EditMode {
         get { return editMode; }
         set
         {
            editMode = value;

            desktopPanel.Enabled = !value;
            refreshButton.Enabled = !value;
            toolPanel.Enabled = !value;
            startRangeTextBox.Enabled = !value;
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
      /// Accessor for connStringTextBox.
      /// </summary>
      public string ConnectionStringText
      {
         set { connStringTextBox.Text = value;}
      }

      /// <summary>
      /// Accessor for sequenceTextBox.
      /// </summary>
      public string SequenceNameText
      {
         set { sequenceTextBox.Text = value; }
      }

      /// <summary>
      /// Accessor for queryTextBox.
      /// </summary>
      public string SqlQueryText
      {
         set { queryTextBox.Text = value; }
      }

      /// <summary>
      /// Accessor for main working area for filter creation.
      /// </summary>
      public Panel DesktopPanel { get { return desktopPanel; } }

      /// <summary>
      /// Accessor for label displaying a barcode example.
      /// </summary>
      public RichTextBox ExampleLabel { get { return exampleRichTextBox; } }

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

      /// <summary>
      /// Gets or sets the reservation data source.
      /// </summary>
      /// <value>The reservation data source.</value>
      public object ReservationDataSource
      {
         get { return reservationGridDataBoundGrid.DataSource; }
         set
         {
            reservationGridDataBoundGrid.DataSource = value;
            reservationGridDataBoundGrid.Refresh();
         }
      }

      internal void ClearDataSource()
      {
         DataTable dt = reservationGridDataBoundGrid.DataSource as DataTable;
         if (dt != null)
         {
            dt.Clear();
         }
         else
         {
            ReservationDataSource = null;
         }
      }

      /// <summary>
      /// Sets the data source of Status column.
      /// </summary>
      /// <param name="source">The source.</param>
      public void SetReservationStatusDataSource(DataTable source)
      {
         statusGridBoundColumn.StyleInfo.DataSource = source;
         statusGridBoundColumn.StyleInfo.DisplayMember = "NAME";
         statusGridBoundColumn.StyleInfo.ValueMember = "ID";
      }

      /// <summary>
      /// Mediator.
      /// </summary>
      public SeriesControlMediator Mediator
      {
         get { return mediator; }
         set { mediator = value; }
      }

      #endregion

      #region Event handlers

      private void exampleRichTextBox_Enter(object sender, EventArgs e)
      {
         mediator.ClearExampleSelection();
      }

      private void dbButton_Click(object sender, EventArgs e)
      {
         mediator.OpenDBDialog();
      }

      private void findButton_Click(object sender, EventArgs e)
      {
         mediator.FindSeries(seriesNameTextBox.Text);
      }

      private void newSeriesButton_Click(object sender, EventArgs e)
      {
         seriesNameTextBox.Enabled = true;
      }

      #endregion

      private void desktopPanel_DragEnter(object sender, DragEventArgs e)
      {
         if (e.Data.GetDataPresent(typeof(SeriesControlMediator.FilterType)))
         {
            e.Effect = DragDropEffects.Copy;
         }
      }

      private void desktopPanel_DragDrop(object sender, DragEventArgs e)
      {
         if (e.Data.GetDataPresent(typeof(SeriesControlMediator.FilterType)))
         {
            Point local = desktopPanel.PointToClient(new Point(e.X, e.Y));
            var ctlType = (SeriesControlMediator.FilterType)e.Data.GetData(typeof (SeriesControlMediator.FilterType));
            mediator.InsertControlAtPosition(ctlType, local.X, local.Y);
         }
      }

      private void dragLabel_DoubleClick(object sender, EventArgs e)
      {
         mediator.AddControl(((Control)sender).Tag);
      }

      private void desktopOuterPanel_DragDrop(object sender, DragEventArgs e)
      {
         if (e.Data.GetDataPresent(typeof(TextBox)))
         {
            mediator.RemoveControl((Control)e.Data.GetData(typeof(TextBox)));
         }
         else if (e.Data.GetDataPresent(typeof(ComboBox)))
         {
            mediator.RemoveControl((Control)e.Data.GetData(typeof(ComboBox)));
         }
      }

      private void desktopOuterPanel_DragEnter(object sender, DragEventArgs e)
      {
         if (e.Data.GetDataPresent(typeof (TextBox)) ||
             e.Data.GetDataPresent(typeof (ComboBox)))
         {
            e.Effect = DragDropEffects.Copy;
         }
         else
         {
            e.Effect = DragDropEffects.None;
         }
      }

      private void button1_Click(object sender, EventArgs e)
      {
         mediator.RefreshTemplateBuilder();
      }
   }
}