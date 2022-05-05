using System;
using System.Linq;
using System.Net;
using System.ServiceModel.Web;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using SharedLibrary;
using UsersDb;
using UsersDb.DataContext;
using UsersDb.Helpers;

namespace CustomersUI
{
    public partial class Login : Page
    {
        protected void Page_Load(object sender, EventArgs args)
        {
            Page.Form.DefaultFocus = txtUserName.ClientID;

            var dc = new UsersDataContext();
            var ip = AccessHelper.GetIPAddress();
            var accessHelper = new AccessHelper(dc);

            try
            {
                accessHelper.VerifyIP(ip);
            }
            catch (WebFaultException<string>)
            {
                using (var auh = new AuditTrailHelper(dc))
                {
                    auh.Add(new Audit
                    {
                        Id = Guid.NewGuid(),
                        RecordDate = DateTime.Now,
                        UserId = 0,
                        IpAddr = ip,
                        ActionId = (int)AuditAction.ForbiddenIpAddress,
                    });

                    dc.SaveChanges();
                }

                throw;
            }

            if (HttpContext.Current.User.Identity.IsAuthenticated)
            {
                var isTrial = dc.CurrentUser.Roles.Where(r => !r.IsDeleted).Any(r => r.Id == (int)UserRoles.TrialUser);

                if (isTrial)
                {
                    Global.RedirectToPage("/trial");
                }
                else
                {
                    Global.RedirectToHomePage();
                }

                return;
            }

            if (Request.QueryString["username"] != null)
            {
                txtUserName.Value = Request.QueryString["username"];
            }

            if (IsPostBack)
            {
                try
                {
                    int userId;
                    accessHelper
                        .WithUsers(d => d.ActiveUsers)
                        .TryAuthenticate(txtUserName.Value, txtUserPass.Text, out userId);

                    var user = dc.GetUser(userId);
                    user.SessionId = Guid.NewGuid();
                    // skip logging the sessionId change
                    user.SkipAuditTrail = true;

                    using (var auh = new AuditTrailHelper(dc))
                    {
                        auh.Add(new Audit
                        {
                            Id = Guid.NewGuid(),
                            RecordDate = DateTime.Now,
                            UserId = userId,
                            IpAddr = ip,
                            ActionId = (int)AuditAction.LogIn,
                        });
                    }

                    dc.SaveChanges();

                    Response.SetAuthCookie(txtUserName.Value, rememberMeCheckBox.Checked, user.SessionId.ToString());
                    Response.Redirect(FormsAuthentication.GetRedirectUrl(txtUserName.Value, rememberMeCheckBox.Checked), false);
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
        }

    }
}