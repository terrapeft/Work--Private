using System;
using System.Collections.Specialized;
using System.Web.UI;

namespace UsersUI.DynamicData.FieldTemplates
{
	public partial class ReadonlyDate_EditField : System.Web.DynamicData.FieldTemplateUserControl
	{
		protected void Page_Load(object sender, EventArgs e)
		{
		}

		protected override void ExtractValues(IOrderedDictionary dictionary)
		{
			dictionary[Column.Name] = ConvertEditedValue(Literal1.Text);
		}

		public override Control DataControl
		{
			get
			{
				return Literal1;
			}
		}
	}
}
