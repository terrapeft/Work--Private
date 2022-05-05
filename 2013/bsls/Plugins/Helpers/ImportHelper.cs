using System;
using System.Collections.Generic;
using System.Text;
using System.Data;
using Jnj.ThirdDimension.Mt.Data;
using Jnj.ThirdDimension.Controls.BarcodeSeries;

namespace Jnj.ThirdDimension.Explorer.BarcodeSeries
{
   /// <summary>
   /// Contains methods for importing data from 3DX table to DataTable
   /// </summary>
   public class ImportHelper
   {
      #region Import
      private static List<string> overridesList;

      /// <summary>
      /// Contains values which will be replaced by default value when found in importing data
      /// </summary>
      public static List<string> OverridesList
      {
         get
         {
            if (overridesList == null)
            {
               overridesList = new List<string>();
               overridesList.Add("0");
               overridesList.Add("");
            }
            return overridesList;
         }
      }

      /// <summary>
      /// Returns table with column names from mappingsCollection and values from source table
      /// </summary>
      /// <param name="mappingsCollection">Collection of names pairs source-destination and default values</param>
      /// <param name="table">Source table</param>
      /// <returns></returns>
      public static DataTable PrepareForImportFrom3DXTable(MapTableToDataTableDialog.MappingsCollection mappingsCollection, DataTable table)
      {
         if (mappingsCollection == null || mappingsCollection.Count == 0)
         {
            return table;
         }

         DataTable dt = new DataTable();
         MapTableToDataTableDialog.Mapping m;

         // create columns with names from mapping collection
         foreach (MapTableToDataTableDialog.Mapping mapping in mappingsCollection)
         {
            dt.Columns.Add(mapping.DestinationName);
         }

         // copy values from source rows to the new table
         foreach (DataRow row in table.Rows)
         {
            DataRow destRow = dt.NewRow();

            for (int k = 0; k < dt.Columns.Count; k++)
            {
               m = mappingsCollection[k];

               // if no matching destination column fill this column with default values
               if (string.IsNullOrEmpty(m.SourceName))
               {
                  destRow[k] = m.DefaultValue;
               }
               else
               {
                  object val = row[m.SourceName];

                  // if source cell has no value or "empty" value - replace it with default value
                  // from mapping collection
                  if (!string.IsNullOrEmpty(m.DefaultValue) && IsValueCanBeOverriden(val))
                  {
                     destRow[k] = m.DefaultValue;
                  }
                  else
                  {
                     destRow[k] = val;
                  }
               }
            }
            dt.Rows.Add(destRow);
         }
         return dt;
      }

      /// <summary>
      /// Converts 3DX Table to DataTable
      /// </summary>
      /// <param name="tdxTable"></param>
      /// <returns></returns>
      public static DataTable Convert3DXTable2DataTable(Table tdxTable)
      {
         DataTable newTable = new DataTable();

         // create columns
         foreach (TableColumn col in tdxTable.Columns)
         {
            newTable.Columns.Add(col.Name, col.ItemType);
         }

         // copy data
         foreach (TableRow tdxRow in tdxTable.Rows)
         {
            DataRow newRow = newTable.NewRow();
            newRow.ItemArray = tdxRow.ItemArray;
            newTable.Rows.Add(newRow);
         }
         
         newTable.AcceptChanges();
         return newTable;
      }

      /// <summary>
      /// Checks if the value should be replaced by default value, by default they are null and DBNull.Value 
      /// </summary>
      /// <param name="val"></param>
      /// <returns></returns>
      public static bool IsValueCanBeOverriden(object val)
      {
         return val == null || val == DBNull.Value || OverridesList.Contains(val.ToString());
      }

      #endregion
   }
}
