using System;
using System.Web;
using System.Linq;
using Db;
using SharedLibrary.IPAddress;

namespace Statix
{
    public class ThemeSelector
    {
        private const string BnpTheme = "Bp2s";
        private const string NewedgeTheme = "Newedge";
        private const string DefaultTheme = "General";

        private const string BnpMasterPage = "/Bp2s.master";
        private const string NewedgeMasterPage = "/Newedge.master";
        private const string DefaultMasterPage = "/Site.master";


        public static string SelectTheme(int siteId, out string themeName)
        {
            if (siteId == (int)Db.Entities.Enums.Site.BnpParibas)
            {
                themeName = BnpTheme;
                return BnpMasterPage;
            }

            if (siteId == (int)Db.Entities.Enums.Site.Newedge)
            {
                themeName = NewedgeTheme;
                return NewedgeMasterPage;
            }

            themeName = DefaultTheme;
            return DefaultMasterPage;
        }

        public static string SelectTheme(HttpRequest request, out string themeName)
        {
            var dc = new StatixEntities();

            // first try by IP
            var ip = IpAddressHelper.GetIPAddress();
            var addr = dc.Sites
                .SelectMany(s => s.IPAddresses.Where(a => a.IPAddr == ip))
                .FirstOrDefault();

            if (addr != null)
            {
                var site = addr.Sites.FirstOrDefault();
                if (site != null)
                {
                    return SelectTheme(site.Id, out themeName);
                }
            }

            // next try by referrer
            var rfr = request.UrlReferrer;
            if (rfr != null)
            {
                var rstr = rfr.ToString();
                var referrer = dc.Sites
                    .SelectMany(s => s.Referrers.Where(a => rstr.IndexOf(a.Value) > -1))
                    .FirstOrDefault();
                if (referrer != null)
                {
                    var rSite = referrer.Sites.FirstOrDefault();
                    if (rSite != null)
                    {
                        return SelectTheme(rSite.Id, out themeName);
                    }
                }
            }

            // finally by url markers
            var url = request.Url.ToString();
            var siteId = url.IndexOf(ServiceConfig.BNP_Paribas_Marker, StringComparison.OrdinalIgnoreCase) >= 0
                ? (int)Db.Entities.Enums.Site.BnpParibas
                : url.IndexOf(ServiceConfig.Newedge_Marker, StringComparison.OrdinalIgnoreCase) >= 0
                    ? (int)Db.Entities.Enums.Site.Newedge
                    : (int)Db.Entities.Enums.Site.General;

            return SelectTheme(siteId, out themeName);
        }
    }
}