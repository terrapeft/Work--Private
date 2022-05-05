using System;
using System.Web;
using System.Web.DynamicData;
using Telerik.Web.UI;
using Telerik.Web.UI.DynamicData;

namespace AdministrativeUI.Controls
{
    public partial class GridOptionsControl : System.Web.UI.UserControl
	{
		private MetaTable table;
		public string RadGridId { get; set; }
		
		private RadGridEx RadGrid
		{
			get
			{
				var ctl = Parent.FindControl(RadGridId) as RadGridEx;
				return ctl;
			}
		}

		protected void Page_Init(object sender, EventArgs e)
		{
			table = DynamicDataRouteHandler.GetRequestMetaTable(Context);
			this.LoadFromCookies();
		}

		protected void filterCheckbox_OnCheckedChanged(object sender, EventArgs e)
		{
			RadGrid.AllowFilteringByColumn = filterCheckbox.Checked;
			RadGrid.ShowGroupPanel = groupCheckbox.Checked;
			RadGrid.MasterTableView.CommandItemDisplay = savePanelCheckbox.Checked ? GridCommandItemDisplay.Top : GridCommandItemDisplay.None;

			RadGrid.Rebind();

			SaveToCookie();
		}

		private void SaveToCookie()
		{
			var c1 = new HttpCookie(table.Name + "gridSettings");

			c1.Values.Add("filter", (RadGrid.AllowFilteringByColumn ? 1 : 0).ToString());
			c1.Values.Add("grouping", (RadGrid.ShowGroupPanel ? 1 : 0).ToString());
			c1.Values.Add("saveButtons", ((int)RadGrid.MasterTableView.CommandItemDisplay).ToString());

			c1.Expires = DateTime.Today.AddYears(10);

			Page.Response.Cookies.Add(c1);
		}

		private void LoadFromCookies()
		{
			var c1 = Request.Cookies[table.Name + "gridSettings"];

			if (c1 != null)
			{
				RadGrid.AllowFilteringByColumn = c1.Values["filter"] == "1";
				filterCheckbox.Checked = RadGrid.AllowFilteringByColumn;

				RadGrid.ShowGroupPanel = c1.Values["grouping"] == "1";
				groupCheckbox.Checked = RadGrid.ShowGroupPanel;

				RadGrid.MasterTableView.CommandItemDisplay = (GridCommandItemDisplay)Convert.ToInt32(c1.Values["saveButtons"]);
				savePanelCheckbox.Checked = RadGrid.MasterTableView.CommandItemDisplay == GridCommandItemDisplay.Top;
			}
		}
	}
}