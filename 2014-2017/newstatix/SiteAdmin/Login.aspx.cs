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
using SharedLibrary.IPAddress;

namespace AdministrativeUI
{
    public partial class Login : Page
    {
        protected void Page_Load(object sender, EventArgs args)
        {
            Page.Form.DefaultFocus = txtUserName.ClientID;

            var dc = new StatixEntities();
            var ip = IpAddressHelper.GetIPAddress();
            
            var accessHelper = new AccessHelper(dc);

            try
            {
                // general verification for IP, without user
                accessHelper.VerifyAdminIpAddress(ip);
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


            if (IsPostBack)
            {
                try
                {
                    int userId;
                    accessHelper
                        .WithUsers(d => d.Administrators)
                        .TryAuthenticate(txtUserName.Text, txtUserPass.Text, out userId)
                        .VerifyUserIpAddress(ip, userId, true);

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
        }
    }
}