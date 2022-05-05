using System;
using Telerik.Web.UI;

namespace Statix.Controls
{
    public partial class TagCloud : System.Web.UI.UserControl
    {
        public Action<string> TagFilterRequest;

        protected void tagCloud_OnItemDataBound(object sender, RadTagCloudEventArgs e)
        {
            e.Item.AccessKey = e.Item.NavigateUrl;
            e.Item.NavigateUrl = string.Empty;
        }

        protected void tagCloud_OnItemClick(object sender, RadTagCloudEventArgs e)
        {
            TagFilterRequest.Invoke(e.Item.AccessKey);
            tagCloud.DataBind();
        }
    }
}