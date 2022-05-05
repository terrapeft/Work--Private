using System;
using System.Text;
using SpansLib.Db;

namespace SpansLib
{
    public class Installation
    {
        private readonly StringBuilder _logBuilder;
        private readonly DbHelper _dbHelper;

        /// <summary>
        /// Initializes a new instance of the <see cref="Installation"/> class.
        /// </summary>
        /// <param name="connStr">The connection string.</param>
        /// <param name="logBuilder">The log builder.</param>
        public Installation(string connStr, StringBuilder logBuilder = null)
        {
            _logBuilder = logBuilder;
            _dbHelper = new DbHelper(connStr);

            AddToLog(AppSettings.ReportInstallStart);
        }

        /// <summary>
        /// Ensures the tables are in database, if not, runs the specified sql file to create them.
        /// </summary>
        /// <param name="checkScript">The check script.</param>
        /// <param name="expectedResult">The expected result.</param>
        /// <param name="sqlFilePath">The SQL file path.</param>
        /// <param name="overwrite">if set to <c>true</c> [overwrite].</param>
        /// <param name="callback">The callback.</param>
        public void EnsureTablesSet(string checkScript, int expectedResult, string sqlFilePath, bool overwrite, Action<string> callback)
        {
            var cfgResult = _dbHelper.ExecuteScalar(checkScript);

            AddToLog(string.Format(AppSettings.ReportInstallRunScriptTemplate, sqlFilePath, overwrite));

            if (cfgResult == null || cfgResult == DBNull.Value || (int) cfgResult != expectedResult || overwrite)
            {
                _dbHelper.ExecuteDdl(sqlFilePath);
                AddToLog(AppSettings.ReportComplete);
            }
            else
            {
                AddToLog(AppSettings.ReportCanceled);
            }
        }

        /// <summary>
        /// Adds message to log.
        /// </summary>
        /// <param name="msg">The MSG.</param>
        /// <exception cref="System.NotImplementedException"></exception>
        private void AddToLog(string msg)
        {
            if (_logBuilder != null)
            {
                _logBuilder.AppendLine(msg);
            }
        }
    }
}
