using SharedLibrary.SmartScaffolding.Attributes;

namespace UsersDb.DataContext
{
	using System.ComponentModel.DataAnnotations;

    [MetadataType(typeof(ActionMetadata))]
	public partial class Action : IAuditable
	{
		public string Key
		{
			get { return Name; }
		}
	}

	[ScaffoldTable(false)]
	[TableCategory("Service Data", "Lookup tables")]
	public class ActionMetadata
	{
	}
}
