using System.ComponentModel;
using System.ComponentModel.DataAnnotations;
using SharedLibrary.SmartScaffolding.Attributes;

namespace Db
{
    [MetadataType(typeof(StatixAppGlossaryMetadata))]
    public partial class StatixAppGlossary
    {

    }

    [ReadOnly(true)]
    [DisplayName("Glossary")]
    public class StatixAppGlossaryMetadata
    {
        [ScaffoldColumn(false)]
        public object GlossaryID { get; set; }

        [SearchBy]
        [Display(Name = "Item", Order = 10)]
        [ScaffoldPrimaryKey(true)]
        public object GlossaryItem { get; set; }

        [SearchBy]
        [Display(Name = "Description", Order = 20)]
        public object Description { get; set; }
    }
}
