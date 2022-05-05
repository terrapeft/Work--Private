using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations;
using SharedLibrary.SmartScaffolding;
using SharedLibrary.SmartScaffolding.Attributes;
using UsersDb.JSON;

namespace UsersDb.DataContext
{
    [MetadataType(typeof(TrialMetadata))]
    public partial class Trial
    {
        public IAuditable TrackEntity { get; set; }
    }

    [ScaffoldTable(false)]
    [ReadOnly(true)]
    [TableCategory("Users")]
    public class TrialMetadata
    {
        [ScaffoldColumn(false)]
        public object Id { get; set; }

        [DisplayName("Verificatin Code")]
        public string VerificationCode { get; set; }

        [DisplayName("Trial Start")]
        public DateTime TrialStart { get; set; }

        [DisplayName("Trial End")]
        public object TrialEnd { get; set; }

        [Display(Name = "Trial request", AutoGenerateFilter = false)]
        [HideIn(PageTemplate.Insert | PageTemplate.Edit | PageTemplate.CustomerView)]
        [UIHint("SubscriptionRequest")]
        public object SubscriptionRequest { get; set; }

        [HideIn(PageTemplate.Insert | PageTemplate.Edit | PageTemplate.CustomerView)]
        public object User { get; set; }
    }
}

