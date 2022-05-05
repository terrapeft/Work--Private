using System;
using System.Collections.Generic;
using System.Text;
using System.Data.Common;
using System.Text.RegularExpressions;
using Jnj.ThirdDimension.Data;
using Jnj.ThirdDimension.Mt.Util;

namespace Jnj.ThirdDimension.Utils.BarcodeSeries
{
   public class ConnectionStringHelper
   {

      #region Public static methods

      public static string GetOdpConnectionString(string info)
      {
         return GetKey("<ODP_CONNECTION_STRING>", "</ODP_CONNECTION_STRING>", info);
      }

      /// <summary>
      /// Decrypts the password in the connection string.
      /// </summary>
      /// <param name="connectionString">The connection string.</param>
      /// <returns>Decrypted connection string.</returns>
      public static string DecryptedConnectionString(string connectionString)
      {
         if (string.IsNullOrEmpty(connectionString)) return string.Empty;

         string pwd = GetKey("password=", ";", connectionString);
         return connectionString.Replace(pwd, Security.XORDecrypt(pwd));
      }

      /// <summary>
      /// Encrypts the connection string.
      /// </summary>
      /// <param name="connectionString">The connection string.</param>
      /// <returns>Decrypted connection string.</returns>
      public static string EncryptConnectionString(string connectionString)
      {
         if (string.IsNullOrEmpty(connectionString)) return string.Empty;

         string pwd = GetKey("password=", ";", connectionString);
         return connectionString.Replace(pwd, Security.XOREncrypt(pwd));
      }

      /// <summary>
      /// Take preconfigured parts of the connection string and use them to create a DbConnectionInfo instance.
      /// </summary>
      /// <param name="connectionString"></param>
      /// <param name="providerType"></param>
      /// <returns></returns>
      public static DbConnectionInfo ParseConnectionString(string connectionString, DataProviderType providerType)
      {
         return new DbConnectionInfo("", connectionString, providerType);
      }

      /// <summary>
      /// Replaces user id.
      /// </summary>
      /// <param name="connectionString">The connection string.</param>
      /// <returns>Decrypted connection string.</returns>
      public static string ChangeUser(string connectionString, string newValue)
      {
         if (string.IsNullOrEmpty(connectionString)) return string.Empty;

         string user = GetKey("User Id=", ";", connectionString);
         return connectionString.Replace(user, newValue);
      }

      /// <summary>
      /// Replaces password.
      /// </summary>
      /// <param name="connectionString">The connection string.</param>
      /// <returns>Decrypted connection string.</returns>
      public static string ChangePassword(string connectionString, string newValue)
      {
         if (string.IsNullOrEmpty(connectionString)) return string.Empty;

         string pwd = GetKey("password=", ";", connectionString);
         return connectionString.Replace(pwd, newValue);
      }

      /// <summary>
      /// Extracts dsn from the connection string.
      /// </summary>
      /// <param name="connString">The conn string.</param>
      /// <returns></returns>
      public static string GetDsn(string connectionString)
      {
         return GetKey("(DESCRIPTION", "))))", connectionString, true);
      }

      /// <summary>
      /// Extracts user from the connection string.
      /// </summary>
      /// <param name="connectionString"></param>
      /// <returns></returns>
      public static string GetUser(string connectionString)
      {
         return GetKey("User Id=", ";", connectionString);
      }

      /// <summary>
      /// Extracts password from the connection string.
      /// </summary>
      /// <param name="connectionString"></param>
      /// <returns></returns>
      public static string GetPassword(string connectionString, bool decrypt)
      {
         if (string.IsNullOrEmpty(connectionString)) return string.Empty;

         string pwd = GetKey("password=", ";", connectionString);
         if (decrypt)
         {
            pwd = Security.XORDecrypt(pwd);
         }
         return pwd;
      }

      /// <summary>
      /// Gets the key skiping the start.
      /// </summary>
      /// <param name="start">The start.</param>
      /// <param name="end">The end.</param>
      /// <param name="source">The source.</param>
      /// <returns></returns>
      public static string GetKey(string start, string end, string source)
      {
         return GetKey(start, end, source, false);
      }

      /// <summary>
      /// Gets the key.
      /// </summary>
      /// <param name="start">The start.</param>
      /// <param name="end">The end.</param>
      /// <param name="source">The source.</param>
      /// <param name="includeMarkup">if set to <c>true</c> the start and end parameters will present in result.</param>
      /// <returns></returns>
      public static string GetKey(string start, string end, string source, bool includeMarkup)
      {
         if (source.Length < start.Length + end.Length) return string.Empty;
         
         int startIndex = source.IndexOf(start, StringComparison.OrdinalIgnoreCase);
         int endIndex = source.IndexOf(end, StringComparison.OrdinalIgnoreCase);

         if (startIndex < 0 || endIndex < 0) return string.Empty;

         string val = source;
         val = val.Substring(val.IndexOf(start, StringComparison.OrdinalIgnoreCase) + (includeMarkup ? 0 : start.Length));
         return val.Substring(0, val.IndexOf(end) + (includeMarkup ? end.Length : 0));
      }

      #endregion

   }
}
