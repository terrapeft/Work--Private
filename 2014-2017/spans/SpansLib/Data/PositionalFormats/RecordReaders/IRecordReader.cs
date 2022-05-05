using System.Collections.Generic;
using SpansLib.Db;

namespace SpansLib.Data.PositionalFormats.RecordReaders
{
    public interface IRecordReader
    {
        string RecordType { get; }
        void Parse(string line, IEnumerable<RecordDefinition> recordDefinitions);
        List<KeyValuePair<string, dynamic>> NamedValues { get; }
    }
}
