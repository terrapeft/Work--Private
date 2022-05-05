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
using SharedLibrary;
using UsersDb;
using UsersDb.DataContext;
using UsersDb.Helpers;

namespace UsersUI
{
    public partial class SearchColumns_EditField : FieldTemplateUserControl
	{
		protected ObjectContext ObjectContext { get; set; }

		public void Page_Load(object sender, EventArgs e)
		{
			var ds = (EntityDataSource)this.FindDataSourceControl();

			ds.ContextCreated += (_, ctxCreatedEnventArgs) => ObjectContext = ctxCreatedEnventArgs.Context;

			ds.Updating += DataSource_UpdatingOrInserting;
			ds.Inserting += DataSource_UpdatingOrInserting;

            var c = Global.GetPostBackControl(this.Page);
            if (c != null && c.ID == Constants.ForeignKeyAutoPostBackSenderId)
            {
                CheckBoxList1.DataBind();
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
				var listItem = CheckBoxList1.Items.FindByValue(pkString);
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
            var ddl = Global.GetPostBackControl(this.Page) as DropDownList;
		    var justEdit = ddl == null;

			var childTable = ChildrenColumn.ChildTable;

			IEnumerable<object> entityCollection = null;
		    var entity = new SearchGroup();

            if (Mode == DataBoundControlMode.Edit && justEdit)
			{
				var rowDescriptor = Row as ICustomTypeDescriptor;
				if (rowDescriptor != null)
				{
                    entity = rowDescriptor.GetPropertyOwner(null) as SearchGroup;
				}
				else
				{
                    entity = Row as SearchGroup;
				}

				entityCollection = (IEnumerable<object>)Column.EntityTypeProperty.GetValue(entity, null);
				var realEntityCollection = entityCollection as RelatedEnd;
				if (realEntityCollection != null && !realEntityCollection.IsLoaded)
				{
					realEntityCollection.Load();
				}
			}

            var scTblId = ddl != null
                ? ddl.SelectedValue.ToInt32()
                : entity.TableId;

		    var query = childTable
                .GetQuery(ObjectContext)
                .Cast<SearchColumn>()
                .Where(s => s.TableId == scTblId)
                .OrderBy(s => s.Alias);

            CheckBoxList1.Items.Clear();

			foreach (var childEntity in query)
			{
				var listItem = new ListItem(
					 childTable.GetDisplayString(childEntity),
					 childTable.GetPrimaryKeyString(childEntity));
				listItem.Attributes.Add("class", "DDCheckboxListItem");

                if (Mode == DataBoundControlMode.Edit && justEdit)
				{
					listItem.Selected = ListContainsEntity(childTable, entityCollection, childEntity);
				}
                
				CheckBoxList1.Items.Add(listItem);
			}
		}

		public override Control DataControl
		{
			get
			{
				return CheckBoxList1;
			}
		}

		protected void selectAllCheckbox_OnCheckedChanged(object sender, EventArgs e)
		{
			foreach (ListItem item in CheckBoxList1.Items)
			{
				item.Selected = selectAllCheckbox.Checked;
			}
		}
	}
}
