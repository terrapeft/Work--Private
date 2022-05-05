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
using Telerik.Web.UI.DynamicData;

namespace FowTradeDataU.umbraco.CustomWebForms
{
    public partial class TDSalesForce : BaseCustomPage
    {
        protected void Page_Init(object sender, EventArgs e)
        {
            Grid = optionsGrid;
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
                        AddValidator(dataItem, "name");
                        AddValidator(dataItem, "value");
                        AddValidator(dataItem, "ddlId", "List1");

                        foreach (var col in Grid.MasterTableView.Columns.OfType<GridBoundColumn>())
                        {
                            var ctl = dataItem[col.UniqueName].Controls[0];
                            ((WebControl)ctl).CssClass = "form-control input-sm";
                        }
                    }
                }

                var editableItem = e.Item as GridEditableItem;
                if (editableItem != null && editableItem.IsInEditMode)
                {
                    var list = editableItem.FindControl("List1") as DropDownList;
                    if (list != null)
                    {
                        list.DataSource = LoadTable(AppSettings.BackEnd_DataSource_DdlOptions_DdlDropDownLists);
                        list.DataTextField = "Name";
                        list.DataValueField = "DropDownListId";
                        list.DataBind();

                        var dataRowView = editableItem.DataItem as DataRowView;
                        if (dataRowView != null)
                        {
                            var ddlId = dataRowView.Row["DropDownListId"].ToString();
                            list.SelectedValue = ddlId;
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
                        var ddl = dataRowView.Row["DropDownList"].ToString();
                        if (label != null) label.Text = ddl;
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
                Grid.DataSource = LoadTable(AppSettings.BackEnd_DataSource_DdlOptions);
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

                var optionId = editedItem.OwnerTableView.DataKeyValues[editedItem.ItemIndex]["OptionId"].ToString();

                var ddlId = GetDdlValue(editedItem["ddlId"].Controls.OfType<DropDownList>().FirstOrDefault());
                var name = GetTextBoxValue(editedItem["name"].Controls.OfType<TextBox>().FirstOrDefault());
                var value = GetTextBoxValue(editedItem["value"].Controls.OfType<TextBox>().FirstOrDefault());
                var isDefault = GetCheckBoxValue(editedItem["isDefault"].Controls.OfType<CheckBox>().FirstOrDefault());
                var orderBy = GetTextBoxValue(editedItem["orderBy"].Controls.OfType<TextBox>().FirstOrDefault());

                int orderByVal;
                int.TryParse(orderBy, out orderByVal);

                ConnectionString = new EntityConnectionStringBuilder(ConfigurationManager.ConnectionStrings["UmbracoMembersEntities"].ConnectionString).ProviderConnectionString;
                Connection = new SqlConnection(ConnectionString);
                Command = new SqlCommand
                {
                    Connection = Connection,
                    CommandText = "dbo.spDdlOptionsUpdate",
                    CommandType = CommandType.StoredProcedure
                };

                Connection.Open();

                Command.Parameters.AddWithValue("@optionId", optionId);
                Command.Parameters.AddWithValue("@DropDownListId", ddlId);
                Command.Parameters.AddWithValue("@name", name);
                Command.Parameters.AddWithValue("@value", value);
                Command.Parameters.AddWithValue("@isDefault", isDefault);
                Command.Parameters.AddWithValue("@orderBy", orderByVal);

                Command.ExecuteNonQuery();

                Connection.Close();
            }
            catch (Exception ex)
            {
                SharedLibrary.Elmah.Logger.LogError(ex);

                var msg = new HtmlGenericControl()
                {
                    InnerHtml = string.Format(AlertTemplate, "Unable to update DDL Option. Reason: ", ex.Message)
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

                var ddlId = GetDdlValue(insertItem["ddlId"].Controls.OfType<DropDownList>().FirstOrDefault());
                var name = GetTextBoxValue(insertItem["name"].Controls.OfType<TextBox>().FirstOrDefault());
                var value = GetTextBoxValue(insertItem["value"].Controls.OfType<TextBox>().FirstOrDefault());
                var isDefault = GetCheckBoxValue(insertItem["isDefault"].Controls.OfType<CheckBox>().FirstOrDefault());
                var orderBy = GetTextBoxValue(insertItem["orderBy"].Controls.OfType<TextBox>().FirstOrDefault());

                int orderByVal;
                int.TryParse(orderBy, out orderByVal);

                ConnectionString = new EntityConnectionStringBuilder(ConfigurationManager.ConnectionStrings["UmbracoMembersEntities"].ConnectionString).ProviderConnectionString;
                Connection = new SqlConnection(ConnectionString);
                Command = new SqlCommand
                {
                    Connection = Connection,
                    CommandText = "dbo.spDdlOptionsInsert",
                    CommandType = CommandType.StoredProcedure
                };

                Connection.Open();

                Command.Parameters.AddWithValue("@DropDownListId", ddlId);
                Command.Parameters.AddWithValue("@name", name);
                Command.Parameters.AddWithValue("@value", value);
                Command.Parameters.AddWithValue("@isDefault", isDefault);
                Command.Parameters.AddWithValue("@orderBy", orderByVal);

                Command.ExecuteNonQuery();

                Connection.Close();
            }
            catch (Exception ex)
            {
                SharedLibrary.Elmah.Logger.LogError(ex);

                var msg = new HtmlGenericControl()
                {
                    InnerHtml = string.Format(AlertTemplate, "Unable to insert MDDL Optionember. Reason: ", ex.Message)
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

                var optionId = editedItem.OwnerTableView.DataKeyValues[editedItem.ItemIndex]["OptionId"].ToString();

                ConnectionString = new EntityConnectionStringBuilder(ConfigurationManager.ConnectionStrings["UmbracoMembersEntities"].ConnectionString).ProviderConnectionString;
                Connection = new SqlConnection(ConnectionString);
                Command = new SqlCommand
                {
                    Connection = Connection,
                    CommandType = CommandType.StoredProcedure
                };

                Connection.Open();

                Command.CommandText = "dbo.spDdlOptionsDelete";
                Command.Parameters.AddWithValue("@optionId", optionId);

                Command.ExecuteNonQuery();

                Connection.Close();
            }
            catch (Exception ex)
            {
                SharedLibrary.Elmah.Logger.LogError(ex);

                var msg = new HtmlGenericControl()
                {
                    InnerHtml = string.Format(AlertTemplate, "Unable to delete DDL Option. Reason: ", ex.Message)
                };

                Grid.Controls.Add(msg);
                e.Canceled = true;
            }
        }

        #endregion


        protected void Grid2_OnNeedDataSource(object sender, GridNeedDataSourceEventArgs e)
        {
            try
            {
                hierarchyGrid.DataSource = LoadTable(AppSettings.BackEnd_DataSource_DdlHierarchy);
            }
            catch (Exception ex)
            {
                SharedLibrary.Elmah.Logger.LogError(ex);

                var msg = new HtmlGenericControl()
                {
                    InnerHtml = string.Format(AlertTemplate, "Failed to load source data. Reason: ", ex.Message)
                };

                hierarchyGrid.Controls.Add(msg);
            }
        }

        protected void Grid2_OnInsertUpdateCommand(object sender, GridCommandEventArgs e)
        {
            try
            {
                var insertItem = e.Item as GridEditableItem;
                if (insertItem == null) return;

                var optionId = GetDdlValue(insertItem["option"].Controls.OfType<DropDownList>().FirstOrDefault());
                var parentOptionId = GetDdlValue(insertItem["parentOption"].Controls.OfType<DropDownList>().FirstOrDefault()).Null();

                ConnectionString = new EntityConnectionStringBuilder(ConfigurationManager.ConnectionStrings["UmbracoMembersEntities"].ConnectionString).ProviderConnectionString;
                Connection = new SqlConnection(ConnectionString);
                Command = new SqlCommand
                {
                    Connection = Connection,
                    CommandText = "dbo.spHierarchyInsertUpdate",
                    CommandType = CommandType.StoredProcedure
                };

                Connection.Open();

                Command.Parameters.AddWithValue("@optionId", optionId);
                Command.Parameters.AddWithValue("@parentOptionId", parentOptionId);

                Command.ExecuteNonQuery();

                Connection.Close();
            }
            catch (Exception ex)
            {
                SharedLibrary.Elmah.Logger.LogError(ex);

                var msg = new HtmlGenericControl()
                {
                    InnerHtml = string.Format(AlertTemplate, "Unable to insert the Hierarchy Option. Reason: ", ex.Message)
                };

                hierarchyGrid.Controls.Add(msg);
                e.Canceled = true;
            }
        }

        protected void Grid2_OnDeleteCommand(object sender, GridCommandEventArgs e)
        {
            try
            {
                var editedItem = e.Item as GridEditableItem;
                if (editedItem == null) return;

                var hierarchyId = editedItem.OwnerTableView.DataKeyValues[editedItem.ItemIndex]["HierarchyId"].ToString();

                ConnectionString = new EntityConnectionStringBuilder(ConfigurationManager.ConnectionStrings["UmbracoMembersEntities"].ConnectionString).ProviderConnectionString;
                Connection = new SqlConnection(ConnectionString);
                Command = new SqlCommand
                {
                    Connection = Connection,
                    CommandText = "dbo.spHierarchyDelete",
                    CommandType = CommandType.StoredProcedure
                };

                Connection.Open();
                Command.Parameters.AddWithValue("@hierarchyId", hierarchyId);
                Command.ExecuteNonQuery();
                Connection.Close();
            }
            catch (Exception ex)
            {
                SharedLibrary.Elmah.Logger.LogError(ex);

                var msg = new HtmlGenericControl()
                {
                    InnerHtml = string.Format(AlertTemplate, "Unable to delete the Hierarchy Option. Reason: ", ex.Message)
                };

                hierarchyGrid.Controls.Add(msg);
                e.Canceled = true;
            }
        }

        protected void Grid2_OnItemDataBound(object sender, GridItemEventArgs e)
        {
            try
            {
                var isInsert = e.Item is GridEditFormInsertItem || e.Item is GridDataInsertItem;
                var editableItem = e.Item as GridEditableItem;
                if (editableItem != null && editableItem.IsInEditMode)
                {
                    var list = editableItem.FindControl("OptionsList") as DropDownList;
                    var options = LoadTable(AppSettings.BackEnd_DataSource_DdlHierarchy_OptionsDdl);

                    if (list != null)
                    {
                        list.DataSource = options;
                        list.DataTextField = "Name";
                        list.DataValueField = "OptionId";
                        list.Enabled = isInsert;
                        list.DataBind();

                        var dataRowView = editableItem.DataItem as DataRowView;
                        if (dataRowView != null)
                        {
                            var ddlId = dataRowView.Row["OptionId"].ToString();
                            list.SelectedValue = ddlId;
                        }
                    }

                    var parentList = editableItem.FindControl("ParentOptionsList") as DropDownList;
                    if (parentList != null)
                    {
                        var dt = options.Copy();

                        var parentNullRow = dt.NewRow();
                        parentNullRow[0] = "<none>";
                        parentNullRow[1] = DBNull.Value;
                        dt.Rows.InsertAt(parentNullRow, 0);

                        parentList.DataSource = dt;
                        parentList.DataTextField = "Name";
                        parentList.DataValueField = "OptionId";
                        parentList.DataBind();

                        var dataRowView = editableItem.DataItem as DataRowView;
                        if (dataRowView != null)
                        {
                            var ddlId = dataRowView.Row["ParentOptionId"].ToString();
                            parentList.SelectedValue = ddlId;
                        }
                    }
                }
                else if (e.Item is GridDataItem && !e.Item.IsInEditMode && Page.IsPostBack)
                {
                    var item = e.Item as GridDataItem;

                    var label = item.FindControl("OptionLabel") as Label;
                    var dataRowView = item.DataItem as DataRowView;
                    if (dataRowView != null)
                    {
                        var ddl = dataRowView.Row["Option"].ToString();
                        if (label != null) label.Text = ddl;
                    }

                    var parentLabel = item.FindControl("ParentOptionLabel") as Label;
                    var rowView = item.DataItem as DataRowView;
                    if (rowView != null)
                    {
                        var parentDdl = rowView.Row["ParentOption"].ToString();
                        if (parentLabel != null) parentLabel.Text = parentDdl;
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

                hierarchyGrid.Controls.Add(msg);
                e.Canceled = true;
            }
        }
    }
}