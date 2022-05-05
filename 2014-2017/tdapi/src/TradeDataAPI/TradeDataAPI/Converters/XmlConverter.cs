using System.Collections.Generic;
using System.Data;
using SharedLibrary;
using UsersDb.Helpers;

namespace TradeDataAPI.Converters
{
    using System;
    using System.Linq;

    /// <summary>
    /// Converts provided data to XML format.
    /// </summary>
    public class XmlConverter : DefaultConverter
    {
        /// <summary>
        /// Adds the property, specified in the Options method to the ResultSet, specified in the WithResultSet method.
        /// </summary>
        /// <param name="data">The dataset.</param>
        /// <param name="omitTableNamesNormalization">if set to <c>true</c> [omit table names normalization].</param>
        /// <returns></returns>
        public override void PrepareForSerialization(DataSet data, bool omitTableNamesNormalization)
        {
            string result;
            OmitNormalization = omitTableNamesNormalization;
            Convert(data, out result);
        }

        /// <summary>
        /// Converts the specified dataset to XML format.
        /// </summary>
        /// <param name="data">The dataset.</param>
        /// <param name="result">The result of conversion.</param>
        /// <returns></returns>
        public override bool Convert(DataSet data, out string result)
        {
            return Convert(data, null, null, 0, 0, out result);
        }

        /// <summary>
        /// Converts the specified dataset to XML format.
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

            ForceDataSetToUseUnspecifiedDateTime(data);

            if (ConverterOptions.HasFlag(ConverterOptions.IncludeNamedProperty) && ResultSet != null)
            {
                AddProperty(ConverterNamedProperty, data);
            }
            else
            {
                SerializeDataSet(data, filterExpressions, sortExpressions, pageSize, pageNumber);
                result = data.GetXml();
            }

            return true;
        }

        private DataSet SerializeDataSet(DataSet data, List<KeyValuePair<int, string>> filterExpressions, List<KeyValuePair<int, string>> sortExpressions, int pageSize, int pageNumber)
        {
            if (filterExpressions != null)
            {
                var list = new List<DataTable>();

                data.Tables
                    .Cast<DataTable>()
                    .ToList()
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
                                .Skip(pageSize * (pageNumber - 1))
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

            return data;
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
                            var dt = (DataTable)kvp.Value;
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

                return SerializeDataSet(data, null, null, 0, 0).GetXml();
            }

            return ToStringNotification;
        }
    }
}