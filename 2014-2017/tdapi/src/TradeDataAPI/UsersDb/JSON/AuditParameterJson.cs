using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Newtonsoft.Json;

namespace UsersDb.JSON
{
    public class AuditParameterJson
    {
        [JsonProperty("p")]
        public string ParameterName = string.Empty;

        [JsonProperty("o")]
        public string OriginalValue = string.Empty;

        [JsonProperty("n")]
        public string NewValue = string.Empty;

        public override string ToString()
        {
            var format = (!string.IsNullOrEmpty(NewValue) && !string.IsNullOrEmpty(OriginalValue))
                ? ServiceConfig.Original_To_New_Template
                : ServiceConfig.Key_Value_Template;

            var prms = new List<object> { ParameterName };
            if (!string.IsNullOrEmpty(OriginalValue))
                prms.Add(OriginalValue);
            if (!string.IsNullOrEmpty(NewValue))
                prms.Add(NewValue);

            return string.Format(format, prms.ToArray());
        }
    }
}
