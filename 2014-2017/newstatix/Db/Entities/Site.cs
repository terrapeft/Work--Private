using System.ComponentModel.DataAnnotations;
using Db.AuditTrail;

namespace Db
{
    [MetadataType(typeof(SiteMetadata))]
    public partial class Site : IAuditable
    {
    }

    [ScaffoldTable(true)]
    public class SiteMetadata
    {
        public object Referrers { get; set; }

        [Display(Name = "IP Addresses")]
        public object IPAddresses { get; set; }
    }
}