using System.ComponentModel;
using System.ComponentModel.DataAnnotations;
using SharedLibrary.SmartScaffolding.Attributes;

namespace UsersDb.DataContext
{
    [MetadataType(typeof(RoleMetadata))]
	public partial class Role : IAuditable
	{
		public string Key
		{
			get { return Name; }
		}
	}

	[TableCategory("Service Data", "Lookup tables")]
	public class RoleMetadata
	{
        [DisplayName("Deleted")]
        public object IsDeleted { get; set; }
    }
}
