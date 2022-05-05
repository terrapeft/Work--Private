using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations;
using SharedLibrary.SmartScaffolding;
using SharedLibrary.SmartScaffolding.Attributes;
using UsersDb.Code;
using UsersDb.Helpers;

namespace UsersDb.DataContext
{
    [MetadataType(typeof(UsageStatMetadata))]
    [ScaffoldTable(true)]
    public partial class UsageStat
    {
        public string StoredProcFriendlyName
        {
            get
            {
                var parts = Method.Name.Split('.');
                return WorkingDatabase.Instance.GetStoredProcMethodPrefix() + (parts.Length == 1 ? parts[0] : parts[1])
                    .Replace(WorkingDatabase.Instance.GetStoredProcPrefix(), string.Empty);
            }
        }

        public string DataFormat
        {
            get { return ((ResultType)DataFormatId).ToString(); }
        }
    }

    [ReadOnly(true)]
    [DisplayName("Usage statistics")]
    [RestrictAction(Action = PageTemplate.Insert)]
    [TableCategory("Users")]
    public class UsageStatMetadata
    {
        [UIHint("JsonTransform")]
        [JsonType(typeof(List<StoredProcParameterJson>))]
        [DisplayName("Method Arguments")]
        public string MethodArgs { get; set; }

        [OrderBy("DESC")]
        [DisplayName("Request Date")]
        public DateTime RequestDate { get; set; }

        /*[ScaffoldColumn(false)]*/
        public string IpId { get; set; }

        [DisplayName("Http Status")]
        public DateTime HttpStatusCode { get; set; }

        [DisplayName("Error")]
        public string ErrorMessage { get; set; }

        [DisplayName("Duration (sec)")]
        [DisplayFormat(DataFormatString = "{0:#,#0,.00}")]
        public string RequestDuration { get; set; }

        [ScaffoldColumn(false)]
        public int DataFormatId { get; set; }

        [DisplayName("Data Format")]
        public string DataFormat { get; set; }

    }
}