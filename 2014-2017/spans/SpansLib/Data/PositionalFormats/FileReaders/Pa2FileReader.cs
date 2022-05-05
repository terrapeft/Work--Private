using SpansLib.Db;

namespace SpansLib.Data.PositionalFormats.FileReaders
{
    public sealed class Pa2FileReader : BaseFileReader
    {
        public Pa2FileReader(string filePath)
        {
            base.FilePath = filePath;
            DefEntities = SpansEntities.GetInstance();
            MasterRecordType = SpanRecordType.Type0;
            FileFormat = GetFileFormat(Constants.Pa2, MasterRecordType, 35, 2);
            LoadDefinitions(FileFormat);
        }
    }
}
