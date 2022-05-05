using SpansLib.Db;

namespace SpansLib.Data.PositionalFormats.FileReaders
{
    public sealed class Pa6FileReader : BaseFileReader
    {
        public Pa6FileReader(string filePath)
        {
            base.FilePath = filePath;
            DefEntities = SpansEntities.GetInstance();
            MasterRecordType = SpanRecordType.Type10;
            FileFormat = GetFileFormat(Constants.Pa6, MasterRecordType, 2, 3);
            LoadDefinitions(FileFormat);
        }
    }
}
