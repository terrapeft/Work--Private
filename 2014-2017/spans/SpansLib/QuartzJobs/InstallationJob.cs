using System;
using System.Text;
using Quartz;
using SharedLibrary;
using SpansLib.Db;

namespace SpansLib.QuartzJobs
{
    public class InstallationJob : Job
    {
        public override void Execute(IJobExecutionContext context)
        {
            base.Execute(context);

            try
            {
                base.Execute(context);

                // via the MergedJobDataMap it is possible to provide data with both - job and trigger
                var connStr = context.MergedJobDataMap.GetString("connStr");
                var overwrite = context.MergedJobDataMap.GetString("overwrite").ToBoolean();

                SpansEntities.EfConnectionString = string.Format(AppSettings.SpansEntitiesConnStrTemplate, connStr);
                var logger = Common.Logging.LogManager.Adapter.GetLogger(JobName);

                var startTime = DateTime.UtcNow;
                var logBuilder = new StringBuilder();
                
                var inst = new Installation(connStr);
                inst.EnsureTablesSet(AppSettings.HasConfigTables, AppSettings.HasConfigTablesExpectedCount, AppSettings.ConfigSqlFile, overwrite,
                    (msg) =>
                    {
                        logBuilder.AppendLine(msg);
                        logger.Info(msg);
                    });

                inst.EnsureTablesSet(AppSettings.HasXmlTables, AppSettings.HasXmlTablesExpectedCount, AppSettings.SpanSqlFile, overwrite,
                    (msg) =>
                    {
                        logBuilder.AppendLine(msg);
                        logger.Info(msg);
                    });

                DbLogger.LogJob(JobName, TriggerName, (sb) =>
                {
                    // Just log job run, because if there were no config tables, it was not possible to use DB log.
                    sb.Append(logBuilder);
                }, startTime, connStr);

                context.Result = AppSettings.ReportJobSuccess;
            }
            catch (Exception ex)
            {
                context.Result = AppSettings.ReportJobFailure;
                DbLogger.Instance.LogError(message: ex.ToString());
                throw new JobExecutionException(ex);
            }
        }
    }
}
