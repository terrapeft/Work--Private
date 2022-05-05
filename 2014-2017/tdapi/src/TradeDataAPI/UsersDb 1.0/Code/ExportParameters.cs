using UsersDb.Helpers;

namespace UsersDb.Code
{
    /// <summary>
    /// Export parameters
    /// </summary>
    public class ExportParameters
    {
        public CsvParameters Csv = new CsvParameters();

        public ResultType OutputFormat = ResultType.Csv;

        public bool IncludeSeries;

        public bool IncludeRoot;

        public bool IndentJson;
    }
}