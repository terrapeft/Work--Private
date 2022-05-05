using System.ComponentModel.DataAnnotations;

namespace UsersDb.DataContext
{
    [MetadataType(typeof(PermissionTypeMetadata))]
	public partial class PermissionType : IAuditable
	{
		public string Key
		{
			get { return Name; }
		}
	}

    [ScaffoldTable(false)]
    public class PermissionTypeMetadata
	{
	}
}
