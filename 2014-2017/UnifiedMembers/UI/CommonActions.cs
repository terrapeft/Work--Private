using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using SharedLibrary.Database;

namespace TradeDataUsers.UI
{
    public class CommonActions
    {
        /// <summary>
        /// Func to load decrypted user's password.
        /// </summary>
        public static Func<string, KeyValuePair<string, string>> LoadTdUserDetails = (connectionStr) =>
        {
            var connStr = ConfigurationManager.ConnectionStrings[connectionStr].ConnectionString;
            using (var dc = new TRADEdataUsersEntities())
            {
                var username = dc.CurrentUser?.Username;

                if (username == null) 
                    return new KeyValuePair<string, string>();

                using (var dbh = new DbHelper(connStr))
                {
                    dbh.Connection.Open();
                    var userData = dbh.CallStoredProcedure("spUserDetails", new Dictionary<string, object> { { "username", username } });

                    if (userData == null || userData.Tables.Count == 0 || userData.Tables[0].Rows.Count == 0)
                    {
                        throw new Exception("Invalid user data.");
                    }

                    var pwd = userData.Tables[0].Rows[0]["Password"].ToString();

                    return new KeyValuePair<string, string>(username, pwd);
                }
            }
        };
    }
}
