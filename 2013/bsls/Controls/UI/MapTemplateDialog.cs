using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Windows.Forms;
using Jnj.ThirdDimension.Instruments;
using Wintellect.PowerCollections;
using Jnj.ThirdDimension.Controls.Grid;

namespace Jnj.ThirdDimension.Controls.BarcodeSeries
{
   /// <summary>
   /// Dialog allows to map values to each other
   /// </summary>
   public partial class MapTemplateDialog : Form
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
      public MapTemplateDialog()
      {
         InitializeComponent();
         //dgvMapping.AutoGenerateColumns = false;
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
         mappingGrid.DataSource = null;
         mappingGrid.DataSource = GetRows();

         // fill grid with available columns for selected 3DX table
         List<string> list = new List<string>(RightColumns);
         list.Insert(0, string.Empty);
         
         gridGridBoundColumn.StyleInfo.DataSource = list;

         DoAutoMapping();

         GridHelper.FitRowHColW(mappingGrid);
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
         MappingsCollection source = mappingGrid.DataSource as MappingsCollection;

         for (int j = 0; j < source.Count; j++)
         {
            val = source[j].DestinationName;

            for (int k = 0; k < RightColumns.Length; k++)
            {
               if (val.ToUpper() == RightColumns[k].ToUpper())
               {
                  source[j].SourceName = RightColumns[k];
               }
            }
         }
      }

      #endregion

      #region UI event handlers

      private void mappingGrid_CurrentCellChanged(object sender, EventArgs e)
      {
         mappingGrid.CurrentCell.ConfirmChanges();
         mappingGrid.Binder.EndEdit();

         if (MappedColumns != null)
         {
            btnOK.Enabled = MappedColumns.IsValid();
         }

         GridHelper.FitRowHColW(mappingGrid);
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
            int filledCount = 0;
            int requiredCount = 0;

            foreach (Mapping m in this)
            {
               if (!string.IsNullOrEmpty(m.DestinationName) && mc.Contains(m.DestinationName) && !string.IsNullOrEmpty(m.SourceName))
                  requiredCount++;

               if (!string.IsNullOrEmpty(m.DestinationName) && !string.IsNullOrEmpty(m.SourceName))
                  filledCount++;
            }

            if (requiredCount != mc.Count) return false;

            if (filledCount > 0) return true;

            return false;
         }
      }

      /// <summary>
      /// Class contains mapping properties
      /// </summary>
      public class Mapping
      {
         private string dName;
         private string sName = null;

         public Mapping(string sourceName, string destinationName, string defaultValue)
            : this(sourceName, destinationName)
         {
            DefaultValue = defaultValue;
         }

         public Mapping(string sourceName, string destinationName)
         {
            dName = destinationName;
            sName = sourceName;
         }

         public string DestinationName
         {
            get { return dName; }
            set { dName = value; }
         }

         public string SourceName 
         {
            get
            {
               if (string.IsNullOrEmpty(sName) && !string.IsNullOrEmpty(DefaultValue))
               {
                  return DefaultValue;  
               }
               return sName;
            }
            set { sName = value;} 
         }

         public string DefaultValue { get; set; }

         public override string ToString()
         {
            return dName;
         }
      }

      #endregion

   }
}