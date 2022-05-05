using System.ComponentModel;
using System.ComponentModel.DataAnnotations;
using SharedLibrary.SmartScaffolding;
using SharedLibrary.SmartScaffolding.Attributes;

namespace UsersDb.DataContext
{
    [MetadataType(typeof(InformerMetadata))]
	public partial class Informer : IAuditable
	{
	}

	[TableCategory("Account")]
	[AllowAction(Action = PageTemplate.Clone)]
	public class InformerMetadata
	{
		[FilterUIHint("Informer")]
		[UIHint("Informer")]
		public Method Method { get; set; }

		[HideIn(PageTemplate.List)]
		[DisplayName("Title Style")]
		public string TitleStyle { get; set; }

		[HideIn(PageTemplate.List)]
		[DisplayName("Content Style")]
		public string ContentStyle { get; set; }

		[HideIn(PageTemplate.List)]
		[DisplayName("Informer Style")]
		public string InformerStyle { get; set; }

		[ScaffoldColumn(false)]
		[HideIn(PageTemplate.List)]
		[DisplayName("Footer Style")]
		public string FooterStyle { get; set; }

		[ScaffoldColumn(false)]
		[DisplayName("Show Footer")]
		public string ShowFooter { get; set; }

		[ScaffoldColumn(false)]
		public string XsltParameters { get; set; }

		[UIHint("XsltFile")]
		public string Xslt;

		[UIHint("ColorPicker")]
		[DisplayName("Informer Color")]
		public string ContentColor {get; set;}

		[UIHint("ColorPicker")]
		[DisplayName("Header Color")]
		public string HeaderColor { get; set; }

		//[ScaffoldColumn(false)]
		[UIHint("ColorPicker")]
		[DisplayName("Footer Color")]
		public string FooterColor { get; set; }
	}
}
