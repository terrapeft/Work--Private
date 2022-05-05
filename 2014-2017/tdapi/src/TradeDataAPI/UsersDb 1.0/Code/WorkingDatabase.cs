using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Web;
using UsersDb.DataContext;

namespace UsersDb.Code
{
    /// <summary>
    /// Singleton
    /// </summary>
    public class WorkingDatabase
    {
        private readonly string _dbAlias;
        private static WorkingDatabase _wd;

        private WorkingDatabase(string dbAlias)
        {
            _dbAlias = dbAlias;
        }

        /// <summary>
        /// Gets the instance.
        /// </summary>
        /// <value>
        /// The instance.
        /// </value>
        public static WorkingDatabase Instance
        {
            get
            {
                if (HttpContext.Current != null)
                {
                    return HttpContext.Current.Session["_work_db"] as WorkingDatabase;
                }

                return _wd;
            }
        }

        public string Alias
        {
            get { return _dbAlias; }
        }

        /// <summary>
        /// Creates the instance.
        /// </summary>
        /// <param name="dbAlias">The database alias.</param>
        public static void CreateInstance(string dbAlias)
        {
            if (HttpContext.Current != null)
            {
                HttpContext.Current.Session["_work_db"] = new WorkingDatabase(dbAlias);
            }
            else
            {
                _wd = new WorkingDatabase(dbAlias);
            }
        }

        /// <summary>
        /// Gets the connection string.
        /// </summary>
        /// <returns></returns>
        public string GetConnectionString()
        {
            return DatabaseConfiguration.GetConnectionString(_dbAlias);
        }

        /// <summary>
        /// Gets the stored proc prefix.
        /// </summary>
        /// <returns></returns>
        public string GetStoredProcPrefix()
        {
            return DatabaseConfiguration.GetStoredProcPrefix(_dbAlias);
        }

        /// <summary>
        /// Gets the stored proc parameter prefix.
        /// </summary>
        /// <returns></returns>
        public string GetStoredProcParamPrefix()
        {
            return DatabaseConfiguration.GetStoredProcParamPrefix(_dbAlias);
        }

        /// <summary>
        /// Gets the stored proc method prefix.
        /// </summary>
        /// <returns></returns>
        public string GetStoredProcMethodPrefix()
        {
            return DatabaseConfiguration.GetStoredProcMethodPrefix(_dbAlias);
        }

        /// <summary>
        /// Gets the stored proc owner.
        /// </summary>
        /// <returns></returns>
        public string GetStoredProcOwner()
        {
            return DatabaseConfiguration.GetStoredProcOwner(_dbAlias);
        }

        /// <summary>
        /// Gets the stored proc informer prefix.
        /// </summary>
        /// <returns></returns>
        public string GetStoredProcInformerPrefix()
        {
            return DatabaseConfiguration.GetStoredProcInformerPrefix(_dbAlias);
        }
    }
}
