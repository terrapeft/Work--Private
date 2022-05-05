using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Globalization;
using SharedLibrary;
using UsersDb.Code;

namespace UsersDb.Helpers
{
    using System.Collections;
    using System.Linq;
    using System.Text;
    using System.Text.RegularExpressions;
    using System.Web;
    using System.Web.Caching;

    /// <summary>
    /// Basic class for database access.
    /// </summary>
    public class DbHelper : IDisposable
    {
        private SqlCommand cmd;

        public static char[] Digits = { '0', '1', '2', '3', '4', '5', '6', '7', '8', '9' };

        public DbHelper(string connStr)
        {
            if (connStr == null)
            {
                connStr = WorkingDatabase.Instance.GetConnectionString();
            }

            this.Connection = new SqlConnection(connStr);
        }

        #region Public methods

        /// <summary>
        /// Gets the connection.
        /// </summary>
        /// <value>
        /// The connection.
        /// </value>
        public SqlConnection Connection { get; private set; }

        /// <summary>
        /// Calls the stored procedure.
        /// </summary>
        /// <param name="spName">Name of the sp.</param>
        /// <returns></returns>
	    public DataSet CallStoredProcedure(string spName)
        {
            int k;
            return CallStoredProcedure(spName, null, out k);
        }

        /// <summary>
        /// Calls the stored procedure with specified parameters.
        /// Parameters are verified against a database and converted to an appropriate type.
        /// </summary>
        /// <param name="spName">Name of the stored procedure.</param>
        /// <param name="spParamPrefix">The stored procedure parameter prefix.</param>
        /// <param name="parameters">The stored procedure parameters.</param>
        /// <returns>
        /// DataSet with one table.
        /// </returns>
        public DataSet CallStoredProcedure(string spName, string spParamPrefix, Dictionary<string, object> parameters)
        {
            int k;
            return CallStoredProcedure(spName, spParamPrefix, parameters, out k);
        }

        /// <summary>
        /// Calls the stored procedure.
        /// </summary>
        /// <param name="spName">Name of the sp.</param>
        /// <param name="parameters">The parameters.</param>
        /// <param name="returnValue">The return value.</param>
        /// <returns></returns>
        public DataSet CallStoredProcedure(string spName, Dictionary<string, object> parameters, out int returnValue)
        {
            return CallStoredProcedure(spName, string.Empty, parameters, out returnValue);
        }

        /// <summary>
        /// Calls the stored procedure.
        /// </summary>
        /// <param name="spName">Name of the sp.</param>
        /// <param name="parameters">The parameters.</param>
        /// <returns></returns>
        public DataSet CallStoredProcedure(string spName, Dictionary<string, object> parameters)
        {
            int k;
            return CallStoredProcedure(spName, parameters, out k);
        }

        /// <summary>
        /// Calls the stored procedure.
        /// </summary>
        /// <param name="spName">Name of the sp.</param>
        /// <param name="parameter">The parameter.</param>
        /// <param name="listOfValues">The list of values.</param>
        /// <returns></returns>
        public DataSet CallStoredProcedure(string spName, string parameter, List<string> listOfValues)
        {
            var ds = new DataSet();

            using (cmd = new SqlCommand(spName, Connection))
            using (var da = new SqlDataAdapter(cmd))
            {
                cmd.CommandTimeout = Connection.ConnectionTimeout;
                cmd.CommandType = CommandType.StoredProcedure;

                var param = cmd.Parameters.AddWithValue("@" + parameter, listOfValues.ToTable("string"));
                param.SqlDbType = SqlDbType.Structured;

                da.Fill(ds);
            }

            return ds;
        }

        /// <summary>
        /// Calls the stored procedure with specified parameters.
        /// Parameters are verified against a database and converted to an appropriate type.
        /// </summary>
        /// <param name="spName">Name of the stored procedure.</param>
        /// <param name="spParamPrefix">The stored procedure parameter prefix.</param>
        /// <param name="parameters">The stored procedure parameters.</param>
        /// <param name="returnValue">The stored procedure return value.</param>
        /// <returns>
        /// DataSet with one table.
        /// </returns>
        public DataSet CallStoredProcedure(string spName, string spParamPrefix, Dictionary<string, object> parameters, out int returnValue)
        {
            returnValue = 0;
            var ds = new DataSet();

            using (cmd = new SqlCommand(spName, Connection))
            using (var da = new SqlDataAdapter(cmd))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.CommandTimeout = 15;//Connection.ConnectionTimeout;

                if (parameters != null)
                {
                    // the way to use correct parameter types
                    SqlCommandBuilder.DeriveParameters(cmd);

                    foreach (var pair in parameters)
                    {
                        var pname = spParamPrefix + pair.Key;

                        if (cmd.Parameters.Contains(pname))
                        {
                            var prm = cmd.Parameters[pname];
                            var pval = pair.Value;

                            if (prm.DbType == DbType.DateTime || prm.DbType == DbType.DateTime2 || prm.DbType == DbType.Date)
                            {
                                pval = Convert.ToDateTime(pval, CultureInfo.InvariantCulture);
                            }

                            prm.Value = pval;
                        }
                    }

                    // fix a name of Structured parameters, whether or not there is a value
                    cmd.Parameters
                        .Cast<SqlParameter>()
                        .Where(p => p.SqlDbType == SqlDbType.Structured)
                        .ToList()
                        .ForEach(FixStructureName);
                }

                da.Fill(ds);

                if (cmd.Parameters.Contains("@RETURN_VALUE"))
                {
                    returnValue = Convert.ToInt32(cmd.Parameters["@RETURN_VALUE"].Value);
                }
            }

            return ds;
        }

        /// <summary>
        /// Gets the stored procedure parameters.
        /// </summary>
        /// <param name="name">The name.</param>
        /// <param name="direction">The direction.</param>
        /// <returns>Formatted string.</returns>
        public string GetStoredProcedureParametersFormatted(string name, ParameterDirection direction)
        {
            var list = GetStoredProcedureParameters(MethodNameMapper.MethodToStoredProc(name))
                .Where(p => p.Direction == direction)
                .ToList();

            var sb = new StringBuilder();

            sb.Append(name);

            if (list.Count > 0)
            {
                sb.AppendLine(", Input parameters:");

                foreach (var param in list)
                {
                    sb.AppendFormat("\t{0},", param).AppendLine();
                }

                // replace comma at the end with semicolon
                sb.Replace(",", ";", sb.Length - 3, 1).AppendLine();
            }
            else
            {
                sb.AppendLine(";").AppendLine();
            }

            return sb.ToString();
        }

        /// <summary>
        /// Loads metadata of the stored procedure parameters.
        /// </summary>
        /// <param name="name">The name.</param>
        /// <returns></returns>
        public List<FieldMetaData> GetStoredProcedureParameters(string name)
        {
            using (cmd = new SqlCommand(name, Connection))
            {
                cmd.CommandTimeout = Connection.ConnectionTimeout;
                cmd.CommandType = CommandType.StoredProcedure;
                SqlCommandBuilder.DeriveParameters(cmd);

                return cmd.Parameters
                    .Cast<SqlParameter>()
                    .Select(p => new FieldMetaData
                    {
                        Name = p.ParameterName,
                        Size = p.Size,
                        Precision = p.Precision,
                        Scale = p.Scale,
                        IsNullable = p.IsNullable,
                        Type = p.SqlDbType.ToString(),
                        Direction = p.Direction
                    })
                    .ToList();
            }
        }


        /// <summary>
        /// Executes the stored procedure to obtain result sets meta data.
        /// Doesn't read the data.
        /// </summary>
        /// <param name="parameters">The parameters.</param>
        /// <returns></returns>
        public List<List<FieldMetaData>> GetStoredProceduresResultSetsMetaData(RequestParameters parameters)
        {
            var results = new List<List<FieldMetaData>>();

            using (cmd = new SqlCommand(parameters.StoredProcName, Connection))
            {
                cmd.CommandTimeout = Connection.ConnectionTimeout;
                cmd.CommandType = CommandType.StoredProcedure;
                SqlCommandBuilder.DeriveParameters(cmd);

                foreach (var param in parameters.MethodArguments)
                {
                    var spp = cmd.Parameters.Cast<SqlParameter>().FirstOrDefault(p => p.ParameterName == param.SqlParameterName);
                    if (spp != null)
                    {
                        spp.Value = param.ParameterValue;
                    }
                }

                using (var reader = cmd.ExecuteReader(CommandBehavior.KeyInfo))
                {
                    do
                    {
                        var s = reader.GetSchemaTable();
                        if (s != null)
                        {
                            var dict = new List<FieldMetaData>();

                            dict.AddRange(s.Rows
                                .Cast<DataRow>()
                                .Select(col => new FieldMetaData
                                {
                                    TableName = s.TableName,
                                    Name = GetDbString(col["ColumnName"]),
                                    Size = GetDbInt(col["ColumnSize"]),
                                    Precision = GetDbInt(col["NumericPrecision"]),
                                    Scale = GetDbInt(col["NumericScale"]),
                                    IsNullable = GetDbBool(col["AllowDBNull"]),
                                    Type = GetDbString(col["DataTypeName"])
                                }));

                            results.Add(dict);
                        }
                    }
                    while (reader.NextResult());
                }
            }

            return results;
        }


        /// <summary>
        /// Queries the table.
        /// </summary>
        /// <param name="sql">The SQL.</param>
        /// <param name="searchOption">The search option.</param>
        /// <param name="selectTop">The select top.</param>
        /// <param name="parameters">The parameters.</param>
        /// <returns></returns>
        public DataTable GetTable(string sql, SearchOptions searchOption, int selectTop, Dictionary<string, string> parameters)
        {
            var command = QueryBuilder.Select(sql, parameters, searchOption, JoinWith.Or, selectTop);
            var dt = new DataTable();

            using (cmd = new SqlCommand(command, Connection))
            {
                cmd.CommandTimeout = Connection.ConnectionTimeout;
                cmd.CommandType = CommandType.Text;

                foreach (var param in parameters)
                {
                    var p = cmd.Parameters.Add(param.Key, SqlDbType.NVarChar);
                    p.Value = GetComparisonValue(param.Value, searchOption);
                }

                var a = new SqlDataAdapter(cmd);
                a.Fill(dt);
            }

            return dt;
        }

        /// <summary>
        /// Gets the table.
        /// </summary>
        /// <param name="sql">The SQL.</param>
        /// <returns></returns>
        public DataTable GetTable(string sql)
        {
            var dt = new DataTable();

            using (cmd = new SqlCommand(sql, Connection))
            {
                cmd.CommandTimeout = Connection.ConnectionTimeout;
                cmd.CommandType = CommandType.Text;
                var a = new SqlDataAdapter(cmd);
                a.Fill(dt);
            }

            return dt;
        }

        /// <summary>
        /// Adds wildcards accordingly to the search option.
        /// </summary>
        /// <param name="val">The original value.</param>
        /// <param name="searchOption">The search option.</param>
        /// <returns></returns>
        public string GetComparisonValue(string val, SearchOptions searchOption)
        {
            var searchVal = val.Replace("[", "[[]");
            searchVal = searchVal.Replace("%", "[%]");
            searchVal = searchVal.Replace("_", "[_]");

            switch (searchOption)
            {
                case SearchOptions.StartsWith:
                    return string.Format("{0}%", searchVal);
                case SearchOptions.EndsWith:
                    return string.Format("%{0}", searchVal);
                case SearchOptions.Contains:
                    return string.Format("%{0}%", searchVal);
                default:
                    return string.Format("{0}", searchVal);
            }

            return null;
        }

        /// <summary>
        /// Closes the connection.
        /// </summary>
        public void Dispose()
        {
            if (Connection != null)
            {
                this.Connection.Close();
            }
        }

        #endregion


        #region Static methods

        /// <summary>
        /// Creates the unique table name with trailing index.
        /// </summary>
        /// <param name="tables">The tables.</param>
        /// <param name="currentTable">The current table.</param>
        /// <returns></returns>
        public static string GetTableName(List<string> tables, string currentTable)
        {
            var regEx = new Regex(@"\D+(?<index>\d+)");
            var root = currentTable.TrimEnd(Digits);
            var namesakes = tables.Where(t => t.StartsWith(root)).ToList();
            var maxIndex = namesakes.Any()
                ? namesakes
                    .Select(n => regEx.Match(n).Groups["index"].Value)
                    .Select(n => string.IsNullOrEmpty(n) ? -1 : System.Convert.ToInt32(n))
                    .Max(i => i)
                : -1;

            return root + ++maxIndex;
        }

        /// <summary>
        /// Determines whether the specified column type is bool.
        /// </summary>
        /// <param name="columnType">Type of the column.</param>
        /// <returns></returns>
        public static bool IsBool(SqlDbType columnType)
        {
            return columnType == SqlDbType.Bit;
        }

        /// <summary>
        /// Determines whether the specified column type is text.
        /// </summary>
        /// <param name="columnType">Type of the column.</param>
        /// <returns></returns>
        public static bool IsText(SqlDbType columnType)
        {
            return columnType == SqlDbType.Char
                 || columnType == SqlDbType.NChar
                 || columnType == SqlDbType.NText
                 || columnType == SqlDbType.NVarChar
                 || columnType == SqlDbType.Text
                 || columnType == SqlDbType.VarChar;
        }

        /// <summary>
        /// Determines whether the specified column type is numeric.
        /// </summary>
        /// <param name="columnType">Type of the column.</param>
        /// <returns></returns>
        public static bool IsNumeric(SqlDbType columnType)
        {
            return columnType == SqlDbType.TinyInt
                      || columnType == SqlDbType.BigInt
                      || columnType == SqlDbType.Decimal
                      || columnType == SqlDbType.Int
                      || columnType == SqlDbType.SmallInt;
        }

        /// <summary>
        /// Determines whether the specified column type is date.
        /// </summary>
        /// <param name="columnType">Type of the column.</param>
        /// <returns></returns>
        public static bool IsDate(SqlDbType columnType)
        {
            return columnType == SqlDbType.Date
                      || columnType == SqlDbType.DateTime
                      || columnType == SqlDbType.DateTime2
                      || columnType == SqlDbType.SmallDateTime
                      || columnType == SqlDbType.Time;
        }

        /// <summary>
        /// Gets string from the DataRow.
        /// </summary>
        /// <param name="val">The val.</param>
        /// <returns>Returns value or empty string if there is no value.</returns>
        public static string GetDbString(object val)
        {
            return (val == null || val == DBNull.Value) ? string.Empty : val.ToString();
        }

        /// <summary>
        /// Gets int from the DataRow.
        /// </summary>
        /// <param name="val">The val.</param>
        /// <returns>Returns value or zero if there is no value.</returns>
        public static int GetDbInt(object val)
        {
            return (val == null || val == DBNull.Value) ? 0 : Convert.ToInt32(val);
        }

        /// <summary>
        /// Gets bool from the DataRow.
        /// </summary>
        /// <param name="val">The val.</param>
        /// <returns>Returns value or false if there is no value.</returns>
        public static bool GetDbBool(object val)
        {
            return (val != null && val != DBNull.Value) && Convert.ToBoolean(val);
        }

        #endregion


        #region Private methods

        /// <summary>
        /// Fixes the name of the structured parameter.
        /// This is the SqlCommandBuilder bug: http://stackoverflow.com/questions/9921121/unable-to-access-table-variable-in-stored-procedure
        /// </summary>
        /// <param name="prm">The PRM.</param>
        private void FixStructureName(SqlParameter prm)
        {
            var parts = prm.TypeName.Split('.');
            if (parts.Length == 3)
            {
                prm.TypeName = parts[1] + "." + parts[2];
            }
        }

        #endregion
    }
}