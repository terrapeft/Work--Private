using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web;

namespace UsersDb
{
	/// <summary>
	/// Accessor for appSettings section of web.config.
	/// </summary>
	public class Config
	{

		#region Connection strings

        /// <summary>
        /// Gets the Users db connection string.
        /// </summary>
        /// <value>
        /// The users connection string.
        /// </value>
        public static string ConnectionStringCipherKey
        {
            get { return ConfigurationManager.AppSettings["connectionStringCipherKey"]; }
        }

		/// <summary>
		/// Gets the Users db connection string.
		/// </summary>
		/// <value>
		/// The users connection string.
		/// </value>
		public static string UsersConnectionString
		{
			get { return ConfigurationManager.ConnectionStrings["UsersConnectionString"].ConnectionString; }
		}

		public static string TDServiceURL
		{
			get { return ConfigurationManager.AppSettings["serviceUrl"]; }
		}

		/// <summary>
		/// Gets the EF's UsersEntities connection string.
		/// </summary>
		/// <value>
		/// The users connection string.
		/// </value>
		public static string EFConnectionString
		{
			get { return ConfigurationManager.ConnectionStrings["UsersEntities"].ConnectionString; }
		}

		#endregion

		#region Encryption related properties

		/// <summary>
		/// Provides the length of the salt.
		/// </summary>
		/// <value>
		/// The length of the salt.
		/// </value>
		public static int SaltLength
		{
			get { return Convert.ToInt32(ConfigurationManager.AppSettings["saltLength"]); }
		}

		/// <summary>
		/// Provides the length of the hashed password.
		/// </summary>
		/// <value>
		/// The length of the hashed password.
		/// </value>
		public static int HashedPwdLength
		{
			get { return Convert.ToInt32(ConfigurationManager.AppSettings["hashedPwdLength"]); }
		}

		/// <summary>
		/// Gets the iterations number for PBKDF2 function.
		/// </summary>
		/// <value>
		/// The iterations number.
		/// </value>
		public static int Pbkdf2IterationsNumber
		{
			get { return Convert.ToInt32(ConfigurationManager.AppSettings["iterationsNum"]); }
		}

		#endregion

	}
}