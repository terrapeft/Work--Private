using System.ComponentModel;
using System.ComponentModel.DataAnnotations;
using SharedLibrary.SmartScaffolding.Attributes;

namespace UsersDb.DataContext
{
    [MetadataType(typeof(SearchGroupMetadata))]
	public partial class SearchGroup : IAuditable
	{
	}

	[DisplayName("Search Groups")]
    [TableCategory("CUI Config")]
	public class SearchGroupMetadata
	{
        [UIHint("SearchColumns")]
		[DisplayName("Search Columns")]
		public object SearchColumns { get; set; }

		[UIHint("GroupPermission")]
        [DisplayName("Required permissions")]
		public object Permissions { get; set; }

        [DisplayName("Table")]
        [UIHint("ForeignKeyAutoPostBack")]
        public object SearchTable { get; set; }
    }
}
