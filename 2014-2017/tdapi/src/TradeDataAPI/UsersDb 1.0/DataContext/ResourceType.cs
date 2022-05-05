using System.ComponentModel.DataAnnotations;

namespace UsersDb.DataContext
{
    [MetadataType(typeof(ResourceTypeMetadata))]
	public partial class ResourceType
	{
	}

	[ScaffoldTable(false)]
	public class ResourceTypeMetadata
	{
	}
}
