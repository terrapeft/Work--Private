using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using SpansLib.Data.PositionalFormats.FileReaders;
using SpansLib.Db;

namespace SpansLib.Data.PositionalFormats.FileWriters
{

    /// <summary>
    /// Common logic for file writers.
    /// </summary>
    public abstract class BaseFileWriter : IFileWriter
    {
        protected IEnumerable<RecordTableName> TableNames;   // collection of table names for the currents file format
        protected IEnumerable<RecordDefinition> FormatDefinitions;
        protected IEnumerable<ExtraField> ExtraFields;
        protected string Filename;
        protected string ConnStr;
        protected bool Overwrite;

        protected BaseFileWriter(string filename)
        {
            this.Filename = filename;
        }

        /// <summary>
        /// Generates the DDL script.
        /// </summary>
        /// <param name="ds">The data set.</param>
        /// <param name="drop">if set to <c>true</c> existed tables will be dropped, otherwise skipped.</param>
        /// <returns></returns>
        public virtual string GenerateDdlScript(DataSet ds, bool drop = false)
        {
            if (ds == null) return string.Empty;

            var sb = new StringBuilder();

            // data tables
            foreach (DataTable dt in ds.Tables.Cast<DataTable>().Where(t => t.TableName != AppSettings.ErrorTableName))
            {
                var recType = TableNames.First(t => t.TableName == dt.TableName);

                sb.AppendFormat(drop
                    ? AppSettings.TableDropAndCreateSqlFormatOpen
                    : AppSettings.TableCreateSqlFormatOpen,
                    dt.TableName);

                foreach (DataColumn col in dt.Columns)
                {
                    // look for column definitions in format specific columns first
                    var info = FormatDefinitions.FirstOrDefault(d => d.RecordType == recType.RecordId && d.ColumnName == col.ColumnName);
                    if (info != null)
                    {
                        sb.AppendFormat(Constants.NullableColumnTemplate, info.ColumnName, info.DataType);
                    }
                    else
                    {
                        // then look in the extra fields collection
                        var eInfo = ExtraFields.FirstOrDefault(ef => ef.RecordId == recType.RecordId && ef.FieldName == col.ColumnName);
                        if (eInfo != null)
                        {
                            sb.AppendFormat(Constants.NotNullableColumnTemplate, eInfo.FieldName, eInfo.FieldType);
                        }
                    }
                }

                sb.Append(AppSettings.TableDropOrCreateSqlFormatClose);
            }

            // error table
            var errDt = ds.Tables[AppSettings.ErrorTableName];
            sb.AppendFormat(drop
                ? AppSettings.TableDropAndCreateSqlFormatOpen
                : AppSettings.TableCreateSqlFormatOpen,
                errDt.TableName);

            foreach (DataColumn col in errDt.Columns)
            {
                sb.AppendFormat(Constants.NullableColumnTemplate, col.ColumnName, AppSettings.DefaultStringColumnType);
            }

            sb.Append(AppSettings.TableDropOrCreateSqlFormatClose);

            return sb.ToString();
        }


        public void UploadData(string connectionString, IFileReader reader, bool appendData)
        {
            UploadData(connectionString, reader, null, appendData);
        }

        /// <summary>
        /// Creates data tables out of the definitions,
        /// creates the file mapping table with the script from app.config,
        /// then uploads data.
        /// </summary>
        /// <param name="connectionString">The connection string.</param>
        /// <param name="reader">The reader.</param>
        /// <param name="batchId">The batch identifier.</param>
        /// <param name="appendData">if set to <c>true</c> [append data].</param>
        public virtual void UploadData(string connectionString, IFileReader reader, int? batchId, bool appendData)
        {
            var data = reader.GetDataSet();

            using (data)
            {
                this.TableNames = reader.TableNames;
                this.FormatDefinitions = reader.FormatDefinitions;
                this.ExtraFields = reader.ExtraFields;
                this.ConnStr = connectionString;
                this.Overwrite = !appendData;

                var db = new DbHelper(ConnStr);

                // add columns
                var script = GenerateDataSetScript(data, reader.MasterRecordType);

                // create tables if not exist
                db.ExecuteScript(script);

                // insert current file into FileMapping and get its ID back
                var fileId = (int)db.ExecuteScalar(string.Format(AppSettings.FileMappingInsertSqlFormat, batchId == null 
                    ? Constants.Null 
                    : batchId.ToString(), Filename));

                InsertFileIdInDataSet(data, fileId, reader.MasterRecordType);

                // insert data
                db.BulkInsert(data);
            }
        }

        /// <summary>
        /// Once tables were created according to format definitions, they require to be updated with some relationships information.
        /// </summary>
        /// <param name="data">The data.</param>
        /// <param name="recordType">Type of the record.</param>
        /// <returns></returns>
        protected virtual string GenerateDataSetScript(DataSet data, string recordType)
        {
            // create tables script
            var script = new StringBuilder(GenerateDdlScript(data, Overwrite));

            // add the Id primary key column to Master table (record type 0)
            var masterTable = TableNames.First(t => t.RecordId == recordType);
            script.Append(string.Format(AppSettings.FileIdForMasterTableSqlFormat, masterTable.TableName, AppSettings.FileIdFieldName));

            return script.ToString();
        }

        /// <summary>
        /// Inserts the source file id in data set.
        /// </summary>
        /// <param name="data">The data.</param>
        /// <param name="fileId">The file identifier.</param>
        /// <param name="recordType">Type of the record.</param>
        protected virtual void InsertFileIdInDataSet(DataSet data, int fileId, string recordType)
        {
            // this action is in order not to create another private method
            Action<string, string> insertAction = (tableName, columnName) =>
            {
                var dt = data.Tables[tableName];
                foreach (DataRow row in dt.Rows)
                {
                    row[AppSettings.FileIdFieldName] = fileId;
                }
            };

            // Master table
            var mtn = TableNames.First(t => t.RecordId == recordType).TableName;
            insertAction.Invoke(mtn, AppSettings.FileIdFieldName);

            // other tables
            data.Tables
                .Cast<DataTable>()
                .Where(dt => dt.TableName != mtn && !dt.TableName.StartsWith(AppSettings.ImportTablesPrefix))
                .ToList()
                .ForEach(dt => insertAction.Invoke(dt.TableName, AppSettings.FileIdFieldName));
        }
    }
}
