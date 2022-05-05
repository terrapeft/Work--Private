using System;
using System.Collections.Specialized;
using System.Web.UI;

namespace UsersUI.DynamicData.FieldTemplates
{
	public partial class ColorPicker_EditField : System.Web.DynamicData.FieldTemplateUserControl
	{
		protected void Page_Load(object sender, EventArgs e)
		{
			smallhsvTextBox.MaxLength = Column.MaxLength;
			if (Column.MaxLength < 20)
				smallhsvTextBox.Columns = Column.MaxLength;
			smallhsvTextBox.ToolTip = Column.Description;

			SetUpValidator(RequiredFieldValidator1);
			SetUpValidator(RegularExpressionValidator1);
			SetUpValidator(DynamicValidator1);
		}

		protected override void ExtractValues(IOrderedDictionary dictionary)
		{
			dictionary[Column.Name] = ConvertEditedValue(smallhsvTextBox.Text);
		}

		public override Control DataControl
		{
			get
			{
				return smallhsvTextBox;
			}
		}
	}
}
