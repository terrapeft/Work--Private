using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Threading.Tasks;
using System.Transactions;
using System.Web;
using SharedLibrary.Cache;
using SharedLibrary.IPAddress;
using SharedLibrary.Passwords;
using UsersDb.DataContext;
using UsersDb.Helpers;
using Company = UsersDb.DataContext.Company;
using User = UsersDb.DataContext.User;

namespace UsersDb.Trial
{
    public class TrialSubscription
    {
        public string Name { get; set; }
        public string Email { get; set; }
        public string CompanyName { get; set; }
        public string Phone { get; set; }

        public TrialSubscription(string name, string email, string company = null, string phone = null)
        {
            Name = name;
            Email = email;
            CompanyName = company;
            Phone = phone;
        }

        /// <summary>
        /// Activates trial.
        /// </summary>
        /// <param name="user">The user.</param>
        /// <exception cref="System.Exception">The user is invalid.</exception>
        public static void StartTrial(User user)
        {
            using (var dc = new UsersDataContext())
            {
                var trial = dc.Trials.SingleOrDefault(c => c.UserId == user.Id);

                if (trial == null)
                {
                    throw new Exception("The user is invalid.");
                }

                if (trial.TrialStart == null)
                {
                    //user.Permissions.Add(new Permission { Id = (int)UiPermission.AccessCustomerUI });
                    trial.TrialStart = DateTime.UtcNow;
                    trial.TrialEnd = trial.TrialStart.Value.AddDays(ServiceConfig.Trial_Period_In_Days);

                    trial.SubscriptionRequest.IsFulfilled = true;
                    trial.SubscriptionRequest.Accepted = true;

                    dc.SaveChanges();
                }
            }
        }

        /// <summary>
        /// Adds the trial request and trialists to the both users' databases.
        /// Sends notification to the administrator.
        /// </summary>
        /// <returns></returns>
        public User AddTrial()
        {
            User user = null;
            Country country = null;
            string randomPassword = null;

            using (var dc = new UsersDataContext())
            {
                // generate new password
                randomPassword = CryptoHelper.GeneratePassword(
                    ServiceConfig.Trial_Password_Length[0],
                    ServiceConfig.Trial_Password_Length[1],
                    ServiceConfig.Trial_Password_Length[2]);

                // search in current users for email
                user = dc.Users.Where(u => !u.IsDeleted).FirstOrDefault(u => u.Email.Equals(Email, StringComparison.OrdinalIgnoreCase));

                // create request anyway to record an attempt.
                var request = new SubscriptionRequest
                {
                    RequestTypeId = (int)SubscriptionRequestTypes.Trial,
                    Accepted = false,
                    Notify = false,
                    IsFulfilled = false
                    //EmailSent = DateTime.UtcNow
                };

                dc.MethodGroups
                    .Where(m => m.IsTrial)
                    .ToList()
                    .ForEach(request.MethodGroups.Add);

                if (user != null) // decline request
                {
                    request.Accepted = false;
                    request.Comment = Resources.Trial_Email_Exists;
                    request.User = user;
                }
                else
                {
                    // get user's IP address
                    var ip = IpAddressHelper.GetIPAddress();

                    // country lookup
                    country = AccessHelper.GetLocationInfo(ip, dc) ?? dc.Countries.FirstOrDefault(c => c.Code.Equals(ServiceConfig.Trial_Default_Country_Code, StringComparison.OrdinalIgnoreCase));

                    // add company and user to the service's database (Users)
                    user = AddServiceUser(dc, country, randomPassword, request);

                    using (var tran = new TransactionScope(TransactionScopeOption.Suppress))
                    {
                        // do not include this call into transaction, to avoid distributed transactions (may be disabled)
                        // but exception will enforce the transaction to rollback
                        AddUnifiedUser(user, country, randomPassword);

                        tran.Complete();
                    }

                    // this will occur only if tran had no exceptions
                    dc.SaveChanges();

                    var template = dc.EmailTemplates.FirstOrDefault(t => t.Name.Equals("Trial Request", StringComparison.InvariantCultureIgnoreCase));

                    var subj = template.Subject
                        .Replace("{email}", Email)
                        .Replace("{phone}", Phone)
                        .Replace("{name}", Name)
                        .Replace("{company}", CompanyName)
                        .Replace("{username}", Email.ToLower())
                        .Replace("{password}", randomPassword)
                        .Replace("{comment}", request.Comment)
                        .Replace("{id}", request.Id.ToString());

                    var body = template.Body
                        .Replace("{email}", Email)
                        .Replace("{phone}", Phone)
                        .Replace("{name}", Name)
                        .Replace("{company}", CompanyName)
                        .Replace("{username}", Email.ToLower())
                        .Replace("{password}", randomPassword)
                        .Replace("{comment}", request.Comment)
                        .Replace("{id}", request.Id.ToString());

                    dc.spSendTrialNotification(
                        ServiceConfig.Trial_Notification_Subscriber,
                        subj,
                        body);
                }
            }

            return user;
        }

        /// <summary>
        /// Sends the trial email to the user.
        /// </summary>
        public void SendTrialAcceptanceEmail(UsersDataContext context, SubscriptionRequest request)
        {
            var user = context.GetUser(request.UserId);
            var verificationUrl = ServiceConfig.Trial_Activation_Link.Replace("{username}", Email.ToLower());

            var pwd = ((KeyValuePair<string, string>)CacheHelper.Get("userDetails")).Value;

            context.spSendTrialEmail(
                user.Lastname,
                ServiceConfig.TradeData_API_Service_URL,
                ServiceConfig.Trial_Method_For_Email_Links,
                user.Username,
                pwd,
                Email,
                verificationUrl,
                ServiceConfig.Trial_Notification_Email_Template,
                ServiceConfig.Trial_Notification_Email_Format,
                string.Empty,
                string.Empty);
        }

        /// <summary>
        /// Sends the rejection email.
        /// </summary>
        /// <param name="context">The context.</param>
        /// <param name="request">The request.</param>
        /// <exception cref="System.Exception">Invalid user data, cannot send trial notification email.</exception>
        public void SendTrialRejectionEmail(UsersDataContext context, SubscriptionRequest request)
        {
            var template = context.EmailTemplates.FirstOrDefault(t => t.Name.Equals("Trial Declined Email", StringComparison.InvariantCultureIgnoreCase));

            var subj = template.Subject
                .Replace("{email}", Email)
                .Replace("{phone}", Phone)
                .Replace("{name}", Name)
                .Replace("{company}", CompanyName)
                .Replace("{username}", Email.ToLower())
                .Replace("{comment}", request.Comment)
                .Replace("{id}", request.Id.ToString());

            var body = template.Body
                .Replace("{email}", Email)
                .Replace("{phone}", Phone)
                .Replace("{name}", Name)
                .Replace("{company}", CompanyName)
                .Replace("{username}", Email.ToLower())
                .Replace("{comment}", request.Comment)
                .Replace("{id}", request.Id.ToString());

            context.spSendTrialNotification(
                Email,
                subj,
                body);

        }

        /// <summary>
        /// Adds the user to the UnifiedMembers database - TradeDataUsers.
        /// </summary>
        /// <param name="user">The user.</param>
        /// <param name="country">The country.</param>
        /// <param name="randomPassword">The random password.</param>
        private bool AddUnifiedUser(User user, Country country, string randomPassword)
        {
            var connStr = ConfigurationManager.ConnectionStrings["TRADEdataUsers"].ConnectionString;
            var getCompanySql = string.Format(ConfigurationManager.AppSettings["symbols:UnifiedUsers_Company_ByName_Format"], CompanyName);
            var getUserSql = string.Format(ConfigurationManager.AppSettings["symbols:UnifiedUsers_User_ByUsername_Format"], user.Username);
            var getCountrySql = string.Format(ConfigurationManager.AppSettings["symbols:UnifiedUsers_Country_ByCode_Format"], country.Code);

            var companyId = GetDbId(connStr, getCompanySql);
            var userId = GetDbId(connStr, getUserSql);
            var countryId = GetDbId(connStr, getCountrySql);

            using (var dbh = new DbHelper(connStr))
            {
                dbh.Connection.Open();

                if (countryId < 1)
                {
                    getCountrySql = string.Format(ConfigurationManager.AppSettings["symbols:UnifiedUsers_Country_ByCode_Format"], "GB");
                    countryId = GetDbId(connStr, getCountrySql);
                }

                if (companyId < 1)
                {
                    dbh.CallStoredProcedure("spCompanyInsert", new Dictionary<string, object>
                    {
                        {"@name", CompanyName},
                        {"@phone", user.Phone},
                        {"@fax", null},
                        {"@address", null},
                        {"@countryId", countryId}
                    });

                    companyId = GetDbId(connStr, getCompanySql);
                }

                if (userId < 1)
                {
                    dbh.CallStoredProcedure("spUserInsert", new Dictionary<string, object>
                    {
                        {"@companyId", companyId},
                        {"@firstName", user.Firstname},
                        {"@lastName", user.Lastname},
                        {"@userName", user.Username},
                        {"@password", randomPassword},
                        {"@expirationDate", DateTime.Today.AddDays(ServiceConfig.Trial_Period_In_Days)}
                    });
                }
            }

            return true;
        }

        /// <summary>
        /// Adds the user to the TradeData API Services's database - Users.
        /// </summary>
        /// <param name="dc">The dc.</param>
        /// <param name="country">The country.</param>
        /// <param name="randomPassword">The random password.</param>
        /// <param name="request">The request.</param>
        /// <returns></returns>
        private User AddServiceUser(UsersDataContext dc, DataContext.Country country, string randomPassword, SubscriptionRequest request)
        {
            var company = dc.Companies.FirstOrDefault(c => c.Name.Equals(CompanyName, StringComparison.OrdinalIgnoreCase));
            if (company == null)
            {
                company = new Company
                {
                    Name = CompanyName,
                    Country = country
                };

                dc.Companies.AddObject(company);
            }

            // encrypt password
            var ch = new CryptoHelper(Config.Pbkdf2IterationsNumber, Config.SaltLength, Config.HashedPwdLength);
            var salt = ch.CreateSalt();
            var pwd = ch.CreatePasswordHash(randomPassword, salt);

            // This path is hardcoded during installation, we only need to provide the machine name to access the shared folder from different machine
            var logoFile = $@"\\{Environment.MachineName}\MSSQLSRV_ATTACHMENTS\emailLogo.png";

            var user = new User
            {
                Password = pwd,
                Salt = salt,
                Username = Email.ToLower(),
                Lastname = Name,
                Email = Email,
                Phone = Phone,
                Company = company,
                ThresholdPeriod = dc.ThresholdPeriods.FirstOrDefault(t => t.Name.Equals(ServiceConfig.Trial_Default_Threshold_Period, StringComparison.OrdinalIgnoreCase)),
                HitsLimit = ServiceConfig.Trial_Default_Hits_Limit,
                TimeZone = dc.TimeZones.FirstOrDefault(tz => tz.Code.Equals(ServiceConfig.Trial_Default_Time_Zone, StringComparison.OrdinalIgnoreCase)),
                AccountExpirationDate = DateTime.UtcNow.AddDays(ServiceConfig.Trial_Period_In_Days),
                IsActive = true
            };

            user.Roles.Add(dc.Roles.FirstOrDefault(r => r.Id == (int)UserRoles.TrialUser));
            user.Roles.Add(dc.Roles.FirstOrDefault(r => r.Id == (int)UserRoles.Customer));
            dc.Users.AddObject(user);
            request.User = user;

            var trial = new DataContext.Trial
            {
                User = user,
                SubscriptionRequest = request
            };

            dc.Trials.AddObject(trial);

            return user;
        }

        /// <summary>
        /// Gets result from the query.
        /// </summary>
        /// <param name="connStr">The connection string.</param>
        /// <param name="sqlQuery">The SQL query.</param>
        /// <param name="decryptPasswords">Open password key on database side before running query.</param>
        /// <returns></returns>
        private int GetDbId(string connStr, string sqlQuery, bool decryptPasswords = false)
        {
            using (var conn = new SqlConnection(connStr))
            using (var command = new SqlCommand(sqlQuery, conn))
            {
                conn.Open();

                if (decryptPasswords)
                {
                    var cmd = new SqlCommand
                    {
                        Connection = conn,
                        CommandText = "dbo.spOpenPasswordsKey",
                        CommandType = CommandType.StoredProcedure
                    };

                    cmd.ExecuteNonQuery();
                }

                var result = command.ExecuteScalar();
                return (result == DBNull.Value) ? -1 : Convert.ToInt32(result);
            }
        }
    }
}