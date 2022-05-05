using Newtonsoft.Json;

namespace SharedLibrary.IPAddress
{
    /// <summary>
    /// JSON serialization support.
    /// </summary>
    public class IpLookupJson
    {
        [JsonProperty("geoplugin_countryName")]
        public string CountryName;

        [JsonProperty("geoplugin_countryCode")]
        public string CountryCode;
    }
}