using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.DynamicData;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace UsersUI
{
	using UsersDb.Helpers;

	public partial class Default_InsertEntityTemplate : System.Web.DynamicData.EntityTemplateUserControl
	{
		private MetaColumn currentColumn;

		protected override void OnLoad(EventArgs e)
		{
			foreach (var column in Table.GetInsertColumns())
			{
				currentColumn = column;
				var item = new DefaultEntityTemplate._NamingContainer();
				EntityTemplate1.ItemTemplate.InstantiateIn(item);
				EntityTemplate1.Controls.Add(item);
			}
		}

		protected void Label_Init(object sender, EventArgs e)
		{
			var label = (Label)sender;
			label.Text = currentColumn.DisplayName;
		}

		protected void Label_PreRender(object sender, EventArgs e)
		{
			var label = (Label)sender;
			var dynamicControl = (DynamicControl)label.FindControl("DynamicControl");
			var ftuc = dynamicControl.FieldTemplate as FieldTemplateUserControl;
			if (ftuc != null && ftuc.DataControl != null)
			{
				label.AssociatedControlID = ftuc.DataControl.GetUniqueIDRelativeTo(label);
			}
		}

		protected void DynamicControl_Init(object sender, EventArgs e)
		{
			var dynamicControl = (DynamicControl)sender;
			dynamicControl.DataField = currentColumn.Name;
		}

	}
}
