using System;
using System.Collections.Generic;
using System.Collections.Specialized;
using System.ComponentModel;
using System.Data.Linq;
using System.Data.Objects;
using System.Data.Objects.DataClasses;
using System.Linq;
using System.Web.DynamicData;
using System.Web.UI;
using System.Web.UI.WebControls;
using SharedLibrary;
using SharedLibrary.Cache;
using UsersDb;
using UsersDb.Code;
using UsersDb.DataContext;

namespace UsersUI.DynamicData.FieldTemplates
{
    public partial class Package_EditField : FieldTemplateUserControl
    {
        private Control postBackControl;

        List<MethodViewState> ListBoxItems
        {
            get { return ViewState["_listBoxItems"] as List<MethodViewState>; }
            set { ViewState["_listBoxItems"] = value; }
        }

        object CurrentRow
        {
            get { return Session[this.ID]; }
            set { Session[this.ID] = value; }
        }

        protected ObjectContext ObjectContext { get; set; }

        public void Page_Load(object sender, EventArgs e)
        {
            var ds = (EntityDataSource)this.FindDataSourceControl();

            ds.ContextCreated += (_, ctxCreatedEnventArgs) => ObjectContext = ctxCreatedEnventArgs.Context;
            ds.Updating += DataSource_UpdatingOrInserting;
            ds.Inserting += DataSource_UpdatingOrInserting;

            postBackControl = Global.GetPostBackControl(Page);

            if (postBackControl != null && postBackControl.ID == databaseList.ID)
            {
                DataBind();
            }
            else
            {
                var dbcfg = CacheHelper.Get("dbConfig", CommonActions.LoadDatabasesAliases);
                databaseList.Items.Clear();
                databaseList.Items.Add("All available");
                databaseList.Items.AddRange(dbcfg.Select(d => new ListItem(d.Value, d.Key.ToString())).ToArray());
            }
        }

        void DataSource_UpdatingOrInserting(object sender, EntityDataSourceChangingEventArgs e)
        {
            var childTable = ChildrenColumn.ChildTable;

            if (Mode == DataBoundControlMode.Edit)
            {
                ObjectContext.LoadProperty(e.Entity, Column.Name);
            }

            dynamic entityCollection = Column.EntityTypeProperty.GetValue(e.Entity, null);

            foreach (dynamic childEntity in childTable.GetQuery(e.Context))
            {
                var isCurrentlyInList = ListContainsEntity(childTable, entityCollection, childEntity);

                string pkString = childTable.GetPrimaryKeyString(childEntity);
                var listItem = mmCheckBoxList.Items.FindByValue(pkString);
                if (listItem == null)
                    continue;

                if (listItem.Selected)
                {
                    if (!isCurrentlyInList)
                        entityCollection.Add(childEntity);
                }
                else
                {
                    if (isCurrentlyInList)
                        entityCollection.Remove(childEntity);
                }
            }
        }

        private static bool ListContainsEntity(MetaTable table, IEnumerable<object> list, object entity)
        {
            return list.Any(e => AreEntitiesEqual(table, e, entity));
        }

        private static bool AreEntitiesEqual(MetaTable table, object entity1, object entity2)
        {
            return table.GetPrimaryKeyValues(entity1).SequenceEqual(table.GetPrimaryKeyValues(entity2));
        }

        protected void CheckBoxList1_DataBound(object sender, EventArgs e)
        {
            var childTable = ChildrenColumn.ChildTable;

            IEnumerable<object> entityCollection = null;

            int k;
            var selectedDatabaseFilter = int.TryParse(databaseList.SelectedValue, out k) ? k : -1;

            if (Mode == DataBoundControlMode.Edit)
            {
                ICustomTypeDescriptor rowDescriptor;

                if (postBackControl != null && postBackControl.ID == databaseList.ID)
                {
                    rowDescriptor = CurrentRow as ICustomTypeDescriptor;
                }
                else
                {
                    CurrentRow = Row;
                    rowDescriptor = Row as ICustomTypeDescriptor;
                }

                var entity = rowDescriptor != null ? rowDescriptor.GetPropertyOwner(null) : Row;

                entityCollection = (IEnumerable<object>)Column.EntityTypeProperty.GetValue(entity, null);
                var realEntityCollection = entityCollection as RelatedEnd;
                if (realEntityCollection != null && !realEntityCollection.IsLoaded)
                {
                    realEntityCollection.Load();
                }
            }

            if (ListBoxItems == null)
            {
                var list = new List<MethodViewState>();

                childTable
                    .GetQuery(ObjectContext)
                    .Cast<Method>()
                    .Where(m => m.MethodType.Id != (int)MethodTypes.Informer)
                    .ToList()
                    .ForEach(m =>
                    {
                        var item = new MethodViewState
                        {
                            Text = m.DisplayName,
                            Value = m.Id,
                            Selected = (Mode == DataBoundControlMode.Edit) && ListContainsEntity(childTable, entityCollection, m),
                            DatabaseId = m.DatabaseId
                        };

                        list.Add(item);
                    });

                ListBoxItems = list;
            }

            ListBoxItems.ForEach(mv =>
            {
                var li = mmCheckBoxList.Items.FindByValue(mv.Value.ToString());
                if (li != null)
                {
                    mv.Selected = li.Selected;
                }
            });

            mmCheckBoxList.Items.Clear();

            ListBoxItems
                .Where(li => selectedDatabaseFilter == -1 || li.DatabaseId == selectedDatabaseFilter)
                .Select(li =>
                    new ListItem
                    {
                        Text = li.Text,
                        Value = li.Value.ToString(),
                        Selected = li.Selected
                    })
                .ToList()
                .ForEach(listItem =>
                {
                    listItem.Attributes.Add("class", "DDCheckboxListItem");
                    mmCheckBoxList.Items.Add(listItem);
                });
        }

        public override Control DataControl
        {
            get
            {
                return mmCheckBoxList;
            }
        }

        protected void selectAllCheckbox_OnCheckedChanged(object sender, EventArgs e)
        {
            foreach (ListItem item in mmCheckBoxList.Items)
            {
                item.Selected = selectAllCheckbox.Checked;
            }
        }

        [Serializable]
        private class MethodViewState
        {
            public string Text;
            public int Value;
            public bool Selected;
            public int DatabaseId;
        }
    }
}
