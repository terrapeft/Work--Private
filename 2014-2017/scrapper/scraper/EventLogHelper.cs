using System.Diagnostics;

namespace Scraper
{
    public class EventLogHelper
    {
        public static void VerifyLog(string logName)
        {
            if (!EventLog.SourceExists(logName))
            {
                EventLog.CreateEventSource(logName, logName);
            }
        }

        public static void Write(string msg)
        {
            EventLog.WriteEntry(AppSettings.EventLog, msg);
        }
    }
}
