using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using SpansLib.Data.PositionalFormats.RecordReaders;
using SpansLib.Db;

namespace SpansLib.Data.PositionalFormats.FileReaders
{
    /// <summary>
    /// Common logic for file parsers.
    /// </summary>
    public abstract class BaseFileReader : IFileReader
    {
        private IEnumerable<ExtraField> _extraFields;
        private IEnumerable<RecordTableName> _tableNames;
        private IEnumerable<RecordDefinition> _formatDefinitions;
        private IEnumerable<Relationship> _relationships;

        protected string FilePath;
        protected SpansEntities DefEntities;
        protected string FileFormat;
        protected Dictionary<string, int> HouseOfParents = new Dictionary<string, int>();

        public IEnumerable<RecordTableName> TableNames
        {
            get { return _tableNames; }
            protected set { _tableNames = value; }
        }

        public IEnumerable<RecordDefinition> FormatDefinitions
        {
            get { return _formatDefinitions; }
        }

        /// <summary>
        /// Gets the collection of tables for the file.
        /// Collection contains all the defined tables even if no appropriate records were found in the file.
        /// Tables contains all the possible fields, including conditional layout (for the record type 4).
        /// </summary>
        /// <returns></returns>
        public virtual DataSet GetDataSet()
        {
            var ds = CreateDataSet();

            using (var file = new StreamReader(File.OpenRead(FilePath)))
            {
                string line;
                int lineNumber = 0;
                while ((line = file.ReadLine()) != null)
                {
                    if (string.IsNullOrEmpty(line)) continue;
                    InsertLine(ds, line, ++lineNumber);
                }
            }

            return ds;
        }

        public string MasterRecordType { get; protected set; }

        public IEnumerable<ExtraField> ExtraFields
        {
            get { return _extraFields; }
            set { _extraFields = value; }
        }

        /// <summary>
        /// Gets the file format which is located in the master record of the file.
        /// </summary>
        /// <param name="expectedFormat">The expected file format.</param>
        /// <param name="expectedRecord">The expected record type.</param>
        /// <param name="startPosition">The start position to read file format.</param>
        /// <param name="fieldLength">Length of the file format field.</param>
        /// <returns></returns>
        /// <exception cref="System.Exception">Unsupported record type.</exception>
        protected virtual string GetFileFormat(string expectedFormat, string expectedRecord, int startPosition, int fieldLength)
        {
            using (var file = new StreamReader(File.OpenRead(FilePath)))
            {
                var line = file.ReadLine();

                if (line == null || line.Substring(0, 2).Trim() != expectedRecord)
                {
                    throw new Exception(string.Format(AppSettings.ReportPaUnknownRecordTemplate, line ?? string.Empty));
                }

                var format = line.Substring(startPosition, fieldLength).Replace(" ", string.Empty);

                if (format != expectedFormat)
                {
                    throw new Exception(string.Format(AppSettings.ReportPaUnknownFileTemplate, format));
                }

                return format;
            }
        }

        /// <summary>
        /// Loads the fields definitions for the determined file format.
        /// </summary>
        /// <param name="fileFormat">The file format.</param>
        /// <returns></returns>
        protected virtual void LoadDefinitions(string fileFormat)
        {
            _formatDefinitions = DefEntities
                .RecordsDefinitions
                .Where(d => d.FileFormat == fileFormat)
                .ToList();

            _extraFields = DefEntities
                .ExtraFields
                .Where(f => f.FileFormat == fileFormat)
                .ToList();

            _tableNames = DefEntities
                .RecordTableNames
                .Where(t => t.FileFormat == fileFormat)
                .ToList();

            _relationships = DefEntities
                .Relationships
                .Where(r => r.FileFormat == fileFormat)
                .ToList();
        }

        /// <summary>
        /// Parses the line and inserts casted values into the data set.
        /// </summary>
        /// <param name="ds">The ds.</param>
        /// <param name="line">The line.</param>
        /// <param name="lineNum">The line number.</param>
        protected virtual void InsertLine(DataSet ds, string line, int lineNum)
        {
            // create a reader according to the line's type
            var reader = CreateRecordReader(line);

            try
            {
                // split the line into collection
                reader.Parse(line, FormatDefinitions);
            }
            catch (Exception ex)
            {
                AddError(ds, ex.ToString(), FilePath, lineNum, line);
            }

            var table = _tableNames.FirstOrDefault(tn => tn.RecordId == reader.RecordType);
            if (table == null)
            {
                AddError(ds, AppSettings.ReportPaUnknownRecord, FilePath, lineNum, line);
                return;
            }

            // update the house of parents
            if (HouseOfParents.ContainsKey(reader.RecordType))
            {
                HouseOfParents.Remove(reader.RecordType);
            }

            // keep the most recent ids in one collection
            HouseOfParents.Add(reader.RecordType, lineNum);

            // add line number
            reader.NamedValues.Add(new KeyValuePair<string, dynamic>(AppSettings.LineNumberFieldName, lineNum));

            // check if a parent line number can be added
            SendRecordToHouseOfParents(reader);
            
            // add values collection to the DataSet
            var dt = ds.Tables[table.TableName];
            var row = dt.NewRow();

            foreach (var pair in reader.NamedValues)
            {
                row[pair.Key] = SafeDbValue(pair.Value);
            }

            dt.Rows.Add(row);
        }

        private object SafeDbValue(object value)
        {
            if (value == null) return DBNull.Value;
            if (value == DBNull.Value) return value;
            if (string.IsNullOrEmpty(value.ToString())) return DBNull.Value;

            return value;
        }

        private void AddError(DataSet ds, string ex, string file, int lineNum, string line)
        {
            var dt = ds.Tables[AppSettings.ErrorTableName];
            if (dt != null)
            {
                var row = dt.NewRow();
                row[Constants.ColumnFilename] = file;
                row[Constants.ColumnLine] = line;
                row[Constants.ColumnError] = ex;
                row[Constants.ColumnLocation] = lineNum;

                dt.Rows.Add(row);
            }
        }

        /// <summary>
        /// Keeps track of current parent records according to the cfg_Relationships table,
        /// updates records with parent line number.
        /// </summary>
        /// <param name="reader">The reader.</param>
        private void SendRecordToHouseOfParents(IRecordReader reader)
        {
            // if there is no parent key, look for the grandparent and so on, as sometimes it may happen, 
            // like with parent for record type 2 for the pa2 format, it's parent either P, or if it is not present, then 1, which is a parent of P.
            var parentLineNumber = GetParentLineNumber(_relationships.First(r => r.RecordId == reader.RecordType));

            // add parent line number
            reader.NamedValues.Add(new KeyValuePair<string, dynamic>(AppSettings.ParentLineNumberFieldName, parentLineNumber));
        }

        /// <summary>
        /// Gets the parent line number.
        /// </summary>
        /// <param name="record">The record.</param>
        /// <returns></returns>
        private int GetParentLineNumber(Relationship record)
        {
            while (true)
            {
                if (record.ParentRecordId.StartsWith("-"))
                {
                    return HouseOfParents[record.RecordId];
                }

                if (HouseOfParents.ContainsKey(record.ParentRecordId))
                {
                    return HouseOfParents[record.ParentRecordId];
                }

                record = _relationships.First(r => r.RecordId == record.ParentRecordId);
            }
        }

        /// <summary>
        /// Finds and creates the appropriate record type class instance.
        /// </summary>
        /// <param name="line">The line.</param>
        /// <returns></returns>
        protected virtual IRecordReader CreateRecordReader(string line)
        {
            // otherwise use base reader
            return new BaseRecordReader();
        }

        /// <summary>
        /// Generates an in-memory DataSet out of the format definitions provided in the riskParametersRecordTypes collection.
        /// </summary>
        /// <returns></returns>
        protected DataSet CreateDataSet()
        {
            var ds = new DataSet();

            // add columns for defined fields, they will store data from file
            _formatDefinitions
                .Where(f => !string.IsNullOrEmpty(f.ColumnName))
                .GroupBy(d => d.RecordType)
                .ToList()
                .ForEach(recordGroup =>
                {
                    var tn = TableNames.First(n => n.RecordId == recordGroup.Key);
                    var dt = new DataTable(tn.TableName);

                    foreach (var recordType in recordGroup)
                    {
                        dt.Columns.Add(recordType.ColumnName, GetColumnType(recordType.DataType));
                    }

                    ds.Tables.Add(dt);
                });

            // add special columns to keep relationships between records
            foreach (DataTable dt in ds.Tables)
            {
                var rec = TableNames.First(n => n.TableName == dt.TableName).RecordId;

                _extraFields
                    .Where(ef => ef.RecordId == rec)
                    .ToList()
                    .ForEach(ef => dt.Columns.Add(ef.FieldName, GetColumnType(ef.FieldType)));
            }

            // add table to store parse errors
            ds.Tables.Add(CreateErrorTable());
            return ds;
        }

        /// <summary>
        /// Table that keeps parsing errors.
        /// </summary>
        /// <returns></returns>
        private DataTable CreateErrorTable()
        {
            var dt = new DataTable(AppSettings.ErrorTableName);
            dt.Columns.Add(Constants.ColumnFilename, typeof(string));
            dt.Columns.Add(Constants.ColumnLine, typeof(string));
            dt.Columns.Add(Constants.ColumnError, typeof(string));
            dt.Columns.Add(Constants.ColumnLocation, typeof(string));

            return dt;
        }

        /// <summary>
        /// Maps the SQL Server data type to .Net type.
        /// </summary>
        /// <param name="dataType">Type of the data.</param>
        /// <returns></returns>
        private Type GetColumnType(string dataType)
        {
            if (dataType.StartsWith(Constants.TypeNvarchar, StringComparison.OrdinalIgnoreCase)) return typeof(string);
            if (dataType.StartsWith(Constants.TypeDecimal, StringComparison.OrdinalIgnoreCase)) return typeof(decimal);
            if (dataType.Equals(Constants.TypeInt, StringComparison.OrdinalIgnoreCase)) return typeof(Int32);
            if (dataType.Equals(Constants.TypeBigint, StringComparison.OrdinalIgnoreCase)) return typeof(Int64);
            if (dataType.StartsWith(Constants.TypeDate, StringComparison.OrdinalIgnoreCase)) return typeof(DateTime);
            if (dataType.StartsWith(Constants.TypeTime, StringComparison.OrdinalIgnoreCase)) return typeof(TimeSpan);
            if (dataType.StartsWith(Constants.TypeReal, StringComparison.OrdinalIgnoreCase)) return typeof(double);

            return typeof(string);
        }
    }
}
