using System.Configuration;

namespace Scraper
{
    public static class AppSettings 
	{
	    private static readonly Configuration _cfg = ConfigurationManager.OpenExeConfiguration(ConfigurationUserLevel.None);
        private static AppSettingsSection _appSettings;

        private static AppSettingsSection SettingsSection
        {
            get { return _appSettings ?? (_appSettings = (AppSettingsSection) _cfg.GetSection("appSettings")); }
        }

		
		/// <summary>
        /// Like "Scrapper"
        /// </summary>
		public static string EventLog { get { return SettingsSection.Settings["EventLog"].Value; }}
		
		/// <summary>
        /// Like "ctl00_cphContentMain_GenericWebUserControl_ShowAllCheckBox"
        /// </summary>
		public static string CheckBoxId { get { return SettingsSection.Settings["CheckBoxId"].Value; }}
		
		/// <summary>
        /// Like "ctl00_cphContentMain_GenericWebUserControl_gridview1"
        /// </summary>
		public static string DataTableId { get { return SettingsSection.Settings["DataTableId"].Value; }}
        
		/// <summary>
        /// Like "1073"
        /// </summary>
		public static int FormInitialWidth { get { return int.Parse(SettingsSection.Settings["FormInitialWidth"].Value); }}
        
		/// <summary>
        /// Like "659"
        /// </summary>
		public static int FormInitialHeight { get { return int.Parse(SettingsSection.Settings["FormInitialHeight"].Value); }}
		
		/// <summary>
        /// Like "vitaly.chupaev@arcadia.spb.ru"
        /// </summary>
		public static string RecipientsTemplate { get { return SettingsSection.Settings["RecipientsTemplate"].Value; }}
		
		/// <summary>
        /// Like "Sirt page report [{0}]"
        /// </summary>
		public static string SubjectFormat { get { return SettingsSection.Settings["SubjectFormat"].Value; }}
		
		/// <summary>
        /// Like "LocalSQLServerMail"
        /// </summary>
		public static string SqlServerMailProfile { get { return SettingsSection.Settings["SqlServerMailProfile"].Value; }}
		
		/// <summary>
        /// Like "http://sirt.cftc.gov/sirt/sirt.aspx?Topic=ForeignOrganizationProducts"
        /// </summary>
		public static string Url { get { return SettingsSection.Settings["Url"].Value; }}
    }
}

