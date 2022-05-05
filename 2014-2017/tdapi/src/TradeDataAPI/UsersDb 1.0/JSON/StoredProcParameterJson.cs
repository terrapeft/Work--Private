using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Newtonsoft.Json;
using UsersDb.Code;
using UsersDb.JSON;

namespace UsersDb.Helpers
{
	/// <summary>
	/// Keeps required info about stored procedure parameter.
	/// </summary>
	public class StoredProcParameterJson : JsonBase
	{
		/// <summary>
		/// Gets or sets the name of the parameter.
		/// Represents the name in format usable for URL request.
		/// </summary>
		[JsonProperty("p")]
		public string ParameterName { get; set; }

		/// <summary>
		/// Gets the SQL name of the parameter.
		/// </summary>
		[JsonIgnore]
        public string SqlParameterName { get { return WorkingDatabase.Instance.GetStoredProcParamPrefix() + ParameterName; } }

        /// <summary>
        /// Gets or sets the parameter value.
        /// </summary>
        [JsonProperty("v")]
		public string ParameterValue { get; set; }

        public override string ToString()
        {
            return string.IsNullOrEmpty(ParameterValue) 
                ? string.Empty 
                : String.Format(ServiceConfig.Key_Value_Template,
                    MapSearchParameter(ParameterName),
                    MapSearchValue(ParameterName, ParameterValue));
        }

	}
}
