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

namespace Jnj.ThirdDimension.Controls.BarcodeSeries
{
   /// <summary>
   /// Allows to choose a value from combobox or type a new one. 
   /// </summary>
   public partial class ChooseColumn : Form
   {
      public ChooseColumn()
      {
         InitializeComponent();
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
      /// Indicates whether to create new column or not.
      /// </summary>
      /// <value><c>true</c> if [create new column]; otherwise, <c>false</c>.</value>
      public bool CreateNewColumn
      {
         get { return columnComboBox.SelectedItem == null && !string.IsNullOrEmpty(columnComboBox.Text); }
      }

      /// <summary>
      /// Returns the name of the new column.
      /// </summary>
      /// <value>The new name of the column.</value>
      public string NewColumnName
      {
         get { return columnComboBox.Text; }
      }

      /// <summary>
      /// Gets the selected column.
      /// </summary>
      /// <value>The selected column.</value>
      public DataColumn SelectedColumn
      {
         get { return columnComboBox.SelectedItem as DataColumn; }
         set { 
            columnComboBox.SelectedItem = value;
            if (columnComboBox.SelectedIndex < 0)
            {
               SetDefaultText();
            }
         }
      }

      /// <summary>
      /// Sets the text to combobox.
      /// </summary>
      /// <param name="text"></param>
      public void SetDefaultText()
      {
         columnComboBox.SelectedIndex = -1;
         columnComboBox.Text = "New column";
      }

      /// <summary>
      /// Indicates if column either selected or name for the new specified.
      /// </summary>
      private bool HasProperSelection
      {
         get { return columnComboBox.SelectedItem != null || !string.IsNullOrEmpty(columnComboBox.Text); }
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
   }
}
