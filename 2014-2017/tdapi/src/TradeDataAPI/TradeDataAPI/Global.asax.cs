using System;
using System.ServiceModel.Activation;
using System.Web.Routing;
using SharedLibrary.Cache;
using UsersDb.Code;

namespace TradeDataAPI
{
	using Elmah;

	using UsersDb;
	using UsersDb.Helpers;

	public class Global : System.Web.HttpApplication
	{
		protected void Application_Start(object sender, EventArgs e)
		{
			// hide the svc extension
			// notice the first parameter of the service route, the service url wil be combined as following:
			// domain.com/first parameter/UriTemplate of WebInvoke attribute
			RouteTable.Routes.Add(new ServiceRoute("", new WebServiceHostFactory(), typeof(ExportDataService)));

			CacheHelper.LoadAsync(Constants.XymRootTableName, CommonActions.LoadXymRootLevelGlobalFunc);

			ServiceConfig.PreloadAsync();
			Resources.PreloadAsync();
		}

/*		public void FormsAuthentication_OnAuthenticate(object sender, FormsAuthenticationEventArgs args)
		{
			if (FormsAuthentication.CookiesSupported)
			{
				if (Request.Cookies[FormsAuthentication.FormsCookieName] != null)
				{
					try
					{
						FormsAuthenticationTicket ticket = FormsAuthentication.Decrypt(
						  Request.Cookies[FormsAuthentication.FormsCookieName].Value);

						//args.User = new System.Security.Principal.GenericPrincipal(
						//  new Samples.AspNet.Security.MyFormsIdentity(ticket),
						//  new string[0]);
					}
					catch (Exception e)
					{
						// Decrypt method failed.
					}
				}
			}
			else
			{
				throw new HttpException("Cookieless Forms Authentication is not " +
												"supported for this application.");
			}
		}*/

		void Application_Error(object sender, EventArgs e)
		{
			Logger.LogError(Server.GetLastError());
			Server.ClearError();
		}
	}
}