using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Db;

namespace Statix
{
    public partial class Test : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            var dc = new StatixEntities();
            var u = dc.CurrentUser;
            if (u.RoleId == 2) return;

            Response.Write("  HTTP_X_COMING_FROM" + Request.ServerVariables["HTTP_X_COMING_FROM"]);

            Response.Write(" <br><br> HTTP_X_FORWARDED_FOR" + Request.ServerVariables["HTTP_X_FORWARDED_FOR"]);

            Response.Write(" <br><br> HTTP_X_FORWARDED" + Request.ServerVariables["HTTP_X_FORWARDED"]);

            Response.Write(" <br><br> HTTP_VIA" + Request.ServerVariables["HTTP_VIA"]);

            Response.Write(" <br><br> HTTP_COMING_FROM" + Request.ServerVariables["HTTP_COMING_FROM"]);

            Response.Write(" <br><br> HTTP_FORWARDED_FOR" + Request.ServerVariables["HTTP_FORWARDED_FOR"]);

            Response.Write(" <br><br> HTTP_FORWARDED" + Request.ServerVariables["HTTP_FORWARDED"]);

            Response.Write(" <br><br> HTTP_FROM " + Request.ServerVariables["HTTP_FROM"]);

            Response.Write(" <br><br> HTTP_PROXY_CONNECTION" + Request.ServerVariables["HTTP_PROXY_CONNECTION"]);

            Response.Write(" <br><br> CLIENT_IP" + Request.ServerVariables["CLIENT_IP"]);

            Response.Write(" <br><br> FORWARDED " + Request.ServerVariables["FORWARDED"]);

            Response.Write(" <br><br> REMOTE_ADDR " + Request.ServerVariables["REMOTE_ADDR"]);

            Response.Write(" <br><br> HTTP_CLIENT_IP" + Request.ServerVariables["HTTP_CLIENT_IP"]);

            Response.Write(" <br><br> X-Forwarded-For " + Request.ServerVariables["X-Forwarded-For"]);

            Response.Write(" <br><br> X_FORWARDED_FOR " + Request.ServerVariables["X_FORWARDED_FOR"]);

            Response.Write(" <br><br> REMOTE_HOST " + Request.ServerVariables["REMOTE_HOST"]);

            Response.Write(" <br><br> HTTP_X_CLUSTER_CLIENT_IP " + Request.ServerVariables["HTTP_X_CLUSTER_CLIENT_IP"]);

            Response.Write(" <br><br> User Host " + Request.UserHostAddress);
        }
    }
}