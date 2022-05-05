using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Text;
using Newtonsoft.Json;
using SharedLibrary;

namespace TradeDataAPI.Converters
{
    using UsersDb;
    using UsersDb.Helpers;

    /// <summary>
    /// Converts provided data to comma-separated CSV format.
    /// </summary>
    public class CsvConverter : DefaultConverter
    {
        private const string Quote = "\"";
        private const string EscapedQuote = "\"\"";
        private static readonly char[] CharactersThatMustBeQuoted = { '"', '\n' };

        private readonly RequestParameters _requestParameters;

        public CsvConverter(RequestParameters requestParameters)
        {
            _requestParameters = requestParameters;
        }

        /// <summary>
        /// Adds the property, specified in the Options method to the ResultSet, specified in the WithResultSet method.
        /// </summary>
        /// <param name="data">The dataset.</param>
        /// <param name="omitTableNamesNormalization">Skip reordering of indecies on the end of the table name.</param>
        public override void PrepareForSerialization(DataSet data, bool omitTableNamesNormalization)
        {
            string result;
            OmitNormalization = omitTableNamesNormalization;
            Convert(data, out result);
        }

        /// <summary>
        /// Converts the specified data.
        /// </summary>
        /// <param name="data">The data.</param>
        /// <param name="result">The result.</param>
        /// <returns></returns>
        public override bool Convert(DataSet data, out string result)
        {
            return Convert(data, null, null, 0, 0, out result);
        }

        /// <summary>
        /// Converts the specified dataset to comma-separated CSV.
        /// </summary>
        /// <param name="data">The dataset.</param>
        /// <param name="filterExpressions">The filter expression.</param>
        /// <param name="sortExpressions">The sort expression.</param>
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

            if (ConverterOptions.HasFlag(ConverterOptions.IncludeNamedProperty) && ResultSet != null)
            {
                AddProperty(ConverterNamedProperty, data);
            }
            else
            {
                var sb = SerializeDataSet(data, filterExpressions, sortExpressions, pageSize, pageNumber);
                result = sb.ToString();
            }
            
            return true;
        }

        private StringBuilder SerializeDataSet(DataSet data, List<KeyValuePair<int, string>> filterExpressions, List<KeyValuePair<int, string>> sortExpressions, int pageSize, int pageNumber)
        {
            if (!OmitNormalization)
                NormalizeTablesNames(data);

            var sb = new StringBuilder();

            for (var k = 0; k < data.Tables.Count; k++)
            {
                var tbl = data.Tables[k];

                if (data.Tables.Count > 1)
                {
                    sb.AppendLine($"[{tbl.TableName}]");
                }

                var filter = GetExpr(filterExpressions, k);
                var sort = GetExpr(sortExpressions, k);

                var rows = !string.IsNullOrEmpty(filter + sort)
                    ? tbl.Select(filter, sort)
                    : tbl.Rows.Cast<DataRow>();

                if (pageSize > 0 && pageNumber > 0)
                {
                    rows = rows
                        .Skip(pageSize * (pageNumber - 1))
                        .Take(pageSize);
                }

                if (_requestParameters.SearchParameters.Export.Csv.ShowColumnNames)
                {
                    var columnNames = tbl.Columns
                        .Cast<DataColumn>()
                        .Select(column => column.ColumnName);

                    sb.AppendLine(string.Join(_requestParameters.SearchParameters.Export.Csv.Delimiter, columnNames));
                }

                foreach (var field in rows.Select(row => row.ItemArray.Select(f => Escape(f.ToString()))))
                {
                    sb.AppendLine(string.Join(_requestParameters.SearchParameters.Export.Csv.Delimiter, field));
                }
            }
            return sb;
        }


        /// <summary>
        /// Escapes the specified string to provide valid csv.
        /// </summary>
        /// <param name="s">The string value.</param>
        /// <returns>Escaped and/or quoted string.</returns>
        private string Escape(string s)
        {
            if (s.Contains(Quote))
            {
                s = s.Replace(Quote, EscapedQuote);
            }

            if (s.IndexOfAny(CharactersThatMustBeQuoted) > -1 || s.Contains(_requestParameters.SearchParameters.Export.Csv.Delimiter) || _requestParameters.SearchParameters.Export.Csv.ForceQuotes)
            {
                s = Quote + s + Quote;
            }

            return s;
        }

        /// <summary>
        /// Converts the ResultSet to JSON string.
        /// </summary>
        public override string ToString()
        {
            if (ResultSet != null)
            {
                var data = new DataSet();

                // add tables
                GetProperties()
                    .ToList().ForEach(kvp =>
                    {
                        if (kvp.Value is DataSet)
                        {
                            var ds = (DataSet)kvp.Value;
                            ds.MoveTablesToNewDataSet(data);
                        }
                        else if (kvp.Value is DataTable)
                        {
                            var dt = (DataTable) kvp.Value;
                            dt.DataSet.MoveTableToNewDataSet(data, dt);
                        }
                        else
                        {
                            var dt = new DataTable(kvp.Key);
                            dt.Columns.Add(new DataColumn("Value"));
                            var r = dt.NewRow();
                            r[0] = kvp.Value.ToString();
                            dt.Rows.Add(r);
                            data.Tables.Add(dt);
                        }
                    });

                return SerializeDataSet(data, null, null, 0, 0).ToString();
            }

            return ToStringNotification;
        }
    }
}