using System;
using System.IO;
using System.Linq;
using System.Web;
using Db;
using SharedLibrary.DynamicRadGrid;
using SharedLibrary.Elmah;

namespace AdministrativeUI
{
    public partial class Upload : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            currentBannerImg.Src = string.Format(ServiceConfig.Banner_Path, themeDdl.SelectedValue, DateTime.Now.ToBinary());
        }

        protected void uploadButton_OnClick(object sender, EventArgs e)
        {
            try
            {
                if (!IsEmpty(fileUpload1.PostedFile))
                {
                    if (IsValid(fileUpload1.PostedFile))
                    {
                        var filename = Server.MapPath(currentBannerImg.Src.Split(new[] { '?' }, StringSplitOptions.RemoveEmptyEntries)[0]);
                        fileUpload1.PostedFile.SaveAs(filename);
                    }
                    else
                    {
                        ValidationError.Display(string.Format(Resources.Restricted_Content_Type,
                            ServiceConfig.Allowed_Content_Type));
                    }
                }
            }
            catch (Exception ex)
            {
                Logger.LogError(ex);
            }
        }

        private bool IsEmpty(HttpPostedFile file)
        {
            return file == null || file.ContentLength == 0;
        }

        private bool IsValid(HttpPostedFile file)
        {
            return ServiceConfig.Allowed_Content_Type.Equals(file.ContentType, StringComparison.CurrentCultureIgnoreCase);
        }
    }
}