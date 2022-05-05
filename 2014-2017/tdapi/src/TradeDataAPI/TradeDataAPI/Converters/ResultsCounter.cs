using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace TradeDataAPI.Converters
{
    using System.Data;

    using UsersDb.Helpers;

    public class ResultsCounter : DefaultConverter
    {
        /// <summary>
        /// Returns number of results.
        /// </summary>
        /// <param name="data">The dataset.</param>
        /// <param name="result">Count.</param>
        /// <returns></returns>
        public override bool Convert(DataSet data, out string result)
        {
            result = data.Tables
                .Cast<DataTable>()
                .Sum(t => t.Rows.Count)
                .ToString();

            return true;
        }

        /// <summary>
        /// Converts the specified data.
        /// </summary>
        /// <param name="data">The data.</param>
        /// <param name="filterExpressions">The filter expressions.</param>
        /// <param name="sortExpressions">The sort expressions.</param>
        /// <param name="pageSize">Size of the page.</param>
        /// <param name="pageNumber">The page number.</param>
        /// <param name="result">The result.</param>
        /// <returns></returns>
        public override bool Convert(DataSet data, List<KeyValuePair<int, string>> filterExpressions, List<KeyValuePair<int, string>> sortExpressions, int pageSize, int pageNumber, out string result)
        {
            result = data.Tables
                .Cast<DataTable>()
                .Sum(t =>
                    {
                        var i = data.Tables.IndexOf(t);
                        var tbl = data.Tables[i];
                        var filter = GetExpr(filterExpressions, i);

                        var rows = !string.IsNullOrEmpty(filter)
                            ? tbl.Select(filter)
                            : tbl.Rows.Cast<DataRow>();

                        return rows.Count();
                    })
                .ToString();

            return true;
        }
    }
}