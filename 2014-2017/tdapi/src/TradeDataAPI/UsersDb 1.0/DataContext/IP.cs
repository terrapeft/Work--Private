using System.Collections.Generic;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations;
using System.Data;
using System.Data.Objects;
using System.Linq;
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
        public string Key
        {
            get { return Ip; }
        }

        /// <summary>
        /// This method is called by context instance from the SaveChanges.
        /// </summary>
        /// <param name="context">The context.</param>
        /// <param name="entry">The entry.</param>
        public void BeforeSave(UsersDataContext context, ObjectStateEntry entry)
        {
            if (entry.State == EntityState.Deleted) return;

            var ip = (IP)entry.Entity;
            var ips = IpListSplitter.Split(ip.Ip, true)
                .Except(context.IPs.Select(i => i.Ip))
                .ToList();

            if (ips.Any())
            {
                if (entry.State == EntityState.Added)
                {
                    ip.Ip = ips.First();

                    foreach (var addr in ips.Skip(1))
                    {
                        var newIp = context.Clone(ip);
                        newIp.Ip = addr;
                        context.IPs.AddObject(newIp);
                    }
                }
                else if (entry.State == EntityState.Modified)
                {
                    var orig = context.ObjectStateManager.GetObjectStateEntry(entry.Entity).OriginalValues;
                    ip.Ip = orig["Ip"].ToString();

                    foreach (var addr in ips)
                    {
                        var newIp = context.Clone(ip);
                        newIp.Ip = addr;
                        context.IPs.AddObject(newIp);
                    }
                }
            }
            else
            {
                // delete entity if the list is empty after checking for unique values.
                if (entry.State == EntityState.Added)
                    entry.ChangeState(EntityState.Unchanged);

                if (entry.State == EntityState.Modified)
                    entry.RejectPropertyChanges("Ip");
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
