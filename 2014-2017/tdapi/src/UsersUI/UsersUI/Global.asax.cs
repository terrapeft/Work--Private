using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.DynamicData;
using System.Web.Routing;
using System.Web.UI;
using SharedLibrary.Cache;
using SharedLibrary.SmartScaffolding;
using SharedLibrary.SmartScaffolding.Attributes;
using UsersDb;
using UsersDb.Code;
using UsersDb.DataContext;
using UsersDb.Helpers;

namespace UsersUI
{
    public class Global : HttpApplication
    {
        private static MetaModel s_defaultModel = new MetaModel();

        public static MetaModel DefaultModel
        {
            get
            {
                return s_defaultModel;
            }
        }

        #region Custom Column Generators

        public static Boolean IsHidden(MetaColumn column)
        {
            var page = (Page)HttpContext.Current.CurrentHandler;
            var pageTemplate = page.GetPageTemplate();

            if (!column.Scaffold || column.IsPrimaryKey || column.IsForeignKeyComponent || column.Name.ToLower() == "isdeleted" || column.Name.ToLower() == "iseditable")
                return true;

            var hideIn = column.GetAttribute<HideInAttribute>();

            if (hideIn != null)
                return (hideIn.PageTemplate & pageTemplate) == pageTemplate;

            return false;
        }

        #endregion

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
            // See http://go.microsoft.com/fwlink/?LinkId=257395 for more information on how to register Entity Data Model with Dynamic Data            
            DefaultModel.RegisterContext(() => (new UsersDataContext()), new ContextConfiguration() { ScaffoldAllTables = true });

            // The following registration should be used if YourDataContextType does not derive from DbContext
            // DefaultModel.RegisterContext(typeof(YourDataContextType), new ContextConfiguration() { ScaffoldAllTables = false });

            // The following statement supports separate-page mode, where the List, Detail, Insert, and 
            // Update tasks are performed by using separate pages. To enable this mode, uncomment the following 
            // route definition, and comment out the route definitions in the combined-page mode section that follows.
            routes.Add(new DynamicDataRoute("{table}/{action}.aspx")
            {
                Constraints = new RouteValueDictionary(new { action = "List|Details|Edit|Insert" }),
                Model = DefaultModel
            });

            // The following statements support combined-page mode, where the List, Detail, Insert, and
            // Update tasks are performed by using the same page. To enable this mode, uncomment the
            // following routes and comment out the route definition in the separate-page mode section above.
            //routes.Add(new DynamicDataRoute("{table}/ListDetails.aspx")
            //{
            //	Action = PageAction.List,
            //	ViewName = "ListDetails",
            //	Model = DefaultModel
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
        }

        void Application_PostAuthenticateRequest(object sender, EventArgs e)
        {
        }

        void Application_Error(object sender, EventArgs e)
        {
            Exception objErr = Server.GetLastError().GetBaseException();
        }

        void Session_Start(object sender, EventArgs e)
        {
            ServiceConfig.PreloadAsync();
            Resources.PreloadAsync();

            using (var dc = new UsersDataContext())
            {
                CacheHelper.Add("dbConfig", CommonActions.LoadDatabasesAliases.Invoke());
                
                var defaultDb = dc.DatabaseConfigurations
                    .Where(d => !d.IsDeleted)
                    .FirstOrDefault(d => d.IsDefault == true);

                if (defaultDb != null)
                {
                    WorkingDatabase.CreateInstance(defaultDb.Alias);
                }
            }

            try
            {
                var dir = Server.MapPath("~/TempFiles");
                if (Directory.Exists(dir))
                {
                    new DirectoryInfo(dir).GetFiles().ToList().ForEach(f => f.Delete());
                }
            }
            catch (Exception ex)
            {
                Logger.LogError(ex);
            }
        }

        #region Custom methods

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

        #endregion
    }
}
