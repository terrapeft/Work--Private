#region Copyright (C) 1994-2009, Johnson & Johnson PRD, LLC.
//---------------------------------------------------------------------------*
//
//    Logger.cs: Utility for logging messages, copied from ROATS.
//
//---
//
//    Copyright (C) 1994-2009, Johnson & Johnson PRD, LLC.
//    All Rights Reserved.
//
//    Vitaly Chupaev, 06/2010
//
//---------------------------------------------------------------------------*/
#endregion

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Diagnostics;
using System.Security.Principal;
using Jnj.ThirdDimension.Util.UsageLog;

namespace Jnj.ThirdDimension.Service.BarcodeSeries
{
   /// <summary>
   /// A wrapper class to easily log exceptions and messages.
   /// Uses the <see>Jnj.ThirdDimension.Util.UsageLog.Reporter</see> class internally.
   /// </summary>
   public class Logger
   {
      private static EventLog eventLog;  // By default it is assigned to application log
      const string logName = "BslsService";

      static Logger()
      {
         Init();
      }

      /// <summary>
      /// Initialize windows event log.
      /// </summary>
      internal static void Init()
      {
         if (!EventLog.SourceExists(logName))
         {
            EventLog.CreateEventSource(logName, logName);
         }

         // configure the event log instance to use this source name
         eventLog = new EventLog(logName) { Source = logName };
      }

      /// <summary>
      /// Returns the windows identity of user.
      /// </summary>
      /// <returns></returns>
      public static string GetIdentity()
      {
         return string.Format("Windows Identity: {0},  Current Principal: {1}",
            WindowsIdentity.GetCurrent().Name, System.Threading.Thread.CurrentPrincipal.Identity.Name);
      }

      /// <summary>
      /// Helper to log service action in both the machine log and the global log.
      /// </summary>
      /// <param name="action">The action string, like MOVE, WEIGH, TARE, etc...</param>
      /// <param name="data">Any other information</param>
      public static void ReportAction(string action, string data)
      {
         string msg = string.Format("{0} - {1}: {2}", GetIdentity(), action, data);
         Reporter.ReportAction(action, data);
         eventLog.WriteEntry(msg, EventLogEntryType.Information);
      }

      /// <summary>
      /// Helper to log service errors in both the machine log and the global log.
      /// </summary>
      /// <param name="message">The error message.</param>
      public static void ReportError(string message)
      {
         string msg = string.Format("{0} - {1}", GetIdentity(), message);
         Reporter.ReportError(msg);
         eventLog.WriteEntry(msg, EventLogEntryType.Error);
      }

      /// <summary>
      /// Helper to log service errors in both the machine log and the global log.
      /// </summary>
      /// <param name="ex">The exception to log.</param>
      public static void ReportError(Exception ex)
      {
         string msg = string.Format("{0} - {1}: {2}\r\n{3}", GetIdentity(), ex.GetType().ToString(), ex.Message, ex.StackTrace);
         Reporter.ReportError(ex, false);
         eventLog.WriteEntry(msg, EventLogEntryType.Error);

         if (ex.InnerException != null)
         {
            msg = string.Format("InnerException for: {0}\r\n{1}\r\n{2}", ex.Message, ex.InnerException.Message, ex.InnerException.StackTrace);
            eventLog.WriteEntry(msg, EventLogEntryType.Error);
         }
      }

      /// <summary>
      /// Helper to log general information messages to the local and global logs.
      /// </summary>
      /// <param name="header"></param>
      /// <param name="info"></param>
      public static void ReportInfo(string header, string info)
      {
         string msg = string.Format("{0} - {1}: {2}", GetIdentity(), header, info);
         Reporter.ReportInfo(header, info);
         eventLog.WriteEntry(msg, EventLogEntryType.Information);
      }
   }
}
