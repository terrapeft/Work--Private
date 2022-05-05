using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Globalization;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;

namespace SharedLibrary.Database
{
    /// <summary>
    /// Basic class for database access.
    /// </summary>
    public class DbHelper : IDisposable
    {
        private SqlCommand cmd;

        public static char[] Digits = { '0', '1', '2', '3', '4', '5', '6', '7', '8', '9' };

        /// <summary>
        /// Initializes a new instance of the <see cref="DbHelper"/> class.
        /// </summary>
        /// <param name="connStr">The connection string.</param>
        public DbHelper(string connStr)
        {
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
            object k;
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
            object k;
            return CallStoredProcedure(spName, spParamPrefix, parameters, out k);
        }

        /// <summary>
        /// Calls the stored procedure.
        /// </summary>
        /// <param name="spName">Name of the sp.</param>
        /// <param name="parameters">The parameters.</param>
        /// <param name="returnValue">The return value.</param>
        /// <returns></returns>
        public DataSet CallStoredProcedure(string spName, Dictionary<string, object> parameters, out object returnValue)
        {
            return CallStoredProcedure(spName, "@", parameters, out returnValue);
        }

        /// <summary>
        /// Calls the stored procedure.
        /// </summary>
        /// <param name="spName">Name of the sp.</param>
        /// <param name="parameters">The parameters.</param>
        /// <returns></returns>
        public DataSet CallStoredProcedure(string spName, Dictionary<string, object> parameters)
        {
            object k;
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
        /// <param name="timeout">The timeout.</param>
        /// <returns>
        /// DataSet with one table.
        /// </returns>
        public DataSet CallStoredProcedure(string spName, string spParamPrefix, Dictionary<string, object> parameters, out object returnValue, int? timeout = null)
        {
            returnValue = 0;
            var ds = new DataSet();

            using (cmd = new SqlCommand(spName, Connection))
            using (var da = new SqlDataAdapter(cmd))
            {
                cmd.CommandType = CommandType.StoredProcedure;

                if (timeout != null)
                {
                    cmd.CommandTimeout = timeout.Value;
                }

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
                    returnValue = cmd.Parameters["@RETURN_VALUE"].Value;
                }
            }

            return ds;
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
        /// <param name="omitZero">Do not add zero if no conflict.</param>
        /// <returns></returns>
        public static string GetTableName(List<string> tables, string currentTable, bool omitZero = false)
        {
            var regEx = new Regex(@"\D+(?<index>\d+)");
            var root = currentTable.TrimEnd(Digits);
            var index = regEx.Match(currentTable).Groups["index"].Value;

            var namesakes = tables.Where(t => t.TrimEnd(Digits).Equals(root, StringComparison.OrdinalIgnoreCase)).ToList();
            var maxIndex = namesakes.Any()
                ? namesakes
                    .Select(n => regEx.Match(n).Groups["index"].Value)
                    .Select(n => string.IsNullOrEmpty(n) ? -1 : Convert.ToInt32(n))
                    .Max(i => i)
                : -1;

            //if (omitZero && string.IsNullOrEmpty(index))
            //  return currentTable;

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