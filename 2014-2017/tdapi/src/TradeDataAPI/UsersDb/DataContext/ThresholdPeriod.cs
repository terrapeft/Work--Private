using System.ComponentModel;
using System.ComponentModel.DataAnnotations;
using SharedLibrary.SmartScaffolding.Attributes;

namespace UsersDb.DataContext
{
    [MetadataType(typeof(ThresholdPeriodMetadata))]
	public partial class ThresholdPeriod : IAuditable
	{
		public string Key
		{
			get { return Name; }
		}

		public override string ToString()
		{
			return Name;
		}
	}

    [ScaffoldTable(true)]
	[TableCategory("Service Data", "Lookup tables")]
	[DisplayName("Threshold Period")]
	public class ThresholdPeriodMetadata
	{
        [ScaffoldColumn(false)]
        public object Users { get; set; }

        [DisplayName("Repeat times")]
        public object HowLong { get; set; }

        [DisplayName("Date Format")]
        public object DatePart { get; set; }

        [ScaffoldColumn(false)]
        [DisplayName("Deleted")]
        public object IsDeleted { get; set; }
    }
}
