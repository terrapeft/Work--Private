using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using UsersDb.DataContext;

namespace UsersUI.DynamicData.Filters
{
	using System.Collections;
	using System.Web.DynamicData;

	using UsersDb;

	public partial class InformerFilter : QueryableFilterUserControl
	{
		private const string NullValueString = "[null]";
		private new MetaForeignKeyColumn Column
		{
			get
			{
				return (MetaForeignKeyColumn)base.Column;
			}
		}

		public override Control FilterControl
		{
			get
			{
				return DropDownList1;
			}
		}

		protected void Page_Load(object sender, EventArgs e)
		{
			if (!Page.IsPostBack)
			{
				if (!Column.IsRequired)
				{
					DropDownList1.Items.Add(new ListItem("[Not Set]", NullValueString));
				}
				PopulateListControl(DropDownList1);
				// Set the initial value if there is one
				string initialValue = DefaultValue;
				if (!String.IsNullOrEmpty(initialValue))
				{
					DropDownList1.SelectedValue = initialValue;
				}
			}
		}

		protected new void PopulateListControl(ListControl listControl)
		{
			var table = ((MetaForeignKeyColumn)this.Column).ParentTable;
            var query = table.GetQuery().Cast<Method>().Where(m => m.TypeId == (int)MethodTypes.Informer);

			foreach (Method row in query)
			{
				string displayString = table.GetDisplayString(row);
				string primaryKeyString = table.GetPrimaryKeyString(row);
				DropDownList1.Items.Add(new ListItem(displayString, primaryKeyString.TrimEnd(new char[0])));
			}
		}

		protected void DropDownList1_SelectedIndexChanged(object sender, EventArgs e)
		{
			OnFilterChanged();
		}

		public override IQueryable GetQueryable(IQueryable source)
		{
			var selectedValue = DropDownList1.SelectedValue;
			if (String.IsNullOrEmpty(selectedValue))
			{
				return source;
			}

			if (selectedValue == NullValueString)
			{
				return ApplyEqualityFilter(source, Column.Name, null);
			}

			IDictionary dict = new Hashtable();
			Column.ExtractForeignKey(dict, selectedValue);
			foreach (DictionaryEntry entry in dict)
			{
				string key = (string)entry.Key;
				if (DefaultValues != null)
				{
					DefaultValues[key] = entry.Value;
				}
				source = ApplyEqualityFilter(source, Column.GetFilterExpression(key), entry.Value);
			}
			return source;
		}
	}
}