using System;
using System.Web.DynamicData;
using Db;

namespace Statix
{
    public partial class List : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (DynamicDataRouteHandler.GetRequestMetaTable(Context).Name == Global.DefaultModel.GetTable(typeof(StatixAppContract)).Name)
            {
                varDiv.Attributes.Add("var-width", string.Empty);
            }
        }
    }
}
