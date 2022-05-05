using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;
using System.Web;

namespace TradeDataAPI.Helpers
{
    public class UrlQueryParser
    {
        private readonly List<KeyValuePair<int, string>> _filters = new List<KeyValuePair<int, string>>();
        private readonly List<KeyValuePair<int, string>> _sort = new List<KeyValuePair<int, string>>();

        // t(?<table>\d+)\.: stands for table index block like "t1.", "t2."
        // (?:(?<concatenation>\w{2,3})-){0,1}: stands for optional concatenation block, like "or-" or "and-", if found, placed to the named group "concatenation"
        // (?<column>\w+): stands for column name block, which should present
        // (?:-(?<operator>\w+)){0,1}: stands for optional operator block, like "-lt", "-in", "-sort", etc.
        // =(?<value>.+): stands for value
        public static readonly string UrlRegExpr = @"t(?<table>\d+)\.(?:(?<concatenation>\w{2,3})-){0,1}(?<column>\w+)(?:-(?<operator>\w+)){0,1}=(?<value>.+)";

        // same as UrlRegExpr but used to build DataTable for structured parameter to pass to a stored procedure, instead of filtering in the code
        // in theory only this one should survive in future, when all stored procedures are updated for internal paging/filtering
        public static readonly string UrlStatixRegExpr = @"g(?<group>\d+)\.(?:(?<concatenation>\w{2,3})-){0,1}(?<column>\w+)(?:-(?<operator>\w+)){0,1}=(?<value>.+)";

        // look for "and" or "or" at the beginning of the string
        public static readonly string CleanupExpr = @"^\s*(?:and\s){0,1}(?:or\s){0,1}";


        /// <summary>
        /// List of columns, which are available for filtering
        /// </summary>
        public Dictionary<int, IEnumerable<string>> IncludeColumns = new Dictionary<int, IEnumerable<string>>();


        public List<KeyValuePair<int, string>> Filters
        {
            get { return _filters; }
        }

        public List<KeyValuePair<int, string>> Sort
        {
            get { return _sort; }
        }

        public DataTable QueryToTable(string[] args)
        {
            var filtersTable = EnsureFiltersTable(null);

            args
            .Where(a => !string.IsNullOrWhiteSpace(a) && a.Contains('='))
            .Select(a =>
            {
                var m = Regex.Match(a, UrlStatixRegExpr, RegexOptions.IgnoreCase);
                if (m.Success)
                {
                    return new
                    {
                        // each search group has brackets around it in the final SQL
                        SearchGroup = int.Parse(m.Groups["group"].ToString()),
                        Operator = m.Groups["operator"]?.Value ?? string.Empty,
                        Column = m.Groups["column"]?.Value ?? string.Empty,
                        Value = HttpUtility.UrlDecode(m.Groups["value"]?.Value ?? string.Empty),
                        Concatenation = m.Groups["concatenation"]?.Value ?? string.Empty
                    };
                }
                return null;
            })
            .Where(b => b != null)
            .OrderBy(b => b.SearchGroup)
            .ToList()
            .ForEach(r =>
            {
                AddRow(filtersTable, r.SearchGroup, r.Column, InvertOperator(r.Operator), r.Value, InvertConcatenator(r.Concatenation));
            });

            return filtersTable;
        }


        /// <summary>
        /// Builds the query.
        /// </summary>
        /// <returns></returns>
        public UrlQueryParser BuildQuery(string[] args)
        {
            args
                .Where(a => !string.IsNullOrWhiteSpace(a) && a.Contains('='))
                .Select(a =>
                {
                    var m = Regex.Match(a, UrlRegExpr, RegexOptions.IgnoreCase);
                    return new
                    {
                        Table = m.Groups["table"]?.Value ?? string.Empty,
                        Operator = m.Groups["operator"]?.Value ?? string.Empty,
                        Column = m.Groups["column"]?.Value ?? string.Empty,
                        Value = m.Groups["value"]?.Value ?? string.Empty,
                        Sort = m.Groups["sort"]?.Value ?? string.Empty,
                        Concatenation = m.Groups["concatenation"]?.Value ?? string.Empty
                    };
                })
                .GroupBy(b => b.Table)
                .ToList()
                .ForEach(g =>
                {
                    var index = string.IsNullOrEmpty(g.Key) ? 0 : Convert.ToInt32(g.Key);
                    var sbf = new StringBuilder();
                    var sbs = new StringBuilder();

                    g.ToList().ForEach(d =>
                    {
                        if (IncludeColumns.ContainsKey(index) && IncludeColumns[index].Contains(d.Column, StringComparer.OrdinalIgnoreCase))
                        {
                            if (d.Operator.Equals("sort", StringComparison.OrdinalIgnoreCase))
                            {
                                sbs.Append((sbs.Length > 0 ? ", " : string.Empty) + TranslateParameter(d.Concatenation, d.Operator, d.Column, d.Value));
                            }
                            else
                            {
                                sbf.Append(TranslateParameter(d.Concatenation, d.Operator, d.Column, d.Value));
                            }
                        }
                    });

                    if (sbf.Length > 0)
                    {
                        _filters.Add(new KeyValuePair<int, string>(index, Regex.Replace(sbf.ToString(), CleanupExpr, string.Empty)));
                    }

                    if (sbs.Length > 0)
                    {
                        _sort.Add(new KeyValuePair<int, string>(index, Regex.Replace(sbs.ToString(), CleanupExpr, string.Empty)));
                    }
                });

            return this;
        }


        /// <summary>
        /// Adds the row.
        /// </summary>
        /// <param name="table">The table.</param>
        /// <param name="groupId">The group number.</param>
        /// <param name="c0">The column name.</param>
        /// <param name="c1">The comparison operator.</param>
        /// <param name="c2">The column value.</param>
        /// <param name="c3">The concatenator with a next statement.</param>
        /// <returns></returns>
        private DataRow AddRow(DataTable table, int groupId, string c0, string c1, string c2, string c3 = null)
        {
            var row = table.NewRow();

            row[0] = groupId;
            row[1] = c0;
            row[2] = c1;
            row[3] = c2;
            row[4] = c3;

            table.Rows.Add(row);

            return row;
        }

        private DataTable EnsureFiltersTable(DataTable filtersTable)
        {
            if (filtersTable == null)
            {
                filtersTable = new DataTable();
                filtersTable.Columns.Add("GroupId", typeof(int));
                filtersTable.Columns.Add("Column", typeof(string));
                filtersTable.Columns.Add("Operator", typeof(string));
                filtersTable.Columns.Add("Value", typeof(string));
                filtersTable.Columns.Add("AndOr", typeof(string));
            }

            return filtersTable;
        }


        public static string InvertOperator(string sqlCommand)
        {
            switch (sqlCommand)
            {
                case "like":
                    return "like";
                case "nlike":
                    return "not like";
                case "neq":
                    return "<>";
                case "gt":
                    return ">";
                case "gte":
                    return ">=";
                case "lt":
                    return "<";
                case "lte":
                    return "<=";
                case "in":
                    return "in";
                case "notin":
                    return "not in";
                default:
                    return "=";
            }
        }

        public static string InvertConcatenator(string andOr)
        {
            switch (andOr)
            {
                case "or":
                    return "or";
                case "and":
                    return "and";
                default:
                    return string.Empty;
            }
        }

        public static string TranslateOperator(string sqlCommand)
        {
            switch (sqlCommand)
            {
                case "like":
                    return "-like";
                case "not like":
                    return "-nlike";
                case "<>":
                    return "-neq";
                case ">":
                    return "-gt";
                case ">=":
                    return "-gte";
                case "<":
                    return "-lt";
                case "<=":
                    return "-lte";
                case "in":
                    return "-in";
                case "not in":
                    return "-notin";
                case "order by":
                    return "-sort";
                case "or":
                    return "or-";
                case "and":
                    return "and-";
                default:
                    return string.Empty;
            }
        }

        /// <summary>
        /// Builds the SQL expression.
        /// </summary>
        /// <param name="concat">The concat.</param>
        /// <param name="queryStringOperator">The query string operator.</param>
        /// <param name="column">The column.</param>
        /// <param name="value">The value.</param>
        /// <returns></returns>
        private string TranslateParameter(string concat, string queryStringOperator, string column, string value)
        {
            var cnct = string.IsNullOrEmpty(concat) ? string.Empty : " " + concat + " ";

            switch (queryStringOperator)
            {
                case "lt":
                    return cnct + column + " < " + value;
                case "gt":
                    return cnct + column + " > " + value;
                case "lte":
                    return cnct + column + " <= " + value;
                case "gte":
                    return cnct + column + " >= " + value;
                case "in":
                    return cnct + column + " in (" + value.Split(',').Select(v => string.Format("'{0}'", v)).Aggregate((str, v) => str + "," + v) + ")";
                case "notin":
                    return cnct + column + " not in (" + value + ")";
                case "like":
                    return cnct + column + " like '" + value + "'";
                case "sort":
                    return column + " " + value;
                default:
                    return cnct + column + " = '" + value + "'";
            }
        }

    }
}