using System.Collections.Generic;
using System.Data;
using System.Text;
using AutoMapper.Internal;
using SharedLibrary;

namespace UsersDb.Code
{
    public static class ExtensionMethods
    {
        #region SearchOptions enum
        /// <summary>
        /// Converts string to string.
        /// </summary>
        /// <param name="value">The value.</param>
        /// <returns></returns>
        public static string ValueToString(this SearchOptions value)
        {
            return ((int)value).ToString();
        }

        /// <summary>
        /// Converts string to string.
        /// </summary>
        /// <param name="value">The value.</param>
        /// <returns></returns>
        public static string NameToString(this SearchOptions value)
        {
            return value.ToString().SplitStringOnCaps();
        }


        /// <summary>
        /// Merges the data from the specified columns to the string.
        /// </summary>
        /// <param name="row">The row.</param>
        /// <param name="columns">The columns.</param>
        /// <returns></returns>
        public static string Merge(this DataRow row, IEnumerable<string> columns)
        {
            var sb = new StringBuilder();
            foreach (var column in columns)
            {
                sb.Append(row[column].ToStringOrEmpty());
                sb.Append(" ");
            }

            return sb.ToString();
        }


        #endregion
    }
}
