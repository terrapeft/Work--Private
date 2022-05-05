using System;
using System.Net;
using System.ServiceModel.Web;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using Db;
using Db.AuditTrail;
using Db.Helpers;
using Db.Json;
using SharedLibrary.Elmah;
using SharedLibrary;
using SharedLibrary.IPAddress;

namespace Statix
{
    public partial class Login : Page
    {
        private StatixEntities dc;
        private string ip;

        protected void Page_Load(object sender, EventArgs args)
        {
            Page.Form.DefaultFocus = txtUserName.ClientID;
            try
            {
                dc = new StatixEntities();
                ip = IpAddressHelper.GetIPAddress();

                WebActivityLogger.Write(Request, Page.Theme);
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
                        Values = (new AuditParameterJson { ParameterName = "Requested URL", OriginalValue = Request.RawUrl }).AsJsonArray(),
                        ActionId = (int)AuditAction.ForbiddenIpAddress,
                    });

                    dc.SaveChanges();
                }

                throw;
            }

            if (HttpContext.Current.User.Identity.IsAuthenticated)
            {
                Response.Redirect("/", false);
                return;
            }

            if (Page.Theme != "General")
            {
                FormsAuthentication.RedirectFromLoginPage("unknown", true);
            }
        }

        protected void btnSubmit_OnClick(object sender, EventArgs e)
        {
            try
            {
                int userId;
                new AccessHelper(dc)
                    .WithUsers(d => d.ActiveUsers)
                    .TryAuthenticate(txtUserName.Text, txtUserPass.Text, out userId)
                    .VerifyUserIpAddress(ip, userId)
                    .RunIPAddrLookup(ip);

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

                    dc.SaveChanges();
                }

                Response.SetAuthCookie(txtUserName.Text, rememberMeCheckBox.Checked, user.SessionId.ToString());
                Response.Redirect(FormsAuthentication.GetRedirectUrl(txtUserName.Text, rememberMeCheckBox.Checked),
                    false);
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
            }
        }

        protected void btnSignUp_OnClick(object sender, EventArgs e)
        {
            try
            {
                Response.Redirect("/Register.aspx");
            }
            catch (Exception ex)
            {
                Logger.LogError(ex);
            }
        }
    }
}