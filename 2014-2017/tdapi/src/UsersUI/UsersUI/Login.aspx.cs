using System;
using System.Configuration;
using System.Net;
using UsersDb.DataContext;

namespace UsersUI
{
	using System.ServiceModel.Web;
	using System.Web;
	using System.Web.Security;
	using System.Web.UI;
	using UsersDb;
	using UsersDb.Helpers;

	public partial class Login : Page
	{
        protected void Page_Load(object sender, EventArgs args)
        {
            Page.Form.DefaultFocus = txtUserName.ClientID;

            if (HttpContext.Current.User.Identity.IsAuthenticated)
            {
                Response.Redirect("/", false);
                return;
            }

            if (IsPostBack)
            {
                var dc = new UsersDataContext();

                try
                {
                    int userId;
                    var ip = AccessHelper.GetIPAddress();

                    new AccessHelper(dc)
                        .VerifyIP(ip)
                        .WithUsers(d => d.Administrators)
                        .TryAuthenticate(txtUserName.Text, txtUserPass.Text, out userId);

                    using (var auh = new AuditTrailHelper(dc))
                    {
                        auh.Add(new Audit
                        {
                            Id = Guid.NewGuid(),
                            RecordDate = DateTime.Now,
                            UserId = userId,
                            IpAddr = ip,
                            ActionId = (int) AuditAction.LogIn,
                        });

                        dc.SaveChanges();
                    }

                    FormsAuthentication.RedirectFromLoginPage(txtUserName.Text, rememberMeCheckBox.Checked);
                }
                catch (WebFaultException<string> ex)
                {
                    if (ex.StatusCode == HttpStatusCode.Unauthorized)
                    {
                        // save failed attempts
                        dc.SaveChanges();
                        errorLabel.Visible = true;
                    }
                }
                catch (Exception ex)
                {
                    Logger.LogError(ex);
                    Response.Redirect("Error.aspx", true);
                }
            }
            else
            {
                var validReferrer = ConfigurationManager.AppSettings["symbologyIframeReferrer"];
                if (Request.UrlReferrer != null && Request.UrlReferrer.ToString().EndsWith(validReferrer, StringComparison.OrdinalIgnoreCase))
                {
                    FormsAuthentication.RedirectFromLoginPage("sys_user", true);
                }
            }
        }
	}
}