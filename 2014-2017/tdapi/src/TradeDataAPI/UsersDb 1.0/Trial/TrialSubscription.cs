using System;
using System.Linq;
using System.Transactions;
using System.Web;
using SharedLibrary.IPAddress;
using SharedLibrary.Passwords;
using UsersDb.DataContext;
using UsersDb.Helpers;

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

        public void AddTrial()
        {
            using (var tran = new TransactionScope())
            using (var dc = new UsersDataContext())
            {
                // generate new password
                var randomPassword = CryptoHelper.GeneratePassword(
                    ServiceConfig.Trial_Password_Length[0],
                    ServiceConfig.Trial_Password_Length[1],
                    ServiceConfig.Trial_Password_Length[2]);

                // this code will be used to verify email
                //var verificationCode = CryptoHelper.GeneratePassword(10, 10, 5);

                // search in current users for email
                var user = dc.Users.Where(u => !u.IsDeleted).FirstOrDefault(u => u.Email.Equals(Email, StringComparison.OrdinalIgnoreCase));

                // create request anyway to record an attempt.
                var request = new SubscriptionRequest
                {
                    RequestTypeId = (int)SubscriptionRequestTypes.Trial,
                    Accepted = false,
                    Notify = false,
                    IsFulfilled = false,
                    EmailSent = DateTime.UtcNow
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

                    dc.SaveChanges();
                }
                else
                {
                    // get user's IP address
                    var ip = IpAddressHelper.GetIPAddress();

                    // country lookup
                    var country = AccessHelper.GetLocationInfo(ip, dc)
                                  ?? dc.Countries.FirstOrDefault(c => c.Code.Equals(ServiceConfig.Trial_Default_Country_Code, StringComparison.OrdinalIgnoreCase));

                    // company is required for any user
                    CompanyName = !string.IsNullOrEmpty(CompanyName) ? CompanyName : string.Format(ServiceConfig.Trial_Company_Name_Template, Email);

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

                    user = new User
                    {
                        Password = pwd,
                        Salt = salt,
                        Username = Email,
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
                    dc.Users.AddObject(user);
                    request.User = user;

                    var trial = new UsersDb.DataContext.Trial
                    {
                        User = user,
                        //VerificationCode = verificationCode,
                        SubscriptionRequest = request
                    };

                    dc.Trials.AddObject(trial);

                    dc.SaveChanges();

                    var verificationUrl = new Uri(
                        new Uri(HttpContext.Current.Request.Url.AbsoluteUri.Replace(HttpContext.Current.Request.Url.AbsolutePath, string.Empty)),
                        string.Format(ServiceConfig.Trial_User_Verification_Link.Replace("~/", string.Empty), user.Username)).ToString();

                    dc.spSendTrialEmail(
                        user.Lastname,
                        ServiceConfig.TradeData_API_Service_URL,
                        ServiceConfig.Trial_Method_For_Email_Links,
                        user.Username,
                        randomPassword,
                        user.Email,
                        verificationUrl,
                        ServiceConfig.Trial_Notification_Email_Template,
                        ServiceConfig.Trial_Notification_Email_Format,
                        ServiceConfig.Trial_SQL_Server_Mail_Profile,
                        "");
                }

                tran.Complete();
            }
        }
    }
}