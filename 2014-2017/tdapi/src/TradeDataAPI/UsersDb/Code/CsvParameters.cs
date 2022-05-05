namespace UsersDb.Code
{
    /// <summary>
    /// CSV parameters.
    /// </summary>
    public class CsvParameters
    {
        private string delimiter = ",";

        public bool ForceQuotes;

        public bool ShowColumnNames;

        public string Delimiter
        {
            get { return delimiter; }
            set { delimiter = string.IsNullOrEmpty(value) ? delimiter : value; }
        }
    }
}