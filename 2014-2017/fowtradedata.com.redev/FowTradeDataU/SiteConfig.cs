//------------------------------------------------------------------------------
// <auto-generated>
//    This code was generated from a template.
//
//    Manual changes to this file may cause unexpected behavior in your application.
//    Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace FowTradeDataU.umbraco.CustomWebForms
{
	using System;
	using System.Linq;
	using System.Collections.Generic;
	using System.Threading.Tasks;
	using TDUmbracoMembership;
	using SharedLibrary.Cache;

	public class SiteConfig
	{
		private static object _lock = new object();
		private const string NO_RESOURCE_FOUND = "Requested string was not found.";
		private static UmbracoMembersEntities dataContext = new UmbracoMembersEntities();

		public static void PreloadAsync()
		{
            Task.Factory.StartNew(() =>
            {
				GetString(8);
				GetString(9);
				GetString(10);
				GetString(11);
				GetString(12);
				GetString(13);
				GetString(14);
				GetString(15);
				GetString(16);
				GetString(17);
				GetString(18);
				GetString(21);
				GetString(22);
            });
		    
            Task.WaitAll();
		}


		/// <summary>
		/// Is used in the FROM field.
		/// </summary>
		public static string Smtp_Sender_NoCache { get { return GetString(1, true); } }

		/// <summary>
		/// This option should be set to True if TLS is enabled.
		/// </summary>
		public static bool Smtp_Enable_SSL_NoCache { get { return GetBoolean(2, true); } }

		/// <summary>
		/// 
		/// </summary>
		public static string Smtp_Host_NoCache { get { return GetString(3, true); } }

		/// <summary>
		/// 
		/// </summary>
		public static int Smtp_Port_NoCache { get { return GetInt(4, true); } }

		/// <summary>
		/// Email(s) of person(s) in charge to receive notifications from the system.
		/// </summary>
		public static string Smtp_Recipients_NoCache { get { return GetString(5, true); } }

		/// <summary>
		/// 
		/// </summary>
		public static string Smtp_Password_NoCache { get { return GetString(6, true); } }

		/// <summary>
		/// Root folder to place attachments of support requests.
		/// </summary>
		public static string Attachments_Root_NoCache { get { return GetString(7, true); } }

		/// <summary>
		/// Salesforce form field
		/// </summary>
		public static string SF_Form_Name { get { return GetString(8, false); } }

		/// <summary>
		/// Salesforce form field
		/// </summary>
		public static string SF_Form_Email { get { return GetString(9, false); } }

		/// <summary>
		/// Salesforce form field
		/// </summary>
		public static string SF_Form_Subject { get { return GetString(10, false); } }

		/// <summary>
		/// Salesforce form field
		/// </summary>
		public static string SF_Form_Query_Type { get { return GetString(11, false); } }

		/// <summary>
		/// Salesforce form field
		/// </summary>
		public static string SF_Form_Query_Type_2 { get { return GetString(12, false); } }

		/// <summary>
		/// Salesforce form field
		/// </summary>
		public static string SF_Form_Query_Type_3 { get { return GetString(13, false); } }

		/// <summary>
		/// Salesforce form field
		/// </summary>
		public static string SF_Form_Description { get { return GetString(14, false); } }

		/// <summary>
		/// Salesforce form field
		/// </summary>
		public static string SF_Form_Priority { get { return GetString(15, false); } }

		/// <summary>
		/// Salesforce form field
		/// </summary>
		public static string SF_Form_Impact { get { return GetString(16, false); } }

		/// <summary>
		/// Salesforce form field
		/// </summary>
		public static string SF_Form_Attachments { get { return GetString(17, false); } }

		/// <summary>
		/// Validation message, when content length was exceeded.
		/// </summary>
		public static string SF_Form_Attachments_Error { get { return GetString(18, false); } }

		/// <summary>
		/// Placeholder {0} stands for the submitted query's subject
		/// </summary>
		public static string SF_Form_Submit_message { get { return GetString(21, false); } }

		/// <summary>
		/// Message is shown, when something went wrong.
		/// Real error can be found in the Errors Log.
		/// </summary>
		public static string SF_Form_Failed { get { return GetString(22, false); } }

		/// <summary>
		/// Sent to administrator after a request submission.
		/// {0} stands for the subject field of the form.
		/// </summary>
		public static string Smtp_Notification_Email_Subject_NoCache { get { return GetString(23, true); } }

		/// <summary>
		/// {0} stands for the attachment filled template,
		///    see the:
		///       Smtp Body Folder Line
		///       Smtp Body File Line
		///       Smtp Body Last File Line
		/// 
		/// {1} stands for the submitted description
		/// </summary>
		public static string Smtp_Body_NoCache { get { return GetString(25, true); } }

		/// <summary>
		/// Notice linebreak after the {0}!
		/// 
		/// {0} stands for \\machine\SF_FILES\TestCompany\71
		/// 
		/// from the
		/// \\machine\SF_FILES\TestCompany\71
		/// ┣File1.txt
		/// ┗File2.txt
		/// 
		/// </summary>
		public static string Smtp_Body_Folder_Line_NoCache { get { return GetString(26, true); } }

		/// <summary>
		/// Notice linebreak after the {0}!
		/// 
		/// {0} stands for ‣File1.txt
		/// 
		/// from 
		/// \\machine\SF_FILES\TestCompany\71
		/// ┣File1.txt
		/// ┗File2.txt
		/// 
		/// </summary>
		public static string Smtp_Body_File_Line_NoCache { get { return GetString(27, true); } }

		/// <summary>
		/// Notice linebreaks after the {0}!
		/// 
		/// {0} stands for ‣File2.txt
		/// 
		/// from 
		/// \\machine\SF_FILES\TestCompany\71
		/// ┣File1.txt
		/// ┗File2.txt
		/// </summary>
		public static string Smtp_Body_Last_File_Line_NoCache { get { return GetString(28, true); } }

		/// <summary>
		/// True or False
		/// </summary>
		public static bool Smtp_Body_Is_Html_NoCache { get { return GetBoolean(29, true); } }

		/// <summary>
		/// User submits the form, the form values then included into email. 
		/// Each line stands for some value, e.g.
		/// Subject: Help!
		/// 
		/// {0} stands for the field name,
		/// {1} stands for the value
		/// </summary>
		public static string Smtp_Body_Form_Line_NoCache { get { return GetString(30, true); } }

		private static string GetString(int id, bool skipCaching = true)
		{
			return CacheHelper.Get<string>("ServiceConfig" + id, () =>
			{
				lock (_lock)
				{
					var val = dataContext.SiteConfigs.FirstOrDefault(str => str.Id == id);
                    if (skipCaching) dataContext.Entry(val).Reload();

					if (val != null)
					{
						return val.Value;
					}

					throw new Exception(NO_RESOURCE_FOUND);
				}
			}, skipCaching);
		}

		private static bool GetBoolean(int id, bool skipCaching = true)
		{
			return CacheHelper.Get<bool>("ServiceConfig" + id, () =>
			{
				lock (_lock)
				{
					var val = dataContext.SiteConfigs.FirstOrDefault(str => str.Id == id);
                    if (skipCaching) dataContext.Entry(val).Reload();

					if (val != null)
					{
						return Convert.ToBoolean(val.Value);
					}

					throw new Exception(NO_RESOURCE_FOUND);
				}
			}, skipCaching);
		}

		private static int GetInt(int id, bool skipCaching = true)
		{
			return CacheHelper.Get<int>("ServiceConfig" + id, () =>
			{
				lock (_lock)
				{
					var val = dataContext.SiteConfigs.FirstOrDefault(str => str.Id == id);
                    if (skipCaching) dataContext.Entry(val).Reload();

					if (val != null)
					{
						return Convert.ToInt32(val.Value);
					}

					throw new Exception(NO_RESOURCE_FOUND);
				}
			}, skipCaching);
		}

		private static List<string> GetStringList(int id, bool strict, bool skipCaching = true)
		{
			return CacheHelper.Get<List<string>>("ServiceConfig" + id, () =>
			{
				lock (_lock)
				{
					var val = dataContext.SiteConfigs.FirstOrDefault(str => str.Id == id);
                    if (skipCaching) dataContext.Entry(val).Reload();

					if (val != null)
					{
						var delimiters = strict ? new[] { Environment.NewLine, "\n" } : new[] { Environment.NewLine, ",", " ", "\n", "\t" };

						return val.Value == null 
							? new List<string>()
							: val.Value
								.Split(delimiters, StringSplitOptions.RemoveEmptyEntries)
								.ToList();
					}

					throw new Exception(NO_RESOURCE_FOUND);
				}
			}, skipCaching);
		}

		private static List<int> GetIntegerList(int id, bool skipCaching = true)
		{
			return CacheHelper.Get<List<int>>("ServiceConfig" + id, () =>
			{
				lock (_lock)
				{
					var val = dataContext.SiteConfigs.FirstOrDefault(str => str.Id == id);
                    if (skipCaching) dataContext.Entry(val).Reload();

					if (val != null)
					{
						return val.Value
							.Split(new[] { Environment.NewLine, ",", " ", "\n", "\t" }, StringSplitOptions.RemoveEmptyEntries)
							.Select(s => {
							    int iVal;
								if (int.TryParse(s, out iVal)) return iVal;
								return -1;})
							.Where(n => n > -1)
							.ToList();
					}

					throw new Exception(NO_RESOURCE_FOUND);
				}
			}, skipCaching);
		}
	}
}

