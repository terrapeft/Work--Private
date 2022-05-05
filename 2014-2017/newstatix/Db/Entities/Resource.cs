using System;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations;
using Db.AuditTrail;
using SharedLibrary.SmartScaffolding;
using SharedLibrary.SmartScaffolding.Attributes;

namespace Db
{
    [MetadataType(typeof(ResourceMetadata))]
	public partial class Resource : IAuditable
	{
		public IAuditable TrackEntity { get; set; } 
	}

	[Description("For resource names please provide only letters, digits and whitespace.")]
	[RestrictAction(Action = PageTemplate.Insert | PageTemplate.Delete)]
    [ResourceTable]
    [ScaffoldTable(true)]
	public class ResourceMetadata
	{
		[ScaffoldColumn(false)]
		public Guid Id { get; set; }

		[RegularExpression(@"^[A-Za-z0-9 ]*$", ErrorMessage = "Please use only letters, digits and whitespace.")]
		[ReadOnlyIn(PageTemplate.Edit)]
		public string Name { get; set; }


        public string Value { get; set; }

		[DisplayName("Resource type")]
        [ReadOnlyIn(PageTemplate.Edit)]
		public object ResourceType { get; set; }

        [GroupBy()]
        [DisplayName("Group name")]
        public string GroupName { get; set; }
	}
}
