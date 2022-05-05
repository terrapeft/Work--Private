using System.ComponentModel.DataAnnotations;
using Db.AuditTrail;

namespace Db
{
    [MetadataType(typeof(ReferrerMetadata))]
    public partial class Referrer : IAuditable
    {
    }

    [ScaffoldTable(true)]
    public class ReferrerMetadata
    {
    }
}