using SpansLib.Db;

namespace SpansLib.Data.PositionalFormats.FileReaders
{
    public sealed class Pa5FileReader : BaseFileReader
    {
        public Pa5FileReader(string filePath)
        {
            base.FilePath = filePath;
            DefEntities = SpansEntities.GetInstance();
            MasterRecordType = SpanRecordType.Type10;
            FileFormat = GetFileFormat(Constants.Pa5, MasterRecordType, 2, 3);
            LoadDefinitions(FileFormat);
        }
    }
}
