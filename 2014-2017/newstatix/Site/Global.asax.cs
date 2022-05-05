using System;
using System.Collections;
using System.Linq;
using System.Web;
using System.Web.DynamicData;
using System.Web.Routing;
using System.Web.UI;
using Db;
using SharedLibrary.Cache;

namespace Statix
{
    public class Global : System.Web.HttpApplication
    {
        private static MetaModel s_defaultModel = new MetaModel();
        public static MetaModel DefaultModel
        {
            get
            {
                return s_defaultModel;
            }
        }

        public static void RegisterRoutes(RouteCollection routes)
        {
            //                    IMPORTANT: DATA MODEL REGISTRATION 
            // Uncomment this line to register an ADO.NET Entity Framework model for ASP.NET Dynamic Data.
            // Set ScaffoldAllTables = true only if you are sure that you want all tables in the
            // data model to support a scaffold (i.e. templates) view. To control scaffolding for
            // individual tables, create a partial class for the table and apply the
            // [ScaffoldTable(true)] attribute to the partial class.
            // Note: Make sure that you change "YourDataContextType" to the name of the data context
            // class in your application.
            // See http://go.microsoft.com/fwlink/?LinkId=257395 for more information on how to add and configure an Entity Data model to this project
            DefaultModel.RegisterContext(typeof(StatixEntities), new ContextConfiguration() { ScaffoldAllTables = true });

            // The following statement supports separate-page mode, where the List, Detail, Insert, and 
            // Update tasks are performed by using separate pages. To enable this mode, uncomment the following 
            // route definition, and comment out the route definitions in the combined-page mode section that follows.
            routes.Add(new DynamicDataRoute("{table}/{action}.aspx")
            {
                Constraints = new RouteValueDictionary(new { action = "List|Details|Popup" }),
                Model = DefaultModel
            });

            // The following statements support combined-page mode, where the List, Detail, Insert, and
            // Update tasks are performed by using the same page. To enable this mode, uncomment the
            // following routes and comment out the route definition in the separate-page mode section above.
            //routes.Add(new DynamicDataRoute("{table}/ListDetails.aspx") {
            //    Action = PageAction.List,
            //    ViewName = "ListDetails",
            //    Model = DefaultModel
            //});

            //routes.Add(new DynamicDataRoute("{table}/ListDetails.aspx") {
            //    Action = PageAction.Details,
            //    ViewName = "ListDetails",
            //    Model = DefaultModel
            //});
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

        void Application_Start(object sender, EventArgs e)
        {
            RegisterRoutes(RouteTable.Routes);
            RegisterScripts();
            CacheData();
        }

        void Session_Start(object sender, EventArgs e)
        {
        }

        void Application_Error(object sender, EventArgs e)
        {
            var objErr = Server.GetLastError().GetBaseException();
        }

        void Application_BeginRequest(object src, EventArgs e)
        {
            if (Request.AppRelativeCurrentExecutionFilePath == "~/")
                HttpContext.Current.RewritePath("Default.aspx");

            var showKeys = Request.QueryString.AllKeys.Contains("ShowKeys", StringComparer.OrdinalIgnoreCase)
                && Request.QueryString["ShowKeys"].Equals("ShowThemPlease");

            if (Request.QueryString.AllKeys.Contains("ClearCache", StringComparer.OrdinalIgnoreCase))
            {
                Response.Write("<div style=\"margin:15px; padding: 15px; color:red; border: 1px solid red;\">");

                if (Request.QueryString["ClearCache"].Equals("all", StringComparison.OrdinalIgnoreCase))
                {
                    Response.Write(string.Format("<strong>Cache items removed (including system):&nbsp;{0}</strong><br>", CacheHelper.Cache.Count));

                    foreach (DictionaryEntry item in CacheHelper.Cache)
                    {
                        if (showKeys) Response.Write(item.Key + "<br>");
                        CacheHelper.Cache.Remove(item.Key.ToString());
                    }
                }
                else
                {
                    Response.Write(string.Format("<strong>Application cache items removed:&nbsp;{0}</strong><br>", CacheHelper.Cache.Count));

                    foreach (DictionaryEntry item in CacheHelper.Cache
                        .Cast<DictionaryEntry>()
                        .Where(de => de.Key.ToString().StartsWith("Resource") || de.Key.ToString().StartsWith("ServiceConfig")))
                    {
                        if (showKeys) Response.Write(item.Key + "<br>");
                        CacheHelper.Cache.Remove(item.Key.ToString());
                    }
                }

                Response.Write("</div>");

                Response.End();
            }
        }

        void Application_PreRequestHandlerExecute(object src, EventArgs e)
        {
            var p = Context.Handler as Page;
            if (p != null)
            {
                p.PreInit += (s, ev) =>
                {
                    string themeName;
                    var master = ThemeSelector.SelectTheme(Request, out themeName);

                    // Null means the page doesn't have master page
                    if (p.MasterPageFile != null)
                    {
                        p.MasterPageFile = master;
                    }

                    if (p.Theme != null)
                    {
                        p.Theme = themeName;
                    }
                };
            }
        }

        #region Custom methods

        private void CacheData()
        {
            ServiceConfig.PreloadAsync();
            Resources.PreloadAsync();
        }

        /// <summary>
        /// Gets the post back control.
        /// </summary>
        /// <param name="page">The page.</param>
        /// <returns></returns>
        public static Control GetPostBackControl(Page page)
        {
            Control control = null;
            var ctrlname = page.Request.Params.Get("__EVENTTARGET");
            if (!string.IsNullOrEmpty(ctrlname))
            {
                control = page.FindControl(ctrlname);
            }
            else
            {
                foreach (string ctl in page.Request.Form)
                {
                    var c = page.FindControl(ctl);
                    if (c is System.Web.UI.WebControls.Button)
                    {
                        control = c;
                        break;
                    }
                }
            }

            return control;
        }

        /// <summary>
        /// Gets the post back control with argument.
        /// </summary>
        /// <param name="page">The page.</param>
        /// <returns></returns>
        public static Control GetPostBackControl(Page page, out string argument)
        {
            Control control = null;
            var ctrlname = page.Request.Params.Get("__EVENTTARGET");
            argument = page.Request.Params.Get("__EVENTARGUMENT");

            if (!string.IsNullOrEmpty(ctrlname))
            {
                control = page.FindControl(ctrlname);
            }
            else
            {
                foreach (string ctl in page.Request.Form)
                {
                    var c = page.FindControl(ctl);
                    if (c is System.Web.UI.WebControls.Button)
                    {
                        control = c;
                        break;
                    }
                }
            }

            return control;
        }

        #endregion
    }
}
