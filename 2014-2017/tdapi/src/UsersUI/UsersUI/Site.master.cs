using System.Web.Security;

namespace UsersUI
{
	using System;
	using System.Web;
	using System.Web.UI;

	public partial class Site : System.Web.UI.MasterPage
	{

		protected override void OnPreRender(EventArgs e)
		{
			base.OnPreRender(e);
		}

		public void AutoRedirect()
		{
			var script = "intervalset = window.setInterval('RedirectToLoginPage()'," + this.Session.Timeout * 60000 + ");";
			var page = (Page)HttpContext.Current.CurrentHandler;
			ScriptManager.RegisterClientScriptBlock(page, page.GetType(), "RedirectToLogin", script, true);
		}

		protected void Page_Load(object sender, EventArgs args)
		{
			System.Collections.IList visibleTables = Global.DefaultModel.VisibleTables;
			if (visibleTables.Count == 0)
			{
				throw new InvalidOperationException("There are no accessible tables. Make sure that at least one data model is registered in Global.asax and scaffolding is enabled or implement custom pages.");
			}

			if (HttpContext.Current.User.Identity.IsAuthenticated)
			{
				multiView1.SetActiveView(authorizedView);
			}
		}
	}
}
