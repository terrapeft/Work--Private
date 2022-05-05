#region Copyright (C) 1994-2010, Johnson & Johnson PRD, LLC.
//---------------------------------------------------------------------------*
//
//   MapTableToDataTableDialog.cs: Allows to map 3dx columns to the wizard columns.
//
//---
//
//   Copyright (C) 1994-2010, Johnson & Johnson PRD, LLC.
//   All Rights Reserved.
//
//   Vitaly Chupaev, 2009
//
//---------------------------------------------------------------------------*/
#endregion

using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Windows.Forms;
using Jnj.ThirdDimension.Mt.Data;
using System.Xml.Serialization;
using System.Runtime.Serialization;
using System.Text;
using System.Xml;
using System.Linq;
using Jnj.ThirdDimension.Explorer;

namespace Jnj.ThirdDimension.Controls.BarcodeSeries
{
   public interface IMapTableToDataTableDialog
   {
      IExplorer Explorer { get; set; }
      string[] CurrentColumns { get; set; }
      string[] MandatoryColumns { get; set; }
      MapTableToDataTableDialog.MappingsCollection MappedColumns { get; }
      bool IsFileImport { get; }
      string FileName { get; }
      DialogResult ShowDialog();
      DataTable GetSourceData();
   }

   /// <summary>
   /// Dialog allow to choose import source (3DX table or csv file) and set defaults for 3DX importing
   /// </summary>
   public partial class MapTableToDataTableDialog : Form
   {

      #region Fields
      private MappingsCollection maps;
      private ColumnsCache cache;
      private IExplorer expl;
      private IEnumerable<TableRow> tdxRows;
      private bool allowFileOnly = false;   // used by AllowFileOnly property
      private bool allow3DXOnly = false;   // used by Allow3DXOnly property
      private string[] currentColumns = new string[0];   // import columns
      private string[] excludeColumns = new string[0];   // grid columns to exclude from the list
      #endregion

      #region Properties
      public IExplorer Explorer
      {
         get { return expl; }
         set
         {
            expl = value;
            if (expl == null || expl.Views == null || expl.Views.Count == 0)
            {
               rb3DX.Enabled = false;
            }
            else
            {
               if (Allow3DXOnly)
               {
                  rb3DX.Checked = true;
               }
            }
         }
      }

      /// <summary>
      /// Returns the name of the file to import from
      /// </summary>
      public string FileName
      {
         get { return txtFile.Text.Trim(); }
      }

      /// <summary>
      /// Array of header texts for columns in the currently opened view (destination columns)
      /// </summary>
      public string[] CurrentColumns
      {
         get { return currentColumns; }
         set { currentColumns = value.Except(excludeColumns).ToArray(); }
      }

      /// <summary>
      /// Array of header texts of mandatory columns
      /// </summary>
      public string[] MandatoryColumns
      {
         get;
         set;
      }

      /// <summary>
      /// The collection of user mappings and default values
      /// </summary>
      public MappingsCollection MappedColumns
      {
         get { return maps; }
      }

      /// <summary>
      /// Checks if the importing is intended from the file or not.
      /// </summary>
      public bool IsFileImport
      {
         get
         {
            return rbFile.Checked;
         }
      }

      /// <summary>
      /// Allows to use as a source only files. 3DX tables will be disabled.
      /// </summary>
      public bool AllowFileOnly
      {
         get { return allowFileOnly; }
         set
         {
            if (value)
            {
               rb3DX.Enabled = false;
               grp3DX.Enabled = false;
            }
            allowFileOnly = value;
         }
      }

      /// <summary>
      /// Allows to use as a source only 3DX tables.
      /// </summary>
      public bool Allow3DXOnly
      {
         get { return allow3DXOnly; }
         set
         {
            if (value)
            {
               rbFile.Enabled = false;
               grpFile.Enabled = false;
            }
            if (rb3DX.Enabled)
            {
               rb3DX.Checked = value;
            }
            allow3DXOnly = value;
         }
      }
      #endregion

      #region Constructor

      public MapTableToDataTableDialog(string[] excludeColumns): this()
      {
         this.excludeColumns = excludeColumns;
      }

      public MapTableToDataTableDialog()
      {
         InitializeComponent();
         cache = new ColumnsCache();
         dgvMapping.AutoGenerateColumns = false;
      }

      public new DialogResult ShowDialog()
      {
         BindTablesCombo();
         BindData(BindMode.BestMatch);
         EnsureRadioButtons();

         return base.ShowDialog();
      }

      private void EnsureRadioButtons()
      {
         rbFile.Enabled = !Allow3DXOnly;
         rb3DX.Enabled = (expl != null && expl.Views != null && expl.Views.Count > 0 && !AllowFileOnly);
      }

      #endregion

      #region Binding
      private void BindTablesCombo()
      {
         if (Explorer == null || Explorer.Views.Count == 0) return;

         cmb3DXTables.Items.Clear();

         // fill combo with available 3DX table names
         foreach (IView view in Explorer.Views)
         {
            cmb3DXTables.Items.Add(view.Table.Name);
         }

         cmb3DXTables.SelectedItem = Explorer.CurrentTable.Name;
      }

      private void BindData(BindMode mode)
      {
         BindData(true, mode);
      }

      private void BindData(bool doMapping, BindMode mode)
      {
         if (rbFile.Checked || CurrentColumns == null || AllowFileOnly || Explorer == null || cmb3DXTables.SelectedItem == null)
            return;

         // fill grid with destination columns
         maps = new MappingsCollection(MandatoryColumns);

         foreach (string col in CurrentColumns)
         {
            maps.Add(new Mapping(string.Empty, col));
         }

         dgvMapping.DataSource = maps;

         // fill grid with available columns for selected 3DX table
         var cols = Get3DXColumns(cmb3DXTables.SelectedItem.ToString());
         cols.Insert(0, new KeyValuePair<string, Type>(string.Empty, typeof(string)));
         col3DX.DataSource = cols;

         if (doMapping)
         {
            DoAutoMapping(cols, mode);
         }
      }

      private void DoAutoMapping(List<KeyValuePair<string, Type>> cols, BindMode mode)
      {
         if (cols == null)
            return;

         for (int j = 0; j < dgvMapping.Rows.Count; j++)
         {
            string table = cmb3DXTables.SelectedItem.ToString();
            string val = dgvMapping[colDestination.Index, j].Value.ToString();
            for (int k = 0; k < cols.Count; k++)
            {
               //if (mode == BindMode.BestMatch)
               //{
                  if (cache.HasMatchingKey(table, val))
                  {
                     bool @default = false;
                     var cachedVal = cache.MatchOrDefault(table, val, out @default);
                     if (@default)
                     {
                        dgvMapping[colDefault.Index, j].Value = cachedVal;
                     }
                     else
                     {
                        dgvMapping[col3DX.Index, j].Value = cachedVal;
                     }
                  }
                  else if (val.ToUpper() == cols[k].Key.ToUpper())
                  {
                     dgvMapping[col3DX.Index, j].Value = cols[k];
                     cache.Add(table, val, cols[k].Key, null);
                  }
                  
               //}
               //else if (mode == BindMode.Template)
               //{
               //   if (cache.HasMatchingKey(table, val, cols))
               //   {
               //      bool @default = false;
               //      var cachedVal = cache.MatchOrDefault(table, val, cols, out @default);
               //      if (@default)
               //      {
               //         dgvMapping[colDefault.Index, j].Value = cachedVal;
               //      }
               //      else
               //      {
               //         dgvMapping[col3DX.Index, j].Value = cachedVal;
               //      }
               //   }
               //}
            }
         }
         btnOK.Enabled = maps.IsValid();
      }

      #endregion

      #region Miscellaneous methods

      private List<KeyValuePair<string, Type>> Get3DXColumns(string tableName)
      {
         if (string.IsNullOrEmpty(tableName)) return null;

         var tdxCols = new List<KeyValuePair<string, Type>>();

         foreach (IView view in Explorer.Views)
         {
            if (view.Table.Name == tableName)
            {
               tdxRows = view.Table.Rows;

               foreach (TableColumn col in view.Table.Columns)
               {
                  tdxCols.Add(new KeyValuePair<string, Type>(col.Name, col.ItemType));
               }
            }
         }
         return tdxCols;
      }

      /// <summary>
      /// DataTable converted from 3DX table.
      /// 3DX Table seems to be not mockable, so the converting is workaround.
      /// </summary>
      public DataTable GetSourceData()
      {
         DataTable dt = new DataTable();

         // get source data as is
         foreach (KeyValuePair<string, Type> col in Get3DXColumns(cmb3DXTables.SelectedItem.ToString()))
         {
            dt.Columns.Add(col.Key, col.Value);
         }

         foreach (TableRow row in Get3DXRows())
         {
            dt.Rows.Add(row.ItemArray);
         }

         // apply default values, if any
         foreach (Mapping map in maps)
         {
            if (!string.IsNullOrEmpty(map.DefaultValue))
            {
               var valueToApply = map.DefaultValue;
               map.DefaultValue = null;

               if (string.IsNullOrEmpty(map.SourceName))
               {
                  map.SourceName = map.DestinationName;
                  dt.Columns.Add(map.DestinationName);
               }

               foreach (DataRow row in dt.Rows)
               {
                  var currValue = row[map.SourceName];
                  if (currValue == DBNull.Value)
                  {
                     row[map.SourceName] = valueToApply;
                  }
               }
            }
         }

         return dt;
      }

      private IEnumerable<TableRow> Get3DXRows()
      {
         if (Explorer.Views.Count > 0)
         {
            if (selectedCheckBox.Checked)
            {
               return Explorer.Views[cmb3DXTables.SelectedIndex].GetSelectedRows();
            }
            else
            {
               return Explorer.Views[cmb3DXTables.SelectedIndex].Table.Rows;
            }
         }
         return null;
      }

      private bool IsValidFile()
      {
         return (txtFile.Text.Length > 0 && File.Exists(txtFile.Text));
      }

      #endregion

      #region UI events handlers
      private void rb3DX_CheckedChanged(object sender, EventArgs e)
      {
         grp3DX.Enabled = rb3DX.Checked;
         loadBarItem.Enabled = rb3DX.Checked;
         saveBarItem.Enabled = rb3DX.Checked;
         clearBarItem.Enabled = rb3DX.Checked;

         BindTablesCombo();

         if (rb3DX.Checked && dgvMapping.DataSource == null)
         {
            BindData(BindMode.BestMatch);
         }
         else
         {
            btnOK.Enabled = maps.IsValid();
         }
      }

      private void rbFile_CheckedChanged(object sender, EventArgs e)
      {
         grpFile.Enabled = rbFile.Checked;
         btnOK.Enabled = IsValidFile();
      }

      private void cmb3DXTables_SelectedIndexChanged(object sender, EventArgs e)
      {
         BindData(BindMode.BestMatch);
         btnOK.Enabled = true;
      }

      private void btnBrowse_Click(object sender, EventArgs e)
      {
         if (openFileDialog1.ShowDialog() == DialogResult.OK)
         {
            txtFile.Text = openFileDialog1.FileName;
            btnOK.Enabled = true;
         }
      }

      private void dgvMapping_CellValueChanged(object sender, DataGridViewCellEventArgs e)
      {
         if (maps != null)
         {
            string table = cmb3DXTables.SelectedItem.ToString();
            string col = dgvMapping[colDestination.Index, e.RowIndex].Value.ToString();
            string value = (string)(dgvMapping[col3DX.Index, e.RowIndex].Value ?? string.Empty);
            string defaultVal = (string)(dgvMapping[colDefault.Index, e.RowIndex].Value ?? string.Empty);
            cache.Add(table, col, value, defaultVal);

            btnOK.Enabled = maps.IsValid();
         }
      }

      void dgvMapping_DataError(object sender, System.Windows.Forms.DataGridViewDataErrorEventArgs e)
      {
         throw new System.NotImplementedException();
      }

      private void txtFile_TextChanged(object sender, EventArgs e)
      {
         if (rbFile.Checked)
         {
            btnOK.Enabled = IsValidFile();
         }
      }

      private void saveBarItem_Click(object sender, EventArgs e)
      {
         if (saveFileDialog1.ShowDialog() == DialogResult.OK)
         {
            dgvMapping.EndEdit();
            cache.Serialize(saveFileDialog1.FileName);
         }
      }

      private void loadBarItem_Click(object sender, EventArgs e)
      {
         if (openFileDialog2.ShowDialog() == DialogResult.OK)
         {
            cache = ColumnsCache.Deserialize(openFileDialog2.FileName);
            BindData(BindMode.Template);
         }
      }

      private void clearBarItem_Click(object sender, EventArgs e)
      {
         cache = new ColumnsCache();
         BindData(false, BindMode.BestMatch);
      }

      private void MapTableToDataTableDialog_FormClosing(object sender, FormClosingEventArgs e)
      {
         if (rb3DX.Checked)
         {
            // prevents from the DataGridView Reentrant Call Exception
            // see for details: http://blogs.dotnetnerds.com/steve/archive/2007/05/17/DataGridView-Reentrant-Call-Nightmare.aspx
            dgvMapping.EndEdit();
            rb3DX.Focus();
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
      /// Class contains mapping properties for MapTableToDataTableDialog class
      /// </summary>
      public class Mapping
      {
         private string dName;

         /// <summary>
         /// 
         /// </summary>
         /// <param name="sourceName"></param>
         /// <param name="destinationName"></param>
         /// <param name="defaultValue"></param>
         /// <param name="sourceColType"></param>
         public Mapping(string sourceName, string destinationName, string defaultValue, Type sourceColType)
            : this(sourceName, destinationName)
         {
            DefaultValue = defaultValue;
            SourceColumnType = sourceColType;
         }

         /// <summary>
         /// 
         /// </summary>
         /// <param name="sourceName"></param>
         /// <param name="destinationName"></param>
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

         public Type SourceColumnType { get; set; }

         public string DefaultValue { get; set; }

         public override string ToString()
         {
            return dName;
         }
      }

      /// <summary>
      /// Contains information about the column and values that was mapped bu a user.
      /// </summary>
      [Serializable]
      public class CachedColumn
      {
         [XmlElement("Name")]
         public string Name;

         [XmlElement("DefaultValue")]
         public string DefaultValue;

         [XmlElement("Mapping")]
         public string MappedValue;

         public CachedColumn()
         {
         }

         public CachedColumn(string colName, string value, string defaultValue)
         {
            Name = colName;
            DefaultValue = defaultValue;
            MappedValue = value;
         }
      }

      [Serializable]
      public class ColumnsCache
      {
         public SerializableDictionary<string, List<CachedColumn>> Tables;

         public ColumnsCache()
         {
            Tables = new SerializableDictionary<string,List<CachedColumn>>();
         }

         protected bool ContainsKey(string table, string key)
         {
            return Tables.Count(t => t.Key == table && t.Value.Count(col => col.Name == key) > 0) > 0;
         }

         internal List<CachedColumn> this[string table]
         {
            get
            {
               var dt = Tables.FirstOrDefault(t => t.Key == table);
               if (string.IsNullOrEmpty(dt.Key)) return null;
               return dt.Value;
            }
         }

         internal CachedColumn this[string table, string key]
         {
            get
            {
               return this[table].FirstOrDefault(col => col.Name == key);
            }
         }

         internal void Add(string table, string columnName, string value, string defaultValue)
         {
            if (this[table] == null)
            {
               Tables.Add(table, new List<CachedColumn>());
            }

            this[table].RemoveAll(c => c.Name == columnName);
            this[table].Add(new CachedColumn(columnName, value, defaultValue));
         }

         internal bool HasMatchingKey(string table, string val)
         {
            if (this.ContainsKey(table, val))
            {
               if (!string.IsNullOrEmpty(this[table, val].MappedValue))
               {
                  return true;
               }
               return !string.IsNullOrEmpty(this[table, val].DefaultValue);
            }
            return false;
         }

         internal string MatchOrDefault(string table, string val, out bool @default)
         {
            @default = false;
            if (this.ContainsKey(table, val))
            {
               if (!string.IsNullOrEmpty(this[table, val].MappedValue))
               {
                  return this[table, val].MappedValue;
               }

               @default = true;
               return this[table, val].DefaultValue;
            }
            return string.Empty;
         }

         /// <summary>
         /// Serializes the class.
         /// </summary>
         /// <typeparam name="T"></typeparam>
         /// <param name="instance">The instance.</param>
         /// <returns>Serialized string.</returns>
         internal void Serialize(string fileName)
         {
            XmlSerializer serializer = new XmlSerializer(typeof(ColumnsCache));
            using (FileStream fs = new FileStream(fileName, FileMode.Create))
            {
               serializer.Serialize(fs, this);
            }
         }

         internal static ColumnsCache Deserialize(string fileName)
         {
            XmlSerializer serializer = new XmlSerializer(typeof(ColumnsCache));
            using (TextReader reader = new StreamReader(fileName))
            {
               return (ColumnsCache) serializer.Deserialize(reader);
            }
         }
      }

      #endregion

      public enum BindMode
      {
         BestMatch,
         Template
      }

   }
}