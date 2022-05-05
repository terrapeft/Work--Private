using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace UsersDb.Code
{
    public class SearchParameters
    {
        // search
        public string SearchFor { get; set; }
        public string[] SearchGroups { get; set; }
        public string[] ExchangeCodes { get; set; }
        public string[] ContractTypes { get; set; }
        public int? SearchOption { get; set; }
        public string ContractNumber { get; set; }
        public int? PageSize { get; set; }
        public int? PageNumber { get; set; }

        // series
        public bool? IncludeRoot { get; set; }
        public bool? IncludeSeries { get; set; }
        public string Format { get; set; }
        public bool? CsvColumns { get; set; }
        public bool? CsvQuotes { get; set; }

        /// <summary>
        /// "1" stands for true, "0" - for false
        /// </summary>
        /// <value>
        /// The find all.
        /// </value>
        public int? FindAll { get; set; }

        public bool? RootSearch { get; set; }

        // save query
        public string QueryName { get; set; }
        public bool? IncludeKeyword { get; set; }
        public string[] RootColumns { get; set; }
        public string[] SeriesColumns { get; set; }
        public bool? IsDeleted { get; set; }
        public bool? Compress { get; set; }
    }
}
