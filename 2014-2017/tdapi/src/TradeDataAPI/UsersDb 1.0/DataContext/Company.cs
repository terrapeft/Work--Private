using System.ComponentModel.DataAnnotations;
using SharedLibrary.SmartScaffolding;
using SharedLibrary.SmartScaffolding.Attributes;

namespace UsersDb.DataContext
{
    [MetadataType(typeof(CompanyMetadata))]
	public partial class Company : IAuditable
	{
		public string Key
		{
			get { return Name; }
		}

		public override string ToString()
		{
			return Name;
		}
	}

    [TableCategory("Service Data")]
	public class CompanyMetadata
	{
		[HideIn(PageTemplate.Insert | PageTemplate.Edit | PageTemplate.CustomerView)]
		public object Users { get; set; }

        [HideIn(PageTemplate.Insert | PageTemplate.Edit | PageTemplate.CustomerView)]
        public object IPs { get; set; }

	}
}
