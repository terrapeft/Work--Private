using System;
using System.Configuration;
using System.Data.Entity;
using System.Linq;
using System.Web;
using SharedLibrary.Session;

namespace TradeDataUsers
{

    /// <summary>
    /// UmbracoMembersEntities defined to specify the DbConfiguration class. 
    /// </summary>
    //[DbConfigurationType(typeof(EfConfiguration))]
    public partial class TRADEdataUsersEntities
    {
        public TRADEdataUsersEntities(string connectionString) : base(connectionString)
        {
        }

        public void Log(ClientAction action, string username, string message = null)
        {
            Log(action, null, username, message);
        }

        public void Log(ClientAction action, int userId, string message = null)
        {
            Log(action, userId, null, message);
        }

        /// <summary>
        /// Gets the current session user.
        /// </summary>
        /// <value>
        /// The current session user.
        /// </value>
        public User CurrentUser => GetUser(CurrentUserId);

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
                            return usr.UserId;
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

        public int ApplicationId
        {
            get
            {
                return SessionHelper.Get("applicationId", () => Convert.ToInt32(ConfigurationManager.AppSettings["tdu:ApplicationId"]));
            }
        }

        public static int? CurrentSiteId
        {
            get
            {
                if (HttpContext.Current != null)
                {
                    if (HttpContext.Current.Session != null && HttpContext.Current.Session["currentSiteID"] != null)
                    {
                        return (int)HttpContext.Current.Session["currentSiteID"];
                    }
                }

                return null;
            }
            set
            {
                SessionHelper.Add("currentSiteID", value);
            }
        }

        /// <summary>
        /// Gets the user from Active and Editable.
        /// </summary>
        /// <param name="id">The id.</param>
        /// <returns></returns>
        public User GetUser(int id)
        {
            return Users.FirstOrDefault(u => u.UserId == id);
        }

        private void Log(ClientAction action, int? userId = null, string username = null, string message = null)
        {
            Histories.Add(new History
            {
                Action = action.ToString(),
                UserId = userId,
                Username = username,
                Message = message,
                ApplicationId = ApplicationId
            });

            SaveChanges();
        }
    }
}
