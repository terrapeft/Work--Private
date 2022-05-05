using System;
using System.Collections.Generic;
using System.Web.Script.Services;
using System.Web.Services;
using UsersDb.DataContext;
using UsersDb.Helpers;
using UsersDb.Search;

namespace CustomersUI.WebMethods
{
    /// <summary>
    /// Summary description for WebService
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [ScriptService]
    public class CustomerService : WebService
    {
        [WebMethod]
        public List<string> FindSuggestions(string searchParams)
        {
            try
            {
                var query = new UserSearchQuery { QueryParameters = searchParams };
                var res = XymDataManager.FindSuggestions(query.DeserializedParameters);
                return res;
            }
            catch (Exception ex)
            {
                Logger.LogError(ex);
                throw;
            }
        }
    }
}
