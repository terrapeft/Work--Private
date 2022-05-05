using System.Configuration;
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
        private readonly UsersDataContext _dataContext;
        private readonly RequestParameters _requestParameters;

        private IEnumerable<User> UsersSet { get; set; }


        /// <summary>
        /// Defines the set of users to work with in subsequent calls.
        /// </summary>
        /// <param name="predicate">The predicate.</param>
        /// <returns></returns>
        public AccessHelper WithUsers(Func<UsersDataContext, IEnumerable<User>> predicate)
        {
            UsersSet = predicate.Invoke(_dataContext);
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
            _requestParameters = requestParams;
        }

        /// <summary>
        /// Initializes a new instance of the <see cref="AccessHelper"/> class.
        /// </summary>
        /// <param name="dc">The dc.</param>
        public AccessHelper(UsersDataContext dc)
        {
            _dataContext = dc;
            UsersSet = dc.ActiveUsers;
        }

        /// <summary>
        /// Tries to authenticate, when failed raises an exception.
        /// <exception cref="System.IdentityModel.Tokens.SecurityTokenException">Username and password required.</exception><exception cref="System.ServiceModel.FaultException">Wrong username or password.</exception>
        /// </summary>
        /// <returns></returns>
        /// <exception cref="WebFaultException{String}"></exception>
        public AccessHelper TryAuthenticate()
        {
            if (_requestParameters == null)
            {
                throw new WebFaultException<string>(Resources.Error_500, HttpStatusCode.InternalServerError);
            }

            var userId = 0;
            TryAuthenticate(_requestParameters.Username, _requestParameters.Password, out userId);
            _requestParameters.UserId = userId;

            return this;
        }


        /// <summary>
        /// Authenticate user without lock and without notification email.
        /// Used for the SymbolLookup, where user is blocked on some period, instead of deactivating the account.
        /// </summary>
        /// <param name="username">The username.</param>
        /// <param name="password">The password.</param>
        /// <param name="userId">The user identifier.</param>
        /// <exception cref="System.NotImplementedException"></exception>
        public bool SimpleAuthentication(string username, string password, out int userId)
        {
            if (SimpleValidate(username, password, out userId))
            {
                _dataContext.CurrentUserId = userId;
                return true;
            }

            return false;
        }


        /// <summary>
        /// Tries to authenticate, when failed raises an exception.
        /// </summary>
        /// <param name="username">The username.</param>
        /// <param name="password">The password.</param>
        /// <param name="userId">The user's id.</param>
        /// <returns></returns>
        /// <exception cref="WebFaultException{String}"></exception>
        public AccessHelper TryAuthenticate(string username, string password, out int userId)
        {
            bool isLocked;
            userId = Validate(username, password, out isLocked);

            if (isLocked)
            {
                //try
                //{
                //    var eh = new EmailHelper(ServiceConfig.Smtp_Host, ServiceConfig.Smtp_Port, ServiceConfig.Enable_SSL);
                //    var message = eh.ComposeMessage(ServiceConfig.Smtp_Sender, ServiceConfig.Smtp_Recipients,
                //        Resources.Email_Account_Locked_Subject,
                //        Resources.Email_Account_Locked_Body);

                //    eh.SendMailAsync(message);
                //}
                //catch (Exception ex)
                //{
                //    Logger.LogError(ex, true);
                //}
            }
            else
            {
                _dataContext.CurrentUserId = userId;
            }

            _dataContext.SaveChanges();
            return this;
        }

        /// <summary>
        /// Tries to authorize, when failed raises an exception.
        /// </summary>
        /// <returns></returns>
        /// <exception cref="WebFaultException{String}"></exception>
        public AccessHelper TryAuthorize()
        {
            var methods = _dataContext
                .GetUser((int)_requestParameters.UserId)
                .MethodNames
                .ToList();
            var allowedMethod = methods.Any(m => m.ToLower() == _requestParameters.MethodName.ToLower());

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
            if (_requestParameters == null)
            {
                throw new WebFaultException<string>(Resources.Error_500, HttpStatusCode.InternalServerError);
            }

            var user = _dataContext.GetUser((int)_requestParameters.UserId);

            if (user.Hits >= user.HitsLimit && !_dataContext.IsFreeMethod(_requestParameters.MethodName))
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
            bool checkIp;
            if (bool.TryParse(ConfigurationManager.AppSettings["checkIP"], out checkIp) && checkIp)
            {
                var found = (ip != null && _dataContext.IsValidIP(ip.IpOrFirstInRange));

                if (!found)
                {
                    throw new WebFaultException<string>(Resources.Error_403_Restricted_IP, HttpStatusCode.Forbidden);
                }
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
            bool checkIp;

            if (bool.TryParse(ConfigurationManager.AppSettings["checkIP"], out checkIp) && checkIp)
            {
                var found = (ip == null || _dataContext.IsValidIP(ip));

                if (!found)
                {
                    throw new WebFaultException<string>(Resources.Error_403_Restricted_IP, HttpStatusCode.Forbidden);
                }
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
            return _dataContext.CurrentUser.SessionId == sessionToken;
        }

        /// <summary>
        /// Validates the specified username and password without locking the account.
        /// </summary>
        /// <param name="userName">The username to validate.</param>
        /// <param name="password">The password to validate.</param>
        /// <param name="userId">The user identifier.</param>
        /// <returns>
        /// User id.
        /// </returns>
        /// <exception cref="WebFaultException{String}"></exception>
        /// <exception cref="WebFaultException{String}"></exception>
        public bool SimpleValidate(string userName, string password, out int userId)
        {
            userId = 0;

            if (string.IsNullOrEmpty(userName) || string.IsNullOrEmpty(password))
            {
                return false;
            }

            var ch = new CryptoHelper(Config.Pbkdf2IterationsNumber, Config.SaltLength, Config.HashedPwdLength);
            var user = UsersSet.FirstOrDefault(u => string.Equals(u.Username, userName, StringComparison.CurrentCultureIgnoreCase));

            if (user != null)
            {
                if (ch.VerifyPassword(password, user.Password, user.Salt))
                {
                    userId = user.Id;
                    return true;
                }

                // else
                _dataContext.AddFailedAttempt(user);
            }

            return false;
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

            var user = UsersSet.FirstOrDefault(u => u.Username.ToLower() == userName.ToLower());

            if (user != null)
            {
                // VerifyPassword cannot be translated into SQL, so no LINQ
                if (ch.VerifyPassword(password, user.Password, user.Salt))
                {
                    _dataContext.ClearFailedAttempts(user);
                    userId = user.Id;
                    isValid = true;
                }
                else
                {
                    _dataContext.AddFailedAttempt(user);

                    if (user.FailedLoginAttemptsCnt >= ServiceConfig.Max_Login_Attempts)
                    {
                        _dataContext.LockUser(user);
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
            string ipStr;

            try
            {
                ipStr = GetIPAddress();

                // look for ip
                var ip = dc.IPs
                    .ToList()
                    .Select(i => new { Temp = new IP { Ip = i.Ip }, Orig = i })
                    .FirstOrDefault(i => i.Temp.Ip == ipStr || i.Temp.Range.Contains(ipStr));

                // add it if not found
                if (ip != null)
                {
                    if (ip.Orig.IsDeleted)
                        ip.Orig.IsDeleted = false;
                }
                else
                {
                    var ipNew = new IP { Ip = ipStr, IsAllowed = false };
                    dc.IPs.AddObject(ipNew);
                }

                dc.SaveChanges();

                // No geolocation information? Add it!
                if (ip.Orig.GeoLocationCountryId == null)
                {
                    var country = GetLocationInfo(ipStr, dc);
                    if (country != null)
                    {
                        ip.Orig.GeoLocationCountryId = country.Id;
                    }
                }

                return ip.Orig;
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
                                var ip = dc.IPs
                                    .ToList()
                                    .Select(j => new { Temp = new IP { Ip = j.Ip }, Orig = j })
                                    .FirstOrDefault(ii => ii.Temp.Ip == i || ii.Temp.Range.Contains(i));

                                if (ip != null)
                                {
                                    var country = GetLocationInfo(ip.Orig.IpOrFirstInRange, dc);
                                    if (country != null)
                                    {
                                        ip.Orig.GeoLocationCountryId = country.Id;
                                        ip.Orig.SkipAuditTrail = true;
                                        ip.Orig.SkipSavingEvents = true;
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