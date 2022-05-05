using System.Net.Mail;
using System.ServiceModel;
using System.ServiceModel.Channels;
using System.Threading.Tasks;
using Newtonsoft.Json;
using SharedLibrary.IPAddress;
using SharedLibrary.Passwords;
using SharedLibrary.SmtpClient;
using UsersDb.DataContext;
using UsersDb.JSON;

namespace UsersDb.Helpers
{
    using System;
    using System.Collections.Generic;
    using System.Linq;
    using System.Net;
    using System.ServiceModel.Web;
    using System.Web;


    using UsersDb;

    /// <summary>
    /// Do most of the things concerning authentication, autorization and other attendant tasks.
    /// </summary>
    public class AccessHelper
    {
        private readonly UsersDataContext dataContext;
        private readonly RequestParameters requestParameters;

        private IEnumerable<User> usersSet { get; set; }


        /// <summary>
        /// Defines the set of users to work with in subsequent calls.
        /// </summary>
        /// <param name="predicate">The predicate.</param>
        /// <returns></returns>
        public AccessHelper WithUsers(Func<UsersDataContext, IEnumerable<User>> predicate)
        {
            usersSet = predicate.Invoke(dataContext);
            return this;
        }

        /// <summary>
        /// Initializes a new instance of the <see cref="AccessHelper" /> class.
        /// </summary>
        /// <param name="dc">The dc.</param>
        /// <param name="requestParams">The request params.</param>
        public AccessHelper(UsersDataContext dc, RequestParameters requestParams)
            : this(dc)
        {
            this.requestParameters = requestParams;
        }

        /// <summary>
        /// Initializes a new instance of the <see cref="AccessHelper"/> class.
        /// </summary>
        /// <param name="dc">The dc.</param>
        public AccessHelper(UsersDataContext dc)
        {
            this.dataContext = dc;
            usersSet = dc.ActiveUsers;
        }

        /// <summary>
        /// Tries to authenticate, when failed raises an exception.
        /// <exception cref="System.IdentityModel.Tokens.SecurityTokenException">Username and password required.</exception><exception cref="System.ServiceModel.FaultException">Wrong username or password.</exception>
        /// </summary>
        /// <returns></returns>
        /// <exception cref="WebFaultException{String}"></exception>
        public AccessHelper TryAuthenticate()
        {
            if (this.requestParameters == null)
            {
                throw new WebFaultException<string>(Resources.Error_500, HttpStatusCode.InternalServerError);
            }

            var userId = 0;
            this.TryAuthenticate(this.requestParameters.Username, this.requestParameters.Password, out userId);
            this.requestParameters.UserId = userId;

            return this;
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
                        Resources.Email_Account_Locked_Subject,
                        Resources.Email_Account_Locked_Body);

                    eh.SendMailAsync(message);
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
        /// Tries to authorize, when failed raises an exception.
        /// </summary>
        /// <returns></returns>
        /// <exception cref="WebFaultException{String}"></exception>
        public AccessHelper TryAuthorize()
        {
            var methods = this.dataContext
                .GetUser((int)this.requestParameters.UserId)
                .MethodNames
                .ToList();
            var allowedMethod = methods.Any(m => m.ToLower() == this.requestParameters.MethodName.ToLower());

            if (!allowedMethod)
            {
                throw new WebFaultException<string>(Resources.Error_405_Method_Not_Allowed, HttpStatusCode.MethodNotAllowed);
            }

            return this;
        }

        /// <summary>
        /// Verifies the hits count.
        /// </summary>
        /// <returns></returns>
        /// <exception cref="WebFaultException{String}">
        /// </exception>
        public AccessHelper VerifyHitsCount()
        {
            if (this.requestParameters == null)
            {
                throw new WebFaultException<string>(Resources.Error_500, HttpStatusCode.InternalServerError);
            }

            var user = this.dataContext.GetUser((int)this.requestParameters.UserId);

            if (user.Hits >= user.HitsLimit && !dataContext.IsFreeMethod(requestParameters.MethodName))
            {
                var message = string.Format(Resources.Error_403_Exceeds_Hits, user.HitsLimit, user.ThresholdPeriod.Name.ToLower());

                throw new WebFaultException<string>(message, HttpStatusCode.Forbidden);
            }

            return this;
        }

        /// <summary>
        /// Verifies the IP address.
        /// </summary>
        /// <param name="ip">The ip.</param>
        /// <returns></returns>
        /// <exception cref="WebFaultException{String}"></exception>
        public AccessHelper VerifyIP(IP ip)
        {
            var found = (ip != null && this.dataContext.IsValidIP(ip.Ip));

            if (!found)
            {
                throw new WebFaultException<string>(Resources.Error_403_Restricted_IP, HttpStatusCode.Forbidden);
            }

            return this;
        }

        /// <summary>
        /// Verifies the IP address.
        /// </summary>
        /// <param name="ip">The ip.</param>
        /// <returns></returns>
        /// <exception cref="WebFaultException{String}"></exception>
        public AccessHelper VerifyIP(string ip)
        {
            var found = (ip == null || this.dataContext.IsValidIP(ip));

            if (!found)
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

            var ch = new CryptoHelper(Config.Pbkdf2IterationsNumber, Config.SaltLength, Config.HashedPwdLength);

            var user = this.usersSet.FirstOrDefault(u => u.Username.ToLower() == userName.ToLower());

            if (user != null)
            {
                // VerifyPassword cannot be translated into SQL, so no LINQ
                if (ch.VerifyPassword(password, user.Password, user.Salt))
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
        /// Gets the IP of the client and does a location lookup if there is no such information about the IP in the db.
        /// </summary>
        /// <returns></returns>
        public static IP RunIpLookup(UsersDataContext dc)
        {
            var ipStr = "127.0.0.1"; //"212.119.177.5";

            try
            {
                ipStr = GetIPAddress();

                // look for ip
                var ip = dc.IPs.Where(i => !i.IsDeleted).FirstOrDefault(i => i.Ip == ipStr);

                // add it if not found
                if (ip == null)
                {
                    var deleted = dc.IPs.Where(i => i.IsDeleted).FirstOrDefault(i => i.Ip == ipStr);
                    if (deleted != null)
                    {
                        deleted.IsDeleted = false;
                    }
                    else
                    {
                        ip = new IP { Ip = ipStr, IsAllowed = false };
                        dc.IPs.AddObject(ip);
                    }

                    dc.SaveChanges();
                }

                // No geolocation information? Add it!
                if (ip.GeoLocationCountryId == null)
                {
                    var country = GetLocationInfo(ipStr, dc);
                    if (country != null)
                    {
                        ip.GeoLocationCountryId = country.Id;
                    }
                }

                return ip;
            }
            catch (Exception ex)
            {
                Logger.LogError(ex);
            }

            return null;
        }

        /// <summary>
        /// Gets the ip address, first tries from OperationContext, then from ServerVariables, otherwise returns "127.0.0.1".
        /// </summary>
        /// <returns></returns>
        public static string GetIPAddress()
        {
            var ipStr = "127.0.0.1"; //"212.119.177.5";

            try
            {
                if (HttpContext.Current != null)
                {
                    // if user is behind the proxy or load balancer, the HTTP_X_FORWARDED_FOR may contain a list of IPs.
                    // we need the last one in the list, which will stand for the last proxi in the route.
                    // http://www.bugdebugzone.com/2013/09/get-users-ip-address-in-load-balancing.html
                    var ip = (HttpContext.Current.Request.ServerVariables["REMOTE_ADDR"] ?? ipStr)
                        .Split(',')
                        .LastOrDefault();

                    if (ip != null)
                    {
                        return ip.Trim();
                    }
                }

                if (OperationContext.Current != null)
                {
                    var endpoint = OperationContext.Current.IncomingMessageProperties[RemoteEndpointMessageProperty.Name] as RemoteEndpointMessageProperty;
                    if (endpoint != null)
                    {
                        ipStr = endpoint.Address == "::1" ? ipStr : endpoint.Address;
                    }

                    return ipStr;
                }
            }
            catch (Exception ex)
            {
                Logger.LogError(ex);
            }

            return ipStr;
        }

        /// <summary>
        /// Runs the ip lookup asynchronous.
        /// </summary>
        /// <param name="ipList">The ip list.</param>
        /// <param name="dc">The dc.</param>
        public static void RunIpLookupAsync(IEnumerable<string> ipList)
        {
            Task.Factory.StartNew(() =>
            {
                using (var dc = new UsersDataContext())
                {
                    try
                    {
                        ipList.ToList()
                            .ForEach(i =>
                            {
                                var ip = dc.IPs.FirstOrDefault(ii => ii.Ip == i);
                                if (ip != null)
                                {
                                    var country = GetLocationInfo(ip.Ip, dc);
                                    if (country != null)
                                    {
                                        ip.GeoLocationCountryId = country.Id;
                                        ip.SkipAuditTrail = true;
                                        ip.SkipSavingEvents = true;
                                    }
                                }
                            });

                        dc.SaveChanges();
                    }
                    catch (Exception ex)
                    {
                        Logger.LogError(ex);
                    }
                }
            });

            Task.WaitAll();
        }

        /// <summary>
        /// Gets the location information by IP.
        /// </summary>
        /// <param name="ip">The IP.</param>
        /// <param name="dc"></param>
        /// <returns>Modified xml from geolocation service.</returns>
        public static Country GetLocationInfo(string ip, UsersDataContext dc)
        {
            try
            {
                var url = string.Format(ServiceConfig.IP_Lookup_URL, ip);
                IpLookupJson cc;

                using (var webClient = new WebClient())
                {
                    var json = webClient.DownloadString(url);
                    cc = JsonConvert.DeserializeObject<IpLookupJson>(json);
                }

                var country = dc.Countries
                    .FirstOrDefault(c => c.Code.Equals(cc.CountryCode, StringComparison.InvariantCultureIgnoreCase));

                if (country == null && !string.IsNullOrWhiteSpace(cc.CountryCode))
                {
                    country = new Country { Code = cc.CountryCode.ToUpper(), Name = cc.CountryName };
                    dc.Countries.AddObject(country);
                    dc.SaveChanges();
                }

                return country;
            }
            catch (Exception ex)
            {
                Logger.LogError(ex);
            }

            return null;
        }
    }
}