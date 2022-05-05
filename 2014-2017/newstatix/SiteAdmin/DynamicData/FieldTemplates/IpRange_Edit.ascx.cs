using System;
using System.Collections.Specialized;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace AdministrativeUI.DynamicData.FieldTemplates
{
	public partial class IpRange_EditField : System.Web.DynamicData.FieldTemplateUserControl
	{
		protected void Page_Load(object sender, EventArgs e)
		{
			TextBox1.MaxLength = Column.MaxLength;
			if (Column.MaxLength < 20)
				TextBox1.Columns = Column.MaxLength;

			TextBox1.TextMode = TextBoxMode.MultiLine;
			TextBox1.Width = 250;
			TextBox1.Height = 350;
			TextBox1.ToolTip = Column.Description;

			SetUpValidator(RequiredFieldValidator1);
			SetUpValidator(RegularExpressionValidator1);
			SetUpValidator(DynamicValidator1);
		}

		protected override void ExtractValues(IOrderedDictionary dictionary)
		{
			dictionary[Column.Name] = ConvertEditedValue(TextBox1.Text);
		}

		public override Control DataControl
		{
			get
			{
				return TextBox1;
			}
		}
	}
}
