using System.Web;
using System.Web.Security;

namespace UsersDb.Helpers
{
    public class SsoHelper
    {
        /// <summary>
        /// Sign out and abandon current Session.
        /// </summary>
        public static void Logout()
        {
            FormsAuthentication.SignOut();

            // this will propagate to Session_End handler in Global.asax.cs where the Sessionid of the user will be cleared
            HttpContext.Current?.Session?.Abandon();
        }
    }
}