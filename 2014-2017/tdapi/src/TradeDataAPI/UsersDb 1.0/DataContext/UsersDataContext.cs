using System;
using System.ComponentModel.DataAnnotations;
using System.Data;
using System.Data.Objects;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using SharedLibrary.Session;
using UsersDb.Helpers;

namespace UsersDb.DataContext
{
    /// <summary>
    /// Extends the data context with custom logic.
    /// </summary>
    public class UsersDataContext : UsersEntities
    {
        private int currentUser = 0;

        public UsersDataContext()
            : base()
        { }

        public UsersDataContext(string connectionString)
            : base(connectionString)
        { }

        public override int SaveChanges(SaveOptions options)
        {
            int res = 0;

            using (var auh = new AuditTrailHelper(this))
            {
                var changes = ObjectStateManager
                    .GetObjectStateEntries(EntityState.Added | EntityState.Modified | EntityState.Deleted)
                    .ToList();

                foreach (var entry in changes.Where(e => e.Entity is IAuditable))
                {
                    var sa = entry.Entity as ISpecialAction;
                    if (sa != null && sa.SkipAuditTrail)
                    {
                        continue;
                    }

                    if (HasCurrentUser(entry.Entity))
                    {
                        auh.Add(entry);
                    }
                }

                foreach (var entry in changes.Where(e => e.Entity is IEntity))
                {
                    var sa = entry.Entity as ISpecialAction;
                    if (sa != null && sa.SkipSavingEvents)
                    {
                        continue;
                    }

                    ((IEntity)entry.Entity).BeforeSave(this, entry);

                    // number of changes may change after BeforeSave call, and we need actual changes in AfterSave below
                    changes = ObjectStateManager
                        .GetObjectStateEntries(EntityState.Added | EntityState.Modified)
                        .ToList();
                }

                try
                {
                    res = base.SaveChanges(options);

                    foreach (var group in changes
                        .Where(e => e.State != EntityState.Detached)
                        .Where(e => e.Entity is IEntity)
                        .Where(e => !(e.Entity is ISpecialAction) || !((ISpecialAction)e.Entity).SkipSavingEvents)
                        .GroupBy(e => e.Entity.GetType()))
                    {
                        var e = group.FirstOrDefault();
                        if (e != null)
                        {
                            ((IEntity)e.Entity).AfterSave(this, group);
                        }
                    }
                }
                catch (UpdateException uex)
                {
                    Logger.LogError(uex, silently: true);

                    var sqlException = uex.InnerException as SqlException;

                    if (sqlException != null)
                    {
                        // Error 2627 stands for unique constraint violation
                        // Error 2601 stands for unique index violation
                        if (sqlException.Number == 2627 || sqlException.Number == 2601)
                        {
                            throw new ValidationException(UsersDb.Resources.Unique_Constraint_Violation_Error,
                                sqlException);
                        }

                        throw new ValidationException(string.Empty, sqlException);
                    }
                }
            }

            return res;
        }

        /// <summary>
        /// Determines whether the current user is known.
        /// </summary>
        /// <param name="entity">The entity.</param>
        /// <returns></returns>
        private bool HasCurrentUser(object entity)
        {
            CurrentUserId = CurrentUserId != 0
                ? CurrentUserId
                : (entity.GetType() == typeof (User))
                    ? ((User) entity).Id
                    : 0;
            
            return CurrentUserId != 0;
        }

        /// <summary>
        /// Gets the administrators.
        /// </summary>
        /// <value>
        /// The administrators.
        /// </value>
        public IQueryable<User> Administrators
        {
            get
            {
                return Users.Where(u => u.Roles.Where(r => !r.IsDeleted).Any(r => r.Permissions.Any(p => p.Id == (int)UiPermission.AccessAdminUI)));
            }
        }

        /// <summary>
        /// Gets the customers.
        /// </summary>
        /// <value>
        /// The customers.
        /// </value>
        public IQueryable<User> Customers
        {
            get
            {
                return Users.Where(u => u.Roles.Where(r => !r.IsDeleted).Any(r => r.Permissions.Any(p => p.Id == (int)UiPermission.AccessCustomerUI)));
            }
        }

        /// <summary>
        /// Gets the active users.
        /// </summary>
        /// <value>
        /// The active users.
        /// </value>
        public IQueryable<User> ActiveUsers
        {
            get { return Users.Where(u => !u.IsDeleted && u.IsActive); }
        }


        /// <summary>
        /// Gets groups marked to search by.
        /// </summary>
        /// <value>
        /// The searchable groups.
        /// </value>
        public IQueryable<SearchGroup> SearchableGroups
        {
            get { return SearchGroups.Where(s => s.TableId == (int)UsersDb.SearchTables.XymRootLevelGLOBAL); }
        }

        /// <summary>
        /// Locks the user.
        /// </summary>
        /// <param name="user">The user.</param>
        public void LockUser(User user)
        {
            user.IsActive = false;
        }

        /// <summary>
        /// Clears the failed attempts.
        /// </summary>
        /// <param name="user">The user.</param>
        public void ClearFailedAttempts(User user)
        {
            user.FailedLoginAttemptsCnt = 0;
        }

        /// <summary>
        /// Adds the failed attempt.
        /// </summary>
        /// <param name="user">The user.</param>
        public void AddFailedAttempt(User user)
        {
            user.FailedLoginAttemptsCnt++;
            user.LastFailedAttempt = DateTime.UtcNow;
        }

        /// <summary>
        /// Gets the user from Active and Editable.
        /// </summary>
        /// <param name="id">The id.</param>
        /// <returns></returns>
        public User GetUser(int id)
        {
            return ActiveUsers.FirstOrDefault(u => u.Id == id);
        }

        /// <summary>
        /// Determines whether the method belongs to any of the groups, which are free for use.
        /// </summary>
        /// <param name="methodName">Name of the method.</param>
        /// <returns></returns>
        public bool IsFreeMethod(string methodName)
        {
            return MethodGroups
                .Where(g => g.Shared)
                .SelectMany(g => g.Methods.Where(m => !m.IsDeleted))
                .Any(m => m.Name.Equals(methodName, StringComparison.InvariantCultureIgnoreCase));
        }

        /// <summary>
        /// Keeps the list of IPs.
        /// </summary>
        public bool IsValidIP(string ip)
        {
            return IPs
                .Where(i => i.IsAllowed)
                .Any(i => i.Ip == ip);
        }

        /// <summary>
        /// Gets or sets the current user id.
        /// </summary>
        /// <value>
        /// The current user id.
        /// </value>
        public int CurrentUserId
        {
            get
            {
                if (HttpContext.Current != null)
                {
                    if (HttpContext.Current.Session != null && HttpContext.Current.Session[Constants.CurrentIdCacheKey] != null)
                    {
                        // for admin UI
                        return (int)HttpContext.Current.Session[Constants.CurrentIdCacheKey];
                    }

                    if (!string.IsNullOrEmpty(HttpContext.Current.User.Identity.Name))
                    {
                        var usr = Users.FirstOrDefault(u => u.Username == HttpContext.Current.User.Identity.Name);
                        if (usr != null)
                        {
                            return usr.Id;
                        }
                    }
                }

                // for the service
                return currentUser;
            }
            set
            {
                // for UI
                SessionHelper.Add(Constants.CurrentIdCacheKey, value);

                // for the service
                currentUser = value;
            }
        }

        /// <summary>
        /// Gets the current session user.
        /// </summary>
        /// <value>
        /// The current session user.
        /// </value>
        public User CurrentUser
        {
            get
            {
                return GetUser(CurrentUserId);
            }
        }

        /// <summary>
        /// Gets the current session user.
        /// </summary>
        /// <value>
        /// The current session user.
        /// </value>
        public static User CurrentSessionUser
        {
            get
            {
                var dc = new UsersDataContext();
                return dc.GetUser(dc.CurrentUserId);
            }
        }

        /// <summary>
        /// Gets a value indicating whether current user has an administrator's rights.
        /// </summary>
        public static bool IsAdministrator
        {
            get
            {
                return CurrentSessionUser.Roles.Where(r => !r.IsDeleted).Any(r => r.Permissions.Any(p => p.Id == (int)UiPermission.AccessAdminUI));
            }
        }
    }
}