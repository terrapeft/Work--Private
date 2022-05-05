using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.EntityClient;
//using System.Data.EntityClient;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using Telerik.Web.UI;
using Telerik.Web.UI.DynamicData;
using Umbraco.Web.UI.Pages;

namespace FowTradeDataU.umbraco.CustomWebForms
{
    public class BaseCustomPage : UmbracoEnsuredPage
    {
        protected RadGridEx Grid { get; set; }
        protected static string ConnectionString;
        protected SqlConnection Connection;
        protected SqlCommand Command;

        internal new const string ErrorPage = "/umbraco/customwebforms/error.aspx";

        /// <summary>
        /// The error panel markup.
        /// </summary>
        internal const string AlertTemplate = "<div class='alert alert-danger fade in error-panel'>" +
                                               "<a href='#' class='close error-panel-close-btn' data-dismiss='alert' aria-label='close'>&times;</a>" +
                                               "{0}{1}" +
                                               "</div>";

        /// <summary>
        /// Gets the internal Telerik's grid image resource path.
        /// </summary>
        /// <param name="imgName">Name of the img.</param>
        /// <returns></returns>
        protected string GetImageSrc(string imgName)
        {
            return Page.ClientScript.GetWebResourceUrl(typeof(RadAjaxLoadingPanel), string.Format("Telerik.Web.UI.Skins.{0}.Grid.{1}.gif", Grid.Skin, imgName));
        }

        /// <summary>
        /// Loads the table with specified query.
        /// </summary>
        /// <param name="sqlQuery">The SQL query.</param>
        /// <param name="decryptPasswords">Open password key on database side before running query.</param>
        /// <param name="cacheData">True to keep data in cache.</param>
        /// <returns></returns>
        protected DataTable LoadTable(string sqlQuery, bool decryptPasswords = false, bool cacheData = false)
        {
            if (Cache[sqlQuery] != null)
            {
                return (DataTable)Cache[sqlQuery];
            }

            var dataTable = new DataTable();
            var connectionString = new EntityConnectionStringBuilder(ConfigurationManager.ConnectionStrings["UmbracoMembersEntities"].ConnectionString).ProviderConnectionString;

            using (var conn = new SqlConnection(connectionString))
            {
                conn.Open();

                if (decryptPasswords)
                {
                    var cmd = new SqlCommand
                    {
                        Connection = conn,
                        CommandText = "dbo.spOpenPasswordsKey",
                        CommandType = CommandType.StoredProcedure
                    };

                    cmd.ExecuteNonQuery();
                }

                var sqlDataAdapter = new SqlDataAdapter { SelectCommand = new SqlCommand(sqlQuery, conn) };
                sqlDataAdapter.Fill(dataTable);

                if (cacheData)
                {
                    Cache[sqlQuery] = dataTable;
                }

                return dataTable;
            }
        }

        /// <summary>
        /// Adds the RequiredFieldValidator to the grid field.
        /// </summary>
        /// <param name="item">The item.</param>
        /// <param name="field">The field.</param>
        /// <param name="templateControl">The template control for template column.</param>
        /// <param name="skipInEditMode">if set to <c>true</c> [skip in edit mode].</param>
        protected void AddValidator(GridEditableItem item, string field, string templateControl = null, bool skipInEditMode = false)
        {
            var cell = item[field];

            var isInsert = item is GridEditFormInsertItem || item is GridDataInsertItem;
            if (skipInEditMode && !isInsert) return;

            string id = null;
            var editor = item.EditManager.GetColumnEditor(field) as GridTextBoxColumnEditor;

            if (editor == null)
            {
                var ddl = item.FindControl(templateControl) as DropDownList;
                if (ddl != null)
                {
                    id = ddl.ID;
                }
                else
                {
                    var txt = item.FindControl(templateControl) as TextBox;
                    if (txt != null)
                    {
                        id = txt.ID;
                    }
                }
            }
            else
            {
                id = editor.TextBoxControl.ID;
            }

            var validator = new RequiredFieldValidator
            {
                ControlToValidate = id,
                ForeColor = System.Drawing.Color.Red,
                ErrorMessage = "&nbsp;*"
            };

            cell.Controls.Add(validator);
        }

        protected string GetDdlValue(DropDownList ctl)
        {
            if (ctl == null)
                return null;

            return ctl.SelectedValue;
        }

        protected bool GetCheckBoxValue(CheckBox ctl)
        {
            if (ctl == null)
                return false;

            return ctl.Checked;
        }

        protected string GetTextBoxValue(TextBox ctl)
        {
            if (ctl == null)
                return null;

            return ctl.Text;
        }

        protected string GetTextBoxValue(HtmlTextArea ctl)
        {
            if (ctl == null)
                return null;

            return ctl.Value;
        }

        protected virtual void Grid_OnItemCommand(object sender, GridCommandEventArgs e)
        {
            var grid = sender as RadGridEx;

            try
            {
                switch (e.CommandName)
                {
                    case RadGrid.CancelCommandName:
                        break;

                    case RadGrid.EditCommandName:
                        grid.MasterTableView.IsItemInserted = false;
                        break;

                    case RadGrid.InitInsertCommandName:
                        grid.MasterTableView.ClearEditItems();
                        break;
                }
            }
            catch (Exception ex)
            {
                SharedLibrary.Elmah.Logger.LogError(ex);

                var msg = new HtmlGenericControl()
                {
                    InnerHtml = string.Format(AlertTemplate, "Item command error. Reason: ", ex.Message)
                };

                grid.Controls.Add(msg);
                e.Canceled = true;
            }
        }
    }

    /// <summary>
    /// Types of drop-down lists available on the SalesForce form.
    /// </summary>
    public enum DdlTypes
    {
        Priority = 1,
        Impact = 3,
        QueryType = 5,
        Subcategory2 = 6,
        Subcategory3 = 7
    }
}