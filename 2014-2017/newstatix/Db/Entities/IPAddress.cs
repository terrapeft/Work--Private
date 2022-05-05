using System.Collections.Generic;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations;
using System.Data;
using System.Data.Objects;
using System.Linq;
using Db.AuditTrail;
using Db.Helpers;
using SharedLibrary;
using SharedLibrary.IPAddress;
using SharedLibrary.SmartScaffolding;
using SharedLibrary.SmartScaffolding.Attributes;

namespace Db
{
    [MetadataType(typeof(IPAddressMetadata))]
    public partial class IPAddress : IAuditable, IEntity, ISpecialAction
    {
        public string Key
        {
            get { return IPAddr; }
        }

        /// <summary>
        /// This method is called by context instance from the SaveChanges.
        /// </summary>
        /// <param name="context">The context.</param>
        /// <param name="entry">The entry.</param>
        public void BeforeSave(StatixEntities context, ObjectStateEntry entry)
        {
            if (entry.State == EntityState.Deleted) return;

            var ip = (IPAddress)entry.Entity;
            var ips = IpListSplitter.Split(ip.IPAddr, true)
                .Except(context.IPAddresses.Select(i => i.IPAddr))
                .ToList();

            if (ips.Any())
            {
                if (entry.State == EntityState.Added)
                {
                    ip.IPAddr = ips.First();

                    foreach (var addr in ips.Skip(1))
                    {
                        var newIp = context.Clone(ip);
                        newIp.IPAddr = addr;
                        context.IPAddresses.AddObject(newIp);
                    }
                }
                else if (entry.State == EntityState.Modified)
                {
                    var orig = context.ObjectStateManager.GetObjectStateEntry(entry.Entity).OriginalValues;
                    ip.IPAddr = orig["IPAddr"].ToString();

                    foreach (var addr in ips)
                    {
                        var newIp = context.Clone(ip);
                        newIp.IPAddr = addr;
                        context.IPAddresses.AddObject(newIp);
                    }
                }
            }
            else
            {
                // delete entity if the list is empty after checking for unique values.
                if (entry.State == EntityState.Added)
                    entry.ChangeState(EntityState.Unchanged);

                if (entry.State == EntityState.Modified)
                    entry.RejectPropertyChanges("IPAddr");
            }
        }

        public void AfterSave(StatixEntities context, IEnumerable<ObjectStateEntry> entries)
        {
            if (entries != null)
            {
                var lookupList = entries
                    .Select(e => e.Entity)
                    .Cast<IPAddress>()
                    .Where(i => i.GeoLocationCountryId == null)
                    .Select(i => i.IPAddr)
                    .ToList();

                LookupHelper.RunIpLookupAsync(lookupList);
            }
        }

        public override string ToString()
        {
            return IPAddr;
        }

        public bool SkipSavingEvents { get; set; }
        public bool SkipAuditTrail { get; set; }
    }

    [DisplayName("IP Addresses")]
    [ScaffoldTable(true)]
    public class IPAddressMetadata
    {
        [UIHint("IpRange")]
        [Display(Name = "IP Address")]
        public object IPAddr { get; set; }

        [DisplayName("Allowed")]
        public object IsAllowed { get; set; }

        [DisplayName("Looked Up Country")]
        [HideIn(PageTemplate.Insert)]
        public object GeoLocationCountryId { get; set; }
    }
}
