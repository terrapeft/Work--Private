#region Copyright (C) 1994-2009, Johnson & Johnson PRD, LLC.
//---------------------------------------------------------------------------*
//
//    BslsWindowsService.cs: Windows service host for BSLS WCF service.
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
using System.Diagnostics;
using System.ServiceProcess;
using System.ServiceModel;
using System.Configuration;
using System.Reflection;
using System.Runtime.Remoting;
using System.Threading;
using Jnj.ThirdDimension.Service.BarcodeSeries;

namespace WindowsService
{
    /// <summary>
    /// Windows service host for BSLS WCF service
    /// </summary>
    public partial class BslsWindowsService : ServiceBase
    {

        #region Members

        private ServiceHost serviceHost = null;   // svchost for wcf service
        private int connectCount = 0;   // opened sessions counter

        #endregion


        #region Constructor

        public BslsWindowsService()
        {
            InitializeComponent();

            // Name the Windows Service
            ServiceName = "BslsWcfWindowsService";
        }

        #endregion


        #region Service lifecycle

        protected override void OnStart(string[] args)
        {

#if DEBUG
            try
            {
                if (ConfigurationManager.AppSettings["runDebugger"] == "yes")
                {
                    //Debugger.Launch();
                }
            }
            catch (Exception)
            {
                //ignore any exception here
            }
#endif

            StartSyncService();

            try
            {
                // Setup Remoting
                string assName = Assembly.GetExecutingAssembly().Location + ".config";
                RemotingConfiguration.Configure(assName, false);
                Logger.ReportAction("Remoting service started", assName);


                if (serviceHost != null)
                {
                    serviceHost.Close();
                }

                // set NLS language
                SetupOracleEnvironment();

                // Create a ServiceHost for the BslsWindowsService type and 
                // provide the base address.
                serviceHost = new ServiceHost(typeof(BslsService));

                // Open the ServiceHostBase to create listeners and start 
                // listening for messages.
                serviceHost.Open();
                Logger.ReportAction("WCF Service host started", ServiceName);
            }
            catch (Exception ex)
            {
                Logger.ReportError(ex);
                StopService();
            }
        }

        private void StartSyncService()
        {
            var startTime = GetScheduleTime(ConfigurationManager.AppSettings["syncTime"]);
            var seriesConnStr = ConfigurationManager.ConnectionStrings["SeriesConnectionString"].ConnectionString;
            var inventoryConnStr = ConfigurationManager.ConnectionStrings["InventoryConnectionString"].ConnectionString;
            
            var syncService = InventorySyncService.CreateService(inventoryConnStr, seriesConnStr, startTime);
            var threadStart = new ThreadStart(syncService.Start);
            var syncThread = new Thread(threadStart);
            
            syncThread.Start();
        }

        protected override void OnStop()
        {
            StopService();
        }

        /// <summary>
        /// System is shutting down
        /// </summary>
        protected override void OnShutdown()
        {
            StopService();
            Logger.ReportAction("WCF Service stopped due to system shutting down.", ServiceName);
        }

        /// <summary>
        /// Records session changes in the log.
        /// </summary>
        /// <param name="changeDescription"></param>
        protected override void OnSessionChange(SessionChangeDescription changeDescription)
        {
            string action = string.Format("{0} - Session ID: {1}", changeDescription.Reason, changeDescription.SessionId);
            switch (changeDescription.Reason)
            {
                case SessionChangeReason.SessionLogon:
                case SessionChangeReason.RemoteConnect:
                    connectCount += 1;
                    break;
                case SessionChangeReason.SessionLogoff:
                case SessionChangeReason.RemoteDisconnect:
                    connectCount -= 1;
                    break;
                case SessionChangeReason.SessionLock:
                case SessionChangeReason.SessionUnlock:
                    break;
                default:
                    break;
            }

            Logger.ReportAction(action, String.Format("Connection number {0}", connectCount));
        }

        /// <summary>
        /// Stop the service in a clean way.
        /// </summary>
        private void StopService()
        {
            lock (serviceHost)
            {
                if (serviceHost != null)
                {
                    serviceHost.Close();
                    serviceHost = null;
                    Logger.ReportAction("WCF Service host stopped", ServiceName);
                }
            }
        }

        #endregion


        #region Configuration

        private DateTime GetScheduleTime(string timeStr)
        {
            var timeParts = timeStr.Split(':');
            var hours = int.Parse(timeParts[0]);
            var minutes = timeParts.Length == 2 ? int.Parse(timeParts[1]) : 0;

            return (DateTime.Now.Hour >= hours && DateTime.Now.Minute > minutes)
               ? DateTime.Today.AddDays(1).AddHours(hours).AddMinutes(minutes)
               : DateTime.Today.AddHours(hours).AddMinutes(minutes);
        }


        /// <summary>
        /// Setups Oracle Environment.
        /// </summary>
        private void SetupOracleEnvironment()
        {
            string oracleNlsLang = ConfigurationManager.AppSettings["oracleNlsLang"];

            if (!string.IsNullOrEmpty(oracleNlsLang))
            {
                Environment.SetEnvironmentVariable("NLS_LANG", oracleNlsLang);
            }
        }

        #endregion

    }
}
