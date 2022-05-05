using System.Collections.Generic;
using System.Data;

namespace TradeDataAPI.Converters
{
    /// <summary>
    /// Provides contract for DataTable converters.
    /// </summary>
    public interface IResultConverter
    {
        /// <summary>
        /// Adds the property, specified in the Options method to the ResultSet, specified in the WithResultSet method.
        /// </summary>
        /// <param name="data">The data.</param>
        /// <param name="omitTableNamesNormalization">Skip reordering of indecies on the end of the table name.</param>
        /// <returns></returns>
        void PrepareForSerialization(DataSet data, bool omitTableNamesNormalization);

        /// <summary>
        /// Converts the specified data and returns it in the out parameter.
        /// </summary>
        /// <param name="data">The data.</param>
        /// <param name="result">The result.</param>
        /// <returns></returns>
        bool Convert(DataSet data, out string result);

        /// <summary>
        /// Converts the specified data and returns it in the out parameter.
        /// </summary>
        /// <param name="data">The data.</param>
        /// <param name="filterExpressions">The filter expressions.</param>
        /// <param name="sortExpressions">The sort expressions.</param>
        /// <param name="pageSize">Size of the page.</param>
        /// <param name="pageNumber">The page number.</param>
        /// <param name="result">The result.</param>
        /// <returns></returns>
        bool Convert(DataSet data, List<KeyValuePair<int, string>> filterExpressions, List<KeyValuePair<int, string>> sortExpressions, int pageSize, int pageNumber, out string result);

        /// <summary>
        /// Specifies the property name of the ResultSet where to add the result of the subsequent conversion.
        /// </summary>
        /// <param name="options">The options.</param>
        /// <param name="propertyName">Name of the property.</param>
        /// <returns></returns>
        IResultConverter Options(ConverterOptions options, string propertyName);

        /// <summary>
        /// Instructs to add conversion results to the dynamic object, provided as a parameter.
        /// </summary>
        /// <param name="result">The result.</param>
        /// <returns></returns>
        IResultConverter WithResultSet(dynamic result);


        /// <summary>
        /// Adds the property to the ResultSet, specified in the WithResultSet method.
        /// </summary>
        /// <param name="propertyName">Name of the property.</param>
        /// <param name="propertyValue">The property value.</param>
        void AddProperty(string propertyName, object propertyValue);
    }
}