using Quartz;

namespace SpansLib.QuartzJobs
{
    public class Job : IJob
    {
        protected string JobName;
        protected string TriggerName;

        public virtual void Execute(IJobExecutionContext context)
        {
            JobName = context.JobDetail.Key.ToString();
            TriggerName = context.Trigger.Key.ToString();
        }
    }
}
