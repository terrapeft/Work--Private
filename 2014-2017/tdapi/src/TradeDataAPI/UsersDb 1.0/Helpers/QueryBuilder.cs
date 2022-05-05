using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;
using System.Threading.Tasks;

namespace UsersDb.Helpers
{
    public class QueryBuilder
    {
        private const string whereConst = " where ";

        /// <summary>
        /// Adds the TOP to select, if specified and build the Where clause.
        /// </summary>
        /// <param name="select">The select.</param>
        /// <param name="parameters">The parameters.</param>
        /// <param name="searchOption">The search option.</param>
        /// <param name="selectTop">The select top.</param>
        /// <returns></returns>
        public static string Select(string select, Dictionary<string, string> parameters, SearchOptions searchOption, JoinWith joinWith, int selectTop = 0)
        {
            if (selectTop > 0)
            {
                var myRegex = new Regex(@"^select", RegexOptions.IgnoreCase);
                return myRegex.Replace(select, @"$& top " + selectTop);
            }

            return select + WhereParametrized(parameters, searchOption, joinWith);
        }

        /// <summary>
        /// Bilds the where clause with specified conditions.
        /// </summary>
        /// <param name="conditions">The conditions.</param>
        /// <param name="joinWith">The join with.</param>
        /// <returns></returns>
        public static string Where(IEnumerable<string> conditions, JoinWith joinWith = JoinWith.Or)
        {
            return whereConst + string.Join(string.Format(" {0} ", joinWith), conditions);
        }

        /// <summary>
        /// Bilds the where clause with the specified conditions.
        /// </summary>
        /// <param name="parameters">The parameters.</param>
        /// <param name="joinWith">The join with.</param>
        /// <returns>Returns where clause for parametrized request, e.g. "where param1 = @param1"</returns>
        public static string WhereParametrized(Dictionary<string, string> parameters, SearchOptions searchOption, JoinWith joinWith)
        {
            return whereConst + string.Join(string.Format(" {0} ", joinWith), parameters.Select(m => m.Key + (searchOption == SearchOptions.Equals ? " = @" : " like @") + m.Key).ToArray());
        }

        /// <summary>
        /// Bilds the where clause condition without "where" keyword.
        /// </summary>
        /// <param name="parameters">The parameters.</param>
        /// <returns></returns>
        public static string Filter(Dictionary<string, List<string>> parameters)
        {
            return string.Join(" and ", parameters
                .Where(p => p.Value.Any())
                .Select(p => "(" + string.Join(" or ", p.Value.Select(v => string.Format("{0}='{1}'", p.Key, v))) + ")"));
        }
    }
}
