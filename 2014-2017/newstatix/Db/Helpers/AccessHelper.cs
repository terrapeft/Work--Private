using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.ServiceModel.Web;
using System.Threading.Tasks;
using System.Web;
using SharedLibrary.Elmah;
using SharedLibrary.IPAddress;
using SharedLibrary.Passwords;
using SharedLibrary.SmtpClient;

namespace Db.Helpers
{
    /// <summary>
    /// Do most of the things concerning authentication, autorization and other attendant tasks.
    /// </summary>
    public class AccessHelper
    {
        private readonly StatixEntities dataContext;

        private IEnumerable<User> usersSet { get; set; }


        /// <summary>
        /// Defines the set of users to work with in subsequent calls.
        /// </summary>
        /// <param name="predicate">The predicate.</param>
        /// <returns></returns>
        public AccessHelper WithUsers(Func<StatixEntities, IEnumerable<User>> predicate)
        {
            usersSet = predicate.Invoke(dataContext);
            return this;
        }

        /// <summary>
        /// Initializes a new instance of the <see cref="AccessHelper"/> class.
        /// </summary>
        /// <param name="dc">The dc.</param>
        public AccessHelper(StatixEntities dc)
        {
            this.dataContext = dc;
            usersSet = dc.Users;
        }

        /// <summary>
        /// Tries to authenticate, when failed raises an exception.
        /// </summary>
        /// <param name="username">The username.</param>
        /// <param name="password">The password.</param>
        /// <param name="userId">The user's id.</param>
        /// <returns></returns>
        /// <exception cref="WebFaultException{String}">
        /// </exception>
        public AccessHelper TryAuthenticate(string username, string password, out int userId)
        {
            bool locked;

            userId = this.Validate(username, password, out locked);

            if (locked)
            {
                try
                {
                    var eh = new EmailHelper(ServiceConfig.Smtp_Host, ServiceConfig.Smtp_Port, ServiceConfig.Enable_SSL);
                    var message = eh.ComposeMessage(ServiceConfig.Smtp_Sender, ServiceConfig.Smtp_Recipients,
                         Resources.Email_Account_Locked_Subject, Resources.Email_Account_Locked_Body);
                    eh.SendMail(message);
                }
                catch (Exception ex)
                {
                    Logger.LogError(ex, true);
                }
            }
            else
            {
                this.dataContext.CurrentUserId = userId;
            }

            this.dataContext.SaveChanges();
            return this;
        }

        /// <summary>
        /// Verifies referrer against values stored for the site.
        /// </summary>
        /// <param name="absoluteUri">The referrer absolute URI.</param>
        /// <param name="siteId">The site identifier.</param>
        public bool IsKnownReferrer(string absoluteUri, int siteId)
        {
            if (dataContext == null)
            {
                throw new WebFaultException<string>(Resources.Error_401_Incorrect_Credentials, HttpStatusCode.ExpectationFailed);
            }

            return (absoluteUri != null && this.dataContext.IsValidSiteIpAddress(absoluteUri, siteId));
        }

        /// <summary>
        /// Verifies the site IP address.
        /// </summary>
        /// <param name="ip">The ip.</param>
        /// <param name="siteId">The site identifier.</param>
        /// <returns></returns>
        /// <exception cref="WebFaultException{String}"></exception>
        public AccessHelper VerifySiteIpAddress(string ip, int siteId)
        {
            if (dataContext == null)
            {
                throw new WebFaultException<string>(Resources.Error_401_Incorrect_Credentials, HttpStatusCode.ExpectationFailed);
            }

            var found = (ip != null && this.dataContext.IsValidSiteIpAddress(ip, siteId));

            if (!found)
            {
                // allow not configured sites to work without IP check
                var site = dataContext.Sites.FirstOrDefault(s => s.Id == siteId);
                if (site == null || !site.IPAddresses.Any())
                    return this;

                throw new WebFaultException<string>(Resources.Error_403_Restricted_IP, HttpStatusCode.Forbidden);
            }

            return this;
        }

        /// <summary>
        /// Verifies the ip address .
        /// </summary>
        /// <param name="ip">The ip.</param>
        /// <returns></returns>
        /// <exception cref="WebFaultException{String}"></exception>
        public AccessHelper VerifyUserIpAddress(string ip)
        {
            if (dataContext == null)
            {
                throw new WebFaultException<string>(Resources.Error_401_Incorrect_Credentials, HttpStatusCode.ExpectationFailed);
            }

            return VerifyUserIpAddress(ip, dataContext.CurrentUserId, false);
        }

        /// <summary>
        /// Verifies the IP address.
        /// </summary>
        /// <param name="ip">The ip.</param>
        /// <param name="userId">The user identifier.</param>
        /// <param name="strict">Ignore user setting SecureByIP if true.</param>
        /// <returns></returns>
        /// <exception cref="WebFaultException{String}"></exception>
        public AccessHelper VerifyUserIpAddress(string ip, int userId, bool strict = false)
        {
            if (dataContext == null)
            {
                throw new WebFaultException<string>(Resources.Error_401_No_Credentials, HttpStatusCode.ExpectationFailed);
            }

            var found = (ip != null && this.dataContext.IsValidUserIpAddress(ip, userId, strict));

            if (!found)
            {
                throw new WebFaultException<string>(Resources.Error_403_Restricted_IP, HttpStatusCode.Forbidden);
            }

            return this;
        }

        /// <summary>
        /// Verifies the IP address to allow access for administrator.
        /// </summary>
        /// <param name="ip">The ip.</param>
        /// <returns></returns>
        /// <exception cref="WebFaultException{String}">
        /// </exception>
        public AccessHelper VerifyAdminIpAddress(string ip)
        {
            if (dataContext == null)
            {
                throw new WebFaultException<string>(Resources.Error_401_No_Credentials, HttpStatusCode.ExpectationFailed);
            }

            if (!dataContext.IPAddresses.Any(a => a.IsAdminIp && a.IsAllowed && a.IPAddr == ip))
            {
                throw new WebFaultException<string>(Resources.Error_403_Restricted_IP, HttpStatusCode.Forbidden);
            }

            return this;
        }

        /// <summary>
        /// Determines whether the session token is up to date.
        /// </summary>
        /// <param name="sessionToken">The session token.</param>
        /// <returns></returns>
        public bool IsSessionTokenUpToDate(Guid sessionToken)
        {
            if (dataContext == null || dataContext.CurrentUserId == 0)
                return false;

            return dataContext.CurrentUser.SessionId == sessionToken;
        }

        /// <summary>
        /// Validates the specified username and password.
        /// </summary>
        /// <param name="userName">The username to validate.</param>
        /// <param name="password">The password to validate.</param>
        /// <param name="userHasBeenLocked">True if user has been locked during the method excution.</param>
        /// <returns>
        /// User id.
        /// </returns>
        /// <exception cref="WebFaultException{String}">
        /// </exception>
        public int Validate(string userName, string password, out bool userHasBeenLocked)
        {
            var userId = 0;
            userHasBeenLocked = false;

            if (string.IsNullOrEmpty(userName) || string.IsNullOrEmpty(password))
            {
                throw new WebFaultException<string>(
                    string.Format(Resources.Error_401_No_Credentials, HttpContext.Current.Request.Url.Scheme, HttpContext.Current.Request.Url.Host),
                    HttpStatusCode.Unauthorized);
            }

            var isValid = false;
            var cr = new CryptoHelper();
            var user = this.usersSet.FirstOrDefault(u => u.Username != null && String.Equals(u.Username, userName, StringComparison.OrdinalIgnoreCase)) ??
                       this.usersSet.FirstOrDefault(u => u.Email != null && String.Equals(u.Email, userName, StringComparison.OrdinalIgnoreCase));

            if (user != null)
            {
                if (cr.VerifyPassword(password, user.Password, user.Salt))
                {
                    this.dataContext.ClearFailedAttempts(user);
                    userId = user.Id;
                    isValid = true;
                }
                else
                {
                    this.dataContext.AddFailedAttempt(user);

                    if (user.FailedLoginAttemptsCnt >= ServiceConfig.Max_Login_Attempts)
                    {
                        this.dataContext.LockUser(user);
                        userHasBeenLocked = true;
                    }
                }
            }

            if (!isValid)
            {
                throw new WebFaultException<string>(Resources.Error_401_Incorrect_Credentials, HttpStatusCode.Unauthorized);
            }

            return userId;
        }

        /// <summary>
        /// Runs the IP address lookup.
        /// </summary>
        /// <param name="ipAddr">The ip addr.</param>
        public void RunIPAddrLookup(string ipAddr)
        {
            LookupHelper.RunIpLookupAsync(new[] { ipAddr });
        }
    }
}