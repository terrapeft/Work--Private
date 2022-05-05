using System.Collections.Generic;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations;
using System.Data;
using System.Data.Objects;
using System.Linq;
using System.Net;
using LukeSkywalker.IPNetwork;
using SharedLibrary;
using SharedLibrary.IPAddress;
using SharedLibrary.SmartScaffolding;
using SharedLibrary.SmartScaffolding.Attributes;
using UsersDb.Helpers;

namespace UsersDb.DataContext
{
    [MetadataType(typeof(IPMetadata))]
    public partial class IP : IAuditable, IEntity, ISpecialAction
    {
        public string Key => Ip;

        public string IpOrFirstInRange => Ip.IndexOfAny(new[] { '\\', '/' }) > -1 ? Range.FirstOrDefault() : Ip;

        public List<string> Range => IpListSplitter.Split(Ip, true);

        /// <summary>
        /// This method is called by context instance from the SaveChanges.
        /// </summary>
        /// <param name="context">The context.</param>
        /// <param name="entry">The entry.</param>
        public void BeforeSave(UsersDataContext context, ObjectStateEntry entry)
        {
            if (entry.State == EntityState.Deleted) return;

            var ip = (IP)entry.Entity;

            switch (entry.State)
            {
                case EntityState.Added:
                    var ips = IpListSplitter.Split(ip.Ip)
                        .Except(context.IPs.Select(i => i.Ip))
                        .ToList();

                    if (ips.Any())
                    {

                        ip.Ip = ips.First();

                        foreach (var addr in ips.Skip(1))
                        {
                            var newIp = context.Clone(ip);
                            newIp.Ip = addr;
                            context.IPs.AddObject(newIp);
                        }
                    }

                    break;
            }
        }

        public void AfterSave(UsersDataContext context, IEnumerable<ObjectStateEntry> entries)
        {
            if (entries != null)
            {
                var lookupList = entries
                    .Select(e => e.Entity)
                    .Cast<IP>()
                    .Where(i => i.GeoLocationCountryId == null || i.GeoLocationCountryId <= 0)
                    .Select(i => i.Ip)
                    .ToList();

                AccessHelper.RunIpLookupAsync(lookupList);
            }
        }

        public override string ToString()
        {
            return Ip;
        }

        public bool SkipSavingEvents { get; set; }
        public bool SkipAuditTrail { get; set; }
    }

    [DisplayName("IP Addresses")]
    [TableCategory("Service Data")]
    public class IPMetadata
    {
        [UIHint("IpRange")]
        public object Ip { get; set; } 

        [DisplayName("Allowed")]
        public object IsAllowed { get; set; }

        [DisplayName("Looked Up Country")]
        [HideIn(PageTemplate.Insert)]
        public object LookedUpCountry { get; set; }

        [DisplayName("Statistics")]
        [HideIn(PageTemplate.Insert | PageTemplate.Edit | PageTemplate.CustomerView)]
        public object UsageStats { get; set; }

        [DisplayName("Deleted")]
        public object IsDeleted { get; set; }
    }
}
