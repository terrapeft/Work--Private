using System;
using System.ComponentModel;
using System.Data.Objects.DataClasses;
using System.Web.UI;

namespace UsersUI.DynamicData.FieldTemplates
{
	public partial class GroupPermission : System.Web.DynamicData.FieldTemplateUserControl
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

            DataList1.DataSource = entityCollection;
            DataList1.DataBind();
        }

        public override Control DataControl
        {
            get
            {
                return DataList1;
            }
        }

	}
}
