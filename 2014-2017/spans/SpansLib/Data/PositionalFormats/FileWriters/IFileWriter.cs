using SpansLib.Data.PositionalFormats.FileReaders;

namespace SpansLib.Data.PositionalFormats.FileWriters
{
    public interface IFileWriter
    {
        void UploadData(string connectionString, IFileReader reader, bool appendData);
        void UploadData(string connectionString, IFileReader reader, int? batchId, bool appendData);
    }
}
