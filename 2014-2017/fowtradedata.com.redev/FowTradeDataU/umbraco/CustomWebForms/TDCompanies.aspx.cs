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
using Telerik.Web.UI;

namespace FowTradeDataU.umbraco.CustomWebForms
{
    public partial class TDCompanies : BaseCustomPage
    {
        protected void Page_Init(object sender, EventArgs e)
        {
            Grid = companiesGrid;
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

                        foreach (var col in Grid.MasterTableView.Columns.OfType<GridBoundColumn>())
                        {
                            var ctl = dataItem[col.UniqueName].Controls[0];
                            ((WebControl)ctl).CssClass = "form-control input-sm";
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

                Grid.Controls.Add(msg);
                e.Canceled = true;
            }
        }

        protected void Grid_OnNeedDataSource(object sender, GridNeedDataSourceEventArgs e)
        {
            try
            {
                Grid.DataSource = LoadTable(AppSettings.BackEnd_DataSource_Companies);
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

                var companyId = editedItem.OwnerTableView.DataKeyValues[editedItem.ItemIndex]["CompanyId"].ToString();

                var name = GetTextBoxValue(editedItem["name"].Controls.OfType<TextBox>().FirstOrDefault());
                var phone = GetTextBoxValue(editedItem["phone"].Controls.OfType<TextBox>().FirstOrDefault());
                var address = GetTextBoxValue(editedItem["address"].Controls.OfType<TextBox>().FirstOrDefault());

                ConnectionString = new EntityConnectionStringBuilder(ConfigurationManager.ConnectionStrings["UmbracoMembersEntities"].ConnectionString).ProviderConnectionString;
                Connection = new SqlConnection(ConnectionString);
                Command = new SqlCommand
                {
                    Connection = Connection,
                    CommandText = "dbo.spCompanyUpdate",
                    CommandType = CommandType.StoredProcedure
                };

                Connection.Open();

                Command.Parameters.AddWithValue("@companyId", companyId);
                Command.Parameters.AddWithValue("@name", name);
                Command.Parameters.AddWithValue("@phone", phone);
                Command.Parameters.AddWithValue("@address", address);

                Command.ExecuteNonQuery();

                Connection.Close();
            }
            catch (Exception ex)
            {
                SharedLibrary.Elmah.Logger.LogError(ex);

                var msg = new HtmlGenericControl()
                {
                    InnerHtml = string.Format(AlertTemplate, "Unable to update Company. Reason: ", ex.Message)
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

                var name = GetTextBoxValue(insertItem["name"].Controls.OfType<TextBox>().FirstOrDefault());
                var phone = GetTextBoxValue(insertItem["phone"].Controls.OfType<TextBox>().FirstOrDefault());
                var address = GetTextBoxValue(insertItem["address"].Controls.OfType<TextBox>().FirstOrDefault());

                ConnectionString = new EntityConnectionStringBuilder(ConfigurationManager.ConnectionStrings["UmbracoMembersEntities"].ConnectionString).ProviderConnectionString;
                Connection = new SqlConnection(ConnectionString);
                Command = new SqlCommand
                {
                    Connection = Connection,
                    CommandText = "dbo.spCompanyInsert",
                    CommandType = CommandType.StoredProcedure
                };

                Connection.Open();

                Command.Parameters.AddWithValue("@name", name);
                Command.Parameters.AddWithValue("@phone", phone);
                Command.Parameters.AddWithValue("@address", address);

                Command.ExecuteNonQuery();

                Connection.Close();
            }
            catch (Exception ex)
            {
                SharedLibrary.Elmah.Logger.LogError(ex);

                var msg = new HtmlGenericControl()
                {
                    InnerHtml = string.Format(AlertTemplate, "Unable to insert Company. Reason: ", ex.Message)
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

                var companyId = editedItem.OwnerTableView.DataKeyValues[editedItem.ItemIndex]["CompanyId"].ToString();

                ConnectionString = new EntityConnectionStringBuilder(ConfigurationManager.ConnectionStrings["UmbracoMembersEntities"].ConnectionString).ProviderConnectionString;
                Connection = new SqlConnection(ConnectionString);
                Command = new SqlCommand
                {
                    Connection = Connection,
                    CommandType = CommandType.StoredProcedure,
                    CommandText = "dbo.spCompanyDelete"
                };

                Connection.Open();

                Command.Parameters.AddWithValue("@companyId", companyId);

                Command.ExecuteNonQuery();

                Connection.Close();
            }
            catch (Exception ex)
            {
                SharedLibrary.Elmah.Logger.LogError(ex);

                var msg = new HtmlGenericControl()
                {
                    InnerHtml = string.Format(AlertTemplate, "Unable to delete Company. Reason: ", ex.Message)
                };

                Grid.Controls.Add(msg);
                e.Canceled = true;
            }
        }

        #endregion
    }
}