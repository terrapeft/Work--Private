using SpansLib.Db;

namespace SpansLib.Data.PositionalFormats.FileReaders
{
    public sealed class Pa3FileReader : BaseFileReader
    {
        public Pa3FileReader(string filePath)
        {
            base.FilePath = filePath;
            DefEntities = SpansEntities.GetInstance();
            MasterRecordType = SpanRecordType.Type0;
            FileFormat = GetFileFormat(Constants.Pa3, MasterRecordType, 35, 2);
            LoadDefinitions(FileFormat);
        }
    }
}
