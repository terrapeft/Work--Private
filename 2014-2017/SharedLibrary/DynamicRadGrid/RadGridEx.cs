using System;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations;
using System.Data.Objects.DataClasses;
using System.Linq;
using System.Web;
using System.Web.DynamicData;
using System.Web.UI;
using System.Web.UI.WebControls;
using SharedLibrary;
using SharedLibrary.SmartScaffolding;
using SharedLibrary.SmartScaffolding.Attributes;

namespace Telerik.Web.UI.DynamicData
{
    public sealed class RadGridEx : RadGrid, IDataBoundControl, IControlParameterTarget, IPersistedSelector
    {
        public const string CloneCommandName = "Clone";
        public int[] PagerNumbers = { 5, 10, 25, 50, 150, 300, 500, 1000 };

        private MetaColumn filteredColumn;
        private System.Web.UI.WebControls.DataKey dataKey;
        //private EntityDataSource dataSource;

        public event EventHandler<ValidationErrorArgs> ValidationError;

        /// <summary>
        /// Called when validation error occures on saving data to database.
        /// </summary>
        /// <param name="e">The e.</param>
        private void OnValidationError(ValidationErrorArgs e)
        {
            var handler = this.ValidationError;
            if (handler != null)
            {
                handler(this, e);
            }
        }

        /// <summary>
        /// Initializes the specified data source.
        /// </summary>
        /// <param name="dataSource">The data source.</param>
        public void Initialize(EntityDataSource dataSource)
        {
            //this.dataSource = dataSource;
            if (UseAsDynamic)
            {
                this.AddColumns();

                MasterTableView.DataKeyNames = this.Table.PrimaryKeyColumns.Select(column => column.Name).ToArray();

                SortCommand += (sender, e) =>
                {
                    if (e.Item.ItemType != GridItemType.Header)
                        return;

                    var sortExpr = string.Format("it.{0}{1}", e.SortExpression, "{0}");

                    var currentColumnCriterion = (e.NewSortOrder == GridSortOrder.Ascending)
                        ? string.Format(sortExpr, " ASC")
                        : (e.NewSortOrder == GridSortOrder.Descending)
                        ? string.Format(sortExpr, " DESC")
                        : string.Empty;
                    dataSource.OrderBy = currentColumnCriterion;
                };

                ItemCommand += (sender, e) =>
                {
                    switch (e.CommandName)
                    {
                        case EditCommandName:
                            Columns
                                .Cast<GridColumn>()
                                .Where(c => c is DynamicGridBoundColumn)
                                .Cast<DynamicGridBoundColumn>()
                                .Where(c => c.HideColumnIn.Value.HasFlag(PageTemplate.Edit))
                                .ToList()
                                .ForEach(c =>
                                {
                                    c.ReadOnly = true;
                                });
                            break;
                        case InitInsertCommandName:
                            Columns
                                .Cast<GridColumn>()
                                .Where(c => c is DynamicGridBoundColumn)
                                .Cast<DynamicGridBoundColumn>()
                                .Where(c => c.HideColumnIn.Value.HasFlag(PageTemplate.Insert))
                                .ToList()
                                .ForEach(c =>
                                {
                                    c.ReadOnly = true;
                                });

                            break;
                    }
                };

                ItemDataBound += (sender, e) =>
                {
                    if (e.Item is GridPagerItem)
                    {
                        var cmb = (RadComboBox)e.Item.FindControl("PageSizeComboBox");
                        cmb.Items.Clear();

                        foreach (var val in PagerNumbers.Select(pagerNumber => pagerNumber.ToString()))
                        {
                            cmb.Items.Add(new RadComboBoxItem(val));
                            cmb.FindItemByText(val).Attributes.Add("ownerTableViewId", MasterTableView.ClientID);
                        }

                        cmb.FindItemByText(e.Item.OwnerTableView.PageSize.ToString()).Selected = true;
                    }
                };
            }

            foreach (RadMenuItem item in FilterMenu.Items)
            {    
                item.Text = item.Text.SplitStringOnCaps();
            }
        }

        /// <summary>
        /// Overrides RadGrid BubbleEvent to manually handle ValidationException.
        /// </summary>
        /// <param name="source">The source.</param>
        /// <param name="e">The <see cref="EventArgs"/> instance containing the event data.</param>
        /// <returns></returns>
        protected override bool OnBubbleEvent(object source, EventArgs e)
        {
            try
            {
                return base.OnBubbleEvent(source, e);
            }
            catch (ValidationException ex)
            {
                this.OnValidationError(new ValidationErrorArgs { Message = ex.Message, Description = ex.InnerException.Message });
                return true;
            }
        }

        /// <summary>
        /// Adds the columns.
        /// </summary>
        private void AddColumns()
        {
            foreach (var column in Table.Columns.Where(c => c.Scaffold).OrderBy(c => c.GetColumnOrder()))
            {
                if (column.IsPrimaryKey)
                {
                    var scaffoldPrimaryKey = column.GetAttribute<ScaffoldPrimaryKeyAttribute>();
                    if (scaffoldPrimaryKey == null || !scaffoldPrimaryKey.Scaffold)
                    {
                        continue;
                    }
                }

                if (column.IsForeignKeyComponent)
                {
                    continue;
                }

                var hideIn = column.GetAttribute<HideInAttribute>();
                var css = column.GetAttribute<CssClassAttribute>();

                var templateColumn = new DynamicGridBoundColumn
                {
                    HeaderText = column.DisplayName,
                    UniqueName = column.Name,
                    SortExpression = column.Name,
                    DataField = column.Name,
                    GroupByExpression = string.Format("{0} group by {0}", column.Name),
                    UIHint = column.UIHint,
                    HideColumnIn = (hideIn == null) ? null : (PageTemplate?)hideIn.PageTemplate,
                    CssClass = (css == null) ? null : css.CssClass
                };

                if (IsNavigationalProperty(column) || IsJsonField(column) || IsLink(column))
                {
                    templateColumn.Groupable = false;
                    templateColumn.AllowFiltering = false;
                }

                if (IsMergable(column))
                {
                    templateColumn.AllowSorting = false;
                }

                templateColumn.Visible = !IsHidden(column);

                MasterTableView.Columns.Add(templateColumn);
            }
        }

        private Boolean IsHidden(MetaColumn column)
        {
            var page = (Page)HttpContext.Current.CurrentHandler;
            var pageTemplate = page.GetPageTemplate();

            var hideIn = column.GetAttribute<HideInAttribute>();

            if (hideIn != null)
            {
                return (hideIn.PageTemplate & pageTemplate) == pageTemplate;
            }

            return false;
        }

        /// <summary>
        /// Determines whether the column stands for navigational property.
        /// </summary>
        /// <param name="column">The column.</param>
        /// <returns></returns>
        private static bool IsNavigationalProperty(MetaColumn column)
        {
            return column.GetAttribute<EdmRelationshipNavigationPropertyAttribute>() != null;
        }

        private static bool IsLink(MetaColumn column)
        {
            return column.GetAttribute<LinkAttribute>() != null;
        }
        /// <summary>
        /// Determines whether the column require Xslt transformation.
        /// </summary>
        /// <param name="column">The column.</param>
        /// <returns></returns>
        private static bool IsJsonField(MetaColumn column)
        {
            return column.GetAttribute<JsonTypeAttribute>() != null;
        }

        /// <summary>
        /// Determines whether the specified column is mergable.
        /// </summary>
        /// <param name="column">The column.</param>
        /// <returns></returns>
        private static bool IsMergable(MetaColumn column)
        {
            return column.GetAttribute<MergablePropertyAttribute>() != null;
        }

        public bool UseAsDynamic { get; set; }

        public string[] DataKeyNames
        {
            get
            {
                return MasterTableView.DataKeyNames;
            }
            set
            {
                MasterTableView.DataKeyNames = value;
            }
        }

        public string GetPropertyNameExpression(string columnName)
        {
            return "DataKeySelectedValue";
        }

        public MetaTable Table
        {
            get
            {
                return this.FindMetaTable();
            }
        }

        public MetaColumn FilteredColumn
        {
            get
            {
                return this.filteredColumn;
            }
        }

        public System.Web.UI.WebControls.DataKey DataKey
        {
            get
            {
                return this.dataKey;
            }
            set
            {
                dataKey = value;
                if (dataKey != null)
                {
                    ((IStateManager)dataKey).TrackViewState();
                }
            }
        }
    }

    public class ValidationErrorArgs : EventArgs
    {
        public string Message { get; set; }
        public string Description { get; set; }
    }
}