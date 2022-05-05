using System;
using System.ComponentModel.DataAnnotations;
using System.Web.DynamicData;
using Db;

namespace Statix
{
    public partial class _Default : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Page.Theme != "General")
            {
                Response.Redirect("/exchanges");
            }
            else if (!IsPostBack)
            {
                contentLabel.Text = Resources.Stub_Default_Page;
            }
        }
    }
}
