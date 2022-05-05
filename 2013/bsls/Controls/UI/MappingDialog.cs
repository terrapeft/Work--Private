#region Copyright (C) 1994-2009, Johnson & Johnson PRD, LLC.
//---------------------------------------------------------------------------*
//
//    MapTemplateDialog.cs: Dialog allows to map values.
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
using System.IO;
using System.Windows.Forms;
using Jnj.ThirdDimension.Instruments;
using Wintellect.PowerCollections;

namespace Jnj.ThirdDimension.Controls.BarcodeSeries
{
   /// <summary>
   /// Dialog allows to map values.
   /// </summary>
   public partial class MappingDialog : Form
   {
      #region Properties

      /// <summary>
      /// Array of strings for left side.
      /// </summary>
      public string[] LeftColumns { get; set; }

      /// <summary>
      /// Array of strings for right side.
      /// </summary>
      public string[] RightColumns { get; set; }

      /// <summary>
      /// Columns which are mandatory for mapping.
      /// </summary>
      public string[] MandatoryColumns { get; set; }

      /// <summary>
      /// Mapped columns.
      /// </summary>
      public MappingsCollection MappedColumns { get; private set; }

      #endregion

      #region Constructor
      public MappingDialog()
      {
         InitializeComponent();
         dgvMapping.AutoGenerateColumns = false;
      }

      /// <summary>
      /// Use it to make mapping without showing a dialog.
      /// </summary>
      public void AutoMap ()
      {
         BindData();
      }

      /// <summary>
      /// Binds data and shows the dialog.
      /// </summary>
      /// <returns></returns>
      public new DialogResult ShowDialog()
      {
         return base.ShowDialog();
      }

      #endregion

      #region Binding

      /// <summary>
      /// Binds columns.
      /// </summary>
      private void BindData()
      {
         dgvMapping.DataSource = null;
         dgvMapping.DataSource = GetRows();

         // fill grid with available columns for selected 3DX table
         col3DX.DataSource = RightColumns;

         DoAutoMapping();
      }

      /// <summary>
      /// Converts string array to bindable collection.
      /// </summary>
      /// <returns></returns>
      private MappingsCollection GetRows()
      {
         MappedColumns = new MappingsCollection(MandatoryColumns);

         foreach (string col in LeftColumns)
         {
            MappedColumns.Add(new Mapping(string.Empty, col));
         }
         return MappedColumns;
      }

      /// <summary>
      /// Find matches.
      /// </summary>
      /// <param name="cols"></param>
      private void DoAutoMapping()
      {
         string val;
         for (int j = 0; j < dgvMapping.Rows.Count; j++)
         {
            val = dgvMapping[colDestination.Index, j].Value.ToString();
            for (int k = 0; k < RightColumns.Length; k++)
            {
               if (val.ToUpper() == RightColumns[k].ToUpper())
               {
                  dgvMapping[col3DX.Index, j].Value = RightColumns[k];
               }
            }
         }
      }

      #endregion

      #region UI event handlers

      private void dgvMapping_CellValueChanged(object sender, DataGridViewCellEventArgs e)
      {
         if (MappedColumns != null)
         {
            btnOK.Enabled = MappedColumns.IsValid();
         }
      }

      #endregion

      #region Embedded classes

      /// <summary>
      /// The collection of user mappings and default values
      /// </summary>
      public class MappingsCollection : List<Mapping>
      {
         private string[] mandatoryColumns;

         public MappingsCollection()
         {
         }

         public MappingsCollection(string[] mandatoryColumns)
         {
            this.mandatoryColumns = mandatoryColumns;
         }

         /// <summary>
         /// Returns source column name by destination column name
         /// </summary>
         /// <param name="destinationName"></param>
         /// <returns></returns>
         public Mapping this[string destinationName]
         {
            get
            {
               foreach (Mapping m in this)
               {
                  if (m.DestinationName == destinationName)
                     return m;
               }
               return null;
            }
         }

         /// <summary>
         /// Checks that mapping parameters are filled correctly
         /// </summary>
         /// <returns></returns>
         public bool IsValid()
         {
            List<string> mc = (mandatoryColumns != null) ? new List<string>(mandatoryColumns) : new List<string>();

            foreach (Mapping m in this)
            {
               if (mc.Contains(m.DestinationName) && string.IsNullOrEmpty(m.SourceName) && string.IsNullOrEmpty(m.DefaultValue))
                  return false;
            }
            return true;
         }
      }

      /// <summary>
      /// Class contains mapping properties
      /// </summary>
      public class Mapping
      {
         private string dName;

         public Mapping(string sourceName, string destinationName, string defaultValue)
            : this(sourceName, destinationName)
         {
            DefaultValue = defaultValue;
         }

         public Mapping(string sourceName, string destinationName)
         {
            dName = destinationName;
            SourceName = sourceName;
         }

         public string DestinationName
         {
            get { return dName; }
            set { dName = value; }
         }

         public string SourceName { get; set; }

         public string DefaultValue { get; set; }

         public override string ToString()
         {
            return dName;
         }
      }

      #endregion
   }
}