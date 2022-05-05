using System;
using System.Collections.Generic;
using System.Collections.Specialized;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Umbraco.Web.Security.Providers;

namespace TDUmbracoMembership
{
    public class TDRoleProvider: MembersRoleProvider
    {
        public override void Initialize(string name, NameValueCollection config)
        {
            base.Initialize(name, config);
        }

        public override void AddUsersToRoles(string[] usernames, string[] roleNames)
        {
            base.AddUsersToRoles(usernames, roleNames);
        }

        public override void CreateRole(string roleName)
        {
            base.CreateRole(roleName);
        }

        public override bool DeleteRole(string roleName, bool throwOnPopulatedRole)
        {
            return base.DeleteRole(roleName, throwOnPopulatedRole);
        }

        public override string[] FindUsersInRole(string roleName, string usernameToMatch)
        {
            return base.FindUsersInRole(roleName, usernameToMatch);
        }

        public override string[] GetAllRoles()
        {
            return base.GetAllRoles();
        }

        public override string[] GetRolesForUser(string username)
        {
            return base.GetRolesForUser(username);
        }

        public override string[] GetUsersInRole(string roleName)
        {
            return base.GetUsersInRole(roleName);
        }

        public override bool IsUserInRole(string username, string roleName)
        {
            return base.IsUserInRole(username, roleName);
        }

        public override void RemoveUsersFromRoles(string[] usernames, string[] roleNames)
        {
            base.RemoveUsersFromRoles(usernames, roleNames);
        }

        public override bool RoleExists(string roleName)
        {
            return base.RoleExists(roleName);
        }

    }
}
