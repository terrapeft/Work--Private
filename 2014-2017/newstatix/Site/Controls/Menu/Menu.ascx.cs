using System;
using System.Web.Security;
using System.Web.UI;

namespace Statix.Controls.Menu
{
    public partial class Menu : UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            
        }

        protected void logout_ServerClick(object sender, EventArgs e)
        {
            FormsAuthentication.SignOut();
            Response.Redirect("/");
        }

        public bool IsAuthenticated { get; set; }
    }
}