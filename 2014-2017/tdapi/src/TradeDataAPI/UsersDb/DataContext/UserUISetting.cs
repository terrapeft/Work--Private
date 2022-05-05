using System.ComponentModel;
using System.ComponentModel.DataAnnotations;
using SharedLibrary.SmartScaffolding.Attributes;

namespace UsersDb.DataContext
{
    [MetadataType(typeof(UserUISettingMetadata))]
	public partial class UserUISetting
	{
		public IAuditable TrackEntity { get; set; } 
	}

	[ScaffoldTable(false)]
	[TableCategory("Account")]
	[DisplayName("User settings")]
	public class UserUISettingMetadata
	{
		[ScaffoldColumn(false)]
		public int Id { get; set; }
	}
}
