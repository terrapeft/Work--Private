using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.EntityClient;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using SharedLibrary;
using Telerik.Web.UI;

namespace FowTradeDataU.umbraco.CustomWebForms
{
    public partial class TDSiteConfig : BaseCustomPage
    {

        protected void Page_Init(object sender, EventArgs e)
        {
            Grid = configGrid;
        }

        protected void Grid_OnItemDataBound(object sender, GridItemEventArgs e)
        {
            try
            {
                var isInsert = e.Item is GridEditFormInsertItem || e.Item is GridDataInsertItem;

                if (e.Item.IsInEditMode && (e.Item is GridEditFormItem || e.Item is GridDataInsertItem))
                {
                    var dataItem = e.Item as GridEditFormItem;
                    if (dataItem != null)
                    {
                        var nameTextBox = dataItem.FindControl("name") as TextBox;
                        if (nameTextBox != null && !isInsert)
                            nameTextBox.Enabled = false;

                        var errMsg = new HtmlGenericControl("div");
                        errMsg.Attributes.Add("class", "help-block with-errors");

                        AddValidator(dataItem, "name", "name");

                        foreach (var col in Grid.MasterTableView.Columns.OfType<GridBoundColumn>())
                        {
                            var ctl = dataItem[col.UniqueName].Controls[0] as WebControl;
                            if (ctl != null)
                            {
                                ctl.CssClass = "form-control input-sm";
                                ctl.Attributes.Add("required", "required");

                                dataItem[col.UniqueName].Controls.Add(errMsg);
                            }
                        }
                    }
                }

                var editableItem = e.Item as GridEditableItem;
                if (editableItem != null && editableItem.IsInEditMode)
                {
                    var name = editableItem.FindControl("name") as TextBox;
                    if (name != null)
                    {
                        //name.ReadOnly = true;
                    }

                    var list = editableItem.FindControl("List1") as DropDownList;
                    if (list != null)
                    {
                        list.DataSource = LoadTable(AppSettings.BackEnd_DataSource_Configuration_DdlResType, true);
                        list.DataTextField = "Name";
                        list.DataValueField = "Id";
                        list.DataBind();

                        var dataRowView = editableItem.DataItem as DataRowView;
                        if (dataRowView != null)
                        {
                            var rtId = dataRowView.Row["resourceTypeId"].ToString();
                            list.SelectedValue = rtId;
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
                        var rt = dataRowView.Row["ResourceType"].ToString();
                        if (label != null) label.Text = rt;
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
                Grid.DataSource = LoadTable(AppSettings.BackEnd_DataSource_Configuration);
            }
            catch (Exception ex)
            {
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

                var Id = editedItem.OwnerTableView.DataKeyValues[editedItem.ItemIndex]["Id"].ToString();

                var name = GetTextBoxValue(editedItem["name"].Controls.OfType<TextBox>().FirstOrDefault());
                var value = GetTextBoxValue(editedItem["value"].Controls.OfType<HtmlTextArea>().FirstOrDefault());
                var description = GetTextBoxValue(editedItem["description"].Controls.OfType<HtmlTextArea>().FirstOrDefault());
                var resourceTypeId = GetDdlValue(editedItem["resourceTypeId"].Controls.OfType<DropDownList>().FirstOrDefault());

                ConnectionString = new EntityConnectionStringBuilder(ConfigurationManager.ConnectionStrings["UmbracoMembersEntities"].ConnectionString).ProviderConnectionString;
                Connection = new SqlConnection(ConnectionString);
                Command = new SqlCommand
                {
                    Connection = Connection,
                    CommandText = "dbo.spSiteConfigUpdate",
                    CommandType = CommandType.StoredProcedure
                };

                Connection.Open();

                Command.Parameters.AddWithValue("@Id", Id);
                Command.Parameters.AddWithValue("@resourceTypeId", resourceTypeId);
                Command.Parameters.AddWithValue("@description", description);
                Command.Parameters.AddWithValue("@value", value);
                Command.Parameters.AddWithValue("@name", name);

                Command.ExecuteNonQuery();

                Connection.Close();
            }
            catch (Exception ex)
            {
                SharedLibrary.Elmah.Logger.LogError(ex);

                var msg = new HtmlGenericControl()
                {
                    InnerHtml = string.Format(AlertTemplate, "Unable to update a SiteConfig. Reason: ", ex.Message)
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

                var name = GetTextBoxValue(insertItem["name"].Controls.OfType<TextBox>().FirstOrDefault()).Null();
                var value = GetTextBoxValue(insertItem["value"].Controls.OfType<HtmlTextArea>().FirstOrDefault()).Null();
                var description = GetTextBoxValue(insertItem["description"].Controls.OfType<HtmlTextArea>().FirstOrDefault()).Null();
                var resourceTypeId = GetDdlValue(insertItem["resourceTypeId"].Controls.OfType<DropDownList>().FirstOrDefault()).Null();

                ConnectionString = new EntityConnectionStringBuilder(ConfigurationManager.ConnectionStrings["UmbracoMembersEntities"].ConnectionString).ProviderConnectionString;
                Connection = new SqlConnection(ConnectionString);
                Command = new SqlCommand
                {
                    Connection = Connection,
                    CommandText = "dbo.spSiteConfigInsert",
                    CommandType = CommandType.StoredProcedure
                };

                Connection.Open();

                if (resourceTypeId != null) Command.Parameters.AddWithValue("@resourceTypeId", resourceTypeId);
                if (description != null) Command.Parameters.AddWithValue("@description", description);
                if (value != null) Command.Parameters.AddWithValue("@value", value);
                if (name != null) Command.Parameters.AddWithValue("@name", name);

                Command.ExecuteNonQuery();

                Connection.Close();
            }
            catch (Exception ex)
            {
                SharedLibrary.Elmah.Logger.LogError(ex);

                var msg = new HtmlGenericControl()
                {
                    InnerHtml = string.Format(AlertTemplate, "Unable to insert into SiteConfig. Reason: ", ex.Message)
                };

                Grid.Controls.Add(msg);
                e.Canceled = true;
            }
        }

        #endregion
    }
}