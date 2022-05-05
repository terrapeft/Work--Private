using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Collections.Specialized;
using System.ComponentModel;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Xml.Linq;
using System.Web.DynamicData;
using UsersDb;
using UsersDb.Helpers;

namespace UsersUI.DynamicData.FieldTemplates
{
    public partial class SubscriptionRequest : System.Web.DynamicData.FieldTemplateUserControl
    {
        public override Control DataControl => Link1;

        protected override void OnDataBinding(EventArgs e)
        {
            var metaTable = DynamicDataRouteHandler.GetRequestMetaTable(Context);

            var rowDescriptor = Row as ICustomTypeDescriptor;
            dynamic entity = rowDescriptor != null ? rowDescriptor.GetPropertyOwner(null) : Row;
            Link1.NavigateUrl = $"/SubscriptionRequests/Details.aspx?Id={entity.SubscriptionRequest.Id}";
            base.OnDataBinding(e);
        }
    }
}
