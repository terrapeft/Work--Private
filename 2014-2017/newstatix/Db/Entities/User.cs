using System;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations;
using System.Data.Objects.DataClasses;
using Db.AuditTrail;
using SharedLibrary.SmartScaffolding;
using SharedLibrary.SmartScaffolding.Attributes;

namespace Db
{
    [MetadataType(typeof(UserMetadata))]
    public partial class User : IAuditable, ISpecialAction
    {
        public override string ToString()
        {
            return Email;
        }

        public bool SkipSavingEvents { get; set; }
        public bool SkipAuditTrail { get; set; }
        
        public bool IsResourcesAdmin
        {
            get
            {
                return RoleId == 3;
            }
        }
    }

    [ScaffoldTable(true)]
    public class UserMetadata
    {
        [Display(Name = "IP Addresses")]
        public object IPAddresses { get; set; }

        [Display(Name = "User Roles")]
        public object UserRole { get; set; }

        [Display(Name = "Secure By IP Address")]
        public object SecureByIp { get; set; }

        [ScaffoldColumn(false)]
        public string CompanyId { get; set; }

        public string Username { get; set; }

        [ScaffoldColumn(false)]
        public string Salt { get; set; }

        [UIHint("Password")]
        [HideIn(PageTemplate.List | PageTemplate.Details | PageTemplate.CustomerView)]
        public string Password { get; set; }

        [UIHint("Email")]
        public string Email { get; set; }

        public string Notes { get; set; }

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
        [Display(Name = "Effective date")]
        [DataType("DateTime")]
        public string EffectiveDate { get; set; }

        [UIHint("Datetime")]
        [Display(Name = "Expires on")]
        [DataType("DateTime")]
        public string ExpiresDate { get; set; }

        [HideIn(PageTemplate.Insert | PageTemplate.Edit | PageTemplate.CustomerView)]
        public object Audits { get; set; }

        [DisplayName("Is Suspended")]
        public object IsSuspended { get; set; }

        [ScaffoldColumn(false)]
        public object SessionId { get; set; }
    }
}