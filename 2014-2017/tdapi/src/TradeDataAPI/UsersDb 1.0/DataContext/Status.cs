using System.ComponentModel;
using System.ComponentModel.DataAnnotations;
using SharedLibrary.SmartScaffolding.Attributes;

namespace UsersDb.DataContext
{
    [MetadataType(typeof(StatusMetadata))]
	public partial class Status : IAuditable
	{
		public string Key
		{
			get { return Name; }
		}
	}

	[ScaffoldTable(false)]
	[TableCategory("Service Data", "Lookup tables")]
	public class StatusMetadata
	{
		[DisplayName("Usage Statistics")]
		public object UsageStats { get; set; }

	}
}
