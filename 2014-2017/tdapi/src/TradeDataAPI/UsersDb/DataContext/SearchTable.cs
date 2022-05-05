using System.ComponentModel.DataAnnotations;

namespace UsersDb.DataContext
{
    [MetadataType(typeof(SearchTableMetadata))]
	public partial class SearchTable
	{
	}

	[ScaffoldTable(false)]
    public class SearchTableMetadata
	{
    }
}
