using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace FowTradeDataU.umbraco.CustomWebForms
{
    public partial class Error : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            var err = Server.GetLastError();
            if (err != null)
            {
                errMessage.InnerText = err.Message;
            }
        }
    }
}