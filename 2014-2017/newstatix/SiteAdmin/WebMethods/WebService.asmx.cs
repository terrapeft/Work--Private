using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.Script.Services;
using System.Web.Services;
using Db;
using SharedLibrary.Elmah;
using SharedLibrary.IPAddress;

namespace AdministrativeUI.WebMethods
{
    /// <summary>
    /// Summary description for WebService
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [ScriptService]
    public class WebService : System.Web.Services.WebService
    {
        [WebMethod]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public string VerifyAndExpandIps(string list, bool ignoreInvalidValues)
        {
            try
            {
                return string.Join("\r\n", IpListSplitter.Split(list, ignoreInvalidValues));
            }
            catch (Exception ex)
            {
                Logger.LogError(ex);
                throw;
            }
        }
    }
}
