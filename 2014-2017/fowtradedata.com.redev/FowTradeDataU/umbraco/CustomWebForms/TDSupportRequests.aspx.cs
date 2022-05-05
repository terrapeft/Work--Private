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
using AutoMapper.Internal;
using TDUmbracoMembership;
using Telerik.Web.UI;
using Telerik.Web.UI.DynamicData;

namespace FowTradeDataU.umbraco.CustomWebForms
{
    public partial class TDSupportRequests : BaseCustomPage
    {

        private Dictionary<string, string> _map;

        protected void Page_Init(object sender, EventArgs e)
        {
            Grid = requestsGrid;
            _map = LoadTable(AppSettings.BackEnd_DataSource_FieldsMapping)
                .Rows
                .Cast<DataRow>()
                .ToDictionary(k => k[0].ToString(), v => v[1].ToString());
        }

        #region Data

        protected void Grid_OnNeedDataSource(object sender, GridNeedDataSourceEventArgs e)
        {
            try
            {
                Grid.DataSource = LoadTable(AppSettings.BackEnd_DataSource_Requests);
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

        protected void Grid_OnItemDataBound(object sender, GridItemEventArgs e)
        {
            try
            {
                var item = e.Item as GridDataItem;
                if (item != null)
                {
                    var rowView = item.DataItem as DataRowView;
                    if (rowView != null)
                    {
                        var cell = item["requestData"];
                        cell.Controls.Clear();

                        AddFormElements(rowView, cell);
                        AddAttachments(rowView, cell);
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

        private void AddAttachments(DataRowView rowView, TableCell cell)
        {
            var data = rowView.Row["RequestFiles"];
            if (data != null && data != DBNull.Value)
            {
                var files = data.ToString().Split(',').ToList();
                if (files.Any())
                {
                    var label = new HtmlGenericControl("div");
                    label.Attributes.Add("class", "request-name");
                    label.InnerText = "Attachments:";
                    cell.Controls.Add(label);

                    var path = files[0];
                    files.RemoveAt(0);

                    var filesText = string.Join("<br>", files.Select(f => "<span class='glyphicon glyphicon-file custom-color-file'></span>&nbsp;" + f));

                    var attCtl = new LiteralControl(
                        string.Format("<div style='margin-top: 1px; margin-bottom: 20px;'><span class='glyphicon glyphicon-folder-open custom-color-folder'></span>&nbsp;&nbsp;{0}:" +
                                      "<br>" +
                                      "<div style='margin-left: 20px;'>{1}</div></div>", path, filesText)
                        );

                    cell.Controls.Add(attCtl);
                }
            }
        }

        private void AddFormElements(DataRowView rowView, TableCell cell)
        {
            var requestData = rowView.Row["RequestData"].ToString();
            var values = requestData.Split('&').ToList();
            var alias = GetFieldAlias("Id");
            values.Insert(0, string.Format("{0}={1}", alias, rowView.Row["Id"]));

            foreach (var pare in values)
            {
                var kv = pare.Split('=');

                if (kv.Length == 2)
                {
                    var label = new HtmlGenericControl("div");
                    label.Attributes.Add("class", "request-name");
                    label.InnerText = GetFieldAlias(kv[0]) + ":";
                    label.Attributes.Add("title", kv[0]);

                    cell.Controls.Add(label);

                    var input = kv[1].Length > 100
                        ? (dynamic)new HtmlTextArea()
                        : new HtmlInputText();

                    input.Attributes.Add("class", "form-control input-sm form-control-addwidth" + ((input is HtmlTextArea) ? " td-textarea" : string.Empty));
                    input.Attributes.Add("readonly", "readonly");
                    input.Value = Uri.UnescapeDataString(kv[1]);
                    cell.Controls.Add(input);
                }
            }
        }

        private string GetFieldAlias(string name)
        {
            return _map.ContainsKey(name) ? _map[name] : name;
        }

        #endregion

        #region Mapping

        protected void Map_OnNeedDataSource(object sender, GridNeedDataSourceEventArgs e)
        {
            var grid = sender as RadGridEx;

            try
            {
                grid.DataSource = LoadTable(AppSettings.BackEnd_DataSource_FieldsMapping);
            }
            catch (Exception ex)
            {
                SharedLibrary.Elmah.Logger.LogError(ex);

                var msg = new HtmlGenericControl()
                {
                    InnerHtml = string.Format(AlertTemplate, "Failed to load source data. Reason: ", ex.Message)
                };

                grid.Controls.Add(msg);
            }
        }

        protected void Map_OnItemDataBound(object sender, GridItemEventArgs e)
        {
            var grid = sender as RadGridEx;

            try
            {
                var isInsert = e.Item is GridEditFormInsertItem || e.Item is GridDataInsertItem;
                if (e.Item.IsInEditMode && (e.Item is GridEditFormItem || e.Item is GridDataInsertItem))
                {
                    var dataItem = e.Item as GridEditFormItem;
                    if (dataItem != null)
                    {

                        AddValidator(dataItem, "name");
                        AddValidator(dataItem, "alias");

                        foreach (var col in grid.MasterTableView.Columns.OfType<GridBoundColumn>())
                        {
                            var ctl = dataItem[col.UniqueName].Controls[0];
                            ((WebControl)ctl).CssClass = "form-control input-sm";

                            if (col.UniqueName == "name" && !isInsert)
                                ((TextBox)ctl).Enabled = false;
                        }
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

                grid.Controls.Add(msg);
                e.Canceled = true;
            }
        }

        #endregion

        protected void Map_OnInsertCommand(object sender, GridCommandEventArgs e)
        {
            var grid = sender as RadGridEx;

            try
            {
                var editedItem = e.Item as GridEditFormInsertItem;
                if (editedItem == null) return;

                var name = GetTextBoxValue(editedItem["name"].Controls.OfType<TextBox>().FirstOrDefault());
                var alias = GetTextBoxValue(editedItem["alias"].Controls.OfType<TextBox>().FirstOrDefault());

                ConnectionString = new EntityConnectionStringBuilder(ConfigurationManager.ConnectionStrings["UmbracoMembersEntities"].ConnectionString).ProviderConnectionString;
                Connection = new SqlConnection(ConnectionString);
                Command = new SqlCommand
                {
                    Connection = Connection,
                    CommandText = "dbo.spSalesforceFieldsMappingInsert",
                    CommandType = CommandType.StoredProcedure
                };

                Connection.Open();

                Command.Parameters.AddWithValue("@name", name);
                Command.Parameters.AddWithValue("@alias", alias);

                Command.ExecuteNonQuery();

                Connection.Close();
            }
            catch (Exception ex)
            {
                SharedLibrary.Elmah.Logger.LogError(ex);

                var msg = new HtmlGenericControl()
                {
                    InnerHtml = string.Format(AlertTemplate, "Unable to insert. Reason: ", ex.Message)
                };

                grid.Controls.Add(msg);
                e.Canceled = true;
            }
        }

        protected void Map_OnUpdateCommand(object sender, GridCommandEventArgs e)
        {
            var grid = sender as RadGridEx;

            try
            {
                var editedItem = e.Item as GridEditableItem;
                if (editedItem == null) return;

                var name = editedItem.OwnerTableView.DataKeyValues[editedItem.ItemIndex]["name"].ToString();
                var alias = GetTextBoxValue(editedItem["alias"].Controls.OfType<TextBox>().FirstOrDefault());

                ConnectionString = new EntityConnectionStringBuilder(ConfigurationManager.ConnectionStrings["UmbracoMembersEntities"].ConnectionString).ProviderConnectionString;
                Connection = new SqlConnection(ConnectionString);
                Command = new SqlCommand
                {
                    Connection = Connection,
                    CommandText = "dbo.spSalesforceFieldsMappingUpdate",
                    CommandType = CommandType.StoredProcedure
                };

                Connection.Open();

                Command.Parameters.AddWithValue("@name", name);
                Command.Parameters.AddWithValue("@alias", alias);

                Command.ExecuteNonQuery();

                Connection.Close();
            }
            catch (Exception ex)
            {
                SharedLibrary.Elmah.Logger.LogError(ex);

                var msg = new HtmlGenericControl()
                {
                    InnerHtml = string.Format(AlertTemplate, "Unable to update. Reason: ", ex.Message)
                };

                grid.Controls.Add(msg);
                e.Canceled = true;
            }
        }

        protected void Map_OnDeleteCommand(object sender, GridCommandEventArgs e)
        {
            var grid = sender as RadGridEx;

            try
            {
                var item = e.Item as GridDataItem;
                if (item == null) return;

                var name = item.OwnerTableView.DataKeyValues[item.ItemIndex]["name"].ToString();

                ConnectionString = new EntityConnectionStringBuilder(ConfigurationManager.ConnectionStrings["UmbracoMembersEntities"].ConnectionString).ProviderConnectionString;
                Connection = new SqlConnection(ConnectionString);
                Command = new SqlCommand
                {
                    Connection = Connection,
                    CommandText = "dbo.spSalesforceFieldsMappingDelete",
                    CommandType = CommandType.StoredProcedure
                };

                Connection.Open();

                Command.Parameters.AddWithValue("@name", name);

                Command.ExecuteNonQuery();

                Connection.Close();
            }
            catch (Exception ex)
            {
                SharedLibrary.Elmah.Logger.LogError(ex);

                var msg = new HtmlGenericControl()
                {
                    InnerHtml = string.Format(AlertTemplate, "Unable to delete. Reason: ", ex.Message)
                };

                grid.Controls.Add(msg);
                e.Canceled = true;
            }
        }

        protected void Map_OnItemCommand(object sender, GridCommandEventArgs e)
        {
            base.Grid_OnItemCommand(sender, e);

            // required, because the Form Values is a template column, which has no template defined in an aspx, it is created programmatically.
            requestsGrid.Rebind();
        }
    }
}