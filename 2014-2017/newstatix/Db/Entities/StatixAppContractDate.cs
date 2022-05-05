using System.ComponentModel;
using System.ComponentModel.DataAnnotations;
using System.Runtime.Serialization;
using SharedLibrary.SmartScaffolding;
using SharedLibrary.SmartScaffolding.Attributes;

namespace Db
{
    [MetadataType(typeof(StatixAppContractDateMetadata))]
    public partial class StatixAppContractDate
    {
    }

    [ReadOnly(true)]
    [DisplayName("Contract Dates")]
    public class StatixAppContractDateMetadata
    {
        [Display(Name = "Exchange", Order = 5)]
        [HideIn(PageTemplate.Popup)]
        [ScaffoldPrimaryKey(true)]
        [SearchBy]
        public object ExchangeCode { get; set; }

        [Display(Name = "Contract Name", Order = 8)]
        [HideIn(PageTemplate.Popup)]
        [SearchBy]
        public object ContractName { get; set; }

        [Display(Name = "F/O", Order = 9)]
        [HideIn(PageTemplate.Popup)]
        public object FutureOrOption { get; set; }

        [Display(Name = "Trading Date", Order = 10)]
        [DisplayFormat(DataFormatString = "{0:dd MMMM yyyy, dddd}")]
        [HideIn(PageTemplate.Unknown | PageTemplate.List)]
        public object TradingDate { get; set; }

        [Display(Name = "Delivery", Order = 20)]
        [SearchBy]
        public object Settlement { get; set; }

        [Display(Name = "Contract Month", Order = 30)]
        [ScaffoldPrimaryKey(true)]
        [SearchBy]
        public object ContractMonth { get; set; }

        [Display(Name = "Date Type", Order = 40)]
        [ScaffoldPrimaryKey(true)]
        [SearchBy]
        public object DateType { get; set; }

        [Display(Name = "Time", Order = 50)]
        [DisplayFormat(DataFormatString = "{0:HH:mm}")]
        public object TradingDateTime { get; set; }

        [ScaffoldColumn(false)]
        public object EquityOption { get; set; }

        [ScaffoldColumn(false)]
        public object ContractType { get; set; }

        [ScaffoldColumn(false)]
        [Display(Order = 70)]
        public object ContractNumber { get; set; }


    }
}
