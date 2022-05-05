using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Text.RegularExpressions;
using SharedLibrary;
using SpansLib.Db;

namespace SpansLib.Data.PositionalFormats.RecordReaders
{
    public class BaseRecordReader : IRecordReader
    {
        private string _recType;
        protected RecordTableName RecordTableName;
        protected static Regex DecimalRegEx = new Regex(@"decimal\((?<precision>\d+),(?<scale>\d+)");

        public string RecordType
        {
            get { return _recType; }
        }

        public Dictionary<string, int> HouseOfParents { get; set; }

        /// <summary>
        /// Gets the named values.
        /// </summary>
        /// <value>
        /// The named values.
        /// </value>
        public List<KeyValuePair<string, dynamic>> NamedValues { get; private set; }

        /// <summary>
        /// Parses the specified line number.
        /// </summary>
        /// <param name="line">The line.</param>
        /// <param name="recordDefinitions">The record definitions.</param>
        public virtual void Parse(string line, IEnumerable<RecordDefinition> recordDefinitions)
        {
            _recType = line.Substring(0, 2).Trim();
            NamedValues = recordDefinitions
                .Where(d => d.RecordType == _recType)
                .Where(d => !string.IsNullOrEmpty(d.ColumnName))
                .OrderBy(d => d.StartPosition)
                .Select(d => new KeyValuePair<string, dynamic>(d.ColumnName, GetValue(line, d)))
                .ToList();
        }

        /// <summary>
        /// Reads value from string and converts it to a specified type.
        /// </summary>
        /// <param name="line">The line.</param>
        /// <param name="d">The d.</param>
        /// <returns></returns>
        protected virtual dynamic GetValue(string line, RecordDefinition d)
        {
            if (d.StartPosition > line.Length)
                return DBNull.Value;

            // get a string from the line
            var strVal = line.Substring(d.StartPosition - 1, Math.Min(d.FieldLength, line.Length - (d.StartPosition - 1))).Trim();
            dynamic dVal = strVal;

            // now convert it
            if (!string.IsNullOrEmpty(strVal))
            {
                if (d.DataType.StartsWith(Constants.TypeNvarchar, StringComparison.OrdinalIgnoreCase))
                {
                    if (string.IsNullOrEmpty(dVal))
                    {
                        if (!string.IsNullOrEmpty(d.DefaultValue))
                        {
                            dVal = d.DefaultValue;
                        }
                        else
                        {
                            dVal = DBNull.Value;
                        }
                    }
                }
                else if (d.DataType.StartsWith(Constants.TypeInt, StringComparison.OrdinalIgnoreCase))
                {
                    int val;
                    if (int.TryParse(strVal, out val))
                    {
                        dVal = val;
                    }
                    else if (int.TryParse(d.DefaultValue, out val))
                    {
                        dVal = val;
                    }
                    else
                    {
                        dVal = DBNull.Value;
                    }
                }
                else if (d.DataType.StartsWith(Constants.TypeBigint, StringComparison.OrdinalIgnoreCase))
                {
                    long val;
                    if (long.TryParse(strVal, out val))
                    {
                        dVal = val;
                    }
                    else if (long.TryParse(d.DefaultValue, out val))
                    {
                        dVal = val;
                    }
                    else
                    {
                        dVal = DBNull.Value;
                    }
                }
                else if (d.DataType.StartsWith(Constants.TypeDecimal, StringComparison.OrdinalIgnoreCase))
                {
                    decimal val;
                    var decStrVal = strVal;

                    var match = DecimalRegEx.Match(d.DataType.Replace(" ", string.Empty));
                    if (match.Success)
                    {
                        var precision = int.Parse(match.Groups["precision"].Value);
                        var scale = int.Parse(match.Groups["scale"].Value);

                        // insert the dot
                        if (decStrVal.Length > precision - scale)
                            decStrVal = strVal.Substring(0, precision - scale) + CultureInfo.CurrentCulture.NumberFormat.NumberDecimalSeparator + strVal.Substring(precision - scale);
                    }

                    if (decimal.TryParse(decStrVal, out val))
                    {
                        dVal = val;
                    }
                    else if (decimal.TryParse(d.DefaultValue, out val))
                    {
                        dVal = val;
                    }
                    else
                    {
                        dVal = DBNull.Value;
                    }
                }
                else if (d.DataType.StartsWith(Constants.TypeReal, StringComparison.OrdinalIgnoreCase))
                {
                    double val;
                    var decStrVal = strVal.EnsureDecimalSeparator();

                    if (double.TryParse(decStrVal, out val))
                    {
                        dVal = val;
                    }
                    else if (double.TryParse(d.DefaultValue, out val))
                    {
                        dVal = val;
                    }
                    else
                    {
                        dVal = DBNull.Value;
                    }
                }
                else if (d.DataType.StartsWith(Constants.TypeDate, StringComparison.OrdinalIgnoreCase))
                {
                    DateTime val;
                    if (DateTime.TryParseExact(strVal, d.DateFormat, CultureInfo.InvariantCulture, DateTimeStyles.None, out val))
                    {
                        dVal = val;
                    }
                    else if (DateTime.TryParseExact(d.DefaultValue, d.DateFormat, CultureInfo.InvariantCulture, DateTimeStyles.None, out val))
                    {
                        dVal = val;
                    }
                    else
                    {
                        dVal = DBNull.Value;
                    }
                }
                else if (d.DataType.StartsWith(Constants.TypeTime, StringComparison.OrdinalIgnoreCase))
                {
                    DateTime val;
                    if (DateTime.TryParseExact(strVal, d.DateFormat, CultureInfo.InvariantCulture, DateTimeStyles.None, out val))
                    {
                        dVal = val.TimeOfDay;
                    }
                    else if (DateTime.TryParseExact(d.DefaultValue, d.DateFormat, CultureInfo.InvariantCulture, DateTimeStyles.None, out val))
                    {
                        dVal = val;
                    }
                    else
                    {
                        dVal = DBNull.Value;
                    }
                }
            }

            return dVal;
        }
    }
}
