using System.ComponentModel;
using System.ComponentModel.DataAnnotations;
using SharedLibrary.SmartScaffolding.Attributes;

namespace UsersDb.DataContext
{
    [MetadataType(typeof(MethodTypeMetadata))]
	public partial class MethodType : IAuditable
	{
		public string Key
		{
			get { return Name; }
		}
	}

	[ScaffoldTable(false)]
	[TableCategory("Service Data", "Lookup tables")]
	[DisplayName("Method types")]
	public class MethodTypeMetadata
	{
	}
}
