using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using UsersDb;
using UsersDb.DataContext;

namespace CustomersUI.Controls
{
    public partial class MenuControl : UserControl
    {
        protected override void OnLoad(EventArgs e)
        {
            base.OnLoad(e);
            logoutButton.Visible = HttpContext.Current.User.Identity.IsAuthenticated;
        }

        public string CurrentPage => Path.GetFileName(Request.PhysicalPath).ToLower();

        public string CurrentUserName => UsersDataContext.CurrentSessionUser.FullName;

        public IEnumerable<string> Pages => GetCustomerPages();

        private IEnumerable<string> GetCustomerPages()
        {
            return Directory
                .EnumerateFiles(Server.MapPath("~/Pages/Tracked/"), "*.aspx", SearchOption.AllDirectories)
                .Select(f => Path.GetFileNameWithoutExtension(f).ToLower());
        }

        protected void logout_ServerClick(object sender, EventArgs e)
        {
            Session.Clear();
            FormsAuthentication.SignOut();
            Global.RedirectToHomePage();
        }
    }
}