using System;
using System.Configuration;
using System.Data;
using System.Data.EntityClient;
using System.Data.SqlClient;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using Telerik.Web.UI;
using Telerik.Web.UI.DynamicData;
using Umbraco.Web.UI.Pages;

namespace TradeDataUsers.UI
{
    public class BaseCustomPage : UmbracoEnsuredPage
    {
        protected RadGrid Grid { get; set; }
        protected static string ConnectionString;
        protected SqlConnection Connection;
        protected SqlCommand Command;

        protected CrudHelper CrudHelper;

        protected bool IsProtectedDatabase = true;

        public new const string ErrorPage = "/umbraco/customwebforms/error.aspx";

        /// <summary>
        /// The error panel markup.
        /// </summary>
        public const string AlertTemplate = "<div class='alert alert-danger fade in error-panel'>" +
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
            return Page.ClientScript.GetWebResourceUrl(typeof(RadAjaxLoadingPanel), $"Telerik.Web.UI.Skins.{Grid.Skin}.Grid.{imgName}.gif");
        }

        /// <summary>
        /// Fills label for a view mode or DDL for edit mode with supplied query and sets required properties of the list.
        /// </summary>
        /// <param name="item">The item.</param>
        /// <param name="ddlTextField">The DDL text field.</param>
        /// <param name="ddlValueField">The DDL value field.</param>
        /// <param name="query">The query.</param>
        /// <returns></returns>
        protected DropDownList SetDropDownList(GridItem item, string ddlTextField, string ddlValueField, string query)
        {
            var controlId = $"{ddlTextField}List";
            return SetDropDownList(item, controlId, ddlTextField, ddlValueField, query);
        }

        /// <summary>
        /// Fills label for a view mode or DDL for edit mode with supplied query and sets required properties of the list.
        /// </summary>
        /// <param name="item">The item.</param>
        /// <param name="controlId">The control identifier.</param>
        /// <param name="ddlTextField">The DDL text field.</param>
        /// <param name="ddlValueField">The DDL value field.</param>
        /// <param name="query">The query.</param>
        /// <returns></returns>
        protected DropDownList SetDropDownList(GridItem item, string controlId, string ddlTextField, string ddlValueField, string query)
        {
            var editableItem = item as GridEditableItem;

            if (editableItem != null && editableItem.IsInEditMode)
            {
                var list = editableItem.FindControl(controlId) as DropDownList;
                if (list != null)
                {
                    list.DataSource = CrudHelper.LoadTable(query, IsProtectedDatabase);
                    list.DataTextField = ddlTextField;
                    list.DataValueField = ddlValueField;
                    list.DataBind();

                    var dataRowView = editableItem.DataItem as DataRowView;
                    if (dataRowView != null)
                    {
                        var ddlId = dataRowView.Row[ddlValueField].ToString();
                        list.SelectedValue = ddlId;
                    }

                    return list;
                }
            }
            else if (item is GridDataItem && !item.IsInEditMode && Page.IsPostBack)
            {
                var label = item.FindControl($"{controlId}Label") as Label;

                var dataRowView = item.DataItem as DataRowView;
                if (dataRowView != null)
                {
                    var ddl = dataRowView.Row[ddlTextField].ToString();
                    if (label != null) label.Text = ddl;
                }
            }

            return null;
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

        protected virtual void Grid_OnItemCommand(object sender, GridCommandEventArgs e)
        {
            var grid = sender as RadGrid;

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
}