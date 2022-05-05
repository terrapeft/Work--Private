using System;
using System.Linq;
using System.Reflection;
using System.Web;
using System.Web.Configuration;
using System.Xml.Linq;
using Elmah;

namespace SharedLibrary.Elmah
{
    /// <summary>
    /// Adds logic to the original ELMAH page factory to work with multiple applications in one project.
    /// In terms of ELMAH, application stands for a table field, which contains application name the message is written for.
    /// For example a web site may have client and administrative parts, and each can be logged in the same table and distinguished by application name.
    /// This logic was not available in the original code.
    /// </summary>
    public class ErrorLogPageFactoryMultiApp : ErrorLogPageFactory
	{
        /// <summary>
        /// Gets the handler, works with multiple applications.
        /// Application name comes in the request query string and taken from the context.
        /// </summary>
        /// <param name="context">The context.</param>
        /// <param name="requestType">Type of the request.</param>
        /// <param name="url">The URL.</param>
        /// <param name="pathTranslated">The path translated.</param>
        /// <returns></returns>
		public override IHttpHandler GetHandler(HttpContext context, string requestType, string url, string pathTranslated)
		{
			var appName = context.Request.Params["app"];
            var ex = context.Request.Params["ex"];
            var incl = context.Request.Params["i"];

			var connStrName = string.Empty;

			var doc = XDocument.Load(AppDomain.CurrentDomain.SetupInformation.ConfigurationFile);
			if (doc.Root != null)
			{
				var elmahSection = doc.Root.Elements("elmah").FirstOrDefault();
				if (elmahSection != null)
				{
					var xElement = elmahSection.Element("errorLog");
					if (xElement != null)
					{
						if (string.IsNullOrWhiteSpace(appName))
						{
							appName = xElement.Attribute("applicationName").Value;
						}

						connStrName = xElement.Attribute("connectionStringName").Value;
					}
				}
			}

			var handler = base.GetHandler(context, requestType, url, pathTranslated);
			var err = new SqlErrorLog(WebConfigurationManager.ConnectionStrings[connStrName].ConnectionString)
			{
				ApplicationName = appName ?? string.Empty,
                ExceptionType = ex ?? string.Empty,
                IncludeExceptionType = (incl != null && incl != "0") && ((incl == "1"))
            };

			var fieldInfo = typeof(ErrorLog).GetField("_contextKey", BindingFlags.NonPublic | BindingFlags.Static);
			if (fieldInfo != null)
			{
				var v = fieldInfo.GetValue(null);
				context.Items[v] = err;
			}

			return handler;
		}
	}
}