using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Web;
using SharedLibrary.IPAddress;

namespace SharedLibrary.ClientStatistics
{

    /// <summary>
    /// Helper tries to obtain available information about a client.
    /// </summary>
    public class ClientStatisticsHelper
    {
        private ClientStatistics stats;

        /// <summary>
        /// Initializes a new instance of the <see cref="ClientStatisticsHelper"/> class.
        /// </summary>
        /// <param name="request">The request.</param>
        /// <param name="themeName">Name of the theme.</param>
        public ClientStatisticsHelper(HttpRequest request, string themeName)
        {
            stats = new ClientStatistics
            {
                UserName = HttpContext.Current.User.Identity.Name,
                Application = themeName,
                UserAgent = request.UserAgent,
                IpAddress = IpAddressHelper.GetIPAddress(),
                Port = request.Url.Port,
                Url = request.Url.ToString(),
                QueryString = request.Url.Query,
                HttpAcceptLanguage = request.Headers["Accept-Language"],
                HttpConnection = request.RequestType,
                HttpAcceptJavaScript = request.Browser.EcmaScriptVersion.Major >= 1,
                HttpAcceptActiveX = request.Browser.ActiveXControls,
                EcmaScriptVersion = request.Browser.EcmaScriptVersion.ToString(),
                ScreenHeight = 0,
                ScreenWidth = 0,
                HttpAcceptCookies = request.Browser.Cookies,
                Platform = request.Browser.Platform,
                IsCrawler = false,
                Referrer = (request.UrlReferrer != null) ? request.UrlReferrer.ToString() : null
            };
        }

        public ClientStatistics Stats
        {
            get { return stats; }
        }
    }
}
