using System;
using Db;

namespace Statix
{
    public partial class _Contacts : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                contentLabel.Text = Resources.Stub_Contact_Us;
            }
        }
    }
}
