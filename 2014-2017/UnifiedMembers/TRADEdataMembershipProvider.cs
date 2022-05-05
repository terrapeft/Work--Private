using System;
using System.Configuration;
using System.Data.Entity.Core.Objects;
using System.Linq;
using System.ServiceModel;
using System.ServiceModel.Channels;
using System.Web;
using System.Web.Security;
using SharedLibrary.IPAddress;
using Umbraco.Web.Security.Providers;

namespace TradeDataUsers
{
    public class TradeDataMembershipProvider : MembersMembershipProvider
    {

        public override bool ValidateUser(string username, string password)
        {
            var users = new TRADEdataUsersEntities();

            bool checkIp;
            string ip = null;
            string siteDns = null;

            if (bool.TryParse(ConfigurationManager.AppSettings["checkIP"], out checkIp) && checkIp)
            {
                ip = IpAddressHelper.GetIPAddress();
                siteDns = HttpContext.Current.Request.Url.DnsSafeHost;
            }

            var userId = new ObjectParameter("userId", typeof(int));
            var isValid = new ObjectParameter("isValid", typeof(bool));
            var retVal = new ObjectParameter("retVal", typeof(int));
            users.AuthenticateUser(username, password, checkIp, ip, siteDns, userId, isValid, retVal);

            var success = isValid.Value != DBNull.Value && (bool)isValid.Value;

            if (!success)
            {
                users.Log(ClientAction.Error, username, $"Error code: {retVal.Value}, {GetCodeTranscript((int)retVal.Value, ip, siteDns)}");
            }

            return success;
        }

        /// <summary>
        /// The auth stored procedure returns error code depending on kind of issue occured during authentication.
        /// Known codes are transcripted here.
        /// </summary>
        /// <param name="status">The stored procedure result code.</param>
        /// <param name="ip">The IP address.</param>
        /// <param name="dns">The DNS.</param>
        /// <returns></returns>
        private string GetCodeTranscript(int status, string ip, string dns)
        {
            switch (status)
            {
                case -1:
                    return $"Invalid host '{dns ?? string.Empty}'";
                case -2:
                    return $"Invalid IP '{ip ?? string.Empty}'";
                case -3:
                    return "Invalid username";
                case -4:
                    return "Invalid password";
                default:
                    return "Unknown code";
            }
        }

        public override MembershipUser GetUser(string username, bool userIsOnline)
        {
            var users = new TRADEdataUsersEntities();
            var user = users.Users.FirstOrDefault(m => m.Username.Equals(username, StringComparison.CurrentCultureIgnoreCase));

            return user == null ? null : CreateMembershipUser(user);
        }

        public override MembershipUser GetUser(object providerUserKey, bool userIsOnline)
        {
            return GetUser(providerUserKey as string, userIsOnline);
        }

        private MembershipUser CreateMembershipUser(User userView)
        {
            var user = new MembershipUser(
                "UmbracoMembershipProvider",
                $"{userView.Firstname} {userView.Lastname}",
                userView.Username,
                string.Empty,
                string.Empty,
                string.Empty,
                true,
                false,
                new DateTime(),
                new DateTime(),
                new DateTime(),
                new DateTime(),
                new DateTime());

            return user;
        }
    }

    public enum ClientAction
    {
        Login,
        SubmitSupportRequest,
        OpenSupportRequest,
        Error,
        Debug
    }
}
