using System.ComponentModel;
using System.ComponentModel.DataAnnotations;
using System.IO;
using SharedLibrary.SmartScaffolding;
using SharedLibrary.SmartScaffolding.Attributes;

namespace Db
{
    [MetadataType(typeof(StatixAppExchangeMetadata))]
    public partial class StatixAppExchange
    {
    }

    [ReadOnly(true)]
    [DisplayName("Exchanges")]
    public class StatixAppExchangeMetadata
    {
        #region List properties

        [Display(Name = "Exchange", Order = 10)]
        [SearchBy]
        [HideIn(PageTemplate.Details)]
        [ScaffoldPrimaryKey(true)]
        [Link(Path = typeof(StatixAppExchange), DisplayField = "ExchangeCode", Filter = new[] { "ExchangeCode" }, 
            Title="Exchange Details: ", Title2Field = "ExchangeCode", Action = "details", DialogWidth = "630", DialogHeight = "600")]
        [UIHint("JavaScriptDialog")]
        public object ExchangeCode { get; set; }

        [Display(Name = "Exchange Name", Order = 20)]
        [SearchBy]
        [HideIn(PageTemplate.Details)]
        public object ExchangeName { get; set; }

        [Display(Name = "Country Name", Order = 30)]
        [SearchBy]
        [HideIn(PageTemplate.Details)]
        public object CountryName { get; set; }

        [Display(Name = "Member", Order = 40)]
        [HideIn(PageTemplate.Details)]
        [Link(Path = typeof(StatixAppMember), Filter = new[] { "ExchangeCode" }, EnableIf = "Member")]
        [UIHint("CustomLink")]
        public object Member { get; set; }

        [Display(Name = "Contracts", Order = 50)]
        [HideIn(PageTemplate.Details)]
        [Link(Path = typeof(StatixAppContract), Filter = new[] { "ExchangeCode" }, EnableIf = "Contracts")]
        [UIHint("CustomLink")]
        public object Contracts { get; set; }

        [Display(Name = "Holidays", Order = 60)]
        [HideIn(PageTemplate.Details)]
        [Link(Path = typeof(StatixAppHoliday), Filter = new[] { "ExchangeCode" }, EnableIf = "Holidays")]
        [UIHint("CustomLink")]
        public object Holidays { get; set; }

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
        [Display(Order = 110)]
        public object Phone { get; set; }

        [HideIn(PageTemplate.List)]
        [Display(Order = 120)]
        public object Fax { get; set; }

        [HideIn(PageTemplate.List)]
        [Display(Order = 125)]
        [UIHint("EmailAddress")]
        public object Email { get; set; }

        [HideIn(PageTemplate.List)]
        [Display(Order = 130)]
        [UIHint("URL")]
        public object Website { get; set; }

        [HideIn(PageTemplate.List)]
        [Display(Name = "Clearing&nbsp;House", Order = 160)]
        public object ClearingHouseName { get; set; }

        [HideIn(PageTemplate.List)]
        [Display(Name = "Treasury&nbsp;Rates", Order = 180)]
        public object TreasuryRates { get; set; }

        [HideIn(PageTemplate.List)]
        [DisplayFormat(DataFormatString = "{0:dd/MM/yyyy HH:mm:ss}")]
        [Display(Name = "Treasury&nbsp;Rates&nbsp;Last&nbsp;Updated", Order = 190)]
        public object TreasuryRatesUpdated { get; set; }

        [HideIn(PageTemplate.List)]
        [Display(Name = "Collateral&nbsp;&&nbsp;Haircuts", Order = 200)]
        public object CollateralAndHaircuts { get; set; }

        [HideIn(PageTemplate.List)]
        [DisplayFormat(DataFormatString = "{0:dd/MM/yyyy HH:mm:ss}")]
        [Display(Name = "Collateral&nbsp;&&nbsp;Haircuts&nbsp;Last Updated", Order = 210)]
        public object CollatHaircutsUpdated { get; set; }

        [HideIn(PageTemplate.List)]
        [Display(Name = "Margin&nbsp;Methods", Order = 170)]
        public object MarginMethods { get; set; }

        [HideIn(PageTemplate.List)]
        [Display(Order = 150)]
        public object Regulator { get; set; }

        [HideIn(PageTemplate.List)]
        [Display(Name = "Trading&nbsp;Methods", Order = 140)]
        public object TradingMethods { get; set; }

        #endregion


        #region Hide them

        [ScaffoldColumn(false)]
        public object ExchangeID { get; set; }

        [ScaffoldColumn(false)]
        public object MIC { get; set; }

        [ScaffoldColumn(false)]
        public object Postcode { get; set; }

        [ScaffoldColumn(false)]
        public object Notes { get; set; }

        #endregion
    }
}
