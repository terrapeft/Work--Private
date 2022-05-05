using System;
using System.Collections.Generic;
using System.Data;
using System.Dynamic;
using System.Linq;
using System.Web.Script.Serialization;

namespace TradeDataAPI.Converters
{
    using System.Web.UI.WebControls.WebParts;

    using Newtonsoft.Json;

    using UsersDb.Helpers;

    /// <summary>
    /// Converts provided data to JSON format.
    /// </summary>
    public class JsonConverter : DefaultConverter
    {
        private readonly RequestParameters _requestParameters;

        public JsonConverter(RequestParameters requestParameters)
        {
            this._requestParameters = requestParameters;
        }

        /// <summary>
        /// Adds the property, specified in the Options method to the ResultSet, specified in the WithResultSet method.
        /// </summary>
        /// <param name="data">The dataset.</param>
        /// <param name="omitTableNamesNormalization">if set to <c>true</c> [omit table names normalization].</param>
        public override void PrepareForSerialization(DataSet data, bool omitTableNamesNormalization)
        {
            OmitNormalization = omitTableNamesNormalization;
            string result;
            Convert(data, out result);
        }

        /// <summary>
        /// Converts the specified dataset to JSON format.
        /// </summary>
        /// <param name="data">The dataset.</param>
        /// <param name="result">The result of conversion.</param>
        /// <returns></returns>
        public override bool Convert(DataSet data, out string result)
        {
            return Convert(data, null, null, 0, 0, out result);
        }

        /// <summary>
        /// Converts the specified dataset to JSON format.
        /// </summary>
        /// <param name="data">The dataset.</param>
        /// <param name="filterExpressions">The filter expressions.</param>
        /// <param name="sortExpressions">The sort expressions.</param>
        /// <param name="pageSize">Size of the page.</param>
        /// <param name="pageNumber">The page number.</param>
        /// <param name="result">The result of conversion.</param>
        /// <returns></returns>
        public override bool Convert(DataSet data, List<KeyValuePair<int, string>> filterExpressions, List<KeyValuePair<int, string>> sortExpressions, int pageSize, int pageNumber, out string result)
        {
            if (!IsValid(data, out result))
            {
                return false;
            }

            ForceDataSetToUseUnspecifiedDateTime(data);

            var tables = data.Tables.Cast<DataTable>();

            if (filterExpressions != null)
            {
                var list = new List<DataTable>();

                tables.ToList()
                    .ForEach(t =>
                    {
                        var i = data.Tables.IndexOf(t);
                        var filter = GetExpr(filterExpressions, i);
                        var sort = GetExpr(sortExpressions, i);

                        var rows = string.IsNullOrEmpty(filter + sort)
                            ? data.Tables[i].Rows.Cast<DataRow>()
                            : data.Tables[i].Select(filter, sort);

                        if (pageSize > 0 && pageNumber > 0)
                        {
                            rows = rows
                                .Skip(pageSize*(pageNumber - 1))
                                .Take(pageSize);
                        }

                        if (rows.Any())
                        {
                            var table = rows.CopyToDataTable();
                            table.TableName = t.TableName;
                            list.Add(table);
                        }
                    });

                data.Tables.Clear();
                data.Tables.AddRange(list.ToArray());
            }

            if (!OmitNormalization)
                NormalizeTablesNames(data);

            if (ConverterOptions.HasFlag(ConverterOptions.IncludeNamedProperty) && ResultSet != null)
            {
                AddProperty(ConverterNamedProperty, data);
            }
            else
            {
                result = JsonConvert.SerializeObject(data, _requestParameters.SearchParameters.Export.IndentJson ? Formatting.Indented : Formatting.None);
            }

            return true;
        }

        /// <summary>
        /// Converts the ResultSet to JSON string.
        /// </summary>
        public override string ToString()
        {
            return ResultSet != null 
                ? JsonConvert.SerializeObject(ResultSet, _requestParameters.SearchParameters.Export.IndentJson ? Formatting.Indented : Formatting.None)
                : ToStringNotification;
        }
    }
}