using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Data;
using System.Data.Objects;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using Db.AuditTrail;
using SharedLibrary.Elmah;
using SharedLibrary.Session;

namespace Db
{
    public partial class StatixEntities
    {
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
                    if (HttpContext.Current.Session != null && HttpContext.Current.Session["currentUserID"] != null)
                    {
                        return (int)HttpContext.Current.Session["currentUserID"];
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

                return 0;
            }
            set
            {
                SessionHelper.Add("currentUserID", value);
            }
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
                : (entity.GetType() == typeof(User))
                    ? ((User)entity).Id
                    : 0;

            return CurrentUserId != 0;
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
                var dc = new StatixEntities();
                return dc.GetUser(dc.CurrentUserId);
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
            get { return Users.Where(u => u.IsSuspended == false); }
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
                return Users.Where(u => u.RoleId == 1 || u.RoleId == 3);
            }
        }

        /// <summary>
        /// Gets a value indicating whether current user has an administrator's rights.
        /// </summary>
        public static bool IsAdministrator
        {
            get
            {
                if (CurrentSessionUser == null) 
                    return false;

                return CurrentSessionUser.RoleId == 1 || CurrentSessionUser.RoleId == 3;
            }
        }

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
                            throw new ValidationException(Db.Resources.Unique_Constraint_Violation_Error,
                                sqlException);
                        }

                        throw new ValidationException(string.Empty, sqlException);
                    }
                }
            }

            return res;
        }

        /// <summary>
        /// Checks if IP address belongs to site view.
        /// </summary>
        /// <param name="ipAddr">The ip addr.</param>
        /// <param name="siteId">The site identifier.</param>
        /// <returns></returns>
        public bool IsValidSiteIpAddress(string ipAddr, int siteId)
        {
            var site = Sites.FirstOrDefault(s => s.Id == siteId);
            if (site == null) return false;

            return site
                 .IPAddresses
                 .Where(i => i.IsAllowed)
                 .Any(i => i.IPAddr == ipAddr);
        }

        /// <summary>
        /// Referrer treated as valid if one of stored values is a part of provided URI.
        /// </summary>
        /// <param name="absoluteUri">The absolute URI.</param>
        /// <param name="siteId">The site identifier.</param>
        /// <returns></returns>
        public bool IsValidReferrer(string absoluteUri, int siteId)
        {
            var site = Sites.FirstOrDefault(s => s.Id == siteId);
            if (site == null) return false;

            return site
                 .Referrers
                 .Any(r => absoluteUri.IndexOf(r.Value, StringComparison.InvariantCultureIgnoreCase) > -1);
        }

        /// <summary>
        /// Checks if IP address belongs to user.
        /// </summary>
        /// <param name="ipAddr">The ip addr.</param>
        /// <param name="userId">The user identifier.</param>
        /// <param name="strictVerification">Verify IP address regardless of the SecureByIp value.</param>
        /// <returns></returns>
        public bool IsValidUserIpAddress(string ipAddr, int userId, bool strictVerification)
        {
            var user = GetUser(userId);
            if (user == null) return false;

            if (!strictVerification && !user.SecureByIp) return true;

            return user
                .IPAddresses
                .Where(i => i.IsAllowed)
                .Any(i => i.IPAddr == ipAddr);
        }

        /// <summary>
        /// Locks the user.
        /// </summary>
        /// <param name="user">The user.</param>
        public void LockUser(User user)
        {
            user.IsSuspended = true;
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
    }
}
