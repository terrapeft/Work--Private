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

        private readonly UsersDataContext _dataContext;

        // input fields
        private readonly string _keyword;
        private readonly SearchOptions _comparisonOperator;
        private readonly int _maxNumberOfSuggestions;

        private DataTable _sourceDt = new DataTable();

        private List<string> _removeColumns = new List<string>();
        private List<string> _protectedColumns = new List<string>();
        private List<string> _keyColumns = new List<string>();
        private List<string> _lookupColumns = new List<string>();
        private List<string> _visibleColumns = new List<string>();
        private readonly List<string> _searchGroups;

        private readonly Dictionary<string, List<string>> _filterParams;

        // output fields
        private DataTable _resultsDt = new DataTable();
        private List<DataRow> _pagedRows = new List<DataRow>();
        //private List<DataRow> dataRows = new List<DataRow>();

        private readonly ConcurrentStack<DataRow> _searchResultsStack = new ConcurrentStack<DataRow>();
        private readonly ConcurrentStack<string> _suggestionsStack = new ConcurrentStack<string>();

        private IEnumerable<string> _suggestions = new List<string>();

        #endregion


        #region Public properties

        /// <summary>
        /// Returns all results as is.
        /// </summary>
        /// <value>
        /// The raw search results.
        /// </value>
        public ConcurrentStack<DataRow> RawSearchResults => _searchResultsStack;

        /// <summary>
        /// Returns a set of trimmed and ordered suggestions.
        /// </summary>
        /// <value>
        /// The suggestions.
        /// </value>
        public IEnumerable<string> Suggestions => _suggestions;

        /// <summary>
        /// Returns results of Find() method.
        /// </summary>
        /// <value>
        /// The results data table.
        /// </value>
        public DataTable ResultsDataTable => _resultsDt;


        /// <summary>
        /// Indicates whether current result set contains protected data.
        /// </summary>
        public bool HasProtectedData { get; set; }

        #endregion


        #region Construtor

        public SearchEngine(UsersDataContext dc, SearchParametersJson prms)
        {
            _dataContext = dc;
            _keyword = prms.Keyword;
            _comparisonOperator = prms.ComparisonOperator;
            _searchGroups = prms.SearchGroups;
            _maxNumberOfSuggestions = prms.MaxNumberOfSuggestions;
            _filterParams = prms.Filter;
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
            _sourceDt = dataSource;
            _pagedRows = _sourceDt.Rows.Cast<DataRow>().ToList();

            return this;
        }

        /// <summary>
        /// These columns will always be among search columns.
        /// </summary>
        /// <param name="keys">The keys.</param>
        /// <returns></returns>
        public SearchEngine SetPersistantColumns(params string[] keys)
        {
            _keyColumns = keys.ToList();

            return this;
        }

        /// <summary>
        /// The data in these columns will be replaced with protection message.
        /// </summary>
        /// <param name="cols">The cols.</param>
        /// <returns></returns>
        public SearchEngine SetProtectedColumns(IEnumerable<string> cols)
        {
            _protectedColumns = cols.ToList();

            return this;
        }

        /// <summary>
        /// The data in these columns will be replaced with protection message.
        /// </summary>
        /// <param name="cols">The cols.</param>
        /// <returns></returns>
        public SearchEngine SetRemoveColumns(IEnumerable<string> cols)
        {
            _removeColumns = cols.ToList();

            return this;
        }

        public SearchEngine SetVisibleColumns(List<string> cols)
        {
            _visibleColumns = cols.ToList();

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
            if (_pagedRows.Any())
            {
                numOfResults = _pagedRows.Count;
                _resultsDt = _pagedRows.CopyToDataTable();

                if (_visibleColumns.Any())
                {
                    _resultsDt.Columns.Cast<DataColumn>()
                        .Select(col => col.ColumnName)
                        .Except(_visibleColumns)
                        .ToList()
                        .ForEach(c => _resultsDt.Columns.Remove(c));
                }

                // apply column changes
                _pagedRows = _resultsDt.Rows.Cast<DataRow>().ToList();
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
            Parallel.For(0, _pagedRows.Count, (i, loopState) =>
            {
                var row = _pagedRows[i];

                if (_comparisonOperator == SearchOptions.Contains)
                {
                    // search by all words in a phrase
                    var keys = _keyword.Split(new[] { ' ' }, StringSplitOptions.RemoveEmptyEntries);

                    // merge searchable columns in one string, this makes logic easier for looking for multiple words
                    var rowData = row.Merge(_lookupColumns);

                    if (keys.All(key => Compare(key, rowData, _comparisonOperator)))
                    {
                        _searchResultsStack.Push(row);
                    }
                }
                else
                {
                    if (_lookupColumns.Select(col => DbHelper.GetDbString(row[col])).Any(val => Compare(_keyword, val, _comparisonOperator)))
                    {
                        _searchResultsStack.Push(row);
                    }
                }
            });

            _pagedRows = _searchResultsStack.ToList();

            ActualizeResults(out numOfResults);

            return this;
        }


        /// <summary>
        /// Finds the suggestions.
        /// </summary>
        /// <returns></returns>
        public SearchEngine FindSuggestions()
        {
            Parallel.For(0, _pagedRows.Count, (i, loopState) =>
            {
                if (_suggestionsStack.Count >= _maxNumberOfSuggestions)
                {
                    loopState.Break();
                }

                var row = _pagedRows[i];

                foreach (var val in _lookupColumns
                    .Select(col => DbHelper.GetDbString(row[col]))
                    .Where(val => Compare(_keyword, val, _comparisonOperator))
                    .Where(val => !_suggestionsStack.Contains(val)))
                {
                    _suggestionsStack.Push(val);
                }
            });

            _suggestions = _suggestionsStack.Take(_maxNumberOfSuggestions);

            return this;
        }


        /// <summary>
        /// Orders by keys and sets the ResultsDataTable to contain data for specified page.
        /// </summary>
        /// <param name="orderBy">The order by.</param>
        /// <param name="ascending">Sort direction.</param>
        /// <returns></returns>
        public SearchEngine GetPage(string orderBy, bool ascending)
        {
            if (ascending)
                _pagedRows = _pagedRows
                    .OrderBy(r => r[orderBy])
                    .ToList();
            else
                _pagedRows = _pagedRows
                    .OrderByDescending(r => r[orderBy])
                    .ToList();

            ReplaceRestrictedData(_pagedRows);
            _resultsDt = _pagedRows.Any() ? _pagedRows.CopyToDataTable() : new DataTable();

            return this;
        }


        /// <summary>
        /// Orders by keys and sets the ResultsDataTable to contain data for specified page.
        /// </summary>
        /// <param name="pageNumber">The page number.</param>
        /// <param name="pageSize">Size of the page.</param>
        /// <param name="orderBy">The order by.</param>
        /// <param name="ascending">Sort direction.</param>
        /// <returns></returns>
        public SearchEngine GetPage(int pageNumber, int pageSize, string orderBy, bool ascending)
        {
            if (pageSize > 0)
            {
                if (ascending)
                    _pagedRows = _pagedRows
                        .OrderBy(r => r[orderBy])
                        .Skip(pageSize * pageNumber)
                        .Take(pageSize)
                        .ToList();
                else
                    _pagedRows = _pagedRows
                        .OrderByDescending(r => r[orderBy])
                        .Skip(pageSize * pageNumber)
                        .Take(pageSize)
                        .ToList();
            }

            ReplaceRestrictedData(_pagedRows);
            _resultsDt = _pagedRows.Any() ? _pagedRows.CopyToDataTable() : new DataTable();

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
            if (rows != null && _removeColumns != null)
            {
                var row = rows.Cast<DataRow>().FirstOrDefault();
                if (row != null)
                {
                    _removeColumns.ForEach(n => row.Table.Columns.Remove(n));
                }
            }

            if (rows == null || _protectedColumns == null)
                return;

            foreach (DataRow row in rows)
            {
                foreach (var protectedColumn in _protectedColumns.Where(c => row[c] != DBNull.Value))
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
            _lookupColumns = ((!_searchGroups.Any() || (_searchGroups.Count == 1 && _searchGroups.Contains("0")))
                ? _dataContext.SearchableGroups
                    .SelectMany(g => g.SearchColumns.Select(c => c.Name))
                : _searchGroups
                    .Select(str => Convert.ToInt32(str))
                    .SelectMany(id => _dataContext.SearchableGroups
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

            if (_visibleColumns.Any() && _lookupColumns.Any())
            {
                _visibleColumns.AddRange(_keyColumns);

                // lookup cols should have all user's cols + keys
                _lookupColumns = _lookupColumns.Intersect(_visibleColumns).ToList();
            }

            if (_lookupColumns.Any())
            {
                _lookupColumns = _lookupColumns.Except(_removeColumns).ToList();
            }

            if (_visibleColumns.Any() && _protectedColumns.Any())
            {
                // protected cols should not contain anything what not in user's cols
                _protectedColumns = _protectedColumns.Intersect(_visibleColumns).ToList();
            }
        }

        /// <summary>
        /// Applies user's filter.
        /// </summary>
        /// <returns></returns>
        private void ApplyDataFilter()
        {
            _pagedRows = _sourceDt.Select(QueryBuilder.Filter(_filterParams)).ToList();
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