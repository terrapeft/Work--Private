using System;
using System.Web.DynamicData;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace UsersUI
{
	using UsersDb.Helpers;

	public partial class DefaultEntityTemplate : EntityTemplateUserControl
	{
		private MetaColumn currentColumn;

		protected override void OnLoad(EventArgs e)
		{
			foreach (var column in Table.GetDisplayColumns())
			{
				currentColumn = column;
				var item = new _NamingContainer();
				EntityTemplate1.ItemTemplate.InstantiateIn(item);
				EntityTemplate1.Controls.Add(item);
			}
		}

		protected void Label_Init(object sender, EventArgs e)
		{
			var label = (Label)sender;
			label.Text = currentColumn.DisplayName;
		}

		protected void DynamicControl_Init(object sender, EventArgs e)
		{
			var dynamicControl = (DynamicControl)sender;
			dynamicControl.DataField = currentColumn.Name;
		}

		public class _NamingContainer : Control, INamingContainer { }

	}
}
