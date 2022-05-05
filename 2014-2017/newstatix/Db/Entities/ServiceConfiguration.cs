using System;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations;
using System.Web.UI;
using Db.AuditTrail;
using SharedLibrary.SmartScaffolding;
using SharedLibrary.SmartScaffolding.Attributes;

namespace Db
{
    [MetadataType(typeof(ServiceConfigurationMetadata))]
	public partial class ServiceConfiguration : IAuditable
	{
		public IAuditable TrackEntity { get; set; }
	}

	[Description("For resource names please provide only letters, digits and whitespace.")]
	[DisplayName("Service Configuration")]
	[RestrictAction(Action = PageTemplate.Insert | PageTemplate.Delete)]
    [ResourceTable]
    [ScaffoldTable(true)]
	public class ServiceConfigurationMetadata
	{
		[ScaffoldColumn(false)]
		public int Id { get; set; }

		[RegularExpression(@"^[A-Za-z0-9 ]*$", ErrorMessage = "Please use only letters, digits and whitespace.")]
		[ReadOnlyIn(PageTemplate.Edit)]
        [CssClass("no-wrap")]
		public string Name { get; set; }

		[DisplayName("Resource type")]
		public object ResourceType { get; set; }

        [GroupBy()]
        [DisplayName("Group name")]
	    public string GroupName { get; set; }
	}
}
