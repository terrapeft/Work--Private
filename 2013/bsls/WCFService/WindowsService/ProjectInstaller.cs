using System;
using System.Collections;
using System.Collections.Generic;
using System.ComponentModel;
using System.Configuration.Install;
using System.Linq;
using System.Diagnostics;
using System.Reflection;
using System.Configuration;


namespace WindowsService
{
   [RunInstaller(true)]
   public partial class ProjectInstaller : Installer
   {
      const string LogName = "BslsService";

      public ProjectInstaller()
      {
         InitializeComponent();
      }

      /// <summary>
      /// Called when installing the service.
      /// </summary>
      /// <param name="stateSaver"></param>
      public override void Install(IDictionary stateSaver)
      {
         // Get configuration settings
         string serviceName;
         string logName;
         GetServiceConfig(out serviceName, out logName);

         if (serviceName != null && serviceName.Length > 0)
         {
            this.BslsWinServiceInstaller.DisplayName = serviceName;
            this.BslsWinServiceInstaller.ServiceName = serviceName;
         }

         // Must call base class first.
         base.Install(stateSaver);

         // Create custom event log if it does not yet exist.
         if (!EventLog.Exists(logName))
         {
            // Create log and source with the same name. Remove source from app log if it exists.
            if (EventLog.SourceExists(logName))
            {
               EventLog.DeleteEventSource(logName);
               Console.WriteLine("Removed event source '{0}'.", logName);
            }

            EventLog.CreateEventSource(logName, logName);
            Console.WriteLine("Created event log and source '{0}'.", logName);
         }

         Console.WriteLine("Using service name '{0}', log name '{1}'.", this.BslsWinServiceInstaller.ServiceName, logName);
      }

      /// <summary>
      /// Uninstall service using correct name
      /// </summary>
      /// <param name="savedState"></param>
      public override void Uninstall(IDictionary savedState)
      {
         // Get configuration settings
         string serviceName;
         string logName;
         GetServiceConfig(out serviceName, out logName);

         if (serviceName != null && serviceName.Length > 0)
         {
            this.BslsWinServiceInstaller.DisplayName = serviceName;
            this.BslsWinServiceInstaller.ServiceName = serviceName;
         }

         // Must call base class first.
         base.Uninstall(savedState);
      }

      /// <summary>
      /// Get service an dlog names from config file.
      /// </summary>
      /// <param name="serviceName"></param>
      /// <param name="logName"></param>
      private static void GetServiceConfig(out string serviceName, out string logName)
      {
         Uri uri = new Uri(Assembly.GetExecutingAssembly().GetName().CodeBase);
         Configuration config = ConfigurationManager.OpenExeConfiguration(uri.LocalPath);
         if (!config.HasFile) throw new ApplicationException("Unable to find config file");

         serviceName = (config.AppSettings.Settings["ServiceName"] != null) ? config.AppSettings.Settings["ServiceName"].Value : string.Empty;
         logName = (config.AppSettings.Settings["LogName"] != null) ? config.AppSettings.Settings["LogName"].Value : LogName;
      }
   }
}
