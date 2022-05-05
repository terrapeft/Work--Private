using System;
using System.Security.AccessControl;
using System.Threading;
using Quartz;
using SharedLibrary;
using SpansLib.Data;
using SpansLib.Db;

namespace SpansLib.QuartzJobs
{
    public class XmlBulkLoadJob : Job
    {
        public override void Execute(IJobExecutionContext context)
        {
            try
            {
                base.Execute(context);

                // via the MergedJobDataMap it is possible to provide data with both - job and trigger
                var localPath = context.MergedJobDataMap.GetString("path");
                var connStr = context.MergedJobDataMap.GetString("connStr");
                var overwriteData = context.MergedJobDataMap.GetString("overwrite").ToBoolean();
                var daysBack = -context.MergedJobDataMap.GetString("daysBack").ToInt32();
                
                SpansEntities.EfConnectionString = string.Format(AppSettings.SpansEntitiesConnStrTemplate, connStr);
                var logger = Common.Logging.LogManager.Adapter.GetLogger(JobName);

                DbLogger.LogJob(JobName, TriggerName, (sb) =>
                {
                    var bw = new BatchWriter(localPath, FileFormat.XmlFormats, DateTime.Today.AddDays(daysBack));
                    bw.Process(connStr, new CancellationToken(), (str) =>
                    {
                        sb.AppendLine(str);
                        logger.Info(str);
                    }, 
                    !overwriteData);
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
