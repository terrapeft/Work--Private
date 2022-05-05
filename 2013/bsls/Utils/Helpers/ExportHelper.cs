#region Copyright (C) 1994-2009, Johnson & Johnson PRD, LLC.
//---------------------------------------------------------------------------*
//
//    CompoundSubmissionClipboardHelper.cs: Helper for copy\paste operations in GridDataBoundGrid
//
//---
//
//    Copyright (C) 1994-2008, Johnson & Johnson PRD, LLC.
//    All Rights Reserved.
//
//    Vitaly Chupaev, 11/2008
//
//---------------------------------------------------------------------------*/
#endregion

using System;
using System.Collections;
using System.Data;
using Syncfusion.Windows.Forms.Grid;
using System.Windows.Forms;

namespace Jnj.ThirdDimension.Utils.BarcodeSeries
{
   /// <summary>
   /// Class used as a return type for some methods in TDXImportExportHelper
   /// </summary>
   public class ExportData
   {
      public string[] TargetColumns;
      public DataColumn[] SourceColumns;
      public DataTable[] SourceTables;
      public Type[] SourceTypes;
   }

   /// <summary>
   /// Contains methods to prepare data for importing from or exporting to 3DX table
   /// The simpliest way to use for importing is to use with MapTableToDataTableDialog form.
   /// </summary>
   public class ExportHelper
   {
      #region Export
      /// <summary>
      /// 
      /// </summary>
      /// <param name="sourceTable"></param>
      /// <param name="collection">internal type: GridBoundColumnsCollection</param>
      /// <returns></returns>
      public ExportData GetExportData(DataTable sourceTable, ICollection collection)
      {
         GridBoundColumnsCollection gridColumns = (GridBoundColumnsCollection)collection;
         
         ExportData ed = new ExportData
                            {
                               TargetColumns = GetColumnsNames(gridColumns),
                               SourceColumns = GetDataColumnsArrayForExport(gridColumns, sourceTable),
                               SourceTables = GetDataTablesArrayForExport(gridColumns, sourceTable)
                            };
         ed.SourceTypes = GetTypesArrayForExport(ed.SourceColumns);

         return ed;
      }

      private string[] GetColumnsNames(GridBoundColumnsCollection gridColumns)
      {
         int k = 0;
         string[] cols = new string[gridColumns.Count];
         foreach (GridBoundColumn col in gridColumns)
         {
            cols[k++] = col.HeaderText;
         }
         return cols;
      }

      private Type[] GetTypesArrayForExport(DataColumn[] cols)
      {
         Type[] types = new Type[cols.Length];

         int k = 0;
         foreach (DataColumn col in cols)
         {
            types[k++] = col.DataType;
         }
         return types;
      }

      private DataTable[] GetDataTablesArrayForExport(GridBoundColumnsCollection coll, DataTable dt)
      {
         DataTable[] tables = new DataTable[coll.Count];

         int k = 0;
         foreach (GridBoundColumn gridCol in coll)
         {
            if (gridCol.StyleInfo.CellType == "ComboBox")
            {
               tables[k++] = MapComboBoxColumnValueToDisplayMember(coll, dt, GetDataColumnByName(gridCol.MappingName, dt));
            }
            else
            {
               tables[k++] = dt;
            }
         }

         return tables;
      }

      private DataColumn[] GetDataColumnsArrayForExport(GridBoundColumnsCollection coll, DataTable dt)
      {
         DataColumn[] columns = new DataColumn[coll.Count];

         int k = 0;
         foreach (GridBoundColumn gridCol in coll)
         {
            columns[k++] = GetDataColumnByName(gridCol.MappingName, dt);
         }
         return columns;
      }

      private DataColumn GetDataColumnByName(string name, DataTable dt)
      {
         foreach (DataColumn dataCol in dt.Columns)
         {
            if (name == dataCol.ColumnName)
            {
               return dataCol;
            }
         }
         return null;
      }

      /// <summary>
      /// Returns a table with the only columns which are visible in the grid
      /// </summary>
      /// <param name="grid"></param>
      /// <param name="table"></param>
      /// <returns></returns>
      public static DataTable ExtractVisibleColumnsFromCurrentTable(GridDataBoundGrid grid)
      {
         return ExtractVisibleColumnsFromCurrentTable(grid, GetDataSourceTable(grid.DataSource));
      }

      /// <summary>
      /// Returns a table with the only columns which are visible in the grid
      /// </summary>
      /// <param name="grid"></param>
      /// <param name="table"></param>
      /// <returns></returns>
      public static DataTable ExtractVisibleColumnsFromCurrentTable(GridDataBoundGrid grid, DataTable table)
      {
         DataTable source = new DataTable();

         GridBoundColumnsCollection cols = grid.Binder.InternalColumns;
         //import columns
         foreach (GridBoundColumn col in cols)
         {
            source.Columns.Add(col.HeaderText);
         }

         //import data
         DataRow nr = null;

         foreach (DataRow row in table.Rows)
         {
            if (row.RowState == DataRowState.Deleted)
               continue;

            nr = source.NewRow();
            source.Rows.Add(nr);

            foreach (GridBoundColumn col in cols)
            {
               nr[col.HeaderText] = col.StyleInfo.HasDisplayMember && col.MappingName.EndsWith("_ID")
                                       ? GetDisplayMemberFromComboDataSource(col, row[col.MappingName].ToString())
                                       : row[col.MappingName];
            }
         }
         return source;
      }

      /// <summary>
      /// Returns collections for exporting to 3DX table
      /// </summary>
      public DataTable MapComboBoxColumnValueToDisplayMember(GridBoundColumnsCollection collection, DataTable source, DataColumn dataColumn)
      {
         DataTable result = new DataTable();

         // add columns preceding dataColumn
         for (int k = 0; k < dataColumn.Ordinal; k++)
         {
            result.Columns.Add();
         }

         // add dataColumn, display member - always a string
         result.Columns.Add(dataColumn.ColumnName, typeof(string));

         // get combobox source table and display/value members
         GridStyleInfo info = collection[dataColumn.ColumnName].StyleInfo;

         DataTable cmbDT;

         if (info.DataSource is DataView)
         {
            cmbDT = (info.DataSource as DataView).Table;
         }
         else
         {
            cmbDT = (DataTable) info.DataSource;
         }

         string displMem = info.DisplayMember;
         string valMem = info.ValueMember;
         bool found = false;

         foreach (DataRowView viewRow in source.DefaultView)
         {
            DataRow row = result.NewRow();
            string val = viewRow[dataColumn.Ordinal].ToString();
            found = false;

            foreach (DataRow cmbRow in cmbDT.Rows)
            {
               if (cmbRow[valMem].ToString().ToUpper() == val.ToUpper())
               {
                  row[dataColumn.Ordinal] = cmbRow[displMem];
                  result.Rows.Add(row);
                  found = true;
                  break;
               }
            }

            // in case no match found
            if (!found)
            {
               row[dataColumn.Ordinal] = val;
               result.Rows.Add(row);
            }
         }
         return result;
      }

      /// <summary>
      /// Gets source table from DataSource
      /// </summary>
      /// <param name="p"></param>
      /// <returns></returns>
      public static DataTable GetDataSourceTable(object dataSource)
      {
         object ds = (dataSource is BindingSource) ? ((BindingSource)dataSource).DataSource : dataSource;
         return (ds is DataView) ? (ds as DataView).Table : (DataTable)ds;
      }

      /// <summary>
      /// Returns display memeber for combobox value member
      /// </summary>
      /// <param name="gbc"></param>
      /// <param name="value">value member</param>
      /// <returns>ValueMember for Combobox DisplayValue</returns>
      public static string GetDisplayMemberFromComboDataSource(GridBoundColumn gbc, string value)
      {
         GridStyleInfo info = gbc.StyleInfo;
         string displMem = info.DisplayMember;
         string valMem = info.ValueMember;

         DataTable cmDt = GetDataSourceTable(info.DataSource);

         foreach (DataRow row in cmDt.Rows)
         {
            if (row[valMem].ToString().ToUpper() == value.ToUpper())
            {
               return row[displMem].ToString();
            }
         }
         return String.Empty;
      }
      #endregion
   }
}
