using System;
using System.Collections.Specialized;
using System.ComponentModel.DataAnnotations;
using System.Web.DynamicData;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace UsersUI
{
    public partial class ForeignKeyAutoPostBack_EditField : System.Web.DynamicData.FieldTemplateUserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (ddlFkAutoPostBack.Items.Count == 0)
            {
                if (Mode == DataBoundControlMode.Insert || !Column.IsRequired)
                {
                    ddlFkAutoPostBack.Items.Add(new ListItem("[Not Set]", ""));
                }
                PopulateListControl(ddlFkAutoPostBack);
            }

            SetUpValidator(RequiredFieldValidator1);
            SetUpValidator(DynamicValidator1);
        }

        protected override void OnDataBinding(EventArgs e)
        {
            base.OnDataBinding(e);

            if (Mode == DataBoundControlMode.Edit)
            {
                string selectedValueString = GetSelectedValueString();
                ListItem item = ddlFkAutoPostBack.Items.FindByValue(selectedValueString);
                if (item != null)
                {
                    ddlFkAutoPostBack.SelectedValue = selectedValueString;
                }
            }
        }

        protected override void ExtractValues(IOrderedDictionary dictionary)
        {
            // If it's an empty string, change it to null
            string value = ddlFkAutoPostBack.SelectedValue;
            if (String.IsNullOrEmpty(value))
            {
                value = null;
            }

            ExtractForeignKey(dictionary, value);
        }

        public override Control DataControl
        {
            get
            {
                return ddlFkAutoPostBack;
            }
        }

    }
}
