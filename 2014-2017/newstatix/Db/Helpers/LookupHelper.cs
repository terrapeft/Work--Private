using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using SharedLibrary.Elmah;
using SharedLibrary.IPAddress;

namespace Db.Helpers
{
    public class LookupHelper
    {
        /// <summary>
        /// Runs the ip lookup asynchronous.
        /// </summary>
        /// <param name="ipList">The ip list.</param>
        public static void RunIpLookupAsync(IEnumerable<string> ipList)
        {
            Task.Factory.StartNew(() =>
            {
                using (var dc = new StatixEntities())
                {
                    try
                    {
                        ipList.ToList()
                            .ForEach(i =>
                            {
                                var ip = dc.IPAddresses.FirstOrDefault(ii => ii.IPAddr == i);
                                if (ip != null && ip.GeoLocationCountryId == null)
                                {
                                    var cc = IpAddressHelper.VerifyGeoLocation(String.Format(ServiceConfig.IP_Lookup_URL, ip));

                                    if (cc != null)
                                    {
                                        var country = dc.Countries.FirstOrDefault(c => c.Code.Equals(cc.CountryCode, StringComparison.OrdinalIgnoreCase));

                                        if (country == null && !string.IsNullOrWhiteSpace(cc.CountryCode))
                                        {
                                            country = new Country { Code = cc.CountryCode.ToUpper(), Name = cc.CountryName };
                                            dc.Countries.AddObject(country);
                                            dc.SaveChanges();
                                        }

                                        if (country != null) ip.GeoLocationCountryId = country.Id;
                                        ip.SkipAuditTrail = true;
                                        ip.SkipSavingEvents = true;
                                    }
                                }
                            });

                        dc.SaveChanges();
                    }
                    catch (Exception ex)
                    {
                        Logger.LogError(ex);
                    }
                }
            });

            Task.WaitAll();
        }
    }
}
