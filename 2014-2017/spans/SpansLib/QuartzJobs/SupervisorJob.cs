using System;
using Quartz;
using SharedLibrary;
using SpansLib.Db;

namespace SpansLib.QuartzJobs
{
    public class SupervisorJob : Job
    {
        public override void Execute(IJobExecutionContext context)
        {
            try
            {
                base.Execute(context);

                // via the MergedJobDataMap it is possible to provide data with both - job and trigger
                var connStr = context.MergedJobDataMap.GetString("connStr");
                var hours = context.MergedJobDataMap.GetString("hoursBack").ToInt32();

                SpansEntities.EfConnectionString = string.Format(AppSettings.SpansEntitiesConnStrTemplate, connStr);

                DbLogger.LogJob(JobName, TriggerName, (sb) =>
                {
                    Supervisor.Run(connStr, hours, sb);
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
