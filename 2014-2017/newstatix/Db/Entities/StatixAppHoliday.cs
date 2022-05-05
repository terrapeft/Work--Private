using System.ComponentModel;
using System.ComponentModel.DataAnnotations;
using SharedLibrary.SmartScaffolding.Attributes;

namespace Db
{
    [MetadataType(typeof(StatixAppHolidayMetadata))]
    public partial class StatixAppHoliday
    {
    }

    [ReadOnly(true)]
    [DisplayName("Holidays")]
    public class StatixAppHolidayMetadata
    {
        [SearchBy]
        [Display(Name = "Exchange", Order = 10)]
        [ScaffoldPrimaryKey(true)]
        public object ExchangeCode { get; set; }

        [Display(Name = "Date", Order = 20)]
        [DisplayFormat(DataFormatString = "{0:dddd, dd MMMM, yyyy}")]
        [ScaffoldPrimaryKey(true)]
        public object HolidayDate { get; set; }

        [SearchBy]
        [Display(Name = "Description", Order = 30)]
        [ScaffoldPrimaryKey(true)]
        public object Description { get; set; }

        [ScaffoldColumn(false)]
        public object ExchangeHolidayID { get; set; }

        [ScaffoldColumn(false)]
        public object ExchangeClosed { get; set; }
    }
}
