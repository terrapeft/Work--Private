using System;
using System.Collections;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.Entity.Infrastructure;
using System.Data.EntityClient;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using SharedLibrary;
using TDUmbracoMembership;
using Telerik.Web.UI;
using Telerik.Web.UI.DynamicData;
using umbraco;
using umbraco.NodeFactory;
using Umbraco.Core;
using Umbraco.Web.WebApi;


namespace FowTradeDataU.umbraco.CustomWebForms
{
    public partial class TDMembers : BaseCustomPage
    {
        protected void Page_Init(object sender, EventArgs e)
        {
            Grid = membersGrid;
        }

        protected void Grid_OnItemDataBound(object sender, GridItemEventArgs e)
        {
            try
            {
                if (e.Item.IsInEditMode && (e.Item is GridEditFormItem || e.Item is GridDataInsertItem))
                {
                    var dataItem = e.Item as GridEditFormItem;

                    if (dataItem != null)
                    {
                        var errMsg = new HtmlGenericControl("div");
                        errMsg.Attributes.Add("class", "help-block with-errors");

                        AddValidator(dataItem, "firstName");
                        AddValidator(dataItem, "lastName");
                        AddValidator(dataItem, "username");
                        AddValidator(dataItem, "password", skipInEditMode: true);
                        AddValidator(dataItem, "companyId", "List1");

                        foreach (var col in Grid.MasterTableView.Columns.OfType<GridBoundColumn>())
                        {
                            var ctl = dataItem[col.UniqueName].Controls[0] as WebControl;
                            if (ctl != null)
                            {
                                ctl.CssClass = "form-control input-sm";
                                //ctl.Attributes.Add("required", "required");

                                dataItem[col.UniqueName].Controls.Add(errMsg);
                            }
                        }
                    }
                }

                var editableItem = e.Item as GridEditableItem;
                if (editableItem != null && editableItem.IsInEditMode)
                {
                    var list = editableItem.FindControl("List1") as DropDownList;
                    if (list != null)
                    {
                        list.DataSource = LoadTable(AppSettings.BackEnd_DataSource_Members_CompanyDdl);
                        list.DataTextField = "Name";
                        list.DataValueField = "CompanyId";
                        list.DataBind();

                        var dataRowView = editableItem.DataItem as DataRowView;
                        if (dataRowView != null)
                        {
                            var companyId = dataRowView.Row["companyId"].ToString();
                            list.SelectedValue = companyId;
                        }
                    }
                }
                else if (e.Item is GridDataItem && !e.Item.IsInEditMode && Page.IsPostBack)
                {
                    var item = e.Item as GridDataItem;
                    var label = item.FindControl("Label1") as Label;

                    var dataRowView = item.DataItem as DataRowView;
                    if (dataRowView != null)
                    {
                        var company = dataRowView.Row["Company"].ToString();
                        if (label != null) label.Text = company;
                    }
                }
            }
            catch (Exception ex)
            {
                SharedLibrary.Elmah.Logger.LogError(ex);

                var msg = new HtmlGenericControl()
                {
                    InnerHtml = string.Format(AlertTemplate, "Error in ItemDataBound event handler. Message: ", ex.Message)
                };

                Grid.Controls.Add(msg);
                e.Canceled = true;
            }
        }

        protected void Grid_OnNeedDataSource(object sender, GridNeedDataSourceEventArgs e)
        {
            try
            {
                Grid.DataSource = LoadTable(AppSettings.BackEnd_DataSource_Members);
            }
            catch (Exception ex)
            {
                SharedLibrary.Elmah.Logger.LogError(ex);

                var msg = new HtmlGenericControl()
                {
                    InnerHtml = string.Format(AlertTemplate, "Failed to load source data. Reason: ", ex.Message)
                };

                Grid.Controls.Add(msg);
            }
        }


        #region CUD

        protected void Grid_OnUpdateCommand(object sender, GridCommandEventArgs e)
        {
            try
            {
                var editedItem = e.Item as GridEditableItem;
                if (editedItem == null) return;

                var memberId = editedItem.OwnerTableView.DataKeyValues[editedItem.ItemIndex]["MemberId"].ToString();

                var username = GetTextBoxValue(editedItem["username"].Controls.OfType<TextBox>().FirstOrDefault());
                var lastName = GetTextBoxValue(editedItem["lastName"].Controls.OfType<TextBox>().FirstOrDefault());
                var firstName = GetTextBoxValue(editedItem["firstName"].Controls.OfType<TextBox>().FirstOrDefault());
                var pwd = GetTextBoxValue(editedItem["password"].Controls.OfType<TextBox>().FirstOrDefault()).Null();
                var companyId = GetDdlValue(editedItem["companyId"].Controls.OfType<DropDownList>().FirstOrDefault());

                ConnectionString = new EntityConnectionStringBuilder(ConfigurationManager.ConnectionStrings["UmbracoMembersEntities"].ConnectionString).ProviderConnectionString;
                Connection = new SqlConnection(ConnectionString);
                Command = new SqlCommand
                {
                    Connection = Connection,
                    CommandText = "dbo.spMemberUpdate",
                    CommandType = CommandType.StoredProcedure
                };

                Connection.Open();

                Command.Parameters.AddWithValue("@memberId", memberId);
                Command.Parameters.AddWithValue("@companyId", companyId);
                Command.Parameters.AddWithValue("@firstName", firstName);
                Command.Parameters.AddWithValue("@lastName", lastName);
                Command.Parameters.AddWithValue("@userName", username);
                Command.Parameters.AddWithValue("@password", pwd);

                Command.ExecuteNonQuery();

                Connection.Close();
            }
            catch (Exception ex)
            {
                SharedLibrary.Elmah.Logger.LogError(ex);

                var msg = new HtmlGenericControl()
                {
                    InnerHtml = string.Format(AlertTemplate, "Unable to update Member. Reason: ", ex.Message)
                };

                Grid.Controls.Add(msg);
                e.Canceled = true;
            }
        }

        protected void Grid_OnInsertCommand(object sender, GridCommandEventArgs e)
        {
            try
            {

                var insertItem = e.Item as GridEditFormInsertItem;
                if (insertItem == null) return;

                var username = GetTextBoxValue(insertItem["username"].Controls.OfType<TextBox>().FirstOrDefault()).Null();
                var lastName = GetTextBoxValue(insertItem["lastName"].Controls.OfType<TextBox>().FirstOrDefault()).Null();
                var firstName = GetTextBoxValue(insertItem["firstName"].Controls.OfType<TextBox>().FirstOrDefault()).Null();
                var pwd = GetTextBoxValue(insertItem["password"].Controls.OfType<TextBox>().FirstOrDefault()).Null();
                var companyId = GetDdlValue(insertItem["companyId"].Controls.OfType<DropDownList>().FirstOrDefault()).Null();

                ConnectionString = new EntityConnectionStringBuilder(ConfigurationManager.ConnectionStrings["UmbracoMembersEntities"].ConnectionString).ProviderConnectionString;
                Connection = new SqlConnection(ConnectionString);
                Command = new SqlCommand
                {
                    Connection = Connection,
                    CommandText = "dbo.spMemberInsert",
                    CommandType = CommandType.StoredProcedure
                };

                Connection.Open();

                if (companyId != null) Command.Parameters.AddWithValue("@companyId", companyId);
                if (firstName != null) Command.Parameters.AddWithValue("@firstName", firstName);
                if (lastName != null) Command.Parameters.AddWithValue("@lastName", lastName);
                if (username != null) Command.Parameters.AddWithValue("@userName", username);
                if (pwd != null) Command.Parameters.AddWithValue("@password", pwd);

                Command.ExecuteNonQuery();

                Connection.Close();
            }
            catch (Exception ex)
            {
                SharedLibrary.Elmah.Logger.LogError(ex);

                var msg = new HtmlGenericControl()
                {
                    InnerHtml = string.Format(AlertTemplate, "Unable to insert Member. Reason: ", ex.Message)
                };

                Grid.Controls.Add(msg);
                e.Canceled = true;
            }
        }

        protected void Grid_OnDeleteCommand(object sender, GridCommandEventArgs e)
        {
            try
            {
                var editedItem = e.Item as GridDataItem;
                if (editedItem == null) return;

                var memberId = editedItem.OwnerTableView.DataKeyValues[editedItem.ItemIndex]["MemberId"].ToString();

                ConnectionString = new EntityConnectionStringBuilder(ConfigurationManager.ConnectionStrings["UmbracoMembersEntities"].ConnectionString).ProviderConnectionString;
                Connection = new SqlConnection(ConnectionString);
                Command = new SqlCommand
                {
                    Connection = Connection,
                    CommandType = CommandType.StoredProcedure
                };

                Connection.Open();

                Command.CommandText = "dbo.spMemberDelete";
                Command.Parameters.AddWithValue("@memberId", memberId);

                Command.ExecuteNonQuery();

                Connection.Close();
            }
            catch (Exception ex)
            {
                SharedLibrary.Elmah.Logger.LogError(ex);

                var msg = new HtmlGenericControl()
                {
                    InnerHtml = string.Format(AlertTemplate, "Unable to delete Member. Reason: ", ex.Message)
                };

                Grid.Controls.Add(msg);
                e.Canceled = true;
            }
        }

        #endregion
    }
}