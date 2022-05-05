using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Db;
using SharedLibrary.ClientStatistics;

namespace Statix
{
    public class WebActivityLogger
    {
        public static void Write(HttpRequest request, string themeName)
        {
            var dc = new StatixEntities();
            var h = new ClientStatisticsHelper(request, themeName);
            var t = h.Stats;
            var log = new LogWebActivity
            {
                App = t.Application,
                ClientIP = t.IpAddress,
                ClientDNSEntry = t.DnsEntry,
                ClientIsCrawler = t.IsCrawler,
                ClientPlatform = t.Platform,
                ClientPort = t.Port,
                ClientUserAgent = t.UserAgent,
                ECMAScriptVersion = t.EcmaScriptVersion,
                HttpAcceptActiveX = t.HttpAcceptActiveX,
                HttpAcceptCookies = t.HttpAcceptCookies,
                HttpAcceptJavaScript = t.HttpAcceptJavaScript,
                HttpAcceptLanguage = t.HttpAcceptLanguage,
                HttpConnection = t.HttpConnection,
                ScreenPixelsHeight = t.ScreenHeight,
                ScreenPixelsWidth = t.ScreenWidth,
                URL = t.Url,
                URLQueryString = t.QueryString,
                URLReferrer = t.Referrer,
                UserName = t.UserName
            };

            dc.LogWebActivities.AddObject(log);
            dc.SaveChanges();
        }
    }
}