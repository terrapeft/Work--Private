using System;
using System.Collections.Specialized;
using System.Diagnostics.PerformanceData;
using System.Web.DynamicData;
using System.Web.UI;
using System.Web.UI.WebControls;
using SharedLibrary;
using UsersDb.Helpers;

namespace UsersUI.DynamicData.FieldTemplates
{
    public partial class DbStoredProcAlias_EditField : FieldTemplateUserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            TextBox1.MaxLength = Column.MaxLength;
            if (Column.MaxLength < 20)
                TextBox1.Columns = Column.MaxLength;
            TextBox1.ToolTip = Column.Description;

            SetUpValidator(RequiredFieldValidator1);
            SetUpValidator(RegularExpressionValidator1);
            SetUpValidator(DynamicValidator1);

            var c = Global.GetPostBackControl(this.Page);
            if (c != null)
            {
                var ddl = c as DropDownList;
                if (ddl != null && ddl.ID == Constants.MethodStoredProcedureSenderId)
                {
                    if (ddl.SelectedItem.Text != Constants.NewMethodCommand)
                    {
                        TextBox1.Text = ddl.SelectedItem.Text.SplitStringOnCaps();
                    }
                }
                else
                {
                    var txt = c as TextBox;
                    if (txt != null && txt.ID == Constants.MethodStoredProcedureCustomeNameSenderId)
                    {
                        TextBox1.Text = txt.Text.SplitStringOnCaps();
                    }
                }
            }
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

        public override Control DataControl => TextBox1;
    }
}
