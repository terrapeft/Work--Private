using System;

namespace SharedLibrary.ClientStatistics
{
    /// <summary>
    /// Data structure for the ClientStatisticsHelper
    /// </summary>
    public class ClientStatistics
    {
        /// <summary>
        /// The application name
        /// </summary>
        public string Application;
        /// <summary>
        /// The username
        /// </summary>
        public string UserName;
        /// <summary>
        /// The IP address
        /// </summary>
        public string IpAddress;
        /// <summary>
        /// The port
        /// </summary>
        public int Port;
        /// <summary>
        /// The user agent
        /// </summary>
        public string UserAgent;
        /// <summary>
        /// The DNS entry
        /// </summary>
        public string DnsEntry;
        /// <summary>
        /// The URL
        /// </summary>
        public string Url;
        /// <summary>
        /// The referrer
        /// </summary>
        public string Referrer;
        /// <summary>
        /// The query string
        /// </summary>
        public string QueryString;
        /// <summary>
        /// The HTTP accept language
        /// </summary>
        public string HttpAcceptLanguage;
        /// <summary>
        /// The HTTP request type (GET, POST)
        /// </summary>
        public string HttpConnection;
        /// <summary>
        /// True if client accepts JavaScript
        /// </summary>
        public bool HttpAcceptJavaScript;
        /// <summary>
        /// True if client accepts ActiveX
        /// </summary>
        public bool HttpAcceptActiveX;
        /// <summary>
        /// True if client accepts cookies
        /// </summary>
        public bool HttpAcceptCookies;
        /// <summary>
        /// The ECMA script version
        /// </summary>
        public string EcmaScriptVersion;
        /// <summary>
        /// The screen height, currently is always 0
        /// </summary>
        public int ScreenHeight;
        /// <summary>
        /// The screen width, currently is always 0
        /// </summary>
        public int ScreenWidth;
        /// <summary>
        /// The platform
        /// </summary>
        public string Platform;
        /// <summary>
        /// True if client is a crawler, currently is always false
        /// </summary>
        public bool IsCrawler;
    }
}
