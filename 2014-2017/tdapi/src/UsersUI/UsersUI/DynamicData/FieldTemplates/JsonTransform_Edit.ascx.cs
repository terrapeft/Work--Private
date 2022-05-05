using System;
using System.Collections.Specialized;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace UsersUI.DynamicData.FieldTemplates
{
	public partial class JsonTransform_EditField : System.Web.DynamicData.FieldTemplateUserControl
	{ 
		protected void Page_Load(object sender, EventArgs e)
		{
            TextBox1.TextMode = TextBoxMode.MultiLine;
            if (Column.MaxLength < 20)
            {
                TextBox1.Columns = Column.MaxLength;
            }

            TextBox1.ToolTip = Column.Description;

			SetUpValidator(RequiredFieldValidator1);
			SetUpValidator(RegularExpressionValidator1);
			SetUpValidator(DynamicValidator1);
		}

        public override void DataBind()
        {
            base.DataBind();

            if (TextBox1.Text.Length > 22)
            {
                TextBox1.Width = 340;
                TextBox1.Height = 100;
            }
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
