using System.ComponentModel;
using System.ComponentModel.DataAnnotations;
using SharedLibrary.SmartScaffolding.Attributes;

namespace UsersDb.DataContext
{
    [MetadataType(typeof(SearchColumnMetadata))]
	public partial class SearchColumn : IAuditable
	{
	    public override string ToString()
	    {
	        return Alias;
	    }
	}

	[DisplayName("Search Columns")]
    [TableCategory("CUI Config")]
	public class SearchColumnMetadata
	{
		[DisplayName("Search Groups")]
		public object SearchGroups { get; set; }

		[OrderBy]
		public object Alias { get; set; }

        [DisplayName("Table")]
        public object SearchTable { get; set; }
	}
}
