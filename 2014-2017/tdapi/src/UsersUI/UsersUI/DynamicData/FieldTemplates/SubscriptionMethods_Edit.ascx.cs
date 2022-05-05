using System;
using System.Collections;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data.Objects;
using System.Data.Objects.DataClasses;
using System.Linq;
using System.Web.DynamicData;
using System.Web.UI;
using System.Web.UI.WebControls;
using UsersDb;
using UsersDb.Code;
using UsersDb.DataContext;

namespace UsersUI
{
    public partial class SubscriptionMethods_EditField : FieldTemplateUserControl
    {
        protected ObjectContext ObjectContext { get; set; }

        public void Page_Load(object sender, EventArgs e)
        {
            var ds = (EntityDataSource)this.FindDataSourceControl();

            ds.ContextCreated += (_, ctxCreatedEnventArgs) => ObjectContext = ctxCreatedEnventArgs.Context;

            ds.Updating += new EventHandler<EntityDataSourceChangingEventArgs>(DataSource_UpdatingOrInserting);
            ds.Inserting += new EventHandler<EntityDataSourceChangingEventArgs>(DataSource_UpdatingOrInserting);
        }

        void DataSource_UpdatingOrInserting(object sender, EntityDataSourceChangingEventArgs e)
        {
            MetaTable childTable = ChildrenColumn.ChildTable;

            if (Mode == DataBoundControlMode.Edit)
            {
                ObjectContext.LoadProperty(e.Entity, Column.Name);
            }

            dynamic entityCollection = Column.EntityTypeProperty.GetValue(e.Entity, null);

            foreach (dynamic childEntity in childTable.GetQuery(e.Context))
            {
                var isCurrentlyInList = ListContainsEntity(childTable, entityCollection, childEntity);

                string pkString = childTable.GetPrimaryKeyString(childEntity);
                ListItem listItem = smCheckBoxList.Items.FindByValue(pkString);
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
            return Enumerable.SequenceEqual(table.GetPrimaryKeyValues(entity1), table.GetPrimaryKeyValues(entity2));
        }

        protected void CheckBoxList1_DataBound(object sender, EventArgs e)
        {
            if (Mode == DataBoundControlMode.Edit)
            {
                var rowDescriptor = Row as ICustomTypeDescriptor;
                var user = rowDescriptor.GetPropertyOwner(null) as User;
                var subscriptionMethods = (IEnumerable<Method>)Column.EntityTypeProperty.GetValue(user, null);

                var realCollection = subscriptionMethods as RelatedEnd;
                if (realCollection != null && !realCollection.IsLoaded)
                {
                    realCollection.Load();
                }
            }
        }

        public override Control DataControl
        {
            get
            {
                return smCheckBoxList;
            }
        }

        protected void selectAllCheckbox_OnCheckedChanged(object sender, EventArgs e)
        {
            foreach (ListItem item in smCheckBoxList.Items)
            {
                item.Selected = selectAllCheckbox.Checked;
            }
        }
    }
}
