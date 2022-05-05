using System;
using System.Collections.Generic;
using System.Text;
using Newtonsoft.Json;
using System.Linq;
using SharedLibrary;
using UsersDb.Helpers;
using UsersDb.JSON;

namespace UsersDb.Code
{
    /// <summary>
    /// Contains search parameters.
    /// </summary>
    public class SearchParametersJson : JsonBase
    {
        private readonly string kvp = ServiceConfig.Key_Value_Template;


        #region Constructors

        public SearchParametersJson()
        {
            PageSize = ServiceConfig.Search_Results_Page_Size;
            MaxNumberOfSuggestions = ServiceConfig.Prediction_Number_Of_Suggestions;
        }

        public SearchParametersJson(bool setDefaults)
            : this()
        {
            if (setDefaults)
            {
                ComparisonOperator = (SearchOptions)ServiceConfig.Default_Search_Option;
                SearchGroups = ServiceConfig.Default_Search_Groups;
            }
        }

        #endregion


        #region Serializable properties

        [JsonProperty("so")]
        public SearchOptions ComparisonOperator;

        [JsonProperty("sc")]
        public List<string> SearchGroups = new List<string>();

        [JsonProperty("fl")]
        public Dictionary<string, List<string>> Filter = new Dictionary<string, List<string>>();

        [JsonProperty("vc")]
        public List<string> VisibleRootColumns = new List<string>();

        [JsonProperty("svc")]
        public List<string> VisibleSeriesColumns = new List<string>();

        [JsonProperty("s")]
        public string Keyword;

        #endregion


        #region Non-serializable properties

        /// <summary>
        /// Sets the ComparisonOperator by parsing the string value.
        /// </summary>
        /// <value>
        /// The comparison operator setter.
        /// </value>
        [JsonIgnore]
        public string ComparisonOperatorSetter
        {
            set { ComparisonOperator = value.ToEnumByName<SearchOptions>(); }
        }

        [JsonIgnore]
        public ExportParameters Export = new ExportParameters();

        [JsonIgnore]
        public int PageNumber;

        [JsonIgnore]
        public int PageSize;

        [JsonIgnore]
        public int MaxNumberOfSuggestions;

        [JsonIgnore]
        public bool ExportSeries;

        [JsonIgnore]
        public bool CheckSeriesAvailability;

        #endregion


        public override string ToString()
        {
            var sb = new StringBuilder();
            sb.AppendFormat(kvp, MapSearchParameter(Constants.SearchForParam), Keyword);
            sb.AppendFormat(kvp, MapSearchParameter(Constants.SearchOptionParam), ComparisonOperator.ToString().SplitStringOnCaps());

            if (SearchGroups.Any())
                sb.AppendFormat(kvp, MapSearchParameter(Constants.SearchGroupsParam), string.Join(", ", LookupSearchGroups(SearchGroups)));
            
            if (Filter.Any())
                sb.Append(FilterToString(Filter));

            return sb.ToString();
        }

        private object FilterToString(Dictionary<string, List<string>> filter)
        {
            var sb = new StringBuilder("<table>");
            foreach (var f in filter.Where(f => f.Value.Any()))
            {
                var val = string.Join(", ", f.Value);
                sb.AppendFormat(kvp, MapSearchParameter(f.Key), string.IsNullOrWhiteSpace(val) ? "All" : val);
            }

            sb.Append("</table>");

            return sb.ToString();
        }

    }
}