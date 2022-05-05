using System;
using System.Configuration;
using System.Reflection;

namespace TDUmbracoMembership
{
    public static class AppSettings 
	{
        private static Configuration Config
        {
            get
            {
                Configuration cfg = null;
                try
                {
                    cfg = ConfigurationManager.OpenExeConfiguration(ConfigurationUserLevel.None);
                }
                catch (ArgumentException)
                {
                }

                return cfg ?? ConfigurationManager.OpenExeConfiguration(new Uri(Assembly.GetExecutingAssembly().GetName().CodeBase).LocalPath);
            }
        }
        private static AppSettingsSection _appSettings;
        private static ConnectionStringsSection _connections;

        private static AppSettingsSection SettingsSection
        {
			get { return _appSettings ?? (_appSettings = (AppSettingsSection) Config.GetSection("appSettings")); }
        }

        private static ConnectionStringsSection Connections
        {
			get { return _connections ?? (_connections = (ConnectionStringsSection) Config.GetSection("connectionStrings")); }
        }

        public static string LocalSqlServerConnectionString { get { return Connections.ConnectionStrings["LocalSqlServer"].ConnectionString; }}
        public static string UmbracoMembersEntitiesConnectionString { get { return Connections.ConnectionStrings["UmbracoMembersEntities"].ConnectionString; }}
    }
}

