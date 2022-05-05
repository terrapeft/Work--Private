using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Diagnostics;
using System.Dynamic;
using System.IO;
using System.Linq;
using System.Net;
using System.Reflection;
using System.ServiceModel;
using System.ServiceModel.Activation;
using System.ServiceModel.Channels;
using System.ServiceModel.Web;
using System.Text;
using System.Web;
using Ionic.Zip;
using Ionic.Zlib;
using Newtonsoft.Json;
using TradeDataAPI.Converters;
using TradeDataAPI.Helpers;
using UsersDb;
using UsersDb.Helpers;
using SharedLibrary;
using SharedLibrary.Cache;
using UsersDb.Code;
using UsersDb.DataContext;
using UsersDb.Search;

namespace TradeDataAPI
{
    //[ServiceBehavior(IncludeExceptionDetailInFaults = true)]
    [AspNetCompatibilityRequirements(RequirementsMode = AspNetCompatibilityRequirementsMode.Required)]
    public class ExportDataService : IExportDataService
    {
        #region Private members

        private readonly UsersDataContext dataContext = new UsersDataContext();

        #endregion

        #region Contract Methods

        /// <summary>
        /// Clears the cached values of the ServiceConfig and the Resources tables.
        /// </summary>
        /// <param name="username">The username.</param>
        /// <param name="password">The password.</param>
        /// <returns></returns>
        public Message ClearCache(string username, string password)
        {
            var ctx = WebOperationContext.Current;

            var rp = new RequestParameters { Username = username, Password = password };
            new AccessHelper(dataContext, rp)
                .VerifyIP(AccessHelper.GetIPAddress())
                .WithUsers(d => d.Administrators)
                .TryAuthenticate();

            var msg = "Cache has been reset.";

            try
            {
                var enumerator = CacheHelper.Cache.GetEnumerator();
                var cacheItems = new List<string>();

                while (enumerator.MoveNext())
                {
                    cacheItems.Add(enumerator.Key.ToString());
                }

                foreach (var key in cacheItems)
                {
                    CacheHelper.Cache.Remove(key);
                }

                CacheHelper.LoadAsync(Constants.XymRootTableName, CommonActions.LoadXymRootLevelGlobalFunc);

                ServiceConfig.PreloadAsync();
                Resources.PreloadAsync();
            }
            catch (Exception ex)
            {
                Logger.LogError(ex);
                ctx.OutgoingResponse.StatusCode = HttpStatusCode.InternalServerError;
                msg = "Failed to clear cache.";
            }

            ctx.OutgoingResponse.StatusCode = HttpStatusCode.OK;
            return ctx.CreateTextResponse(msg, "text/plain");
        }

        /// <summary>
        /// Retrieves data for the sites.
        /// Unlike the GetData method, works with "virtual" methods "GetSymbol", "GetSeries" and "GetSeries" with modificator "search" on the place of the format,
        /// like api.dev/GetSeries/search?param1=[..]
        /// It gives more flexibility and allows to pass table-valued parameters to the stored procedures.
        /// </summary>
        /// <param name="dbAlias">The database alias.</param>
        /// <param name="storedProcId">The stored proc identifier.</param>
        /// <param name="username">The username.</param>
        /// <param name="password">The password.</param>
        /// <param name="pageSize">Size of the page.</param>
        /// <param name="pageNumber">The page number.</param>
        /// <param name="sortColumn">The sort column.</param>
        /// <param name="sortOrder">The sort order.</param>
        /// <param name="source">The data source.</param>
        /// <returns></returns>
        public Message GetSiteData(string dbAlias, string storedProcId, string username, string password, string pageSize, string pageNumber, string sortColumn, string sortOrder, string source)
        {
            var rp = GetParameters(dbAlias, storedProcId, ResultType.Json, username, password);
            var ctx = WebOperationContext.Current;
            HttpStatusCode statusCode;

            var str = StatisticCollector.LogCall(rp, out statusCode, () =>
            {
                new AccessHelper(dataContext, rp)
                    .VerifyIP(AccessHelper.GetIPAddress())
                    .TryAuthenticate()
                    .TryAuthorize()
                    .VerifyHitsCount();

                string errorMessage;
                ValidateMethodParams(rp, out errorMessage);

                var @params = rp.MethodArguments
                    .ToDictionary(k => k.ParameterName, v => (object)v.ParameterValue);

                if (rp.DataFilters != null && rp.DataFilters.Rows.Count > 0)
                {
                    @params.Add("filters", rp.DataFilters);
                }

                using (var h = new DbHelper(DatabaseConfiguration.GetConnectionString(dbAlias)))
                {
                    h.Connection.Open();
                    var ds = h.CallStoredProcedure(rp.StoredProcName, DatabaseConfiguration.GetStoredProcParamPrefix(dbAlias), @params);

                    string result;
                    var itsOk = ResultManager.GetConverter(rp).Convert(ds, out result);

                    if (itsOk && !dataContext.IsFreeMethod(rp.MethodName))
                    {
                        // if we are here, then it means there were no errors and result is not empty, 
                        // and thus we can encrease a hit counter
                        var user = dataContext.GetUser((int)rp.UserId);
                        user.Hits++;
                        user.SkipAuditTrail = true;
                        dataContext.SaveChanges();
                    }

                    return result;
                }
            });

            ctx.OutgoingResponse.StatusCode = statusCode;
            return ctx.CreateTextResponse(str, "text/plain");
            //return ctx.CreateTextResponse(str, "application/json");

        }

        /// <summary>
        /// Gets the data in appropriate format.
        /// </summary>
        /// <param name="dbAlias">The database alias.</param>
        /// <param name="storedProcId">The string to identify and choose the stored procedure in the lookup table.</param>
        /// <param name="format">The format.</param>
        /// <param name="username">The username.</param>
        /// <param name="password">The password.</param>
        /// <param name="pageSize">Size of the page.</param>
        /// <param name="pageNumber">The page number.</param>
        /// <param name="csvColNames">Show column names.</param>
        /// <param name="csvForceQuotes">Force quotes.</param>
        /// <param name="indentJson">Indent JSON.</param>
        /// <param name="csvDelimiter">The CSV delimiter.</param>
        /// <returns>
        /// String which contains XML or JSON or CSV or error message.
        /// </returns>
        public Message GetData(
            string dbAlias,
            string storedProcId,
            string format,
            string username,
            string password,
            string pageSize,
            string pageNumber,
            string csvColNames = "false",
            string csvForceQuotes = "false",
            string indentJson = "false",
            string csvDelimiter = ",")
        {
            var rp = GetParameters(dbAlias, storedProcId, format.ToEnumByName<ResultType>(), username, password, csvColNames, csvForceQuotes, indentJson, csvDelimiter);
            var ctx = WebOperationContext.Current;
            HttpStatusCode statusCode;

            var str = StatisticCollector.LogCall(rp, out statusCode, () =>
            {
                new AccessHelper(dataContext, rp)
                    .VerifyIP(AccessHelper.GetIPAddress())
                    .TryAuthenticate()
                    .TryAuthorize()
                    .VerifyHitsCount();

                string errorMessage;
                ValidateMethodParams(rp, out errorMessage);

                var @params = rp.MethodArguments
                    .ToDictionary(k => k.ParameterName, v => (object)v.ParameterValue);

                using (var h = new DbHelper(DatabaseConfiguration.GetConnectionString(dbAlias)))
                {
                    h.Connection.Open();
                    var ds = h.CallStoredProcedure(rp.StoredProcName, DatabaseConfiguration.GetStoredProcParamPrefix(dbAlias), @params);

                    var qp = new UrlQueryParser
                    {
                        IncludeColumns = ds.Tables
                            .Cast<DataTable>()
                            .ToDictionary(t => ds.Tables.IndexOf(t), t => t.Columns.Cast<DataColumn>().Select(c => c.ColumnName))
                    };

                    qp.BuildQuery(HttpUtility.UrlDecode(HttpContext.Current.Request.Url.Query).Split('&'));

                    string result;
                    var itsOk = ResultManager.GetConverter(rp).Convert(ds, qp.Filters, qp.Sort, pageSize.ToInt32(), pageNumber.ToInt32(), out result);

                    if (itsOk && !dataContext.IsFreeMethod(rp.MethodName))
                    {
                        // if we are here, then it means there were no errors and result is not empty, 
                        // and thus we can encrease a hit counter
                        var user = dataContext.GetUser((int)rp.UserId);
                        user.Hits++;
                        user.SkipAuditTrail = true;
                        dataContext.SaveChanges();
                    }

                    return result;
                }
            });

            ctx.OutgoingResponse.StatusCode = statusCode;
            return ctx.CreateTextResponse(str, "text/plain");

        }

        /// <summary>
        /// Returns help for the specified method.
        /// There are several cases:
        /// 1. No username and password provided.
        /// 2. Method has obligitory parameters thewere not specified.
        /// 3. All params are specified or there is no params.
        /// </summary>
        /// <param name="dbAlias">The database alias.</param>
        /// <param name="storedProcId">The stored proc id.</param>
        /// <param name="username">The username.</param>
        /// <param name="password">The password.</param>
        /// <returns></returns>
        public Message GetHelp(string dbAlias, string storedProcId, string username, string password)
        {
            var rp = GetParameters(dbAlias, storedProcId, ResultType.Help, username, password);

            var ctx = WebOperationContext.Current;
            HttpStatusCode statusCode;

            var str = StatisticCollector.LogCall(rp, out statusCode, () =>
            {
                var sb = new StringBuilder();

                new AccessHelper(dataContext, rp)
                    .TryAuthenticate()
                    .TryAuthorize()
                    .VerifyIP(AccessHelper.GetIPAddress());

                if (!string.IsNullOrEmpty(rp.Username))
                {
                    // virtual method GetBySymbol - search
                    if (storedProcId == Constants.SearchAlias)
                    {
                        sb.AppendFormat(ServiceConfig.GetBySymbol_API_Help, ServiceConfig.Default_Search_Option);
                    }

                    // data methods
                    else if (dataContext.GetUser((int)rp.UserId).MethodNames.Contains(rp.MethodName))
                    {
                        using (var h = new DbHelper(DatabaseConfiguration.GetConnectionString(dbAlias)))
                        {
                            h.Connection.Open();

                            var list = h.GetStoredProcedureParameters(rp.StoredProcName)
                                .Where(p => p.Direction == ParameterDirection.Input || p.Direction == ParameterDirection.InputOutput)
                                .ToList();

                            sb.AppendFormat("{0}{1}", rp.MethodName, Environment.NewLine);
                            sb.AppendLine("---------------------------------------------------------------------------------");
                            sb.AppendFormat("{0}Input:", Environment.NewLine);

                            if (list.Count == 0)
                            {
                                sb.Append(Resources.Help_Has_No_Input_Params);
                                sb.Append("Output");
                                sb.Append(GatherOutputMetaData(h, rp));
                            }
                            else
                            {
                                sb.AppendFormat("{0}{1}{1}", GatherInputMetaData(list), Environment.NewLine);
                                sb.Append("Output");

                                var allParams = rp.MethodArguments
                                    .Select(s => s.SqlParameterName)
                                    .ToList();

                                var procParams = list
                                    .Where(p => !p.IsNullable)
                                    .Select(p => p.Name)
                                    .ToList();

                                sb.Append(!procParams.Except(allParams).Any()
                                    ? GatherOutputMetaData(h, rp)
                                    : ": " + Resources.Help_Sp_Suggest_To_Specify_Params);
                            }

                            sb.Append(Resources.Help_Options);
                        }
                    }
                }

                return sb.ToString();
            });

            ctx.OutgoingResponse.StatusCode = statusCode;
            return ctx.CreateTextResponse(str, "text/plain");
            ;
        }

        /// <summary>
        /// Lists the methods available for the specified users.
        /// </summary>
        /// <param name="dbAlias">The database alias.</param>
        /// <param name="username">The username.</param>
        /// <param name="password">The password.</param>
        /// <returns></returns>
        public Message GetList(string dbAlias, string username, string password)
        {
            var rp = GetParameters(dbAlias, null, ResultType.List, username, password);

            var ctx = WebOperationContext.Current;
            HttpStatusCode statusCode;

            var str = StatisticCollector.LogCall(rp, out statusCode, () =>
            {
                new AccessHelper(dataContext, rp)
                    .TryAuthenticate()
                    .VerifyIP(AccessHelper.GetIPAddress());

                if (!dataContext.GetUser((int)rp.UserId).MethodNames.Any())
                {
                    statusCode = HttpStatusCode.NotFound;
                    throw new WebFaultException<string>(Resources.Error_404_Packages_Not_Found, statusCode);
                }

                using (var h = new DbHelper(DatabaseConfiguration.GetConnectionString(dbAlias)))
                {
                    h.Connection.Open();
                    var sb = new StringBuilder();

                    foreach (var m in dataContext.GetUser((int)rp.UserId).MethodNames)
                    {
                        try
                        {
                            sb.Append(h.GetStoredProcedureParametersFormatted(m, ParameterDirection.Input));
                        }
                        catch (Exception ex)
                        {
                            Logger.LogError(ex);
                        }
                    }

                    return sb.ToString();
                }
            });

            ctx.OutgoingResponse.StatusCode = statusCode;
            return ctx.CreateTextResponse(str, "text/plain");
        }

        /// <summary>
        /// Runs the query.
        /// </summary>
        /// <param name="dbAlias">The database alias.</param>
        /// <param name="format">The output format.</param>
        /// <param name="keyword">The keyword.</param>
        /// <param name="includeSeries">Include series data.</param>
        /// <param name="columnGroupIds">The column group ids.</param>
        /// <param name="searchOption">The search option.</param>
        /// <param name="exchangeCodes">The exchange codes.</param>
        /// <param name="contractTypes">The contract types.</param>
        /// <param name="username">The username.</param>
        /// <param name="password">The password.</param>
        /// <param name="pageSize">Size of the page.</param>
        /// <param name="pageNumber">The page number.</param>
        /// <param name="availability">If check for the Series availability.</param>
        /// <param name="includeRoot">Include root data.</param>
        /// <param name="csvColNames">The CSV col names.</param>
        /// <param name="csvForceQuotes">The CSV force quotes.</param>
        /// <param name="indentJson">The indent json.</param>
        /// <param name="csvDelimiter">The CSV delimiter.</param>
        /// <param name="compress">Return zip.</param>
        /// <returns></returns>
        public Message GetSearchResults(string dbAlias, string format, string keyword, string includeSeries, string columnGroupIds, string searchOption, string exchangeCodes,
            string contractTypes, string username, string password, string pageSize, string pageNumber, string availability,
            string includeRoot = "1",
            string csvColNames = "false",
            string csvForceQuotes = "false",
            string indentJson = "false",
            string csvDelimiter = ",",
            string compress = "0")
        {
            var rt = format.ToEnumByName<ResultType>();

            if (rt == ResultType.Help)
            {
                return GetHelp(dbAlias, Constants.SearchAlias, username, password);
            }

            var rp = GetParameters(dbAlias, Constants.SearchAlias, rt, username, password, csvColNames, csvForceQuotes, indentJson, UnescapeValue(csvDelimiter));
            var ctx = WebOperationContext.Current;

            var zip = compress == "1";

            MemoryStream zipStream = null;
            ZipFile zipFile = null;

            if (zip)
            {
                zipStream = new MemoryStream();
                zipFile = new ZipFile { CompressionLevel = CompressionLevel.BestCompression };
            }

            HttpStatusCode statusCode;

            var str = StatisticCollector.LogCall(rp, out statusCode, () =>
            {
                new AccessHelper(dataContext, rp)
                    .VerifyIP(AccessHelper.GetIPAddress())
                    .TryAuthenticate()
                    .TryAuthorize();

                if (rt == ResultType.Count || rt == ResultType.List || rt == ResultType.None)
                {
                    statusCode = HttpStatusCode.NotImplemented;
                    return Resources.Not_Implemented_Message;
                }

                rp.SearchParameters.Keyword = UnescapeValue(keyword);
                rp.SearchParameters.SearchGroups = columnGroupIds.ToList();
                rp.SearchParameters.IncludeSeries = (includeSeries ?? "0") == "1";
                rp.SearchParameters.IncludeRoot = (includeRoot ?? (zip ? "0" : "1")) == "1";
                rp.SearchParameters.CheckSeriesAvailability = (availability ?? "0") == "1";
                rp.SearchParameters.ComparisonOperator = searchOption.ToEnumByVal<SearchOptions>();
                rp.SearchParameters.Zip = zip;

                if (pageNumber != null)
                {
                    rp.SearchParameters.PageNumber = pageNumber.ToInt32();
                }

                rp.SearchParameters.PageSize = rt == ResultType.Count ? 0 : string.IsNullOrEmpty(pageSize) ? 0 : pageSize.ToInt32();

                rp.SearchParameters.Filter = new Dictionary<string, List<string>>
                {
                    {Constants.ExchangeCodeColumn, exchangeCodes.ToList(unescape: true)},
                    {Constants.ContractTypeColumn, contractTypes.ToList(unescape: true)}
                };

                string errorMessage;
                ValidateSearchParams(rp, out errorMessage);

                int rootCount;
                int seriesCount;
                var ds = XymDataManager.Search(rp.SearchParameters, out rootCount, out seriesCount);

                var tables = ds.Tables
                    .Cast<DataTable>();

                var result = new ExpandoObject();
                var converter = ResultManager
                    .GetConverter(rp)
                    .WithResultSet(result);

                converter.AddProperty("RootCount", rootCount);
                converter.AddProperty("SeriesCount", seriesCount);

                // add root data and root count
                if (rp.SearchParameters.IncludeRoot)
                {
                    var rootTables = tables
                        .Where(t => t.TableName.StartsWith("Table", StringComparison.OrdinalIgnoreCase))
                        .Select(t => t.TableName)
                        .ToList();

                    if (zip)
                    {
                        string rootData;
                        ResultManager.GetConverter(rp).Convert(ds.MoveTablesToNewDataSet(rootTables), out rootData);

                        if (!string.IsNullOrWhiteSpace(rootData) && !rootData.Equals("No results.", StringComparison.OrdinalIgnoreCase))
                        {
                            zipFile.AddEntry($"root.{format.ToLower()}", Encoding.UTF8.GetBytes(rootData)).LastModified = DateTime.Now;
                        }
                    }
                    else
                    {
                        // add not yet stringified result of convertion to the ResultSet
                        converter
                            .Options(ConverterOptions.IncludeNamedProperty, "Root")
                            .PrepareForSerialization(ds.MoveTablesToNewDataSet(rootTables), true);
                    }
                }

                // add series data and series count
                if (rp.SearchParameters.IncludeSeries)
                {
                    var seriesTables = tables
                        .Where(t => t.TableName.StartsWith("Series", StringComparison.OrdinalIgnoreCase))
                        .Select(t => t.TableName)
                        .ToList();

                    if (zip)
                    {
                        string seriesData;
                        ResultManager.GetConverter(rp).Convert(ds.MoveTablesToNewDataSet(seriesTables), out seriesData);

                        if (!string.IsNullOrWhiteSpace(seriesData) && !seriesData.Equals("No results.", StringComparison.OrdinalIgnoreCase))
                        {
                            zipFile.AddEntry($"series.{format.ToLower()}", Encoding.UTF8.GetBytes(seriesData)).LastModified = DateTime.Now;
                        }
                    }
                    else
                    {
                        // add not yet stringified result of convertion to the ResultSet
                        converter
                            .Options(ConverterOptions.IncludeNamedProperty, "Series")
                            .PrepareForSerialization(ds.MoveTablesToNewDataSet(seriesTables), true);
                    }
                }

                if (!zip)
                {
                    // add other tables - availability, protection, etc.
                    tables.ToList().ForEach(t =>
                    {
                        converter.AddProperty(t.TableName, t);
                    });

                    // serialize
                    return converter.ToString();
                }

                return string.Empty;
            });

            zipFile?.Save(zipStream);
            if (zipStream != null)
            {
                zipStream.Position = 0;
            }

            ctx.OutgoingResponse.StatusCode = statusCode;

            if (zip)
            {
                var archiveName = string.Format(ServiceConfig.CUI_Export_Archive_Filename, DateTime.Now.ToString(ServiceConfig.CUI_Export_Date_Format));
                ctx.OutgoingResponse.Headers.Add("Content-Disposition", $"attachment; filename={archiveName}.zip");
                return ctx.CreateStreamResponse(zipStream, "application/octet-stream");
            }

            return ctx.CreateTextResponse(str, "text/plain");
        }

        public Message GetSuggestions(string dbAlias, string keyword, string columnGroupIds, string searchOption, string exchangeCodes, string contractTypes, string username, string password)
        {
            var rp = GetParameters(string.Empty, Constants.SuggestionsAlias, ResultType.None, username, password);
            var ctx = WebOperationContext.Current;

            new AccessHelper(dataContext, rp)
                .TryAuthenticate()
                .VerifyIP(AccessHelper.GetIPAddress());

            var res = XymDataManager.FindSuggestions(new SearchParametersJson
            {
                Keyword = keyword,
                Filter = new Dictionary<string, List<string>>
                {
                    {Constants.ExchangeCodeColumn, exchangeCodes.ToList(unescape: true)},
                    {Constants.ContractTypeColumn, contractTypes.ToList(unescape: true)}
                },
                SearchGroups = columnGroupIds.Split(',').ToList(),
                ComparisonOperator = (SearchOptions)Convert.ToInt32(searchOption)
            });

            var str = JsonConvert.SerializeObject(res);
            ctx.OutgoingResponse.StatusCode = HttpStatusCode.OK;
            return ctx.CreateTextResponse(str, "text/plain");
        }

        /// <summary>
        /// Gets the series.
        /// </summary>
        /// <param name="dbAlias">The database alias.</param>
        /// <param name="format">The format.</param>
        /// <param name="exchangeCode">The exchange code.</param>
        /// <param name="contractNum">The contract number.</param>
        /// <param name="pageSize">Size of the page.</param>
        /// <param name="pageNum">The page number.</param>
        /// <param name="username">The username.</param>
        /// <param name="password">The password.</param>
        /// <returns></returns>
        public Message GetSeries(string dbAlias, string format, string exchangeCode, string contractNum, string pageSize, string pageNum, string username, string password)
        {
            var rt = format.ToEnumByName<ResultType>();
            var rp = GetParameters(string.Empty, "GetSeries", rt, username, password);
            var exchCode = HttpUtility.UrlDecode(exchangeCode);

            var ctx = WebOperationContext.Current;

            new AccessHelper(dataContext, rp)
                .TryAuthenticate()
                .VerifyIP(AccessHelper.GetIPAddress());

            rp.UserId = UsersDataContext.CurrentSessionUser.Id;

            HttpStatusCode statusCode;

            var prms = new SearchParametersJson
            {
                PageNumber = int.Parse(pageNum),
                PageSize = int.Parse(pageSize)
            };

            var str = StatisticCollector.LogCall(rp, out statusCode, () =>
            {
                int count;
                var ds = XymDataManager.FindSeries(exchCode, contractNum, prms, out count);

                // keep results in object, until the end
                var result = new ExpandoObject();
                var converter = ResultManager
                    .GetConverter(rp)
                    .WithResultSet(result);

                // save results to the Series dynamic property
                converter
                    .Options(ConverterOptions.IncludeNamedProperty, "Series")
                    .PrepareForSerialization(ds, false);

                // add count
                converter.AddProperty("SeriesCount", count);

                // now serialize the result
                return converter.ToString();
            });

            ctx.OutgoingResponse.StatusCode = HttpStatusCode.OK;
            return ctx.CreateTextResponse(str, "text/plain");
        }

        /// <summary>
        /// Gets the series.
        /// </summary>
        /// <param name="dbAlias">The database alias.</param>
        /// <param name="storedProcId">The stored proc identifier.</param>
        /// <param name="format">The format.</param>
        /// <param name="words">The words.</param>
        /// <param name="pageSize">Size of the page.</param>
        /// <param name="pageNum">The page number.</param>
        /// <param name="username">The username.</param>
        /// <param name="password">The password.</param>
        /// <param name="findAll">The find all.</param>
        /// <returns></returns>
        public Message FullTextSearch(string dbAlias, string storedProcId, string format, string words, string pageSize, string pageNum, string username, string password, string findAll)
        {
            var rt = format.ToEnumByName<ResultType>();
            var rp = GetParameters(dbAlias, storedProcId, rt, username, password);

            var ctx = WebOperationContext.Current;

            new AccessHelper(dataContext, rp)
                .TryAuthenticate()
                .VerifyIP(AccessHelper.GetIPAddress());

            rp.UserId = UsersDataContext.CurrentSessionUser.Id;

            HttpStatusCode statusCode;

            rp.SearchParameters.PageNumber = int.Parse(pageNum);
            rp.SearchParameters.PageSize = int.Parse(pageSize);
            rp.SearchParameters.FindAll = (!string.IsNullOrWhiteSpace(findAll) && findAll == "1");
            rp.SearchParameters.Keyword = UnescapeValue(words);

            var str = StatisticCollector.LogCall(rp, out statusCode, () =>
            {
                int count;
                var ds = XymDataManager.SeriesFullTextSearch(rp, out count);

                // keep results in object, until the end
                var result = new ExpandoObject();
                var converter = ResultManager
                    .GetConverter(rp)
                    .WithResultSet(result);

                // save results to the Series dynamic property
                converter
                    .Options(ConverterOptions.IncludeNamedProperty, "Series")
                    .PrepareForSerialization(ds, false);

                // add count
                converter.AddProperty("SeriesCount", count);

                // now serialize the result
                return converter.ToString();
            });

            ctx.OutgoingResponse.StatusCode = HttpStatusCode.OK;
            return ctx.CreateTextResponse(str, "text/plain");
        }

        #endregion

        #region Private static methods

        /// <summary>
        /// Unescapes the value.
        /// </summary>
        /// <param name="obj">The object.</param>
        /// <returns></returns>
        private static string UnescapeValue(object obj)
        {
            if (obj == null || obj == DBNull.Value)
                return null;

            return Uri.UnescapeDataString(obj.ToString());
        }

        /// <summary>
        /// Gathers the stored procedure's input parameters metadata.
        /// </summary>
        /// <param name="list">The list.</param>
        /// <returns></returns>
        private static string GatherInputMetaData(IEnumerable<FieldMetaData> list)
        {
            return list.Aggregate(string.Empty, (agg, c) => string.Format("{0}\r\n\t{1}", agg, c));
        }

        /// <summary>
        /// Gathers the stored procedure's result sets metadata.
        /// </summary>
        /// <param name="dbHelper">The db helper.</param>
        /// <param name="requestParameters">The request parameters.</param>
        /// <returns></returns>
        private static string GatherOutputMetaData(DbHelper dbHelper, RequestParameters requestParameters)
        {
            var retList = dbHelper.GetStoredProceduresResultSetsMetaData(requestParameters);
            var sb = new StringBuilder();
            sb.AppendFormat(", result sets ({0}):{1}", retList.Count, Environment.NewLine);

            for (var k = 0; k < retList.Count; k++)
            {
                var info = retList[k];
                sb.AppendFormat("Table{0}:\r\n", k);

                foreach (var dsItem in info)
                {
                    sb.AppendFormat("\t{0}\r\n", dsItem);
                }
            }

            sb.AppendLine();
            return sb.ToString();
        }

        /// <summary>
        /// Looks up for the stored procedure, collects parameters from QueryString.
        /// </summary>
        /// <param name="dbAlias">The database alias.</param>
        /// <param name="storedProcId">The string to identify and choose the stored procedure in the lookup table.</param>
        /// <param name="format">The format.</param>
        /// <param name="username">The username.</param>
        /// <param name="password">The password.</param>
        /// <param name="csvColNames">Show column names.</param>
        /// <param name="csvForceQuotes">Force quotes.</param>
        /// <param name="indentJSON">Indent JSON.</param>
        /// <param name="csvDelimiter">The CSV delimiter.</param>
        /// <returns></returns>
        private static RequestParameters GetParameters(string dbAlias, string storedProcId, ResultType format, string username, string password,
            string csvColNames = "false",
            string csvForceQuotes = "false",
            string indentJSON = "false",
            string csvDelimiter = ",")
        {
            var qs = HttpContext.Current.Request.QueryString;
            var @params = new RequestParameters { Username = username, Password = password };
            WorkingDatabase.CreateInstance(dbAlias);

            if (!string.IsNullOrEmpty(storedProcId))
            {
                bool inclCols, forceQuotes, indentJson;
                bool.TryParse(csvColNames, out inclCols);
                bool.TryParse(csvForceQuotes, out forceQuotes);
                bool.TryParse(indentJSON, out indentJson);

                @params.MethodName = storedProcId;
                @params.ConnectionString = DatabaseConfiguration.GetConnectionString(dbAlias);
                @params.SearchParameters.Export.Csv.ShowColumnNames = inclCols;
                @params.SearchParameters.Export.Csv.ForceQuotes = forceQuotes;
                @params.SearchParameters.Export.Csv.Delimiter = csvDelimiter;
                @params.SearchParameters.Export.IndentJson = indentJson;
                @params.SearchParameters.Export.OutputFormat = format;

                @params.MethodArguments.AddRange(qs.AllKeys.Select(k => new StoredProcParameterJson { ParameterName = k, ParameterValue = UnescapeValue(qs[k]) }));

                var qp = new UrlQueryParser();
                @params.DataFilters = qp.QueryToTable(HttpContext.Current.Request.Url.Query.Split('&'));
            }

            return @params;
        }

        private bool IsDataRequest(ResultType resutlType)
        {
            return resutlType == ResultType.Csv || resutlType == ResultType.Json || resutlType == ResultType.Xml;
        }

        /// <summary>
        /// Determines whether the specified configuration parameters are valid.
        /// </summary>
        /// <param name="spConfigParameters">The configuration parameters.</param>
        /// <param name="errorMessage">The error message.</param>
        /// <returns></returns>
        private static void ValidateMethodParams(RequestParameters spConfigParameters, out string errorMessage)
        {
            errorMessage = string.Empty;

            if (spConfigParameters == null)
            {
                errorMessage = Resources.Service_Parameter_Is_Null;
                throw new WebFaultException<string>(errorMessage, HttpStatusCode.BadRequest);
            }

            if (string.IsNullOrEmpty(spConfigParameters.StoredProcName))
            {
                errorMessage = Resources.Service_No_SP_Name;
                throw new WebFaultException<string>(errorMessage, HttpStatusCode.BadRequest);
            }
        }

        /// <summary>
        /// Determines whether the specified configuration parameters are valid.
        /// </summary>
        /// <param name="spConfigParameters">The configuration parameters.</param>
        /// <param name="errorMessage">The error message.</param>
        /// <returns></returns>
        private static void ValidateSearchParams(RequestParameters spConfigParameters, out string errorMessage)
        {
            errorMessage = string.Empty;

            if (string.IsNullOrEmpty(spConfigParameters.SearchParameters.Keyword))
            {
                errorMessage = Resources.Error_400_No_Keyword;
                throw new WebFaultException<string>(errorMessage, HttpStatusCode.BadRequest);
            }

            //if (spConfigParameters.SearchParameters.Zip && (!spConfigParameters.SearchParameters.IncludeSeries && !spConfigParameters.SearchParameters.IncludeRoot))
            //{
            //    errorMessage = Resources.Error_400_No_Parameter_Value;
            //    throw new WebFaultException<string>(errorMessage, HttpStatusCode.BadRequest);
            //}
        }

        #endregion
    }
}

