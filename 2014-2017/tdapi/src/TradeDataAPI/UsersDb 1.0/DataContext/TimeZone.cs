using System.ComponentModel;
using System.ComponentModel.DataAnnotations;
using SharedLibrary.SmartScaffolding;
using SharedLibrary.SmartScaffolding.Attributes;

namespace UsersDb.DataContext
{
    [MetadataType(typeof(TimeZoneMetadata))]
	public partial class TimeZone : IAuditable
	{
		public override string ToString()
		{
			return Name;
		}
	}

	[DisplayName("Time Zones")]
	[TableCategory("Service Data")]
	public class TimeZoneMetadata
	{
		[OrderBy]
		public object Name { get; set; }

        [HideIn(PageTemplate.Insert | PageTemplate.Edit)]
        public object Users { get; set; }

	}
}
