using System.ComponentModel;
using System.ComponentModel.DataAnnotations;
using SharedLibrary.SmartScaffolding;
using SharedLibrary.SmartScaffolding.Attributes;

namespace UsersDb.DataContext
{
    [MetadataType(typeof(CountryMetadata))]
	public partial class Country : IAuditable
	{
		public override string ToString()
		{
			return Name;
		}
	}

	[TableCategory("Service Data")]
	public class CountryMetadata
	{
		[OrderBy]
		public object Name { get; set; }

        [DisplayName("IP List")]
        [HideIn(PageTemplate.Insert | PageTemplate.Edit | PageTemplate.CustomerView)]
        public object IpList { get; set; }

        [HideIn(PageTemplate.Insert | PageTemplate.Edit | PageTemplate.CustomerView)]
        public object Companies { get; set; }
	}
}
