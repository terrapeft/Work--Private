using System;
using Db;

namespace Statix
{
    public partial class _Policy : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                contentLabel.Text = Resources.Stub_Privacy_Policy;
            }
        }
    }
}
