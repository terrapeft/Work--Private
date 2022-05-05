using System;
using System.Collections.Specialized;
using System.Linq;
using System.Web.Configuration;
using System.Web.Security;
using Umbraco.Core.Models;
using Umbraco.Web.Security.Providers;

namespace TDUmbracoMembership
{
    public class TDMembersMembershipProvider : MembersMembershipProvider
    {

        public override bool ValidateUser(string username, string password)
        {
            var members = new UmbracoMembersEntities();
            var member = members.MemberViews
                .FirstOrDefault(m => m.Username.Equals(username, StringComparison.CurrentCultureIgnoreCase) && m.Password == password);

            if (member != null)
            {
                members.Log(ClientAction.Login, member.MemberId);
            }
            else
            {
                members.Log(ClientAction.Login, username, "Member doesn't exist.");
            }

            return member != null;
        }

        public override MembershipUser GetUser(string username, bool userIsOnline)
        {
            var members = new UmbracoMembersEntities();
            var member = members.MemberViews.FirstOrDefault(m => m.Username.Equals(username, StringComparison.CurrentCultureIgnoreCase));

            return member == null ? null : CreateMembershipUser(member);
        }

        public override MembershipUser GetUser(object providerUserKey, bool userIsOnline)
        {
            return this.GetUser(providerUserKey as string, userIsOnline);
        }

        private MembershipUser CreateMembershipUser(MemberView userView)
        {
            var user = new MembershipUser(
                "UmbracoMembershipProvider",
                string.Format("{0} {1}", userView.Firstname, userView.Lastname),
                userView.Username,
                string.Empty,
                string.Empty,
                string.Empty,
                true,
                true,
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
        Error
    }
}
