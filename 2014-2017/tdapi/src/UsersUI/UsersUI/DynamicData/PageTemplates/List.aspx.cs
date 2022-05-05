using System;
using System.ComponentModel;
using System.Data;
using System.Web;
using System.Web.DynamicData;
using System.Web.UI.WebControls;
using SharedLibrary;
using SharedLibrary.DynamicRadGrid;
using SharedLibrary.SmartScaffolding;
using SharedLibrary.SmartScaffolding.Attributes;
using Telerik.Web.UI.DynamicData;
using UsersDb.DataContext;
using UsersUI.Helpers;

namespace UsersUI
{
    using System.Linq;
    using System.Web.UI.WebControls.Expressions;

    using Telerik.Web.UI;

    using UsersDb;
    using UsersDb.Helpers;

    public partial class List : System.Web.UI.Page
    {
        protected MetaTable Table;
        protected RadGridEx RadGrid;
        protected UsersDataContext DataContext = new UsersDataContext();

        /// <summary>
        /// Gets a value indicating whether the insert button is allowed for the current table.
        /// </summary>
        protected bool AllowInsert
        {
            get
            {
                var restrictions = Table.GetAttribute<RestrictActionAttribute>();
                var isResourceTable = Table.HasAttribute<ResourceTableAttribute>();
                var allowResEdit = DataContext.CurrentUser.IsResourcesAdmin && isResourceTable;
                return (allowResEdit || (!Table.IsReadOnly && (restrictions == null || !restrictions.Action.HasFlag(PageTemplate.Insert))));
            }
        }

        /// <summary>
        /// Gets a value indicating whether the delete button is allowed for the current table.
        /// </summary>
        protected bool AllowDelete
        {
            get
            {
                var restrictions = Table.GetAttribute<RestrictActionAttribute>();
                var isResourceTable = Table.HasAttribute<ResourceTableAttribute>();
                var allowResEdit = DataContext.CurrentUser.IsResourcesAdmin && isResourceTable;
                return (allowResEdit || (!Table.IsReadOnly && (restrictions == null || !restrictions.Action.HasFlag(PageTemplate.Delete))));
            }
        }

        /// <summary>
        /// Gets the image src.
        /// </summary>
        /// <param name="imgName">Name of the img.</param>
        /// <returns></returns>
        protected string GetImageSrc(string imgName)
        {
            return Page.ClientScript.GetWebResourceUrl(typeof(RadAjaxLoadingPanel), string.Format("Telerik.Web.UI.Skins.{0}.Grid.{1}.gif", RadGrid.Skin, imgName));
        }

        /// <summary>
        /// Handles the Init event of the Page control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="EventArgs"/> instance containing the event data.</param>
        protected void Page_Init(object sender, EventArgs e)
        {
            Table = DynamicDataRouteHandler.GetRequestMetaTable(Context);
            GridDataSource.ContextTypeName = Table.Name;
            RadGrid.SetMetaTable(Table, Table.GetColumnValuesFromRoute(Context));

            if (Table.EntityType != Table.RootEntityType)
            {
                GridQueryExtender.Expressions.Add(new OfTypeExpression(Table.EntityType));
            }

            if (Table.HasAttribute<DescriptionAttribute>())
            {
                descriptionDiv.Visible = true;
                descriptionContent.InnerHtml = Table.GetAttribute<DescriptionAttribute>().Description;
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
            Title = Table.DisplayName;
            GridDataSource.OrderBy = Table.GetOrderExpression();
            GridDataSource.Include = Table.ForeignKeyColumnsNames;
            BreadcrumbControl1.Table = Table;
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
            RadGrid.MasterTableView.CurrentPageIndex = 0;
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
                case RadGridEx.CloneCommandName:
                    {
                        var item = (GridDataItem)e.Item;
                        var kc = this.Table.PrimaryKeyColumns.FirstOrDefault();

                        if (kc == null) return;

                        var id = (int)item.GetDataKeyValue(kc.Name);
                        var dc = new UsersDataContext();
                        var currInformer = dc.Informers.FirstOrDefault(i => i.Id == id);
                        if (currInformer == null) return;

                        var newInformer = dc.Clone(currInformer);
                        newInformer.UserId = dc.CurrentUserId;

                        dc.Informers
                            .Where(inf => e.Item.IsInEditMode && e.Item.OwnerTableView.IsItemInserted)
                            .ToList()
                            .ForEach(i => RadGrid.MasterTableView.ClearEditItems());

                        dc.Informers.AddObject(newInformer);
                        dc.SaveChanges();
                        RadGrid.Rebind();
                    }
                    break;

                case Telerik.Web.UI.RadGrid.DeleteSelectedCommandName:
                    if (Table.Name == DataContext.GetEntitySetName(typeof(Permission)))
                    {
                        foreach (GridDataItem item in RadGrid.SelectedItems)
                        {
                            var id = (int)item.GetDataKeyValue("Id");
                            var pe = DataContext.Permissions.FirstOrDefault(p => p.Id == id);

                            if (pe != null && pe.PermissionTypeId == (int)PermissionTypes.BuiltIn)
                            {
                                e.Canceled = true;
                                return;
                            }
                        }
                    }

                    break;

                case Telerik.Web.UI.RadGrid.CancelCommandName:
                    break;

                case Telerik.Web.UI.RadGrid.EditCommandName:
                    RadGrid.MasterTableView.IsItemInserted = false;
                    break;

                case Telerik.Web.UI.RadGrid.InitInsertCommandName:
                    RadGrid.MasterTableView.ClearEditItems();
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
                if (Table.Name == DataContext.GetEntitySetName(typeof(Permission)))
                {
                    var keyCol = CommonHelper.GetName(() => (new Permission()).Id);
                    var id = (int)dataItem.GetDataKeyValue(keyCol);
                    var pe = DataContext.Permissions.FirstOrDefault(p => p.Id == id);

                    if (pe.PermissionTypeId == (int)PermissionTypes.BuiltIn)
                    {
                        dataItem["deleteButton"].Controls[0].Visible = false;
                        dataItem["editButton"].Controls[0].Visible = false;
                    }
                }
            }
        }

        #region Private stuff

        /// <summary>
        /// Initializes the grid.
        /// </summary>
        private void InitializeGrid()
        {
            var restrictions = Table.GetAttribute<RestrictActionAttribute>();
            var abilities = Table.GetAttribute<AllowActionAttribute>();
            var isResourceTable = Table.HasAttribute<ResourceTableAttribute>();
            var allowResEdit = DataContext.CurrentUser.IsResourcesAdmin && isResourceTable;

            if (!allowResEdit && restrictions != null)
            {
                if (restrictions.Action.HasFlag(PageTemplate.Edit))
                {
                    RadGrid.Columns[0].Visible = false;
                }
                else if (restrictions.Action.HasFlag(PageTemplate.Delete))
                {
                    RadGrid.Columns[1].Visible = false;
                }
            }

            if (abilities != null)
            {
                if (abilities.Action.HasFlag(PageTemplate.Clone))
                {
                    RadGrid.Columns[2].Visible = true;
                }
            }

            // Disable edit/delete
            if (Table.IsReadOnly)
            {
                RadGrid.Columns[0].Visible = false;
                RadGrid.Columns[1].Visible = false;
            }

            var groupBy = Table.GroupByColumn();
            if (groupBy != null)
            {
                var groupExpr = new GridGroupByExpression();
                var selectField = new GridGroupByField() { FieldAlias = groupBy, FieldName = groupBy, HeaderText = "Group" };
                var groupByField = new GridGroupByField() { FieldAlias = groupBy, FieldName = groupBy };

                groupExpr.SelectFields.Add(selectField);
                groupExpr.GroupByFields.Add(groupByField);

                RadGrid.MasterTableView.GroupByExpressions.Add(groupExpr);
            }

            RadGrid.Initialize(GridDataSource);
        }

        #endregion
    }
}
