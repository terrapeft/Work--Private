using System;
using System.Linq;
using System.Text;

namespace SpansLib.Db
{
    public class DbLogger
    {
        private static DbLogger _logger;
        private static string _connStr;

        private DbLogger()
        {
        }

        /// <summary>
        /// Creates the instance.
        /// </summary>
        public static void CreateInstance()
        {
            _logger = new DbLogger();
        }

        /// <summary>
        /// Gets the instance of the logger.
        /// </summary>
        /// <value>
        /// The instance.
        /// </value>
        public static DbLogger Instance
        {
            get { return _logger; }
        }

        /// <summary>
        /// Logs the error.
        /// </summary>
        /// <param name="file">The file.</param>
        /// <param name="message">The message.</param>
        public void LogError(string file = null, string message = null)
        {
            using (var e = SpansEntities.GetInstance())
            {
                e.Errors.Add(new Error { FileName = file, Information = message });
                try
                {
                    e.SaveChanges();
                }
                catch (Exception ex)
                {
                    
                }
            }
        }

        /// <summary>
        /// Encapsulates logic for logging job details before start and after finish.
        /// </summary>
        /// <param name="jobName">Name of the job.</param>
        /// <param name="triggerName">Name of the trigger.</param>
        /// <param name="action">The action.</param>
        /// <param name="startTimeUtc">The start time (UTC).</param>
        /// <param name="connStr">The connection string.</param>
        public static void LogJob(string jobName, string triggerName, Action<StringBuilder> action, DateTime? startTimeUtc = null, string connStr = null)
        {
            _connStr = connStr;
            CreateInstance();

            var logId = Instance.LogJobStart(jobName, triggerName, startTimeUtc);
            var sb = new StringBuilder();

            action.Invoke(sb);

            Instance.LogJobTrace(logId, sb.ToString());
        }

        /// <summary>
        /// Logs the job start parameters and time.
        /// </summary>
        /// <param name="jobName">Name of the job.</param>
        /// <param name="triggerName">Name of the trigger.</param>
        /// <param name="startTimeUtc">The start time (UTC).</param>
        /// <returns></returns>
        private int LogJobStart(string jobName, string triggerName, DateTime? startTimeUtc = null)
        {
            using (var e = SpansEntities.GetInstance())
            {
                var log = e.ImportLogs.Add(new ImportLog
                {
                    JobName = jobName, TriggerName = triggerName
                });

                e.SaveChanges();

                if (startTimeUtc != null)
                {
                    // The log.StartDateUtc is an Identity column, so it's not possible to pass value to db.
                    var dbHelper = new DbHelper(_connStr);
                    dbHelper.ExecuteScript(string.Format(AppSettings.SetJobStartTimeTemplate, log.Id, startTimeUtc.Value.ToString("yyyy-MM-dd HH:mm:ss")));
                }

                return log.Id;
            }
        }

        /// <summary>
        /// Logs the job trace.
        /// </summary>
        /// <param name="logId">The log identifier.</param>
        /// <param name="trace">The trace.</param>
        private void LogJobTrace(int logId, string trace)
        {
            using (var e = SpansEntities.GetInstance())
            {
                var log = e.ImportLogs.FirstOrDefault(l => l.Id == logId);
                if (log != null)
                {
                    log.EndDateUtc = DateTime.UtcNow;
                    log.Trace = trace;
                    e.SaveChanges();
                }
            }
        }
    }
}
