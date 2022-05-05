
using System;
using System.Security.Principal;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using SharedLibrary;
using UsersDb;
using UsersDb.DataContext;
using UsersDb.Helpers;

namespace CustomersUI
{
    public partial class Site : MasterPage
    {
        /// <summary>
        /// Handles the Load event of the Page control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="args">The <see cref="EventArgs"/> instance containing the event data.</param>
	    protected void Page_Load(object sender, EventArgs args)
        {
            var userName = HttpContext.Current.User != null && HttpContext.Current.User.Identity.IsAuthenticated ? HttpContext.Current.User.Identity.Name : string.Empty;
            var principal = new GenericPrincipal(new GenericIdentity(userName, string.Empty), new string[] { });
            var allowed = UrlAuthorizationModule.CheckUrlAccessForPrincipal(Page.AppRelativeVirtualPath, principal, Request.HttpMethod);

            if (allowed)
            {
                if (HttpContext.Current.User.Identity.IsAuthenticated)
                {
                    var dc = new UsersDataContext();
                    if (!new AccessHelper(dc).IsSessionTokenUpToDate(Request.GetSessionToken(HttpContext.Current.User.Identity.Name)))
                    {
                        using (var auh = new AuditTrailHelper(dc))
                        {
                            auh.Add(new Audit
                            {
                                Id = Guid.NewGuid(),
                                RecordDate = DateTime.Now,
                                UserId = dc.CurrentUserId,
                                IpAddr = AccessHelper.GetIPAddress(),
                                ActionId = (int)AuditAction.ConcurrentLogOff,
                            });
                        }

                        dc.SaveChanges();

                        FormsAuthentication.SignOut();
                        FormsAuthentication.RedirectToLoginPage();
                    }
                }

                multiView1.SetActiveView(authorizedView);
            }
        }
    }
}
