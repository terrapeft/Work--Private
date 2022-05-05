namespace Db
{
    using System;
    using System.Linq;
    using System.Web.Security;

    public class CustomRoleProvider : RoleProvider
    {
        private string applicationName;

        /// <summary>
        /// Determines whether the user is in role.
        /// </summary>
        /// <param name="userIdentity">The user identity could be username or email.</param>
        /// <param name="roleName">Name of the role.</param>
        public override bool IsUserInRole(string userIdentity, string roleName)
        {
            using (var usersContext = new StatixEntities())
            {
                var user = usersContext.Users
                    .SingleOrDefault(u => u.Username == userIdentity || u.Email == userIdentity);
                if (user == null)
                {
                    return false;
                }

                return user.UserRole.Name.Equals(roleName, StringComparison.OrdinalIgnoreCase);
            }
        }

        public override string[] GetRolesForUser(string username)
        {
            using (var usersContext = new StatixEntities())
            {
                var user = usersContext.Users.SingleOrDefault(u => u.Username == username);
                if (user == null)
                {
                    return new string[] { };
                }

                return new[] { user.UserRole.Name };
            }
        }

        public override void CreateRole(string roleName)
        {
            throw new NotImplementedException();
        }

        public override bool DeleteRole(string roleName, bool throwOnPopulatedRole)
        {
            throw new NotImplementedException();
        }

        public override bool RoleExists(string roleName)
        {
            throw new NotImplementedException();
        }

        public override void AddUsersToRoles(string[] usernames, string[] roleNames)
        {
            throw new NotImplementedException();
        }

        public override void RemoveUsersFromRoles(string[] usernames, string[] roleNames)
        {
            throw new NotImplementedException();
        }

        public override string[] GetUsersInRole(string roleName)
        {
            throw new NotImplementedException();
        }

        public override string[] GetAllRoles()
        {
            using (var usersContext = new StatixEntities())
            {
                return usersContext.UserRoles.Select(r => r.Name).ToArray();
            }
        }

        public override string[] FindUsersInRole(string roleName, string usernameToMatch)
        {
            throw new NotImplementedException();
        }

        public override string ApplicationName
        {
            get
            {
                return this.applicationName;
            }
            set
            {
                this.applicationName = value;
            }
        }
    }
}