using System;
using System.Linq;
using System.Web.DynamicData;
using System.Web.Security;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.Expressions;
using Db;
using SharedLibrary.DynamicRadGrid;
using SharedLibrary.Extensions;
using SharedLibrary.SmartScaffolding;
using SharedLibrary.SmartScaffolding.Attributes;
using Telerik.Web.UI;
using Telerik.Web.UI.DynamicData;

namespace AdministrativeUI.DynamicData.PageTemplates
{
    public partial class List : System.Web.UI.Page
    {
        protected MetaTable table;
        protected RadGridEx radGrid;
        protected StatixEntities dataContext = new StatixEntities();

        /// <summary>
        /// Gets a value indicating whether the insert button is allowed for the current table.
        /// </summary>
        protected bool AllowInsert
        {
            get
            {
                var restrictions = table.GetAttribute<RestrictActionAttribute>();
                var isResourceTable = table.HasAttribute<ResourceTableAttribute>();
                var allowResEdit = dataContext.CurrentUser.IsResourcesAdmin && isResourceTable;
                return (allowResEdit || (!table.IsReadOnly && (restrictions == null || !restrictions.Action.HasFlag(PageTemplate.Insert))));
            }
        }

        /// <summary>
        /// Gets a value indicating whether the delete button is allowed for the current table.
        /// </summary>
        protected bool AllowDelete
        {
            get
            {
                var restrictions = table.GetAttribute<RestrictActionAttribute>();
                var isResourceTable = table.HasAttribute<ResourceTableAttribute>();
                var allowResEdit = dataContext.CurrentUser.IsResourcesAdmin && isResourceTable;
                return (allowResEdit || (!table.IsReadOnly && (restrictions == null || !restrictions.Action.HasFlag(PageTemplate.Delete))));
            }
        }

        /// <summary>
        /// Gets the image src.
        /// </summary>
        /// <param name="imgName">Name of the img.</param>
        /// <returns></returns>
        protected string GetImageSrc(string imgName)
        {
            return Page.ClientScript.GetWebResourceUrl(typeof(RadAjaxLoadingPanel), string.Format("Telerik.Web.UI.Skins.{0}.Grid.{1}.gif", radGrid.Skin, imgName));
        }

        /// <summary>
        /// Handles the Init event of the Page control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="EventArgs"/> instance containing the event data.</param>
        protected void Page_Init(object sender, EventArgs e)
        {
            table = DynamicDataRouteHandler.GetRequestMetaTable(Context);
            GridDataSource.ContextTypeName = table.Name;
            radGrid.SetMetaTable(table, table.GetColumnValuesFromRoute(Context));

            if (table.EntityType != table.RootEntityType)
            {
                GridQueryExtender.Expressions.Add(new OfTypeExpression(table.EntityType));
            }

            this.InitializeGrid();
        }

        /// <summary>
        /// Handles the Load event of the Page control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="EventArgs"/> instance containing the event data.</param>
        protected void Page_Load(object sender, EventArgs e)
        {
            Title = table.DisplayName;
            GridDataSource.OrderBy = table.GetOrderExpression();
            GridDataSource.Include = table.ForeignKeyColumnsNames;
            BreadcrumbControl1.Table = table;
            BreadcrumbControl1.DataBind();
        }

        /// <summary>
        /// Handles the PreRender event of the Label control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="EventArgs"/> instance containing the event data.</param>
        protected void Label_PreRender(object sender, EventArgs e)
        {
            var label = (Label)sender;
            var dynamicFilter = (DynamicFilter)label.FindControl("DynamicFilter");
            var fuc = dynamicFilter.FilterTemplate as QueryableFilterUserControl;

            if (fuc != null && fuc.FilterControl != null)
            {
                label.AssociatedControlID = fuc.FilterControl.GetUniqueIDRelativeTo(label);
            }
        }

        /// <summary>
        /// Handles the FilterChanged event of the DynamicFilter control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="EventArgs"/> instance containing the event data.</param>
        protected void DynamicFilter_FilterChanged(object sender, EventArgs e)
        {
            radGrid.MasterTableView.CurrentPageIndex = 0;
        }

        /// <summary>
        /// Handles the OnItemCommand event of the radGrid control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="GridCommandEventArgs"/> instance containing the event data.</param>
        protected void radGrid_OnItemCommand(object sender, GridCommandEventArgs e)
        {
            switch (e.CommandName)
            {
                case RadGrid.CancelCommandName:
                    break;

                case RadGrid.EditCommandName:
                    radGrid.MasterTableView.IsItemInserted = false;
                    break;

                case RadGrid.InitInsertCommandName:
                    radGrid.MasterTableView.ClearEditItems();
                    break;
            }
        }

        /// <summary>
        /// RADs the grid_ on validation error.
        /// </summary>
        /// <param name="sender">The sender.</param>
        /// <param name="e">The e.</param>
        protected void radGrid_OnValidationError(object sender, ValidationErrorArgs e)
        {
            ValidationError.Display(e.Message + Environment.NewLine + e.Description);
        }

        /// <summary>
        /// Handles the OnItemDataBound event of the radGrid control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="GridItemEventArgs"/> instance containing the event data.</param>
        protected void radGrid_OnItemDataBound(object sender, GridItemEventArgs e)
        {
            var dataItem = e.Item as GridDataItem;
            if (dataItem != null)
            {
/*                if (table.Name == dataContext.GetEntitySetName(typeof(Permission)))
                {
                    var keyCol = CommonHelper.GetName(() => (new Permission()).Id);
                    var id = (int)dataItem.GetDataKeyValue(keyCol);
                    var pe = dataContext.Permissions.FirstOrDefault(p => p.Id == id);

                    if (pe.PermissionTypeId == (int)PermissionTypes.BuiltIn)
                    {
                        dataItem["deleteButton"].Controls[0].Visible = false;
                        dataItem["editButton"].Controls[0].Visible = false;
                    }
                }*/
            }
        }

        #region Private stuff

        /// <summary>
        /// Initializes the grid.
        /// </summary>
        private void InitializeGrid()
        {
            var restrictions = table.GetAttribute<RestrictActionAttribute>();
            var abilities = table.GetAttribute<AllowActionAttribute>();
            var isResourceTable = table.HasAttribute<ResourceTableAttribute>();
            var allowResEdit = dataContext.CurrentUser.IsResourcesAdmin && isResourceTable;

            if (!allowResEdit && restrictions != null)
            {
                if (restrictions.Action.HasFlag(PageTemplate.Edit))
                {
                    radGrid.Columns[0].Visible = false;
                }
                else if (restrictions.Action.HasFlag(PageTemplate.Delete))
                {
                    radGrid.Columns[1].Visible = false;
                }
            }

            if (abilities != null)
            {
                if (abilities.Action.HasFlag(PageTemplate.Clone))
                {
                    radGrid.Columns[2].Visible = true;
                }
            }

            // Disable edit/delete
            if (table.IsReadOnly)
            {
                radGrid.Columns[0].Visible = false;
                radGrid.Columns[1].Visible = false;
            }

            var groupBy = table.GroupByColumn();
            if (groupBy != null)
            {
                var groupExpr = new GridGroupByExpression();
                var selectField = new GridGroupByField() { FieldAlias = groupBy, FieldName = groupBy, HeaderText = "Group" };
                var groupByField = new GridGroupByField() { FieldAlias = groupBy, FieldName = groupBy };

                groupExpr.SelectFields.Add(selectField);
                groupExpr.GroupByFields.Add(groupByField);

                radGrid.MasterTableView.GroupByExpressions.Add(groupExpr);
            }

            radGrid.Initialize(GridDataSource);
        }

        #endregion
    }
}
