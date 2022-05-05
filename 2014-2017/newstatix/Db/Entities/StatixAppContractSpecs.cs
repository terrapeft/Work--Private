using System.ComponentModel;
using System.ComponentModel.DataAnnotations;
using SharedLibrary.SmartScaffolding.Attributes;

namespace Db
{
    [MetadataType(typeof(StatixAppContractSpecsMetadata))]
    public partial class StatixAppContractSpec
    {
    }

    [ReadOnly(true)]
    [DisplayName("Contracts")] // some javascript relies on "Contracts" string, if you're going to change it, change also the javascript.
    [AdvancedSearch(/*ExcludeIn = new[] { "Newedge" }*/)]
    public class StatixAppContractSpecsMetadata
    {
        [ScaffoldColumn(false)]
        public object ExchangeCode { get; set; }

        [ScaffoldColumn(false)]
        public object ContractNumber { get; set; }

        [ScaffoldColumn(false)]
        public object ContractName { get; set; }

        [Display(Name = "Ticker&nbsp;Code", Order = 20)]
        public object TickerCode { get; set; }

        [Display(Name = "Future/Option", Order = 30)]
        public object FutureOrOption { get; set; }

        [Display(Name = "Contract&nbsp;Type", Order = 40)]
        public object ContractType { get; set; }

        [Display(Name = "Contract&nbsp;Size", Order = 50)]
        public object ContractSize { get; set; }

        [Display(Name = "Start&nbsp;Date", Order = 60)]
        [DisplayFormat(DataFormatString = "{0:dd/MM/yyyy HH:mm:ss}")]
        public object StartDate { get; set; }

        [ScaffoldColumn(false)]
        public object DelistDate { get; set; }

        [Display(Name = "Base&nbsp;Currency", Order = 70)]
        public object BaseCurrency { get; set; }

        [Display(Name = "Other&nbsp;Unit", Order = 80)]
        public object OtherUnitCode { get; set; }

        [ScaffoldColumn(false)]
        public object ExerciseType { get; set; }

        [Display(Order = 90)]
        public object Delivery { get; set; }

        [Display(Name = "Premium&nbsp;Payment", Order = 100)]
        public object PremiumPayment { get; set; }

        [Display(Order = 110)]
        public object MPF { get; set; }

        [Display(Name = "Tick&nbsp;Value", Order = 120)]
        public object TickValue { get; set; }

        [Display(Name = "Trading&nbsp;Months", Order = 130)]
        public object TradingMonths { get; set; }

        [ScaffoldColumn(false)]
        public object PositionLimitSpot { get; set; }

        [ScaffoldColumn(false)]
        public object PositionLimitMonth { get; set; }

        [ScaffoldColumn(false)]
        public object PositionLimitAllMonths { get; set; }

        [ScaffoldColumn(false)]
        public object PositionLimit { get; set; }

        [ScaffoldColumn(false)]
        public object MarginNotes { get; set; }

        [Display(Name = "Trading&nbsp;Hours", Order = 140)]
        public object TradingHours { get; set; }

        [ScaffoldColumn(false)]
        public object PositionLimitsUpdated { get; set; }

        [ScaffoldColumn(false)]
        public object MarginsUpdated { get; set; }

        [Display(Name = "Contract&nbsp;Spec&nbsp;Last Updated", Order = 30)]
        [DisplayFormat(DataFormatString = "{0:dd/MM/yyyy HH:mm:ss}")]
        public object SpecUpdated { get; set; }

        [ScaffoldColumn(false)]
        public object ExchangeFees { get; set; }

        [ScaffoldColumn(false)]
        public object ExchangeFeesUpdated { get; set; }

        [Display(Name = "ISO&nbsp;MIC", Order = 10)]
        public object ISOMic { get; set; }


    }
}
