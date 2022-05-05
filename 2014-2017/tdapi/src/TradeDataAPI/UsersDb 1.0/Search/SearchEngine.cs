using System;
using System.Collections;
using System.Collections.Concurrent;
using System.Collections.Generic;
using System.Data;
using System.Globalization;
using System.Linq;
using System.Threading.Tasks;
using UsersDb.Code;
using UsersDb.DataContext;
using UsersDb.Helpers;

namespace UsersDb.Search
{
    public class SearchEngine
    {
        #region Private members

        private UsersDataContext dataContext;

        // input fields
        private string keyword;
        private SearchOptions comparisonOperator;
        private int maxNumberOfSuggestions;

        private DataTable sourceDt = new DataTable();

        private List<string> removeColumns = new List<string>();
        private List<string> protectedColumns = new List<string>();
        private List<string> keyColumns = new List<string>();
        private List<string> lookupColumns = new List<string>();
        private List<string> visibleColumns = new List<string>();
        private List<string> searchGroups = new List<string>();

        private Dictionary<string, List<string>> filterParams = new Dictionary<string, List<string>>();

        // output fields
        private DataTable resultsDt = new DataTable();
        private List<DataRow> pagedRows = new List<DataRow>();
        //private List<DataRow> dataRows = new List<DataRow>();

        private ConcurrentStack<DataRow> searchResultsStack = new ConcurrentStack<DataRow>();
        private ConcurrentStack<string> suggestionsStack = new ConcurrentStack<string>();

        private IEnumerable<string> suggestions = new List<string>();

        #endregion


        #region Public properties

        /// <summary>
        /// Returns all results as is.
        /// </summary>
        /// <value>
        /// The raw search results.
        /// </value>
        public ConcurrentStack<DataRow> RawSearchResults
        {
            get { return searchResultsStack; }
        }

        /// <summary>
        /// Returns a set of trimmed and ordered suggestions.
        /// </summary>
        /// <value>
        /// The suggestions.
        /// </value>
        public IEnumerable<string> Suggestions
        {
            get { return suggestions; }
        }

        /// <summary>
        /// Returns results of Find() method.
        /// </summary>
        /// <value>
        /// The results data table.
        /// </value>
        public DataTable ResultsDataTable
        {
            get { return resultsDt; }
        }


        /// <summary>
        /// Indicates whether current result set contains protected data.
        /// </summary>
        public bool HasProtectedData { get; set; }

        #endregion


        #region Construtor

        public SearchEngine(UsersDataContext dc, SearchParametersJson prms)
        {
            dataContext = dc;
            keyword = prms.Keyword;
            comparisonOperator = prms.ComparisonOperator;
            searchGroups = prms.SearchGroups;
            maxNumberOfSuggestions = prms.MaxNumberOfSuggestions;
            filterParams = prms.Filter;
        }

        #endregion


        #region Public methods


        /// <summary>
        /// Sets the data source.
        /// </summary>
        /// <param name="dataSource">The data source.</param>
        /// <returns></returns>
        public SearchEngine SetDataSource(DataTable dataSource)
        {
            sourceDt = dataSource;
            pagedRows = sourceDt.Rows.Cast<DataRow>().ToList();

            return this;
        }

        /// <summary>
        /// These columns will always be among search columns.
        /// </summary>
        /// <param name="keys">The keys.</param>
        /// <returns></returns>
        public SearchEngine SetPersistantColumns(params string[] keys)
        {
            keyColumns = keys.ToList();

            return this;
        }

        /// <summary>
        /// The data in these columns will be replaced with protection message.
        /// </summary>
        /// <param name="cols">The cols.</param>
        /// <returns></returns>
        public SearchEngine SetProtectedColumns(IEnumerable<string> cols)
        {
            protectedColumns = cols.ToList();

            return this;
        }

        /// <summary>
        /// The data in these columns will be replaced with protection message.
        /// </summary>
        /// <param name="cols">The cols.</param>
        /// <returns></returns>
        public SearchEngine SetRemoveColumns(IEnumerable<string> cols)
        {
            removeColumns = cols.ToList();

            return this;
        }

        public SearchEngine SetVisibleColumns(List<string> cols)
        {
            visibleColumns = cols.ToList();

            return this;
        }

        public SearchEngine ApplyRulesAndFilters()
        {
            ApplyColumnsSets();
            ApplyDataFilter();

            return this;
        }

        /// <summary>
        /// Processes the current page data - removes columns, copies rows to output table.
        /// </summary>
        /// <returns></returns>
        public SearchEngine ActualizeResults()
        {
            int k;
            return ActualizeResults(out k);
        }

        /// <summary>
        /// Processes the current page data - removes columns, copies rows to output table.
        /// </summary>
        /// <param name="numOfResults">The number of results.</param>
        /// <returns></returns>
        public SearchEngine ActualizeResults(out int numOfResults)
        {
            numOfResults = 0;

            // apply column changes
            if (pagedRows.Any())
            {
                numOfResults = pagedRows.Count;
                resultsDt = pagedRows.CopyToDataTable();

                if (visibleColumns.Any())
                {
                    resultsDt.Columns.Cast<DataColumn>()
                        .Select(col => col.ColumnName)
                        .Except(visibleColumns)
                        .ToList()
                        .ForEach(c => resultsDt.Columns.Remove(c));
                }

                // apply column changes
                pagedRows = resultsDt.Rows.Cast<DataRow>().ToList();
            }

            return this;
        }

        /// <summary>
        /// Finds the specified keyword.
        /// </summary>
        /// <param name="numOfResults">The number of results.</param>
        /// <returns></returns>
        public SearchEngine Find(out int numOfResults)
        {
            Parallel.For(0, pagedRows.Count, (i, loopState) =>
            {
                var row = pagedRows[i];
                if (lookupColumns.Select(col => DbHelper.GetDbString(row[col])).Any(val => Compare(keyword, val, comparisonOperator)))
                {
                    searchResultsStack.Push(row);
                }
            });

            pagedRows = searchResultsStack.ToList();

            ActualizeResults(out numOfResults);

            return this;
        }


        /// <summary>
        /// Finds the suggestions.
        /// </summary>
        /// <returns></returns>
        public SearchEngine FindSuggestions()
        {
            Parallel.For(0, pagedRows.Count, (i, loopState) =>
            {
                if (suggestionsStack.Count >= maxNumberOfSuggestions)
                {
                    loopState.Break();
                }

                var row = pagedRows[i];

                foreach (var val in lookupColumns
                    .Select(col => DbHelper.GetDbString(row[col]))
                    .Where(val => Compare(keyword, val, comparisonOperator))
                    .Where(val => !suggestionsStack.Contains(val)))
                {
                    suggestionsStack.Push(val);
                }
            });

            suggestions = suggestionsStack.Take(maxNumberOfSuggestions);

            return this;
        }


        /// <summary>
        /// Orders by keys and sets the ResultsDataTable to contain data for specified page.
        /// </summary>
        /// <param name="orderBy">The order by.</param>
        /// <param name="thenBy">The then by.</param>
        /// <returns></returns>
        public SearchEngine GetPage(string orderBy, string thenBy)
        {
            pagedRows = pagedRows
                .OrderBy(r => r[orderBy])
                .ThenBy(r => r[thenBy])
                .ToList();

            ReplaceRestrictedData(pagedRows);
            resultsDt = pagedRows.Any() ? pagedRows.CopyToDataTable() : new DataTable();

            return this;
        }


        /// <summary>
        /// Orders by keys and sets the ResultsDataTable to contain data for specified page.
        /// </summary>
        /// <param name="pageNumber">The page number.</param>
        /// <param name="pageSize">Size of the page.</param>
        /// <param name="orderBy">The order by.</param>
        /// <param name="thenBy">The then by.</param>
        /// <returns></returns>
        public SearchEngine GetPage(int pageNumber, int pageSize, string orderBy, string thenBy)
        {
            if (pageSize > 0)
            {
                pagedRows = pagedRows
                    .OrderBy(r => r[orderBy])
                    .ThenBy(r => r[thenBy])
                    .Skip(pageSize * pageNumber)
                    .Take(pageSize)
                    .ToList();
            }

            ReplaceRestrictedData(pagedRows);
            resultsDt = pagedRows.Any() ? pagedRows.CopyToDataTable() : new DataTable();

            return this;
        }

        #endregion


        #region Private methods

        /// <summary>
        /// Replaces the restricted data with predefined message.
        /// </summary>
        /// <param name="rows">The rows.</param>
        private void ReplaceRestrictedData(IEnumerable rows)
        {
            if (rows != null && removeColumns != null)
            {
                var row = rows.Cast<DataRow>().FirstOrDefault();
                if (row != null)
                {
                    removeColumns.ForEach(n => row.Table.Columns.Remove(n));
                }
            }

            if (rows == null || protectedColumns == null)
                return;

            foreach (DataRow row in rows)
            {
                foreach (var protectedColumn in protectedColumns.Where(c => row[c] != DBNull.Value))
                {
                    row[protectedColumn] = Resources.Search_Results_Require_Permission;
                    HasProtectedData = true;
                }
            }
        }

        /// <summary>
        /// A list of columns (configured in Admin UI), which are allowed for search.
        /// Other columns are ignored.
        /// </summary>
        /// <returns></returns>
        private SearchEngine SetLookupColumns()
        {
            // expand groups to columns
            // if no ids provided, get all available for the XymRootLevelGLOBAL table
            lookupColumns = ((!searchGroups.Any() || (searchGroups.Count == 1 && searchGroups.Contains("0")))
                ? dataContext.SearchableGroups
                    .SelectMany(g => g.SearchColumns.Select(c => c.Name))
                : searchGroups
                    .Select(str => Convert.ToInt32(str))
                    .SelectMany(id => dataContext.SearchableGroups
                        .Where(g => g.Id == id)
                        .SelectMany(g => g.SearchColumns.Select(c => c.Name))))
                .Distinct()
                .ToList();

            return this;
        }

        /// <summary>
        /// Updates the columns collections accroding to rules.
        /// E.g. remove all lookup columns except selected by user, etc.
        /// </summary>
        /// <returns></returns>
        private void ApplyColumnsSets()
        {
            SetLookupColumns();

            if (visibleColumns.Any() && lookupColumns.Any())
            {
                visibleColumns.AddRange(keyColumns);

                // lookup cols should have all user's cols + keys
                lookupColumns = lookupColumns.Intersect(visibleColumns).ToList();
            }

            if (lookupColumns.Any())
            {
                lookupColumns = lookupColumns.Except(removeColumns).ToList();
            }

            if (visibleColumns.Any() && protectedColumns.Any())
            {
                // protected cols should not contain anything what not in user's cols
                protectedColumns = protectedColumns.Intersect(visibleColumns).ToList();
            }
        }

        /// <summary>
        /// Applies user's filter.
        /// </summary>
        /// <returns></returns>
        private void ApplyDataFilter()
        {
            pagedRows = sourceDt.Select(QueryBuilder.Filter(filterParams)).ToList();
        }

        /// <summary>
        /// Compares the specified keyword taking into account the search option.
        /// </summary>
        /// <param name="keyword">The keyword.</param>
        /// <param name="val">The val.</param>
        /// <param name="searchOption">The search option.</param>
        /// <returns></returns>
        private static bool Compare(string keyword, string val, SearchOptions searchOption)
        {
            if (searchOption == SearchOptions.Equals)
                return val.Equals(keyword, StringComparison.InvariantCultureIgnoreCase);

            if (searchOption == SearchOptions.Contains)
                return CultureInfo.InvariantCulture.CompareInfo.IndexOf(val, keyword, CompareOptions.IgnoreCase) > -1;

            if (searchOption == SearchOptions.EndsWith)
                return val.EndsWith(keyword, StringComparison.InvariantCultureIgnoreCase);

            return val.StartsWith(keyword, StringComparison.InvariantCultureIgnoreCase);
        }

        #endregion
    }
}