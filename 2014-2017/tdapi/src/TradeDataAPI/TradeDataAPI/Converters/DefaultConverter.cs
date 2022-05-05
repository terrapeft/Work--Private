using System.Collections.Generic;
using System.Data;
using System.Dynamic;
using System.Text.RegularExpressions;
using UsersDb.Helpers;

namespace TradeDataAPI.Converters
{
    using System;
    using System.Linq;

    using UsersDb;

    /// <summary>
    /// Contains basic functionality common for all converters.
    /// </summary>
    public class DefaultConverter : IResultConverter
    {
        protected ConverterOptions ConverterOptions = ConverterOptions.None;

        protected string ConverterNamedProperty;

        protected dynamic ResultSet = null;

        protected const string ToStringNotification = "Run the Convert method";

        protected bool OmitNormalization = false;

        /// <summary>
        /// Determines whether the specified dataset is valid.
        /// </summary>
        /// <param name="data">The dataset.</param>
        /// <param name="errorMessage">The error message.</param>
        /// <returns></returns>
        protected bool IsValid(DataSet data, out string errorMessage)
        {
            errorMessage = string.Empty;

            if (data == null || data.Tables.Count == 0)
            {
                errorMessage = Resources.Dataset_Is_Null_Or_Empty;
                return false;
            }

            if (data.Tables.Cast<DataTable>().All(t => t.Rows.Count == 0))
            {
                errorMessage = Resources.Dataset_No_Tables;
                return false;
            }

            return true;
        }

        /// <summary>
        /// Forces the data set to use unspecified date time to prevent from automatic conversion to local time during serialization.
        /// </summary>
        /// <param name="data">The data.</param>
        protected void ForceDataSetToUseUnspecifiedDateTime(DataSet data)
        {
            var columnsOfInterest = data.Tables
                .Cast<DataTable>()
                .SelectMany(table => table.Columns
                    .Cast<DataColumn>()
                    .Where(item => item.DataType == typeof(DateTime) && item.DateTimeMode == DataSetDateTime.UnspecifiedLocal));

            foreach (var item in columnsOfInterest)
            {
                // this prevents from automatic conversion to local time during serialization
                item.DateTimeMode = DataSetDateTime.Unspecified;
            }
        }

        protected string GetExpr(List<KeyValuePair<int, string>> list, int index)
        {
            return list == null ? string.Empty : list.FirstOrDefault(p => p.Key == index).Value;
        }

        /// <summary>
        /// Normalizes the tables indecies.
        /// </summary>
        /// <param name="data">The data.</param>
        /// <param name="omitZero">Omit zero in table name.</param>
        protected void NormalizeTablesNames(DataSet data, bool omitZero = false)
        {
            var existedTables = data.Tables
                .Cast<DataTable>()
                .Select(t2 => t2.TableName.TrimEnd(DbHelper.Digits))
                .ToList();

            data.Tables
                .Cast<DataTable>()
                .ToList()
                .ForEach(t =>
                {
                    t.TableName = DbHelper.GetTableName(existedTables, t.TableName, omitZero);
                    existedTables.Add(t.TableName);
                });
        }

        /// <summary>
        /// When implemented in derived classes, converts the specified dataset.
        /// </summary>
        /// <param name="data">The dataset.</param>
        /// <param name="result">The result of conversion.</param>
        /// <returns></returns>
        public virtual bool Convert(DataSet data, out string result)
        {
            result = Resources.Not_Implemented_Message;
            return false;
        }

        /// <summary>
        /// Adds the property, specified in the Options method to the ResultSet, specified in the WithResultSet method.
        /// </summary>
        /// <param name="data">The data.</param>
        /// <param name="omitTableNamesNormalization">Skip reordering of indecies on the end of the table name.</param>
        /// <exception cref="System.NotImplementedException"></exception>
        public virtual void PrepareForSerialization(DataSet data, bool omitTableNamesNormalization)
        {
            throw new NotImplementedException();
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
        public virtual bool Convert(DataSet data, List<KeyValuePair<int, string>> filterExpressions, List<KeyValuePair<int, string>> sortExpressions, int pageSize, int pageNumber, out string result)
        {
            result = Resources.Not_Implemented_Message;
            return false;
        }

        public IResultConverter Options(ConverterOptions options, string propertyName)
        {
            ConverterOptions = options;
            ConverterNamedProperty = propertyName;
            return this;
        }

        public IResultConverter WithResultSet(dynamic result)
        {
            ResultSet = result;
            return this;
        }

        public void AddProperty(string propertyName, object propertyValue)
        {
            if (ResultSet != null)
            {
                var dict = (IDictionary<string, object>)ResultSet;
                dict[propertyName] = propertyValue;
            }
        }

        public IEnumerable<KeyValuePair<string, object>> GetProperties()
        {
            return (IEnumerable<KeyValuePair<string, object>>)ResultSet
                ?? new Dictionary<string, object>();
        }

    }
}