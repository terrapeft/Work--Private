using System;
using System.Threading;
using Quartz;
using SharedLibrary;
using SpansLib.Db;
using SpansLib.Ftp;
using WinSCP;

namespace SpansLib.QuartzJobs
{
    public class FtpSyncJob : Job
    {
        public override void Execute(IJobExecutionContext context)
        {
            try
            {
                base.Execute(context);

                // via the MergedJobDataMap it is possible to provide data with both - job and trigger
                var localPath = context.MergedJobDataMap.GetString("localPath");
                var ftpPath = context.MergedJobDataMap.GetString("ftpPath");
                var connStr = context.MergedJobDataMap.GetString("connStr");
                var daysBack = -context.MergedJobDataMap.GetString("daysBack").ToInt32();
                var skipFolders = context.MergedJobDataMap.GetString("skipFolders").ToList(";");
                var skipFiles = context.MergedJobDataMap.GetString("skipFileTypes").ToList(";");
                var overwrite = context.MergedJobDataMap.GetString("overwrite").ToBoolean();

                SpansEntities.EfConnectionString = string.Format(AppSettings.SpansEntitiesConnStrTemplate, connStr);
                var logger = Common.Logging.LogManager.Adapter.GetLogger(JobName);

                DbLogger.LogJob(JobName, TriggerName, (sb) =>
                {
                    var ftp = new FtpHelper(new Uri(ftpPath), Protocol.Ftp);
                    ftp.SyncFolders(
                        localPath,
                        msg =>
                        {
                            sb.AppendLine(msg);
                            logger.Info(msg);
                        },
                        new CancellationToken(),
                        DateTime.Today.AddDays(daysBack),
                        overwrite,
                        skipFolders,
                        skipFiles);
                });

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
