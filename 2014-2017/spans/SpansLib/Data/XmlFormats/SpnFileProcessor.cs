using System;
using System.Data;
using System.Linq;
using System.Text;
using System.Xml;
using System.Xml.Linq;
using System.Xml.Schema;
using SharedLibrary;
using SpansLib.Db;

namespace SpansLib.Data.XmlFormats
{
    public class SpnFileProcessor
    {
        public void BulkLoad(string connStr, string schemaFilePath, string dataFilePath, bool createTables, bool validate = false)
        {
            if (validate)
            {
                ValidateXml(schemaFilePath, dataFilePath);
            }

            if (createTables)
            {
                var db = new DbHelper(connStr);

                // drop and create tables
                db.ExecuteDdl(AppSettings.SpanSqlFile);
            }

            var xbi = new SqlXmlBulkInsert(connStr);
            xbi.BulkLoad(dataFilePath, schemaFilePath, AppSettings.SqlXmlBulkLoadErrorFile);
        }

        private void ValidateXml(string schemaFilePath, string dataFilePath)
        {
            var schemas = new XmlSchemaSet();
            schemas.Add(string.Empty, XmlReader.Create(schemaFilePath));

            var xdoc = XDocument.Load(dataFilePath);
            xdoc.Validate(schemas, (sender, args) => { throw new Exception(args.Message); });
        }

        public virtual string GenerateDdlScript(DataSet ds, bool drop = false)
        {
            if (ds == null) return string.Empty;

            var sb = new StringBuilder();

            // data tables
            foreach (var dt in ds.Tables.Cast<DataTable>())
            {
                sb.AppendFormat(drop
                    ? AppSettings.TableDropAndCreateSqlFormatOpen
                    : AppSettings.TableCreateSqlFormatOpen,
                    dt.TableName);

                foreach (DataColumn col in dt.Columns)
                {
                    sb.AppendFormat(Constants.ColumnTemplate, col.ColumnName, col.DataType.GetSqlType(), col.AllowDBNull ? Constants.Null : Constants.NotNull);
                }

                sb.Append(AppSettings.TableDropOrCreateSqlFormatClose);
            }

            return sb.ToString();
        }
    }
}
