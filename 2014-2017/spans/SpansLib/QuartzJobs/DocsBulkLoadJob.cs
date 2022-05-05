using System;
using Quartz;
using SpansLib.Data.XmlFormats;
using SpansLib.Db;

namespace SpansLib.QuartzJobs
{
    public class DocsBulkLoadJob : Job
    {
        public override void Execute(IJobExecutionContext context)
        {
            try
            {
                base.Execute(context);

                // via the MergedJobDataMap it is possible to provide data with both - job and trigger
                var connStr = context.MergedJobDataMap.GetString("connStr");
                var ftpPath = context.MergedJobDataMap.GetString("ftpPath");
                var filePath = context.MergedJobDataMap.GetString("filePath");
                var serviceFiles = context.MergedJobDataMap.GetString("serviceFiles");

                SpansEntities.EfConnectionString = string.Format(AppSettings.SpansEntitiesConnStrTemplate, connStr);
                var logger = Common.Logging.LogManager.Adapter.GetLogger(JobName);

                DbLogger.LogJob(JobName, TriggerName, (sb) =>
                    DocsProcessor.Load(ftpPath, connStr, filePath, serviceFiles,
                        (msg) =>
                        {
                            sb.AppendLine(msg);
                            logger.Info(msg);
                        })
                    );

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
