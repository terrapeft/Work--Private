using System;
using System.Collections.Generic;
using System.IO;
using System.Net;
using System.Net.Http;
using System.Text;
using Newtonsoft.Json;
using RestSharp;
using SharedLibrary.JSON;
using UsersDb.Code;

namespace UsersDb.Helpers
{
    public class TdApiHelper
    {
        private readonly HttpRequestMessage _request;
        private readonly string _tdApiBaseUrl;
        private readonly string _user;
        private readonly string _password;
        private readonly string _errorMessage;
        private readonly List<string> _predefinedMethods = new List<string> { "GetBySymbol", "GetSuggestions", "GetSeries", "GetSeries/search" };

        public TdApiHelper(HttpRequestMessage request, string errorMessage)
        {
            _request = request;
            _errorMessage = errorMessage;
        }

        public TdApiHelper(HttpRequestMessage request, string tdApiBaseUrl, string user, string password, string errorMessage) : this(request, errorMessage)
        {
            _tdApiBaseUrl = tdApiBaseUrl;
            _user = user;
            _password = password;
        }

        /// <summary>
        /// Requests the TRADEdata API for data.
        /// </summary>
        /// <param name="alias">The alias.</param>
        /// <param name="storedProcedure">The stored procedure.</param>
        /// <param name="params">The parameters.</param>
        /// <param name="method">The HTTP method.</param>
        /// <returns></returns>
        public HttpResponseMessage GetData(string alias, string storedProcedure, Dictionary<string, object> @params = null, Method method = Method.GET)
        {
            var client = new RestClient(_tdApiBaseUrl);
            var request = new RestRequest(GetUrl(alias, storedProcedure), method);

            new UrlQueryBuilder(request, _user, _password)
                .SetParameters(@params);

            ServicePointManager.ServerCertificateValidationCallback = delegate { return true; };

            var uri = client.BuildUri(request).ToString();

            var resp = client.Execute(request);
            var data = resp.Content;

            if ((int)resp.StatusCode > 399)
            {
                return HandleException(resp);
            }

            var receivedData = JsonHelper.IsValidJson(data) ? data : JsonConvert.SerializeObject(new { Table0 = new string[0] });
            var response = _request.CreateResponse(resp.StatusCode);

            response.Content = new StringContent(receivedData, Encoding.UTF8, "application/json");

            return response;
        }

        private string GetUrl(string alias, string storedProcedure, string format = "json")
        {
            var site = "site/";
            if (_predefinedMethods.Contains(storedProcedure))
            {
                site = string.Empty;
            }

            return $"{site}{alias}/{storedProcedure}/{format}";
        }

        public static Stream GetStream(string url)
        {
            var client = new RestClient(url);
            var request = new RestRequest();
            var dataStream = new MemoryStream();

            request.ResponseWriter = (s) => s.CopyTo(dataStream);

            ServicePointManager.ServerCertificateValidationCallback = delegate { return true; };

            var resp = client.Execute(request);
            if ((int)resp.StatusCode > 399)
            {
                throw new Exception(resp.ErrorMessage ?? resp.Content);
            }

            return dataStream;
        }

        public Stream GetStream(string alias, string storedProcedure, string format, out HttpStatusCode status, Dictionary<string, object> @params = null)
        {
            var client = new RestClient(_tdApiBaseUrl);
            var request = new RestRequest(GetUrl(alias, storedProcedure, format)) { Timeout = 43200000 };

            var dataStream = new MemoryStream();
            new UrlQueryBuilder(request, _user, _password).SetParameters(@params);

            request.ResponseWriter = (s) => s.CopyTo(dataStream);

            ServicePointManager.ServerCertificateValidationCallback = delegate { return true; };

            var resp = client.Execute(request);

            if ((int)resp.StatusCode > 399)
            {
                HandleException(resp);
            }

            status = resp.StatusCode;
            return dataStream;
        }

        public string GetString(string alias, string storedProcedure, Dictionary<string, object> @params = null, Method method = Method.GET)
        {
            var client = new RestClient(_tdApiBaseUrl);
            var request = new RestRequest(GetUrl(alias, storedProcedure), method);

            new UrlQueryBuilder(request, _user, _password)
                .SetParameters(@params);

            ServicePointManager.ServerCertificateValidationCallback = delegate { return true; };

            var resp = client.Execute(request);
            var data = resp.Content;

            if ((int)resp.StatusCode > 399)
            {
                HandleException(resp);
            }

            return JsonHelper.IsValidJson(data) ? JsonHelper.CleanUp(data) : null;
        }

        /// <summary>
        /// Requests the TRADEdata API for data and returns it as string.
        /// </summary>
        /// <param name="alias">The db alias.</param>
        /// <param name="storedProcedure">The stored procedure.</param>
        /// <param name="format">The data format to return in (xml, csv).</param>
        /// <param name="status">The request status.</param>
        /// <param name="params">The request parameters.</param>
        /// <param name="method">The method name.</param>
        /// <returns></returns>
        public string GetString(string alias, string storedProcedure, string format, out HttpStatusCode status, Dictionary<string, object> @params = null, Method method = Method.GET)
        {
            var client = new RestClient(_tdApiBaseUrl);
            var request = new RestRequest(GetUrl(alias, storedProcedure, format), method);

            new UrlQueryBuilder(request, _user, _password)
                .SetParameters(@params);

            ServicePointManager.ServerCertificateValidationCallback = delegate { return true; };
            var resp = client.Execute(request);

            if ((int)resp.StatusCode > 399)
            {
                HandleException(resp);
            }

            status = resp.StatusCode;
            return resp.Content;
        }

        /// <summary>
        /// Creates a parameters dictionary for TDAPI call.
        /// </summary>
        /// <param name="options">The options.</param>
        /// <returns></returns>
        public Dictionary<string, object> GatherParameters(SearchParameters options)
        {
            var @params = new Dictionary<string, object>()
                {
                    { "pn", 0 }, // page number
                    { "ps", 0 }, // page size
                    { "s", options.SearchFor },
                    { "so", options.SearchOption }, // comparison option
                    { "sa", "0" }, // series availability
                    { "re", options.IncludeRoot == true ? "1" : "0" },
                    { "se", options.IncludeSeries == true ? "1" : "0" }, // include series
                    { "cn", options.CsvColumns == true ? bool.TrueString : bool.FalseString },
                    { "q", options.CsvQuotes == true ? bool.TrueString : bool.FalseString },
                    { "zip", options.Compress == true ? "1" : "0" }
                };

            if (options.SearchGroups != null && options.SearchGroups.Length > 0)
                @params.Add("sc", string.Join(",", options.SearchGroups));
            if (options.ExchangeCodes != null && options.ExchangeCodes.Length > 0)
                @params.Add("ec", string.Join(",", options.ExchangeCodes));
            if (options.ContractTypes != null && options.ContractTypes.Length > 0)
                @params.Add("ct", string.Join(",", options.ContractTypes));

            return @params;
        }

        /// <summary>
        /// Logs the exception with Elmah library, returns user friendly message to the client in a JSON format.
        /// </summary>
        public HttpResponseMessage HandleException(IRestResponse resp)
        {
            return HandleException(resp.ErrorException ?? new Exception(resp.ErrorMessage ?? resp.Content));
        }

        /// <summary>
        /// Logs the exception with Elmah library, returns user friendly message to the client in a JSON format.
        /// </summary>
        /// <param name="ex">The ex.</param>
        /// <returns></returns>
        public HttpResponseMessage HandleException(Exception ex)
        {
            SharedLibrary.Elmah.Logger.LogError(ex);

            var errMsg = _errorMessage ?? ex.Message;
            return ResponseMessage(HttpStatusCode.InternalServerError, JsonConvert.SerializeObject(new { Error = errMsg }));
        }

        /// <summary>
        /// Returns some message to the client in a JSON format.
        /// </summary>
        /// <param name="status">The status.</param>
        /// <param name="text">The text.</param>
        /// <returns></returns>
        public static HttpResponseMessage ResponseMessage(HttpStatusCode status, string text = "")
        {
            return new HttpResponseMessage(status) { Content = new StringContent(text, Encoding.UTF8, "application/json") };
        }
    }
}
