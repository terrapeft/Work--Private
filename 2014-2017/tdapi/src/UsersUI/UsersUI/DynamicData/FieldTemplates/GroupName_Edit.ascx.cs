using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Collections.Generic;
using System.Collections.Specialized;
using System.ComponentModel;
using System.Data.Objects;
using System.Data.Objects.DataClasses;
using System.Linq;
using System.Linq.Expressions;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Xml.Linq;
using System.Web.DynamicData;
using SharedLibrary;
using UsersDb.DataContext;

namespace UsersUI.DynamicData.FieldTemplates
{
    public partial class GroupName_EditField : System.Web.DynamicData.FieldTemplateUserControl
    {
        protected const string NewGroupNameCommand = "<New group>";

        protected void Page_Load(object sender, EventArgs e)
        {
            SetUpValidator(RequiredFieldValidator1);
        }

        protected override void ExtractValues(IOrderedDictionary dictionary)
        {
            var value = SelectedValue;
            if (value == string.Empty || value == NewGroupNameCommand)
            {
                value = null;
            }

            dictionary[Column.Name] = ConvertEditedValue(value?.Replace('<', '_').Replace('>', '_'));
        }

        public string SelectedValue => newGroupNameTextBox.Text.Length > 0 ? newGroupNameTextBox.Text : DropDownList1.SelectedValue;

        public override Control DataControl => newGroupNameTextBox.Text.Length > 0 ? (Control)newGroupNameTextBox : DropDownList1;

        protected void DropDownList1_OnDataBound(object sender, EventArgs e)
        {
            IConfiguration entity = null;

            DropDownList1.Items.Add(new ListItem(NewGroupNameCommand));

            if (Mode == DataBoundControlMode.Edit)
            {
                var rowDescriptor = Row as ICustomTypeDescriptor;
                if (rowDescriptor != null)
                {
                    entity = rowDescriptor.GetPropertyOwner(null) as IConfiguration;
                }
                else
                {
                    entity = Row as IConfiguration;
                }
            }

            ((IEnumerable<dynamic>)Table.GetQuery())
                .ToList() // materialize to be able to cast, LINQ to Entities only supports casting EDM primitive or enumeration types
                .Cast<IConfiguration>()
                .Select(o => o.GroupName)
                .Distinct()
                .OrderBy(gn => gn)
                .ToList() // just to call the foreach
                .ForEach(gn =>
                {
                    DropDownList1.Items.Add(new ListItem(gn));
                });

            if (entity != null)
            {
                DropDownList1.SelectedValue = entity.GroupName;
                newGroupNameTextBox.CssClass = "DDTextBox hide";
            }
        }
    }
}
