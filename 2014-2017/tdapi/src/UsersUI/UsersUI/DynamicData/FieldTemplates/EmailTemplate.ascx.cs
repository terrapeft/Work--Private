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
using SharedLibrary.SmartScaffolding;
using SharedLibrary.SmartScaffolding.Attributes;
using UsersDb;
using UsersDb.Helpers;

namespace UsersUI.DynamicData.FieldTemplates
{
    public partial class EmailTemplate : System.Web.DynamicData.FieldTemplateUserControl
    {
        public override Control DataControl => previewIframe;

        protected override void OnDataBinding(EventArgs e)
        {
            var metaTable = DynamicDataRouteHandler.GetRequestMetaTable(Context);
            UsersDb.DataContext.EmailTemplate dfd = new UsersDb.DataContext.EmailTemplate();

            var rowDescriptor = Row as ICustomTypeDescriptor;
            dynamic entity = rowDescriptor != null ? rowDescriptor.GetPropertyOwner(null) : Row;

            subjSpan.InnerText = entity.Subject;

            var body = FieldValue.ToString();
            var format = ServiceConfig.Trial_Notification_Email_Format;
            var fileSrc = $"~/TempFiles/{CleanFileName((entity.Subject + entity.Body + format).GetHashCode().ToString())}.html";
            var fileName = Server.MapPath(fileSrc);
            var dir = Path.GetDirectoryName(fileName);

            Directory.CreateDirectory(dir);

            try
            {
                File.WriteAllText(fileName, body);
                previewIframe.Src = fileSrc;

                // copy logo image
                File.Copy(Server.MapPath("~/Content/Images/emailLogo.png"), Path.Combine(dir, "emailLogo.png"), true);
            }
            catch (Exception ex)
            {
                Literal1.InnerText = ex.ToString();
                Logger.LogError(ex);
            }

            base.OnDataBinding(e);
        }

        private string CleanFileName(string fileName)
        {
            return Path.GetInvalidFileNameChars().Aggregate(fileName, (current, c) => current.Replace(c.ToString(), string.Empty));
        }
    }
}
