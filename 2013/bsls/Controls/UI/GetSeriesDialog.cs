#region Copyright (C) 1994-2009, Johnson & Johnson PRD, LLC.
//---------------------------------------------------------------------------*
//
//    ChooseColumn.cs: Allows to choose a value from combobox or type a new one. 
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
using Jnj.ThirdDimension.Data.BarcodeSeries;

namespace Jnj.ThirdDimension.Controls.BarcodeSeries
{
   /// <summary>
   /// Allows to choose a value from combobox or type a new one. 
   /// </summary>
   public partial class GetSeriesDialog : Form
   {
      private SeriesDataLayer dataLayer;

      public GetSeriesDialog()
      {
         InitializeComponent();
      }

      public GetSeriesDialog(SeriesDataLayer dl) : this()
      {
         dataLayer = dl;
      }

      public object DataSource
      {
         get { return columnComboBox.DataSource; }
         set { columnComboBox.DataSource = value; }
      }

      public string DisplayMember
      {
         get { return columnComboBox.DisplayMember; }
         set { columnComboBox.DisplayMember = value; }
      }
      
      public string ValueMember
      {
         get { return columnComboBox.ValueMember; }
         set { columnComboBox.ValueMember = value; }
      }

      /// <summary>
      /// Returns the name of the new column.
      /// </summary>
      /// <value>The new name of the column.</value>
      public string NewColumnName
      {
         get { return rangeTextBox.Text; }
      }

      /// <summary>
      /// Returns DataRow for selected series.
      /// </summary>
      public BSDataSet.SeriesRow SelectedSeries
      {
         get
         {
            return rangeTextBox.Tag as BSDataSet.SeriesRow;
         }
      }

      /// <summary>
      /// Returns DataRow for selected series.
      /// </summary>
      public int NumberOfValues
      {
         get
         {
            return (int)integerTextBox1.IntegerValue;
         }
         set
         {
            integerTextBox1.IntegerValue = value;
         }
      }

      public bool SpecifyNumberOfValues
      {
         get
         {
            return numberPanel.Enabled;
         }
         set
         {
            columnPanel.Enabled = !value;
            numberPanel.Enabled = value;
         }
      }

      /// <summary>
      /// Gets the selected column.
      /// </summary>
      /// <value>The selected column.</value>
      public DataColumn SelectedColumn
      {
         get { return columnComboBox.SelectedItem as DataColumn; }
         set 
         { 
            columnComboBox.SelectedItem = value;
         }
      }

      /// <summary>
      /// Indicates if column either selected or name for the new specified.
      /// </summary>
      private bool HasProperSelection
      {
         get { return columnComboBox.SelectedItem != null; }
      }

      /// <summary>
      /// Handles the Changed event of the columnComboBox control.
      /// </summary>
      /// <param name="sender">The source of the event.</param>
      /// <param name="e">The <see cref="System.EventArgs"/> instance containing the event data.</param>
      private void columnComboBox_Changed(object sender, EventArgs e)
      {
         okButton.Enabled = HasProperSelection;
      }

      private void findButton_Click(object sender, EventArgs e)
      {
         SeriesSearchDialog search = new SeriesSearchDialog(rangeTextBox.Text, dataLayer);
         if (search.ShowDialog() == DialogResult.OK)
         {
            BSDataSet.SeriesDataTable dt = search.Series;
            if (dt.Rows.Count > 0)
            {
               BSDataSet.SeriesRow row = dt.Rows[0] as BSDataSet.SeriesRow;
               rangeTextBox.Text = row.NAME;
               rangeTextBox.Tag = row;
            }
            okButton.Enabled = SpecifyNumberOfValues || HasProperSelection;
         }
      }
   }
}
