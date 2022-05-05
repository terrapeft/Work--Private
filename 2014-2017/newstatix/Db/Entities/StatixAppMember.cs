using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using SharedLibrary.SmartScaffolding;
using SharedLibrary.SmartScaffolding.Attributes;

namespace Db
{
    [MetadataType(typeof(StatixAppMemberMetadata))]
    public partial class StatixAppMember
    {
    }

    [ReadOnly(true)]
    [DisplayName("Members")]
    public class StatixAppMemberMetadata
    {
        #region List properties

        [SearchBy]
        [Display(Name = "Exchange", Order = 10)]
        [HideIn(PageTemplate.Details)]
        [ScaffoldPrimaryKey(true)]
        public object ExchangeCode { get; set; }

        [SearchBy]
        [Display(Name = "Company Name", Order = 20)]
        [HideIn(PageTemplate.Details)]
        [Link(Path = typeof(StatixAppMember), DisplayField = "CompanyName", Filter = new[] { "MemberID" },
            Title = "Member Details: ", Title2Field = "CompanyName", Action = "details", DialogWidth = "450", DialogHeight = "470")]
        [UIHint("JavaScriptDialog")]
        public object CompanyName { get; set; }

        [SearchBy]
        [Display(Name = "Exchange Mnemonic", Order = 30)]
        public object ClearingCode { get; set; }

        [SearchBy]
        [Display(Order = 110)]
        public object Phone { get; set; }

        [SearchBy]
        [Display(Name = "Membership Type", Order = 250)]
        public object MemberType1 { get; set; }

        #endregion


        #region Details properties

        [HideIn(PageTemplate.List)]
        [Display(Name = "Address&nbsp;Line&nbsp;1", Order = 70)]
        public object Address1 { get; set; }

        [HideIn(PageTemplate.List)]
        [Display(Name = "Address&nbsp;Line&nbsp;2", Order = 80)]
        public object Address2 { get; set; }

        [HideIn(PageTemplate.List)]
        [Display(Name = "Address&nbsp;Line&nbsp;3", Order = 90)]
        public object Address3 { get; set; }

        [HideIn(PageTemplate.List)]
        [Display(Name = "Address&nbsp;Line&nbsp;4", Order = 100)]
        public object Address4 { get; set; }

        [HideIn(PageTemplate.List)]
        [Display(Order = 120)]
        public object Fax { get; set; }

        [HideIn(PageTemplate.List)]
        [Display(Order = 130)]
        public object Email { get; set; }

        [HideIn(PageTemplate.List)]
        [Display(Order = 140)]
        public object Website { get; set; }

        #endregion


        #region Hide them

        [ScaffoldColumn(false)]
        public object MemberID { get; set; }

        [ScaffoldColumn(false)]
        public object Postcode { get; set; }

        [ScaffoldColumn(false)]
        public object TerritoryCode { get; set; }

        [ScaffoldColumn(false)]
        public object MemberType2 { get; set; }

        [ScaffoldColumn(false)]
        public object MemberType3 { get; set; }

        [ScaffoldColumn(false)]
        public object MemberType4 { get; set; }

        [ScaffoldColumn(false)]
        public object LastUpdated { get; set; }

        #endregion

    }
}
