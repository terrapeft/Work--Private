using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using SharedLibrary;
using SharedLibrary.Cache;
using UsersDb.Code;
using UsersDb.DataContext;
using UsersDb.Helpers;

namespace UsersDb.Search
{
    /// <summary>
    /// Class shares methods required both for API and Web UI.
    /// </summary>
    public class XymDataManager
    {
        private const string whereClauseFormat = "({0}='{1}' and {2}='{3}')";
        private static readonly string[] keyColumns =
        {
            Constants.ExchangeCodeColumn,
            Constants.ContractTypeColumn,
            Constants.ContractNameColumn,
            Constants.ContractNumberColumn,
            Constants.TickerCodeColumn
        };

        /// <summary>
        /// Searches the specified keyword.
        /// </summary>
        /// <param name="prms">The PRMS.</param>
        /// <param name="count">The number of records.</param>
        /// <returns></returns>
        public static DataSet Search(SearchParametersJson prms, out int count)
        {
            var ds = new DataSet();

            using (var dataContext = new UsersDataContext())
            {
                var se = new SearchEngine(dataContext, prms);

                var results = se
                    .SetDataSource(CacheHelper.Get(Constants.XymRootTableName, CommonActions.LoadXymRootLevelGlobalFunc))
                    .SetVisibleColumns(prms.VisibleRootColumns)
                    .SetPersistantColumns(keyColumns)
                    .SetProtectedColumns(GetRestrictedColumns(dataContext, prms.VisibleRootColumns, SearchTables.XymRootLevelGLOBAL))
                    .SetRemoveColumns(ServiceConfig.Exclude_Root_Columns)
                    .ApplyRulesAndFilters()
                    .Find(out count)
                    .GetPage(prms.PageNumber, prms.PageSize, Constants.ExchangeCodeColumn, Constants.ContractTypeColumn);

                ds.Tables.Add(results.ResultsDataTable);

                var tableNames = ds.Tables
                    .Cast<DataTable>()
                    .Select(t => t.TableName);

                if (prms.ExportSeries)
                {
                    var seriesAll = FindSeries(results.RawSearchResults, prms, out count);
                    seriesAll.TableName = DbHelper.GetTableName(tableNames.ToList(), "Series");
                    ds.Tables.Add(seriesAll);
                }
                else if (prms.CheckSeriesAvailability)
                {
                    var dt = GetSeriesAvailability(results.ResultsDataTable.Rows.Cast<DataRow>());
                    dt.TableName = DbHelper.GetTableName(tableNames.ToList(), "Availability");
                    ds.Tables.Add(dt);
                }

                if (results.HasProtectedData && !prms.ExportSeries)
                {
                    var dt = new DataTable { TableName = DbHelper.GetTableName(tableNames.ToList(), "Protection") };
                    dt.Columns.Add("HasProtectedData", typeof(bool));
                    var row = dt.NewRow();
                    row[0] = true;
                    dt.Rows.Add(row);
                    ds.Tables.Add(dt);
                }
            }

            return ds;
        }


        /// <summary>
        /// Finds the suggestions.
        /// </summary>
        /// <param name="prms">The search parameters.</param>
        /// <returns></returns>
        public static List<string> FindSuggestions(SearchParametersJson prms)
        {
            try
            {
                if (string.IsNullOrEmpty(prms.Keyword) || prms.Keyword.Length < ServiceConfig.Prediction_Min_Length)
                {
                    return new List<string>();
                }

                using (var dataContext = new UsersDataContext())
                {
                    var se = new SearchEngine(dataContext, prms);

                    return se
                        .SetDataSource(CacheHelper.Get(Constants.XymRootTableName, CommonActions.LoadXymRootLevelGlobalFunc))
                        .SetPersistantColumns(keyColumns)
                        .SetVisibleColumns(prms.VisibleRootColumns)
                        .SetRemoveColumns(ServiceConfig.Exclude_Root_Columns)
                        //.SetProtectedColumns(GetRestrictedColumns(dataContext, prms.VisibleRootColumns, SearchTables.XymRootLevelGLOBAL))
                        .ApplyRulesAndFilters()
                        .FindSuggestions()
                        .Suggestions
                        .OrderBy(i => i)
                        .ToList();
                }
            }
            catch (Exception ex)
            {
                Logger.LogError(ex);
                throw;
            }
        }

        /// <summary>
        /// Search for extended data by key.
        /// </summary>
        /// <param name="exchangeCode">The exchange code.</param>
        /// <param name="contractNumber">The contract number.</param>
        /// <param name="prms">The search parameters.</param>
        /// <param name="count">The count.</param>
        /// <returns></returns>
        public static DataSet FindSeries(string exchangeCode, string contractNumber, SearchParametersJson prms, out int count)
        {
            using (var h = new DbHelper(Config.UsersConnectionString))
            using (var dataContext = new UsersDataContext())
            {
                h.Connection.Open();

                var series = LoadSeries(GetEcctTable(exchangeCode, contractNumber), prms, h, out count);
                return ApplyRulesAndFiltersForSeries(dataContext, series, prms);
            }
        }

        /// <summary>
        /// Search for extended data by key.
        /// </summary>
        /// <param name="rootTableRows">The root table rows.</param>
        /// <param name="prms">The search parameters.</param>
        /// <param name="count">The count.</param>
        /// <returns></returns>
        public static DataTable FindSeries(IEnumerable<DataRow> rootTableRows, SearchParametersJson prms, out int count)
        {
            using (var h = new DbHelper(Config.UsersConnectionString))
            using (var dataContext = new UsersDataContext())
            {
                h.Connection.Open();

                if (rootTableRows.Any())
                {
                    var series = LoadSeries(GetEcctTable(rootTableRows), prms, h, out count);
                    return ApplyRulesAndFiltersForSeries(dataContext, series, prms).Tables[0].Copy();
                }

                count = 0;
                return new DataTable();
            }
        }

        /// <summary>
        /// Gets unique exchange codes.
        /// </summary>
        /// <returns></returns>
        public static DataSet GetUniqueExchangeCodes(string dbAlias)
        {
            try
            {
                var ds = new DataSet();
                var dt = CacheHelper
                    .Get(Constants.ExchangeCodesCacheKey, dbAlias, CommonActions.LoadExchangeCodesFunc)
                    .Copy(); // copy it, otherwise a cached table will belong to the dataset of a previous call.

                ds.Tables.Add(dt);
                return ds;
            }
            catch (Exception ex)
            {
                Logger.LogError(ex);
                throw;
            }
        }

        /// <summary>
        /// Gets unique contract types.
        /// </summary>
        /// <returns></returns>
        public static DataSet GetUniqueContractTypes(string dbAlias)
        {
            try
            {
                var ds = new DataSet();
                var dt = CacheHelper
                    .Get(Constants.ContractTypesCacheKey, dbAlias, CommonActions.LoadContractTypesFunc)
                    .Copy(); // copy it, otherwise a cached table will belong to the dataset of a previous call.

                ds.Tables.Add(dt);
                return ds;
            }
            catch (Exception ex)
            {
                Logger.LogError(ex);
                throw;
            }
        }

        /// <summary>
        /// Gets the list of the columns from the XymRootLevelGLOBAL table.
        /// </summary>
        /// <param name="tableName">Name of the table.</param>
        /// <returns></returns>
        public static IEnumerable<string> GetTableColumns(string tableName)
        {
            try
            {
                var dt = CacheHelper.Get("_columns", tableName, CommonActions.LoadTableColumnsFunc);

                return dt.Rows
                    .Cast<DataRow>()
                    .Select(r => r[0].ToString())
                    .ToList();
            }
            catch (Exception ex)
            {
                Logger.LogError(ex);
                throw;
            }
        }


        #region Private methods

        /// <summary>
        /// Applies the rules and filters for series.
        /// </summary>
        /// <param name="dataContext">The data context.</param>
        /// <param name="seriesTable">The series table.</param>
        /// <param name="prms">The PRMS.</param>
        /// <returns></returns>
        private static DataSet ApplyRulesAndFiltersForSeries(UsersDataContext dataContext, DataTable seriesTable, SearchParametersJson prms)
        {
            var se = new SearchEngine(dataContext, prms);
            var results = se
                .SetDataSource(seriesTable)
                .SetVisibleColumns(prms.VisibleSeriesColumns)
                .SetRemoveColumns(ServiceConfig.Exclude_Series_Columns)
                .SetProtectedColumns(GetRestrictedColumns(dataContext, prms.VisibleSeriesColumns,
                        SearchTables.XymREUTERSTradedSeriesGLOBAL))
                .SetPersistantColumns(keyColumns)
                .ApplyRulesAndFilters()
                .ActualizeResults()
                .GetPage(Constants.ExchangeCodeColumn, Constants.ContractNumberColumn);

            var ds = new DataSet();
            ds.Tables.Add(results.ResultsDataTable);

            return ds;
        }

        /// <summary>
        /// Gets the series availability.
        /// </summary>
        /// <param name="rootTableRows">The root table rows.</param>
        /// <returns></returns>
        private static DataTable GetSeriesAvailability(IEnumerable<DataRow> rootTableRows)
        {
            if (rootTableRows.Any())
            {
                using (var helper = new DbHelper(Config.UsersConnectionString))
                {
                    helper.Connection.Open();
                    var dts = helper.CallStoredProcedure("dbo.spCUIHasSeries", new Dictionary<string, object>
                    {
                        {"@ecct", GetEcctTable(rootTableRows)}
                    });

                    return dts.Tables.Count > 0 ? dts.Tables[0].Detach() : new DataTable();
                }
            }

            return new DataTable();
        }

        /// <summary>
        /// Creates table with ExchangeCode and ContractNumber columns filled with values.
        /// </summary>
        /// <param name="exchangeCode">The exchange code.</param>
        /// <param name="contractNumber">The contract number.</param>
        /// <returns></returns>
        private static DataTable GetEcctTable(string exchangeCode, string contractNumber)
        {
            var dt = new DataTable();
            dt.Columns.Add(Constants.ExchangeCodeColumn);
            dt.Columns.Add(Constants.ContractNumberColumn);

            var r = dt.NewRow();

            r[Constants.ExchangeCodeColumn] = exchangeCode;
            r[Constants.ContractNumberColumn] = contractNumber;

            dt.Rows.Add(r);

            return dt;
        }

        /// <summary>
        /// Creates table with ExchangeCode and ContractNumber columns filled with values.
        /// </summary>
        /// <param name="rows">The rows.</param>
        /// <returns></returns>
        private static DataTable GetEcctTable(IEnumerable<DataRow> rows)
        {
            var dt = rows.CopyToDataTable();
            dt.Columns
                .Cast<DataColumn>()
                .Where(c => c.ColumnName != Constants.ExchangeCodeColumn && c.ColumnName != Constants.ContractNumberColumn)
                .ToList()
                .ForEach(c => dt.Columns.Remove(c));

            return dt;
        }

        /// <summary>
        /// Loads data from XymREUTERSTradedSeriesGLOBAL by keys.
        /// </summary>
        /// <param name="ecct">The ExchangeCode - ContractNumber pairs.</param>
        /// <param name="prms">The PRMS.</param>
        /// <param name="dbHelper">The database helper.</param>
        /// <param name="count">The number of total records.</param>
        /// <returns></returns>
        private static DataTable LoadSeries(DataTable ecct, SearchParametersJson prms, DbHelper dbHelper, out int count)
        {
            var cols = prms.VisibleSeriesColumns.Count == 0
                ? "*".ToList()
                : prms.VisibleSeriesColumns.Union(keyColumns);

            var ds = dbHelper.CallStoredProcedure("spCUIGetSeries", string.Empty, new Dictionary<string, object>
            {
                {"@columns", cols.ToTable("string")},
                {"@page", prms.PageNumber},
                {"@pageSize", prms.PageSize},
                {"@ecct", ecct}
            },
            out count);

            return ds.Tables.Count == 0 ? new DataTable() : ds.Tables[0];
        }

        /// <summary>
        /// Gets the restricted columns.
        /// </summary>
        /// <param name="dataContext">The data context.</param>
        /// <param name="visibleColumns">The user series columns.</param>
        /// <param name="st">The st.</param>
        /// <returns></returns>
        private static IEnumerable<string> GetRestrictedColumns(UsersDataContext dataContext, IEnumerable<string> visibleColumns, SearchTables st)
        {
            var user = dataContext.CurrentUser;
            var restrictedColumns = new List<string>();
            visibleColumns = visibleColumns ?? new List<string>();

            // not totaly a LINQ query used here in order to avoid the "Referencing Non-Scalar Variables Not Supported" limitation
            foreach (var groupPermissions in dataContext.SearchGroups.Where(s => s.TableId == (int)st).Select(g => g.Permissions))
            {
                var pm = groupPermissions.Except(user.Permissions);
                restrictedColumns.AddRange(pm
                    .SelectMany(j => j.SearchGroups
                        .Where(s => s.TableId == (int)st)
                        .Where(g => g.TableId == (int)st)
                        .SelectMany(g => g.SearchColumns))
                    .Select(c => c.Name));
            }

            return visibleColumns.Any()
                ? restrictedColumns.Intersect(visibleColumns)
                : restrictedColumns;
        }

        #endregion

    }
}