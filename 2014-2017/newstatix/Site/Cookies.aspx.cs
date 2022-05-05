using System;
using Db;

namespace Statix
{
    public partial class Cookies : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                contentLabel.Text = Resources.Stub_Cookie;
            }
        }
    }
}