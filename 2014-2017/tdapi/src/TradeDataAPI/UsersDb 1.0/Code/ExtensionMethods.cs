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

        #endregion
    }
}
