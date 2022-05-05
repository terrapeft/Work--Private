using System;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using Db;
using Db.AuditTrail;
using Db.Helpers;
using SharedLibrary;
using SharedLibrary.IPAddress;

namespace Statix
{
    public partial class Site : System.Web.UI.MasterPage
    {
        protected void Page_Init(object sender, EventArgs args)
        {
            Menu1.IsAuthenticated = HttpContext.Current.User.Identity.IsAuthenticated;
        }

        protected void Page_Load(object sender, EventArgs args)
        {
            System.Collections.IList visibleTables = Global.DefaultModel.VisibleTables;
            if (visibleTables.Count == 0)
            {
                throw new InvalidOperationException("There are no accessible tables. Make sure that at least one data model is registered in Global.asax and scaffolding is enabled or implement custom pages.");
            }

            if (HttpContext.Current.User.Identity.IsAuthenticated)
            {
                WebActivityLogger.Write(Request, Page.Theme);

                var dc = new StatixEntities();
                if (!new AccessHelper(dc).IsSessionTokenUpToDate(
                        Request.GetSessionToken(HttpContext.Current.User.Identity.Name)))
                {
                    using (var auh = new AuditTrailHelper(dc))
                    {
                        auh.Add(new Audit
                        {
                            Id = Guid.NewGuid(),
                            RecordDate = DateTime.Now,
                            UserId = dc.CurrentUserId,
                            IpAddr = IpAddressHelper.GetIPAddress(),
                            ActionId = (int)AuditAction.ConcurrentLogOff,
                        });
                    }

                    dc.SaveChanges();

                    FormsAuthentication.SignOut();
                    FormsAuthentication.RedirectToLoginPage();
                }
            }
        }
    }
}
