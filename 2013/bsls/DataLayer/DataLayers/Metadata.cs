using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using Jnj.ThirdDimension.Utils.BarcodeSeries;

namespace Jnj.ThirdDimension.Data.BarcodeSeries
{
   public partial class SeriesDataLayer
   {
      public class Metadata
      {

         #region Private members

         private SeriesDataLayer dl;

         private const string SchemaSql = "SchemaSql";
         private const string TableSql = "TableSql_Format";
         private const string FieldSql = "FieldSql_Format";
         private const string SequenceSql = "SequenceSql_Format";

         #endregion

         
         #region Constructors

         private Metadata()
         {
            // Prevents anyone from creating a Instrument instance without the data layer.
         }

         public Metadata(SeriesDataLayer dl)
            : this()
         {
            this.dl = dl;
         }

         #endregion

         #region DB access methods

         public List<string> GetSchemas()
         {
            return dl.Get<DataTable>(dl[SchemaSql]).RowsToList();
         }

         public List<string> GetTables(string schema)
         {
            return dl.Get<DataTable>(string.Format(dl[TableSql], schema)).RowsToList();
         }

         public List<string> GetFields(string schema, string table)
         {
            return dl.Get<DataTable>(string.Format(dl[FieldSql], table, schema)).RowsToList();
         }

         public List<string> GetSequences(string schema)
         {
            return dl.Get<DataTable>(string.Format(dl[SequenceSql], schema)).RowsToList();
         }


         #endregion

      }
   }
}
