using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SharedLibrary.JSON
{
    /// <summary>
    /// Contains helper methods related to JSON format.
    /// </summary>
    public class JsonHelper
    {
        /// <summary>
        /// Determines whether the string is valid json.
        /// </summary>
        /// <param name="strInput">The string input.</param>
        /// <returns></returns>
        public static bool IsValidJson(string strInput)
        {
            strInput = CleanUp(strInput);

            return ((strInput.StartsWith("{") && strInput.EndsWith("}")) || //For object
                    (strInput.StartsWith("[") && strInput.EndsWith("]"))); //For array
        }

        /// <summary>
        /// Trims BOM (byte order mark)
        /// </summary>
        /// <param name="strInput">The string input.</param>
        /// <returns></returns>
        public static string CleanUp(string strInput)
        {
            return strInput.Trim().Trim('\uFEFF', '\u200B');
        }
    }
}
