using System.ComponentModel.DataAnnotations;

namespace UsersDb.DataContext
{
    [MetadataType(typeof(DataFormatMetadata))]
	public partial class DataFormat
	{
	}

	[ScaffoldTable(false)]
    public class DataFormatMetadata
	{
	}
}
