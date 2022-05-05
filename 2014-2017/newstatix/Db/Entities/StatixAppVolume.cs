using System;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations;
using SharedLibrary.SmartScaffolding.Attributes;

namespace Db
{
    [MetadataType(typeof(StatixAppVolumeMetadata))]
    public partial class StatixAppVolume
    {
    }

    [ReadOnly(true)]
    [DisplayName("Contract Volumes")]
    [OrderByIt("it.TradingYear DESC, it.TradingMonth DESC")]
    public class StatixAppVolumeMetadata
    {
        [Display(Name = "Year", Order = 10)]
        [ScaffoldPrimaryKey(true)]
        public object TradingYear { get; set; }

        [Display(Name = "Month", Order = 20)]
        [ScaffoldPrimaryKey(true)]
        public object TradingMonth { get; set; }

        [Display(Order = 30)]
        public object Volume { get; set; }

        [Display(Name = "Open Interest", Order = 40)]
        public object OpenInterest { get; set; }

        [Display(Name = "Trading Days", Order = 50)]
        public object TradingDays { get; set; }

        [ScaffoldColumn(false)]
        [Display(Order = 60)]
        public object ExchangeCode { get; set; }

        [ScaffoldColumn(false)]
        [Display(Order = 70)]
        public object ContractNumber { get; set; }
    }
}
