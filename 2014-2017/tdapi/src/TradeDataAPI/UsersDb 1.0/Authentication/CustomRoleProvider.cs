using UsersDb.DataContext;

namespace UsersDb.Authentication
{
    using System;
    using System.Linq;
    using System.Web.Security;

    using UsersDb;

    public class CustomRoleProvider : RoleProvider
    {
        private string applicationName;

        public override bool IsUserInRole(string username, string roleName)
        {
            using (var usersContext = new UsersDataContext())
            {
                var user = usersContext.Users
                    .SingleOrDefault(u => u.Username == username);
                if (user == null)
                {
                    return false;
                }
                return user.Roles != null && user.Roles.Where(r => !r.IsDeleted).Select(u => u.Name).Any(r => r == roleName);
            }
        }

        public override string[] GetRolesForUser(string username)
        {
            using (var usersContext = new UsersDataContext())
            {
                var user = usersContext.Users.Where(u => !u.IsDeleted).SingleOrDefault(u => u.Username == username);
                if (user == null)
                {
                    return new string[] { };
                }

                return user.Roles?.Where(r => !r.IsDeleted).Select(u => u.Name).ToArray() ?? new string[] { };
            }
        }

        public int GetUserId(string username)
        {
            using (var usersContext = new UsersDataContext())
            {
                var user = usersContext.Users.Where(u => !u.IsDeleted).SingleOrDefault(u => u.Username == username);
                if (user == null)
                {
                    return user.Id;
                }

                return 0;
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
            using (var usersContext = new UsersDataContext())
            {
                return usersContext.Roles.Select(r => r.Name).ToArray();
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