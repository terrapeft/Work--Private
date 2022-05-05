using System;
using System.Collections.Specialized;
using System.Web.DynamicData;
using System.Web.UI;
using System.Web.UI.WebControls;
using UsersDb.Helpers;

namespace UsersUI.DynamicData.FieldTemplates
{
    public partial class ConnectionString_EditField : FieldTemplateUserControl
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
            SetUpValidator(DynamicValidator1);
        }

        protected override void ExtractValues(IOrderedDictionary dictionary)
        {
            var str = ConvertEditedValue(TextBox1.Text);
            if (str != null)
            {
                dictionary[Column.Name] = CommonHelper.EncryptConnectionString(str.ToString());
                return;
            }

            dictionary[Column.Name] = ConvertEditedValue(TextBox1.Text);
        }

        protected override void OnDataBinding(EventArgs e)
        {
            base.OnDataBinding(e);
            if (Column.MaxLength > 0)
            {
                TextBox1.MaxLength = Math.Max(FieldValueEditString.Length, Column.MaxLength);
            }
        }

        public override void DataBind()
        {
            base.DataBind();
            TextBox1.Text = CommonHelper.DecryptConnectionString(FieldValueEditString);

            if (TextBox1.Text.Length > 22)
            {
                TextBox1.Width = 340;
                TextBox1.Height = 100;
            }
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
