using System.Collections.Generic;
using Newtonsoft.Json;
using UsersDb.Helpers;

namespace UsersDb.Code
{
    public class MethodArgumentsJson
    {
        [JsonProperty("ma")]
        public List<StoredProcParameter> Parameters = new List<StoredProcParameter>();
    }
}