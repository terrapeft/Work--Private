using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations;
using System.Data.Objects.DataClasses;
using System.Linq;
using SharedLibrary.SmartScaffolding;
using SharedLibrary.SmartScaffolding.Attributes;

namespace UsersDb.DataContext
{
    [MetadataType(typeof(UserMetadata))]
    [ScaffoldTable(true)]
    public partial class User : IAuditable, ISpecialAction
    {
        public string FullName
        {
            get
            {
                return string.IsNullOrEmpty(Middlename)
                    ? string.Format("{0} {1}", Firstname, Lastname)
                    : string.Format("{0} {1} {2}", Firstname, Middlename, Lastname);
            }
        }

        public List<Method> Methods
        {
            get
            {
                var isTrial = Roles.Any(r => r.Id == (int)UserRoles.TrialUser);
                var mg = (new UsersDataContext()).MethodGroups;
                var ms = mg.Where(g => isTrial ? g.IsTrial : g.Shared);
                var sharedMethods = ms.SelectMany(g => g.Methods);

                return Subscriptions
                    .Select(s => s.MethodGroup)
                    .SelectMany(g => g.Methods)
                    .Union(sharedMethods)
                    .Where(m => !m.IsDeleted)
                    .ToList();
            }
        }

        public bool IsNewTrial
        {
            get
            {
                return Roles.Any(r => r.Id == (int)UserRoles.TrialUser) && Trials.Any(t => t.TrialStart == null);
            }
        }

        public List<string> MethodNames
        {
            get
            {
                var isTrial = Roles.Any(r => r.Id == (int)UserRoles.TrialUser);
                var mg = (new UsersDataContext()).MethodGroups;
                var ms = mg.Where(g => isTrial ? g.IsTrial : g.Shared);
                var sharedMethods = ms.SelectMany(g => g.Methods.Where(m => !m.IsDeleted).Select(m => m.Name));

                return Subscriptions
                    .Select(s => s.MethodGroup)
                    .SelectMany(g => g.Methods)
                    .Where(m => !m.IsDeleted)
                    .Select(m => m.Name)
                    .Union(sharedMethods)
                    .ToList();
            }
        }

        public List<Permission> Permissions
        {
            get
            {
                return Roles
                    .SelectMany(r => r.Permissions)
                    .ToList();
            }
        }

        public bool IsResourcesAdmin
        {
            get
            {
                return Permissions.Any(p => p.Id == (int)UiPermission.ResourcesAdmin);
            }
        }

        public string Key
        {
            get
            {
                return Username;
            }
        }

        public override string ToString()
        {
            return FullName;
        }

        public bool SkipSavingEvents { get; set; }
        public bool SkipAuditTrail { get; set; }
    }

    [TableCategory("Users")]
    public class UserMetadata
    {
        //[Display(Order = 1)]
        public string Username { get; set; }

        [ScaffoldColumn(false)]
        public string Salt { get; set; }

        [UIHint("Password")]
        [HideIn(PageTemplate.List | PageTemplate.Details | PageTemplate.CustomerView)]
        public string Password { get; set; }

        [HideIn(PageTemplate.Edit | PageTemplate.Insert)]
        public string Hits { get; set; }

        [UIHint("ReadonlyDate")]
        [Display(Name = "Failed logins")]
        [HideIn(PageTemplate.Insert | PageTemplate.Edit | PageTemplate.CustomerView)]
        public string FailedLoginAttemptsCnt { get; set; }

        [UIHint("ReadonlyDate")]
        [Display(Name = "Last Failure")]
        [DataType("DateTime")]
        [HideIn(PageTemplate.Insert | PageTemplate.Edit | PageTemplate.CustomerView)]
        public string LastFailedAttempt { get; set; }

        [UIHint("Datetime")]
        [Display(Name = "Expires On")]
        [DataType("DateTime")]
        public string AccountExpirationDate { get; set; }

        [Display(Name = "Phone")]
        [UIHint("Phone")]
        public string Phone { get; set; }

        [Display(Name = "Phone Ext")]
        [UIHint("Text")]
        public string PhoneExt { get; set; }

        [Display(Name = "Hits Limit")]
        public string HitsLimit { get; set; }

        [HideIn(PageTemplate.Insert | PageTemplate.Edit | PageTemplate.CustomerView)]
        [Display(Name = "User's log")]
        public EntityCollection<UsageStat> UsageStats { get; set; }

        [Display(Name = "Threshold Period End")]
        public DateTime ThresholdPeriodEnd { get; set; }

        [HideIn(PageTemplate.Insert | PageTemplate.Edit | PageTemplate.CustomerView)]
        public object Audits { get; set; }

        [HideIn(PageTemplate.Insert | PageTemplate.Edit | PageTemplate.CustomerView)]
        [DisplayName("Search Queries")]
        public object UserSearchQueries { get; set; }

        [HideIn(PageTemplate.CustomerView)]
        [FilterUIHint("UserRoleFilter")]
        public object Roles { get; set; }

        [DisplayName("Is Active")]
        public object IsActive { get; set; }

        [DisplayName("First Name")]
        public string Firstname { get; set; }

        [DisplayName("Middle Name")]
        public string Middlename { get; set; }

        [DisplayName("Last Name")]
        public string Lastname { get; set; }

        [DisplayName("Requested packages")]
        [HideIn(PageTemplate.Insert | PageTemplate.Edit | PageTemplate.CustomerView)]
        public object SubscriptionRequests { get; set; }

        [ScaffoldColumn(false)]
        [DisplayName("Trials")]
        [HideIn(PageTemplate.Insert | PageTemplate.Edit | PageTemplate.CustomerView)]
        public object Trials { get; set; }

        [ScaffoldColumn(false)]
        public object SessionId { get; set; }

        [HideIn(PageTemplate.Insert | PageTemplate.Edit)]
        public object Subscriptions { get; set; }

        [ScaffoldColumn(false)]
        [DisplayName("Time Zone")]
        public object TimeZone { get; set; }

        [DisplayName("Deleted")]
        public object IsDeleted { get; set; }
    }
}