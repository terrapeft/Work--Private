using System.ComponentModel;
using System.ComponentModel.DataAnnotations;
using SharedLibrary.SmartScaffolding.Attributes;

namespace UsersDb.DataContext
{
    [MetadataType(typeof(PermissionMetadata))]
	public partial class Permission : IAuditable
	{
        public static string TrialistRoleName = "Trialist";

        public string Key
		{
			get { return Name; }
		}
	}

    [TableCategory("CUI Config")]
	public class PermissionMetadata
	{
        [DisplayName("User roles")]
        public string Roles { get; set; }

        [DisplayName("Search groups")]
        public string SearchGroups { get; set; }

        [DisplayName("Permission type")]
        public object PermissionType { get; set; }
	}
}
