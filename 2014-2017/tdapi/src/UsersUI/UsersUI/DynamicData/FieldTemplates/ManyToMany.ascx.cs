using System;
using System.Collections;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations;
using System.Data.Objects;
using System.Data.Objects.DataClasses;
using System.Web.DynamicData;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace UsersUI
{
	public partial class ManyToManyField : System.Web.DynamicData.FieldTemplateUserControl
	{
		protected override void OnDataBinding(EventArgs e)
		{
			base.OnDataBinding(e);

		    var rowDescriptor = Row as ICustomTypeDescriptor;
			var entity = rowDescriptor != null ? rowDescriptor.GetPropertyOwner(null) : Row;

			var entityCollection = Column.EntityTypeProperty.GetValue(entity, null);
			var realEntityCollection = entityCollection as RelatedEnd;
			if (realEntityCollection != null && !realEntityCollection.IsLoaded)
			{
				realEntityCollection.Load();
			}

			Repeater1.DataSource = entityCollection;
			Repeater1.DataBind();
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
