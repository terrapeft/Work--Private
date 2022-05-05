using System.ComponentModel;
using System.ComponentModel.DataAnnotations;
using SharedLibrary.SmartScaffolding;
using SharedLibrary.SmartScaffolding.Attributes;

namespace UsersDb.DataContext
{
    [MetadataType(typeof(EmailTemplateMetadata))]
    public partial class EmailTemplate : IAuditable
    {
        public IAuditable TrackEntity { get; set; }
    }

    [TableCategory("System Settings")]
    [DisplayName("Email Templates")]
    [RestrictAction(Action = PageTemplate.Insert | PageTemplate.Delete)]
    [ResourceTable]
    public class EmailTemplateMetadata
    {
        [ScaffoldColumn(false)]
        public int Id { get; set; }

        [RegularExpression(@"^[A-Za-z0-9 ]*$", ErrorMessage = "Please use only letters, digits and whitespace.")]
        [ReadOnlyIn(PageTemplate.Edit)]
        public string Name { get; set; }

        [HideIn(PageTemplate.List)]
        public string Subject { get; set; }

        [UIHint("Description")]
        public string Description { get; set; }

        //[HideIn(PageTemplate.List)]
        //[UIHint("File")]
        //[ScaffoldColumn(false)]
        //public string LogoPath { get; set; }

        [DisplayName("Email")]
        [UIHint("EmailTemplate")]
        public string Body { get; set; }
    }
}
