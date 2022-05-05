using System.ComponentModel;
using System.ComponentModel.DataAnnotations;
using SharedLibrary.SmartScaffolding.Attributes;

namespace Db
{
    [MetadataType(typeof(StatixAppContractMetadata))]
    public partial class StatixAppContract
    {
    }

    [ReadOnly(true)]
    [DisplayName("Contracts")] // some javascript relies on "Contracts" string, if you're going to change it, change also the javascript.
    [AdvancedSearch(/*ExcludeIn = new[] { "Newedge" }*/)]
    [Where("it.ContractType <> 'D' and it.ContractType <> 'Z' and it.ContractType <> 'N' and it.ContractType <> 'T'")]
    public class StatixAppContractMetadata
    {
        [ScaffoldColumn(false)]
        public object ContractID { get; set; }

        [Display(Name = "Exchange", Order = 10)]
        [ScaffoldPrimaryKey(true)]
        [SearchBy]
        public object ExchangeCode { get; set; }

        [ScaffoldColumn(false)]
        public object ContractNumber { get; set; }

        [Display(Name = "Contract Name", Order = 20)]
        [SearchBy]
        [Link(Path = typeof(StatixAppContractSpec), DisplayField = "ContractName", Filter = new[] { "ExchangeCode", "ContractNumber" },
            Title = "Contract Details: ", Title2Field = "ContractName", Action = "details", DialogWidth = "640", DialogHeight = "540")]
        [UIHint("JavaScriptDialog")]
        public object ContractName { get; set; }

        [Display(Name = "Ticker", Order = 30)]
        [SearchBy]
        public object TickerCode { get; set; }

        [Display(Name = "ISOMic", Order = 40)]
        [SearchBy]
        public object ISOMic { get; set; }

        [Display(Name = "Started", Order = 50)]
        [DisplayFormat(DataFormatString = "{0:dd/MM/yyyy}")]
        public object StartDate { get; set; }

        [Display(Name = "Delisted", Order = 60)]
        [DisplayFormat(DataFormatString = "{0:dd/MM/yyyy}")]
        public object DelistDate { get; set; }

        [Display(Name = "F/O", Order = 70)]
        [SearchBy]
        public object FutureOrOption { get; set; }

        [ScaffoldColumn(false)]
        public object ContractType { get; set; }

        [Display(Name = "Contract Type", Order = 80)]
        [SearchBy]
        public object ContractTypeDescription { get; set; }

        [ScaffoldColumn(false)]
        public object CycleCode { get; set; }

        [Display(Name = "Volumes", Order = 90)]
        [Link(Display = "View", EnableIf = "Volumes", Path = typeof(StatixAppVolume), Filter = new[] { "ExchangeCode", "ContractNumber" },
            Title = "Contract Volumes, ", Title2Field = "ContractName", DialogWidth = "700", DialogHeight = "570")]
        [UIHint("JavaScriptDialog")]
        public object Volumes { get; set; }

        [Display(Name = "Dates", Order = 100)]
        [Link(Display = "View", EnableIf = "TradingDates", Path = typeof(StatixAppContractDate), Filter = new[] { "ExchangeCode", "ContractNumber" },
            Title = "Contract Trading Dates, ", Title2Field = "ContractName", DialogWidth = "700", DialogHeight = "570")]
        [UIHint("JavaScriptDialog")]
        public object TradingDates { get; set; }

    }
}
