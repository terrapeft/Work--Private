using System;
using System.ServiceModel.Web;
using System.Web;
using System.Web.UI;
using Db;
using Db.AuditTrail;
using Db.Helpers;
using Db.Json;
using SharedLibrary.IPAddress;

namespace Statix
{
    public partial class Newedge : MasterPage
    {
        protected override void OnInit(EventArgs e)
        {
            var ip = IpAddressHelper.GetIPAddress();
            var dc = new StatixEntities();

            try
            {
                var helper = new AccessHelper(dc);
                var knownReferrer = false;

                if (Request.UrlReferrer != null)
                {
                    knownReferrer = helper.IsKnownReferrer(Request.UrlReferrer.ToString(), (int)Db.Entities.Enums.Site.Newedge);
                }

                if (!knownReferrer)
                {
                    helper.VerifySiteIpAddress(ip, (int)Db.Entities.Enums.Site.Newedge);
                }

                base.OnInit(e);
            }
            catch (WebFaultException<string>)
            {
                using (var auh = new AuditTrailHelper(dc))
                {
                    auh.Add(new Audit
                    {
                        Id = Guid.NewGuid(),
                        RecordDate = DateTime.Now,
                        UserId = 0,
                        IpAddr = ip,
                        Values = (new AuditParameterJson { ParameterName = "Requested URL", OriginalValue = Request.RawUrl }).AsJsonArray(),
                        ActionId = (int)AuditAction.ForbiddenIpAddress,
                    });

                    dc.SaveChanges();
                }

                throw;
            }
        }

        protected void Page_Load(object sender, EventArgs args)
        {
            if (HttpContext.Current.User.Identity.IsAuthenticated)
            {
                WebActivityLogger.Write(Request, Page.Theme);
            }
        }
    }
}
