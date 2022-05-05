using System;
using System.Diagnostics;
using System.Linq;
using System.Web;
using System.Web.DynamicData;
using System.Web.UI;
using SharedLibrary.Cache;
using UsersDb;
using UsersDb.Code;
using UsersDb.DataContext;
using UsersDb.Helpers;

namespace CustomersUI
{
    public class Global : HttpApplication
    {
        private static readonly MetaModel defaultModel = new MetaModel();

        public static MetaModel DefaultModel => defaultModel;

        void Application_Start(object sender, EventArgs e)
        {
            RegisterModel();
            RegisterScripts();
        }

        void Application_End(object sender, EventArgs e)
        {
        }

        void Application_Error(object sender, EventArgs e)
        {
        }

        void Session_Start(object sender, EventArgs e)
        {
            CacheData();

            using (var dc = new UsersDataContext())
            {
                var defaultDb = dc.DatabaseConfigurations.Where(d => !d.IsDeleted).FirstOrDefault(d => d.IsDefault == true);
                if (defaultDb != null)
                {
                    WorkingDatabase.CreateInstance(defaultDb.Alias);

                    CacheHelper.LoadAsync(Constants.XymRootTableName, CommonActions.LoadXymRootLevelGlobalFunc);
                    CacheHelper.LoadAsync(Constants.ExchangeCodesCacheKey, defaultDb.Alias, CommonActions.LoadExchangeCodesFunc);
                    CacheHelper.LoadAsync(Constants.ContractTypesCacheKey, defaultDb.Alias, CommonActions.LoadContractTypesFunc);
                    CacheHelper.LoadAsync("_columns", Constants.XymRootTableName, CommonActions.LoadTableColumnsFunc);
                    CacheHelper.LoadAsync("_columns", Constants.XymReutersTableName, CommonActions.LoadTableColumnsFunc);
                }
            }
		}

        #region Private stuff


        /// <summary>
        /// Loads sensible data into cache.
        /// </summary>
        private void CacheData()
        {
            ServiceConfig.PreloadAsync();
            Resources.PreloadAsync();
        }

        private void RegisterModel()
        {
            DefaultModel.RegisterContext(() => (new UsersDataContext()), new ContextConfiguration() { ScaffoldAllTables = true });
        }

        private static void RegisterScripts()
        {
            ScriptManager.ScriptResourceMapping.AddDefinition("jquery", new ScriptResourceDefinition
            {
                Path = "//ajax.aspnetcdn.com/ajax/jQuery/jquery-2.1.1.min.js",
                DebugPath = "//ajax.aspnetcdn.com/ajax/jQuery/jquery-2.1.1.js",
                CdnPath = "//ajax.aspnetcdn.com/ajax/jQuery/jquery-2.1.1.min.js",
                CdnDebugPath = "//ajax.aspnetcdn.com/ajax/jQuery/jquery-2.1.1.js",
                CdnSupportsSecureConnection = true,
                LoadSuccessExpression = "window.jQuery"
            });
        }

        #endregion

        #region Static methods
        public static void RedirectToHomePage()
        {
            HttpContext.Current.Response.Redirect("Default.aspx", false);
        }

        public static void RedirectToPage(string page)
        {
            HttpContext.Current.Response.Redirect(page, false);
        }

        /*
                /// <summary>
                /// Sets the authentication cookie.
                /// </summary>
                /// <param name="userId">The user identifier.</param>
                public static HttpCookie CreateAuthenticationCookie(string userId)
                {
                    var expiration = DateTime.Now.AddDays(ServiceConfig.Remember_Me_Period);
                    var ticket = new FormsAuthenticationTicket(1,
                      userId,
                      DateTime.Now,
                      expiration,
                      true,
                      expiration.Ticks.ToString(),
                      FormsAuthentication.FormsCookiePath);

                    // Encrypt the ticket.
                    var encTicket = FormsAuthentication.Encrypt(ticket);
                    var cookie = new HttpCookie(FormsAuthentication.FormsCookieName, encTicket) { Expires = expiration, HttpOnly = true };
                    return cookie;
                }


                public static FormsAuthenticationTicket AuthenticationTicket
                {
                    get
                    {
                        if (HttpContext.Current == null) return null;

                        var authCookie = HttpContext.Current.Request.Cookies[FormsAuthentication.FormsCookieName];
                        if (authCookie != null)
                        {
                            return FormsAuthentication.Decrypt(authCookie.Value);
                        }

                        return null;
                    }
                }
                /// <summary>
                /// Gets a value indicating whether user chose to remember him.
                /// </summary>
                public static bool RememberMe
                {
                    get
                    {
                        if (HttpContext.Current == null) return false;

                        var authCookie = HttpContext.Current.Request.Cookies[FormsAuthentication.FormsCookieName];

                        if (authCookie != null && !string.IsNullOrWhiteSpace(authCookie.Value))
                        {
                            var ticket = FormsAuthentication.Decrypt(authCookie.Value);
                            if (ticket != null && !string.IsNullOrWhiteSpace(ticket.UserData))
                            {
                                var dt = new DateTime(Convert.ToInt64(ticket.UserData));
                                return DateTime.Now < dt;
                            }
                        }

                        return false;
                    }
                }
                */
        #endregion
    }
}
