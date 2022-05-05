using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Collections.Specialized;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Xml.Linq;
using System.Web.DynamicData;
using UsersDb.DataContext;

namespace UsersUI.DynamicData.FieldTemplates
{
	using System.ComponentModel;
	using System.Data.Objects.DataClasses;

	public partial class RequestMethodsField : System.Web.DynamicData.FieldTemplateUserControl
	{

		protected override void OnDataBinding(EventArgs e)
		{
			base.OnDataBinding(e);

		    var rowDescriptor = Row as ICustomTypeDescriptor;
			var entity = rowDescriptor != null ? rowDescriptor.GetPropertyOwner(null) : Row;

			// Get the collection and make sure it's loaded
			var entityCollection = Column.EntityTypeProperty.GetValue(entity, null) as EntityCollection<MethodGroup>;
			if (entityCollection == null)
			{
				throw new InvalidOperationException(
					String.Format("The Children template does not support the collection type of the '{0}' column on the '{1}' table.", Column.Name, Table.Name));
			}

			if (!entityCollection.IsLoaded)
			{
				entityCollection.Load();
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
