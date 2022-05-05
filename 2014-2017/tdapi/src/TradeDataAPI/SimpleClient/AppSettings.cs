using System;
using System.Collections.Generic;
using System.Configuration;
using System.Reflection;
using System.Collections.Specialized;

namespace SimpleClient
{
    public static class AppSettings 
	{
        private static AppSettingsSection _appSettings;

        private static NameValueCollection SettingsSection
        {
            get { return ConfigurationManager.AppSettings; }
        }

        
		/// <summary>
        /// Like "32"
        /// </summary>
		public static int saltLength => int.Parse(SettingsSection["saltLength"]);
        
		/// <summary>
        /// Like "32"
        /// </summary>
		public static int hashedPwdLength => int.Parse(SettingsSection["hashedPwdLength"]);
        
		/// <summary>
        /// Like "10000"
        /// </summary>
		public static int iterationsNum => int.Parse(SettingsSection["iterationsNum"]);
		
		/// <summary>
        /// Like "VN6J87*LfzcR*CBmzvF4K6zg|-w2R+l|%YC|B5fR^ARCvV9n8T7IVEk3Tiqz"
        /// </summary>
		public static string connectionStringCipherKey => SettingsSection["connectionStringCipherKey"];
		
		/// <summary>
        /// Like "LocalSqlServer;OracleServices"
        /// </summary>
        public static IEnumerable<string> excludeConnStr => SettingsSection["excludeConnStr"].Split(new [] {';'}, StringSplitOptions.RemoveEmptyEntries);
		
		/// <summary>
        /// Like "http://tdapi.uat/"
        /// </summary>
		public static string baseURL => SettingsSection["baseURL"];
		
		/// <summary>
        /// Like "vchupaev@mail.ru"
        /// </summary>
		public static string defaultUser => SettingsSection["defaultUser"];
		
		/// <summary>
        /// Like "123"
        /// </summary>
		public static string defaultPwd => SettingsSection["str:defaultPwd"];
		
		/// <summary>
        /// Like "usr"
        /// </summary>
		public static string UsersDbAlias => SettingsSection["UsersDbAlias"];
		
		/// <summary>
        /// Like "spTDAppSelect"
        /// </summary>
		public static string storedProcPrefix => SettingsSection["storedProcPrefix"];
		
		/// <summary>
        /// Like "@param"
        /// </summary>
		public static string storedProcParamPrefix => SettingsSection["storedProcParamPrefix"];
		
		/// <summary>
        /// Like "Get"
        /// </summary>
		public static string storedProcPubPrefix => SettingsSection["storedProcPubPrefix"];
		
		/// <summary>
        /// Like "dbo"
        /// </summary>
		public static string storedProcOwner => SettingsSection["storedProcOwner"];
		
		/// <summary>
        /// Like "select routine_schema + '.' + routine_name as name from {0}.information_schema.routines           where routine_type = 'PROCEDURE' and routine_name like '{1}%' order by name asc"
        /// </summary>
		public static string loadStoredProcsSql => SettingsSection["loadStoredProcsSql"];
    }
}

