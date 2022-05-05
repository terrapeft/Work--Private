using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.ServiceModel;
using System.ServiceModel.Channels;
using System.Web;
using LukeSkywalker.IPNetwork;
using Newtonsoft.Json;
using SharedLibrary.Elmah;

namespace SharedLibrary.IPAddress
{
    /// <summary>
    /// A set of methods to work with http client.
    /// </summary>
    public class IpAddressHelper
    {
        private static HttpContextBase _webContext;

        /// <summary>
        /// Gets or sets the web context.
        /// Used to obtain server variables.
        /// </summary>
        /// <value>
        /// The web context.
        /// </value>
        public static HttpContextBase WebContext
        {
            get
            {
                if (_webContext == null && HttpContext.Current != null)
                {
                    _webContext = new HttpContextWrapper(HttpContext.Current);
                }

                return _webContext;
            }
            set
            {
                _webContext = value;
            }
        }

        /// <summary>
        /// Gets the IP address, first tries from ServerVariables then from OperationContext otherwise returns "127.0.0.1".
        /// </summary>
        /// <returns></returns>
        public static string GetIPAddress()
        {
            var ipStr = "127.0.0.1"; //*/"212.119.177.5";

            try
            {
                if (WebContext != null)
                {
                    var remoteAddr = WebContext.Request.ServerVariables["REMOTE_ADDR"] ?? string.Empty;
                    var ip = (remoteAddr == "::1" ? ipStr : remoteAddr);
                    return ip.Trim();
                }

                if (OperationContext.Current != null)
                {
                    var endpoint = OperationContext.Current.IncomingMessageProperties[RemoteEndpointMessageProperty.Name] as RemoteEndpointMessageProperty;
                    if (endpoint != null)
                    {
                        ipStr = endpoint.Address == "::1" ? ipStr : endpoint.Address;
                    }

                    return ipStr;
                }
            }
            catch (Exception ex)
            {
                Logger.LogError(ex);
            }

            return ipStr;
        }

        /// <summary>
        /// Gets the location information by IP from the third party web service.
        /// The service URL is specified in app.config.
        /// </summary>
        /// <param name="geoServiceUrl">The geo service URL with IP parameter.</param>
        /// <returns>
        /// Modified xml from geolocation service.
        /// </returns>
        public static IpLookupJson VerifyGeoLocation(string geoServiceUrl)
        {
            try
            {
                IpLookupJson cc;

                using (var webClient = new WebClient())
                {
                    var json = webClient.DownloadString(geoServiceUrl);
                    cc = JsonConvert.DeserializeObject<IpLookupJson>(json);
                }

                return cc;
            }
            catch (Exception ex)
            {
                Logger.LogError(ex);
            }

            return null;
        }

        /// <summary>
        /// Determines whether the specified network is a range.
        /// </summary>
        /// <param name="network">The network.</param>
        /// <returns></returns>
        public static bool IsRange(string network) => network.IndexOfAny(new[] { '\\', '/' }) > -1;

        /// <summary>
        /// Gets the network part.
        /// </summary>
        /// <param name="addr">The addr.</param>
        /// <returns></returns>
        public static string Network(string addr) => IsRange(addr) ? addr.Split('\\', '/')[0] : addr;

        /// <summary>
        /// Gets the CIDR part.
        /// </summary>
        /// <param name="addr">The addr.</param>
        /// <returns></returns>
        public static string Cidr(string addr) => IsRange(addr) ? addr.Split('\\', '/')[1] : null;

        /// <summary>
        /// Ensures IPs from the input list are not in any existed range, also compares single IPs.
        /// </summary>
        /// <param name="existed">The existed.</param>
        /// <param name="input">The user input for submit.</param>
        /// <param name="errors">The existed or intersecting IPs/ranges.</param>
        /// <returns></returns>
        public static bool EnsureIntersections(List<string> existed, List<string> input, out List<string> errors)
        {
            var cache = new Dictionary<string, string>();
            var isValid = true;

            // compare strings
            existed
                .Intersect(input)
                .ToList()
                .ForEach(i =>
                {
                    var d = input.FirstOrDefault(il => il.Equals(i));
                    if (d != null)
                    {
                        isValid = false;

                        if (!cache.ContainsKey(d))
                        {
                            cache.Add(d, " - already in list.");
                        }
                    }
                });

            // check ranges
            var ips = existed
                .Where(IsRange);

            foreach (var i in input)
            {
                foreach (var n in ips)
                {
                    if (!IsRange(i))
                    {
                        if (IPNetwork.Contains(IPNetwork.Parse(Network(n), byte.Parse(Cidr(n))), System.Net.IPAddress.Parse(Network(i))))
                        {
                            isValid = false;

                            if (!cache.ContainsKey(i))
                            {
                                cache.Add(i, $" - belongs to existed range '{n}'.");
                            }

                            break;
                        }
                    }
                    else
                    {
                        if (IPNetwork.Overlap(IPNetwork.Parse(Network(n), byte.Parse(Cidr(n))), IPNetwork.Parse(Network(i), byte.Parse(Cidr(i)))))
                        {
                            isValid = false;

                            if (!cache.ContainsKey(i))
                            {
                                cache.Add(i, $" - intersects with existed range '{n}'.");
                            }

                            break;
                        }
                    }
                }
            }

            errors = cache
                .Select(d => d.Key + d.Value)
                .ToList();

            return isValid;
        }
    }
}
