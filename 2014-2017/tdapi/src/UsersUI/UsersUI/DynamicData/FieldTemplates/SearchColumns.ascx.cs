using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data.Objects.DataClasses;
using System.Web.UI;
using System.Linq;
using UsersDb;
using UsersDb.DataContext;

namespace UsersUI
{
	public partial class SearchColumnsField : System.Web.DynamicData.FieldTemplateUserControl
	{
		protected override void OnDataBinding(EventArgs e)
		{
			base.OnDataBinding(e);

			object entity;
			ICustomTypeDescriptor rowDescriptor = Row as ICustomTypeDescriptor;
			if (rowDescriptor != null)
			{

				entity = rowDescriptor.GetPropertyOwner(null);
			}
			else
			{
				entity = Row;
			}


			var entityCollection = Column.EntityTypeProperty.GetValue(entity, null);
			var realEntityCollection = entityCollection as RelatedEnd;
			if (realEntityCollection != null && !realEntityCollection.IsLoaded)
			{
				realEntityCollection.Load();
			}

		    var scc = entityCollection as IEnumerable<SearchColumn>;

		    if (scc != null)
		    {
		        Repeater1.DataSource = scc.OrderBy(s => s.Alias);
		        Repeater1.DataBind();
		    }
		}

		public override Control DataControl
		{
			get
			{
				return Repeater1;
			}
		}

	}
}
