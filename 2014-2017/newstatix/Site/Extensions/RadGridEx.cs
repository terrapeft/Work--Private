using System.Collections;
using System.Collections.Specialized;
using UsersDb.Helpers;

namespace UsersUI
{
    using System;
    using System.ComponentModel;
    using System.ComponentModel.DataAnnotations;
    using System.Data.Objects.DataClasses;
    using System.Linq;
    using System.Web.DynamicData;
    using System.Web.UI;
    using System.Web.UI.WebControls;

    using Telerik.Web.UI;
    using Telerik.Web.UI.DynamicData;

    using UsersDb;
    using UsersDb.SmartScaffolding.Attributes;

    using DataKey = System.Web.UI.WebControls.DataKey;

    public sealed class RadGridEx : RadGrid, IDataBoundControl, IControlParameterTarget, IPersistedSelector
    {
        public const string CloneCommandName = "Clone";
        public int[] PagerNumbers = {10, 25, 50, 150, 300, 500, 1000};

        private MetaColumn filteredColumn;
        private DataKey dataKey;
        private EntityDataSource dataSource;

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
        internal void Initialize(EntityDataSource dataSource)
        {
            this.dataSource = dataSource;
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

                    e.Item.OwnerTableView.Rebind();
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
                            Rebind();

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
            foreach (var column in Table.Columns.Where(c => !IsSystemColumn(c)))
            {
                var hideIn = column.GetAttribute<HideInAttribute>();

                var templateColumn = new DynamicGridBoundColumn
                {
                    HeaderText = column.DisplayName,
                    UniqueName = column.Name,
                    SortExpression = column.Name,
                    DataField = column.Name,
                    GroupByExpression = string.Format("{0} group by {0}", column.Name),
                    UIHint = column.UIHint,
                    HideColumnIn = (hideIn == null) ? null : (PageTemplate?)hideIn.PageTemplate,
                    //ReadOnly = !IsColumnEditable(column) || IsChild(column)
                };

                if (IsNavigationalProperty(column))
                {
                    templateColumn.Groupable = false;
                    templateColumn.AllowFiltering = false;
                }

                if (IsJsonField(column))
                {
                    templateColumn.Groupable = false;
                    templateColumn.AllowSorting = false;
                }

                if (IsMergable(column))
                {
                    templateColumn.AllowSorting = false;
                }

                templateColumn.Visible = !Global.IsHidden(column);

                MasterTableView.Columns.Add(templateColumn);
            }
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

        private static bool IsSystemColumn(MetaColumn column)
        {
            return (!column.Scaffold || column.IsPrimaryKey || column.IsForeignKeyComponent /*|| column.Name.ToLower() == "isdeleted" || column.Name.ToLower() == "iseditable"*/);
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

        public DataKey DataKey
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