using System;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations;
using SharedLibrary.SmartScaffolding.Attributes;

namespace Db
{
    [MetadataType(typeof(FilteredContractTypeMetadata))]
    public partial class FilteredContractType
    {
    }

    [ReadOnly(true)]
    [DisplayName("Contracts by Type")]
    public class FilteredContractTypeMetadata
    {
        [Display(Name = "Contract Type", Order = 10)]
        [Link(Path = typeof(StatixAppContract), Filter = new[] { "ContractType" }, DisplayField = "Description")]
        [UIHint("CustomLink")]
        public object Description { get; set; }

        [ScaffoldColumn(false)]
        public object ContractTypeID { get; set; }

        [ScaffoldColumn(false)]
        public object ContractType { get; set; }

        [ScaffoldColumn(false)]
        public object SFAInstrumentType { get; set; }

        [ScaffoldColumn(false)]
        public object SFADescription { get; set; }
    }
}
