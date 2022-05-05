using System.Collections.Generic;
using System.Data;
using SpansLib.Db;

namespace SpansLib.Data.PositionalFormats.FileReaders
{
    public interface IFileReader
    {
        IEnumerable<RecordTableName> TableNames { get; }
        IEnumerable<RecordDefinition> FormatDefinitions { get; }
        IEnumerable<ExtraField> ExtraFields { get; }
        DataSet GetDataSet();
        string MasterRecordType { get; }
    }
}
