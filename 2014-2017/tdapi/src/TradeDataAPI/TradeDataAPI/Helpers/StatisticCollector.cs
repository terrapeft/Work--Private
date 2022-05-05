using System.Web;
using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.ServiceModel;
using System.ServiceModel.Channels;
using System.ServiceModel.Web;
using System.Threading.Tasks;
using UsersDb.Code;
using UsersDb.DataContext;
using UsersDb.JSON;

namespace TradeDataAPI.Helpers
{
    using System.Net;


    using UsersDb;
    using UsersDb.Helpers;

    /// <summary>
    /// Helps to collect statistic of a service usage.
    /// </summary>
    public class StatisticCollector
    {
        private TimeSpan duration = TimeSpan.Zero;
        private DateTime endRequest = DateTime.MinValue;

        private readonly RequestParameters requestParameters;
        private readonly DateTime startTime;
        private readonly List<string> excludedParameterNames = new List<string> { "p", "RETURN_VALUE" };

        public StatisticCollector(RequestParameters requestParameters)
        {
            startTime = DateTime.UtcNow;
            this.requestParameters = requestParameters;
            StatusCode = HttpStatusCode.OK;
        }

        public HttpStatusCode StatusCode { get; set; }
        public string ErrorMessage { get; set; }

        /// <summary>
        /// Logs the service call.
        /// </summary>
        public void LogCallAsync()
        {
            duration = DateTime.UtcNow - startTime;
            endRequest = DateTime.UtcNow;

            Task.Factory.StartNew(() =>
            {
                using (var dc = new UsersDataContext())
                {
                    var ip = AccessHelper.RunIpLookup(dc);
                    var method = GetMethod(requestParameters.MethodName, dc);
                    var spp = GetStoredProcedureParameters(requestParameters);

                    // HttpContext not available at this point
                    dc.CurrentUserId = requestParameters.UserId ?? 0;

                    var us = new UsageStat
                    {
                        UserId = requestParameters.UserId,
                        MethodId = method == null ? null : (int?)method.Id,
                        MethodArgs = JsonConvert.SerializeObject(spp),
                        DataFormatId = (int)requestParameters.SearchParameters.Export.OutputFormat,
                        RequestDuration = (long)duration.TotalMilliseconds,
                        RequestDate = endRequest,
                        StatusId = (int)ActionStatus.Succeeded,
                        HttpStatusCode = (int)StatusCode,
                        IpId = ip.Id
                    };

                    if (!string.IsNullOrEmpty(ErrorMessage))
                    {
                        us.StatusId = (int)ActionStatus.Fialed;
                        us.ErrorMessage = ErrorMessage;
                    }

                    dc.UsageStats.AddObject(us);
                    dc.SaveChanges();
                }

            });

            Task.WaitAll();
        }

        /// <summary>
        /// Gets the method.
        /// </summary>
        /// <param name="methodName">Name of the method.</param>
        /// <param name="dc">The dc.</param>
        /// <returns></returns>
        private Method GetMethod(string methodName, UsersDataContext dc)
        {
            return dc.Methods.FirstOrDefault(m => m.Name == methodName);
        }

        /// <summary>
        /// Gets the stored procedure call with parameters and values.
        /// </summary>
        /// <param name="cfg"></param>
        /// <returns></returns>
        private List<StoredProcParameterJson> GetStoredProcedureParameters(RequestParameters cfg)
        {
            var ma = new List<StoredProcParameterJson>();
            ma.AddRange(cfg.MethodArguments
                 .Where(p => !excludedParameterNames.Contains(p.ParameterName))
                 .Select(p => p));

            return ma;
        }

        #region Error handling

        /// <summary>
        /// Incapsulates statistics logging and error handling.
        /// </summary>
        /// <param name="rp">The rp.</param>
        /// <param name="statusCode">The status code.</param>
        /// <param name="func">The func.</param>
        /// <returns></returns>
        /// <exception cref="System.ArgumentNullException">Context is null</exception>
        public static string LogCall(RequestParameters rp, out HttpStatusCode statusCode, Func<string> func)
        {
            var sc = new StatisticCollector(rp);

            try
            {
                statusCode = HttpStatusCode.OK;
                try
                {
                    return func.Invoke();
                }
                finally
                {
                    sc.LogCallAsync();
                }
            }
            catch (WebFaultException<string> webFaultException)
            {
                if (webFaultException.StatusCode != HttpStatusCode.Unauthorized)
                {
                    Logger.LogError(webFaultException);
                }

                sc.StatusCode = webFaultException.StatusCode;
                sc.ErrorMessage = string.Format("Error {0}: {1}.\r\nMessage: {2}", (int)sc.StatusCode, webFaultException.Message, webFaultException.Detail);

                statusCode = webFaultException.StatusCode;
                return sc.ErrorMessage;
            }
            catch (SqlException sqlException)
            {
                var status = HttpStatusCode.InternalServerError;

                if (sqlException.Message.Contains("expects parameter"))
                {
                    status = HttpStatusCode.BadRequest;
                }

                Logger.LogError(sqlException);

                sc.StatusCode = status;
                sc.ErrorMessage = PrepareErrorMessage(sqlException.Message);

                statusCode = status;
                return sc.ErrorMessage;
            }
            catch (FormatException formatException)
            {
                var status = HttpStatusCode.InternalServerError;

                if (formatException.Message.Contains("failed to convert"))
                {
                    status = HttpStatusCode.BadRequest;
                }

                Logger.LogError(formatException);

                sc.StatusCode = status;
                sc.ErrorMessage = PrepareErrorMessage(formatException.Message);

                statusCode = status;
                return sc.ErrorMessage;
            }
            catch (EvaluateException evaluateException)
            {
                Logger.LogError(evaluateException);

                sc.StatusCode = HttpStatusCode.BadRequest;
                sc.ErrorMessage = PrepareErrorMessage(evaluateException.Message);

                statusCode = HttpStatusCode.BadRequest;
                return sc.ErrorMessage;
            }
            catch (Exception ex)
            {
                Logger.LogError(ex);

                sc.ErrorMessage = PrepareErrorMessage(ex.Message);
                sc.StatusCode = HttpStatusCode.InternalServerError;

                statusCode = sc.StatusCode;
                return Resources.Error_500;
            }
        }


        /// <summary>
        /// Prepares the error message.
        /// </summary>
        /// <param name="message">The message.</param>
        /// <returns></returns>
        private static string PrepareErrorMessage(string message)
        {
            var msg = message;

            if (message.Contains("Procedure or function "))
            {
                msg = message.Replace("Procedure or function ", "Method ");
            }

            if (message.Contains(WorkingDatabase.Instance.GetStoredProcPrefix()))
            {
                msg = msg.Replace(WorkingDatabase.Instance.GetStoredProcPrefix(), WorkingDatabase.Instance.GetStoredProcMethodPrefix());
            }

            return msg;
        }

        #endregion
    }
}