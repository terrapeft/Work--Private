using System;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations;
using SharedLibrary.SmartScaffolding;
using SharedLibrary.SmartScaffolding.Attributes;

namespace UsersDb.DataContext
{
    [MetadataType(typeof(ResourceMetadata))]
	public partial class Resource : IAuditable, IConfiguration
    {
		public IAuditable TrackEntity { get; set; } 
	}

    [Description("Changes will take effect for any user only after his or her session is restarted!")]
    [TableCategory("System Settings")]
	[RestrictAction(Action = PageTemplate.Insert | PageTemplate.Delete)]
    [ResourceTable]
	public class ResourceMetadata
	{
		[ScaffoldColumn(false)]
		public Guid Id { get; set; }

		[RegularExpression(@"^[A-Za-z0-9 ]*$", ErrorMessage = "Please use only letters, digits and whitespace.")]
		[ReadOnlyIn(PageTemplate.Edit)]
		public string Name { get; set; }

		[DisplayName("Resource type")]
        [ReadOnlyIn(PageTemplate.Edit)]
		public object ResourceType { get; set; }

        [GroupBy()]
        [DisplayName("Group name")]
        [UIHint("GroupName")]
        public string GroupName { get; set; }

        [DisplayName("Deleted")]
        public object IsDeleted { get; set; }
    }
}
