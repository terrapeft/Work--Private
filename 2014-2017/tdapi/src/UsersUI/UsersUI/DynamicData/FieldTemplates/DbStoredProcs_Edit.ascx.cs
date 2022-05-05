using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Collections.Generic;
using System.Collections.Specialized;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations;
using System.Data.Objects;
using System.Data.Objects.DataClasses;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Xml.Linq;
using System.Web.DynamicData;
using SharedLibrary;
using SharedLibrary.Cache;
using SharedLibrary.SmartScaffolding;
using UsersDb.Code;
using UsersDb.DataContext;
using UsersDb.Helpers;

namespace UsersUI.DynamicData.FieldTemplates
{
    public partial class DbStoredProcs_EditField : System.Web.DynamicData.FieldTemplateUserControl
    {
        private Control postBackControl;
        protected const string NoAliasNotificationFormat = "[Choose {0}]";

        object CurrentRow
        {
            get { return Session[this.ID]; }
            set { Session[this.ID] = value; }
        }


        protected ObjectContext ObjectContext { get; set; }

        protected void Page_Load(object sender, EventArgs e)
        {
            var ds = (EntityDataSource)this.FindDataSourceControl();

            ds.ContextCreated += (_, ctxCreatedEnventArgs) => ObjectContext = ctxCreatedEnventArgs.Context;
            ds.Updating += DataSource_UpdatingOrInserting;
            ds.Inserting += DataSource_UpdatingOrInserting;

            var c = Global.GetPostBackControl(this.Page);
            if (c != null && c.ID == Constants.ForeignKeyAutoPostBackSenderId)
            {
                ddlMethodStoredProcedure.DataBind();
            }
            else
            {
                newMethodNameTextBox.CssClass = (ddlMethodStoredProcedure.SelectedValue == Constants.NewMethodCommand)
                    ? "DDTextBox"
                    : "DDTextBox hide";
            }

            SetUpValidator(RequiredFieldValidator2);
        }

        private void DataSource_UpdatingOrInserting(object sender, EntityDataSourceChangingEventArgs e)
        {

        }

        protected void ddlMethodStoredProcedure_DataBound(object sender, EventArgs e)
        {
            // ddl stands for the Database Configuration dropdown, which is an autopostback control.
            var ddl = Global.GetPostBackControl(this.Page) as DropDownList;

            var rowBound = (ddl == null);

            Method entity = null;
            if (Mode == DataBoundControlMode.Edit)
            {
                ICustomTypeDescriptor rowDescriptor;

                //if (!rowBound)
                //{
                //    rowDescriptor = CurrentRow as ICustomTypeDescriptor;
                //}
                //else
                //{
                //    CurrentRow = Row;
                    rowDescriptor = Row as ICustomTypeDescriptor;
                //}

                entity = (Method)(rowDescriptor != null ? rowDescriptor.GetPropertyOwner(null) : Row);
            }

            var dbAlias = (ddl != null)
                ? ddl.SelectedItem.Text
                : (entity != null)
                    ? entity.DatabaseConfiguration.Alias
                    : string.Empty;

            var currentMethod = (entity != null)
                    ? entity.Name
                    : string.Empty;

            if (!string.IsNullOrWhiteSpace(dbAlias))
            {
                var list = CacheHelper.Get("availableStoredProcedures", dbAlias, currentMethod, CommonActions.LoadStoredProcedures);
                ddlMethodStoredProcedure.Items.Clear();
                ddlMethodStoredProcedure.Items.AddRange(list.Select(i => new ListItem(i)).ToArray());
                ddlMethodStoredProcedure.Items.Insert(0, Constants.NewMethodCommand);

                if (entity != null)
                {
                    ddlMethodStoredProcedure.SelectItemByValue(entity.Name);
                }

                if (ddlMethodStoredProcedure.SelectedValue == Constants.NewMethodCommand)
                {
                    newMethodNameTextBox.CssClass = "DDTextBox";
                    if (!string.IsNullOrWhiteSpace(currentMethod))
                    {
                        newMethodNameTextBox.Text = currentMethod;
                    }
                }
            }
            else
            {
                // get column name from metadata
                var dn = Table.Columns
                    .FirstOrDefault(c => c.Name == nameof(DatabaseConfiguration))?
                    .DisplayName;

                ddlMethodStoredProcedure.Items.Clear();
                ddlMethodStoredProcedure.Items.Add(string.Format(NoAliasNotificationFormat, dn));
            }
        }

        public string SelectedValue => newMethodNameTextBox.Text.Length > 0 ? newMethodNameTextBox.Text : ddlMethodStoredProcedure.SelectedValue;

        protected override void ExtractValues(IOrderedDictionary dictionary)
        {
            //dictionary[Column.Name] = ConvertEditedValue(ddlMethodStoredProcedure.SelectedValue);
            var value = SelectedValue;
            if (value == string.Empty || value == Constants.NewMethodCommand)
            {
                value = null;
            }

            dictionary[Column.Name] = ConvertEditedValue(value?.Replace('<', '_').Replace('>', '_'));
        }

        public override Control DataControl => newMethodNameTextBox.Text.Length > 0 ? (Control)newMethodNameTextBox : ddlMethodStoredProcedure;
    }
}
