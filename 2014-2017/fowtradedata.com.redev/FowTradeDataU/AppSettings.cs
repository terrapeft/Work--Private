using System;
using System.Collections.Generic;
using System.Configuration;
using System.Reflection;

namespace FowTradeDataU.umbraco.CustomWebForms
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

        private static AppSettingsSection SettingsSection
        {
			get { return _appSettings ?? (_appSettings = (AppSettingsSection) Config.GetSection("appSettings")); }
        }

		
		/// <summary>
        /// Like "00N7E000000FogB"
        /// </summary>
		public static string SalesForce_Subcategory1_Name { get { return SettingsSection.Settings["TD:SalesForce_Subcategory1_Name"].Value; }}
		
		/// <summary>
        /// Like "00N7E000000FogC"
        /// </summary>
		public static string SalesForce_Subcategory2_Name { get { return SettingsSection.Settings["TD:SalesForce_Subcategory2_Name"].Value; }}
		
		/// <summary>
        /// Like "00N7E000000G6t8"
        /// </summary>
		public static string SalesForce_Impact_Name { get { return SettingsSection.Settings["TD:SalesForce_Impact_Name"].Value; }}
		
		/// <summary>
        /// Like "https://euromoneyplc--EIIUAT.cs86.my.salesforce.com/servlet/servlet.WebToCase?encoding=UTF-8"
        /// </summary>
		public static string SalesForce_Form_Action { get { return SettingsSection.Settings["TD:SalesForce_Form_Action"].Value; }}
		
		/// <summary>
        /// Like "00N7E000000G0MD"
        /// </summary>
		public static string SalesForce_Form_Field1_Name { get { return SettingsSection.Settings["TD:SalesForce_Form_Field1_Name"].Value; }}
		
		/// <summary>
        /// Like "0127E00000006CG"
        /// </summary>
		public static string SalesForce_Form_CaseRecordType_Name { get { return SettingsSection.Settings["TD:SalesForce_Form_CaseRecordType_Name"].Value; }}
		
		/// <summary>
        /// Like "00N7E000000GD21"
        /// </summary>
		public static string SalesForce_Form_AttachmentId_Name { get { return SettingsSection.Settings["TD:SalesForce_Form_AttachmentId_Name"].Value; }}
		
		/// <summary>
        /// Like "00D7E000000CoW7"
        /// </summary>
		public static string SalesForce_Form_OrgId_Value { get { return SettingsSection.Settings["TD:SalesForce_Form_OrgId_Value"].Value; }}
		
		/// <summary>
        /// Like "Sales & Account Management"
        /// </summary>
		public static string SalesForce_Form_HideImpact_Value { get { return SettingsSection.Settings["TD:SalesForce_Form_HideImpact_Value"].Value; }}
		
		/// <summary>
        /// Like "SELECT * FROM vwMembers"
        /// </summary>
		public static string BackEnd_DataSource_Members { get { return SettingsSection.Settings["TD:BackEnd_DataSource_Members"].Value; }}
		
		/// <summary>
        /// Like "SELECT Companyid, Name FROM Companies"
        /// </summary>
		public static string BackEnd_DataSource_Members_CompanyDdl { get { return SettingsSection.Settings["TD:BackEnd_DataSource_Members_CompanyDdl"].Value; }}
		
		/// <summary>
        /// Like "SELECT * FROM Companies"
        /// </summary>
		public static string BackEnd_DataSource_Companies { get { return SettingsSection.Settings["TD:BackEnd_DataSource_Companies"].Value; }}
		
		/// <summary>
        /// Like "SELECT * FROM vwDropDownListOptions order by DropDownListId, [OrderBy], OptionId"
        /// </summary>
		public static string BackEnd_DataSource_DdlOptions { get { return SettingsSection.Settings["TD:BackEnd_DataSource_DdlOptions"].Value; }}
		
		/// <summary>
        /// Like "select DropDownListId, Name from DropDownLists"
        /// </summary>
		public static string BackEnd_DataSource_DdlOptions_DdlDropDownLists { get { return SettingsSection.Settings["TD:BackEnd_DataSource_DdlOptions_DdlDropDownLists"].Value; }}
		
		/// <summary>
        /// Like "SELECT * FROM vwHierarchy order by DropDownListId, ParentHierarchyId, HierarchyId"
        /// </summary>
		public static string BackEnd_DataSource_DdlHierarchy { get { return SettingsSection.Settings["TD:BackEnd_DataSource_DdlHierarchy"].Value; }}
		
		/// <summary>
        /// Like "select Name, OptionId from vwDdlNameValue"
        /// </summary>
		public static string BackEnd_DataSource_DdlHierarchy_OptionsDdl { get { return SettingsSection.Settings["TD:BackEnd_DataSource_DdlHierarchy_OptionsDdl"].Value; }}
		
		/// <summary>
        /// Like "SELECT * FROM vwSupportRequests"
        /// </summary>
		public static string BackEnd_DataSource_Requests { get { return SettingsSection.Settings["TD:BackEnd_DataSource_Requests"].Value; }}
		
		/// <summary>
        /// Like "SELECT * FROM vwSiteConfig order by name"
        /// </summary>
		public static string BackEnd_DataSource_Configuration { get { return SettingsSection.Settings["TD:BackEnd_DataSource_Configuration"].Value; }}
		
		/// <summary>
        /// Like "select Id, Name from resourcetype"
        /// </summary>
		public static string BackEnd_DataSource_Configuration_DdlResType { get { return SettingsSection.Settings["TD:BackEnd_DataSource_Configuration_DdlResType"].Value; }}
		
		/// <summary>
        /// Like "SELECT * FROM vwElmahError order by TimeUTC desc"
        /// </summary>
		public static string BackEnd_DataSource_Errors { get { return SettingsSection.Settings["TD:BackEnd_DataSource_Errors"].Value; }}
		
		/// <summary>
        /// Like "SELECT * FROM SalesforceFieldsMapping"
        /// </summary>
		public static string BackEnd_DataSource_FieldsMapping { get { return SettingsSection.Settings["TD:BackEnd_DataSource_FieldsMapping"].Value; }}
    }
}

