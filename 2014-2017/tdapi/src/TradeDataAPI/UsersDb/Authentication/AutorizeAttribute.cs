using System;
using System.Configuration;
using System.Data.Objects;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Security.Authentication;
using System.Threading;
using System.Threading.Tasks;
using System.Web;
using System.Web.Http;
using System.Web.Http.Controllers;
using System.Web.Http.Filters;
using System.Web.Security;
using SharedLibrary.IPAddress;
using UsersDb.DataContext;

namespace UsersDb.Authentication
{

    /// <summary>
    /// Attribute for use with Web API actions.
    /// </summary>
    public class AutorizeAttribute : ActionFilterAttribute
    {
        private readonly string _permission;
        private readonly string _authCookie;

        public AutorizeAttribute(string permission, string authCookie)
        {
            _permission = permission;
            _authCookie = authCookie;
        }

        public override void OnActionExecuting(HttpActionContext actionContext)
        {
            var userName = actionContext.RequestContext.Principal.Identity.Name;
            var dc = new UsersDataContext();

            try
            {
                // check IP address 
                string ip;
                if (!VerifyIpAddr(dc, out ip))
                {
                    FormsAuthentication.SignOut();
                    SharedLibrary.Elmah.Logger.LogError(new AccessViolationException($"The '{actionContext.ActionDescriptor.ActionName}' method requested from the forbidden IP address '{ip}'."));
                    throw new HttpResponseException(HttpStatusCode.Forbidden);
                }

                // find user
                var user = dc.Users
                    .FirstOrDefault(u => u.Username.Equals(userName, StringComparison.OrdinalIgnoreCase));

                if (user == null || !user.Roles.SelectMany(r => r.Permissions)
                    .Any(p => p.Name.Equals(_permission, StringComparison.OrdinalIgnoreCase)))
                {
                    FormsAuthentication.SignOut();
                    throw new HttpResponseException(new HttpResponseMessage(HttpStatusCode.Forbidden));
                }

                // check concurrent login
                var sessionGuid = GetSessionGuid();
                var userGuid = user.SessionId;

                var result = userGuid != null && sessionGuid != userGuid;

                if (result)
                {
                    FormsAuthentication.SignOut();
                    throw new HttpResponseException(HttpStatusCode.Forbidden);
                }

            }
            catch (HttpResponseException aex)
            {
                SharedLibrary.Elmah.Logger.LogError(aex);
                throw;
            }
            catch (Exception ex)
            {
                SharedLibrary.Elmah.Logger.LogError(ex);
                throw;
            }

            base.OnActionExecuting(actionContext);
        }

        /// <summary>
        /// Verifies the ip address against the allowed ranges.
        /// </summary>
        /// <param name="dc">The datacontext.</param>
        /// <param name="ip">The ip address to verify.</param>
        /// <returns></returns>
        public static bool VerifyIpAddr(UsersDataContext dc, out string ip)
        {
            ip = "";
            bool checkIp;

            if (bool.TryParse(ConfigurationManager.AppSettings["checkIP"], out checkIp) && checkIp)
            {
                // determine a requsting IP Address
                ip = IpAddressHelper.GetIPAddress();

                if (!string.IsNullOrWhiteSpace(ip))
                {
                    // check in the white list
                    var isValid = new ObjectParameter("isValid", typeof(bool));
                    dc.spIsAllowedIpAddress(ip, isValid);

                    return isValid.Value != DBNull.Value && (bool)isValid.Value;
                }

                return false;
            }

            return true;
        }

        public Guid GetSessionGuid()
        {
            if (HttpContext.Current == null)
                return Guid.Empty;

            var authCookie = HttpContext.Current.Request.Cookies[_authCookie];
            if (authCookie != null)
            {
                var ticket = FormsAuthentication.Decrypt(authCookie.Value);

                if (!string.IsNullOrWhiteSpace(ticket?.UserData))
                {
                    Guid guid;
                    if (Guid.TryParse(ticket.UserData, out guid))
                    {
                        return guid;
                    }
                }
            }

            // if no guid in cookie, then any guid value will force to log out the user.
            return Guid.Empty;
        }
    }
}
