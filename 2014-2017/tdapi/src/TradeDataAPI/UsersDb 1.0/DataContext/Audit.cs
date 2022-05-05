using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations;
using SharedLibrary.SmartScaffolding;
using SharedLibrary.SmartScaffolding.Attributes;
using UsersDb.JSON;

namespace UsersDb.DataContext
{
    [MetadataType(typeof(AuditMetadata))]
    public partial class Audit
    {
        public IAuditable TrackEntity { get; set; }
    }

    [TableCategory("Users")]
    [RestrictAction(Action = PageTemplate.Insert)]
    [ReadOnly(true)]
    public class AuditMetadata
    {
        [ScaffoldColumn(false)]
        public Guid Id { get; set; }

        [UIHint("JsonTransform")]
        [JsonType(typeof(List<AuditParameterJson>))]
        public string Values { get; set; }

        [OrderBy("DESC")]
        [DisplayName("Record Date")]
        public DateTime RecordDate { get; set; }

        [DisplayName("Table")]
        public object TableName { get; set; }

        [DisplayName("IP Address")]
        public object IpAddr { get; set; }
    }
}