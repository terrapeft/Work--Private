#region Copyright (C) 1994-2009, Johnson & Johnson PRD, LLC.
//---------------------------------------------------------------------------*
//
//    InstantDbAccess.cs: Provides easy access to database when the SeriesDataLayer stuff is unnecessary.
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
using System.Text.RegularExpressions;
using AMS.Profile;
using Oracle.DataAccess.Client;
using System.Data;
using Oracle.DataAccess.Types;
using Jnj.ThirdDimension.Utils.BarcodeSeries;
using System.Reflection;

namespace Jnj.ThirdDimension.Data.BarcodeSeries
{
   /// <summary>
   /// Provides easy access to database when the SeriesDataLayer stuff is unnecessary.
   /// </summary>
   public class InstantDbAccess
   {
            
      #region Members

      private const string SeqRange = "SequenceSP";
      private static readonly string SeqCurrVal = "SeqCurrVal";
      private static readonly string CreateSeq = "CreateSequence";
      private static DbConnectionInfo connInfo;
      private static Config config;
      private static BSDataSet dsCache;

      #endregion

      
      #region Public methods

      public static DbConnectionInfo PrepareDBConnectionInfo(string connectionString, DataProviderType providerType)
      {
         return ConnectionStringHelper.ParseConnectionString(connectionString, providerType);
      }            

      /// <summary>
      /// Connects using the specified connection string.
      /// </summary>
      /// <param name="connString">The conn string.</param>
      /// <returns></returns>
      public static DbConnection Connect(string connString, DataProviderType providerType)
      {
         DbConnectionInfo ci = PrepareDBConnectionInfo(connString, providerType);
         return DbConnection.Open(ci);
      }

      /// <summary>
      /// Generic method to return typed datasets from a query.
      /// </summary>
      /// <typeparam name="T">The typed data table type</typeparam>
      /// <param name="sql">The query with filter</param>
      /// <returns>The typed data table with records after executing query.</returns>
      public static T GetDataTable<T>(string sql, DbConnection provider) where T : DataTable, new()
      {
         T dt = new T();

         if (provider == null)
         {
            throw new Exception("Connection has not been opened for DB operation.");
         }

         try
         {
            provider.Fill(sql, dt);
         }
         catch (Exception ex)
         {
            string msg = string.Format("Got exception in provider.Fill: {0}, the query was: {1}", ex, sql);
            ApplicationException ae = new ApplicationException(msg, ex);
            MessagesHelper.ReportError(ae, false);
            throw ae;
         }

         return dt;
      }

      /// <summary>
      /// Generic method to return typed datasets from a query.
      /// </summary>
      /// <typeparam name="T">The typed data table type</typeparam>
      /// <param name="sql">The query with filter</param>
      /// <returns>The typed data table with records after executing query.</returns>
      public static T GetDataTable<T>(string sql, string filter, DbConnection provider) where T : DataTable, new()
      {
         T dt = new T();

         if (provider == null)
         {
            throw new Exception("Connection has not been opened for DB operation.");
         }

         try
         {
            provider.Fill(string.Format("{0} where {1}", sql, filter), dt);
         }
         catch (Exception ex)
         {
            string msg = string.Format("Got exception in provider.Fill: {0}, the query was: {1}", ex, sql);
            ApplicationException ae = new ApplicationException(msg, ex);
            MessagesHelper.ReportError(ae, false);
            throw ae;
         }

         return dt;
      }

      /// <summary>
      /// Get current sequence value from dba_sequences, using supplied provider.
      /// </summary>
      /// <param name="sequenceOwner">The sequence owner (schema).</param>
      /// <param name="sequenceName">A name of the sequence without schema name.</param>
      /// <param name="provider">The provider.</param>
      /// <returns></returns>
      public static decimal GetSequenceLastNumber(string sequenceOwner, string sequenceName, DbOdpConnection provider)
      {
         string sql = string.Format(GetValue(SeqCurrVal), sequenceName.ToUpper(), sequenceOwner.ToUpper());

         OracleCommand cmd = new OracleCommand(sql, provider.Connection);
         object val = cmd.ExecuteScalar();

         if (val != null && val != DBNull.Value)
         {
            return (decimal)val;
         }
         return -1;
      }

      /// <summary>
      /// Creates the Sequence.
      /// </summary>
      /// <param name="sequenceName">Name of the sequence.</param>
      public static void CreateSequence(string sequenceName, decimal startFrom, DbOdpConnection provider)
      {
         // create sequence
         string sql = string.Format(GetValue(CreateSeq), sequenceName.ToUpper(), startFrom);
         OracleCommand cmd = new OracleCommand(sql, provider.Connection);
         cmd.ExecuteNonQuery();

      }


      /// <summary>
      /// Tries to establish connection and returns the result.
      /// </summary>
      /// <param name="connectionString">The connection string.</param>
      /// <returns></returns>
      public static bool TryConnection(string connectionString, DataProviderType providerType)
      {
         DbConnection conn = Connect(connectionString, providerType);
         bool result = (conn != null);
         conn.Dispose();
         
         return result;
      }

      /// <summary>
      /// Returns a range of sequence values.
      /// </summary>
      /// <param name="count"></param>
      /// <param name="sequence"></param>
      public static decimal[] GetSequenceValues(int count, string sequence, DbOdpConnection provider)
      {
         string anonymousBlock = GetValue("SequenceArray");

         OracleParameter paramCount = new OracleParameter("p1", OracleDbType.Int32, count, ParameterDirection.Input);
         OracleParameter paramSeqName = new OracleParameter("p2", OracleDbType.Varchar2, sequence,
                                                            ParameterDirection.Input);

         // create an associative array parameter
         OracleParameter paramArray = new OracleParameter();
         paramArray.ParameterName = "p3";
         paramArray.OracleDbType = OracleDbType.Decimal;
         paramArray.CollectionType = OracleCollectionType.PLSQLAssociativeArray;
         paramArray.Direction = ParameterDirection.Output;
         paramArray.Size = count;

         // create the command object
         OracleCommand cmd = provider.Connection.CreateCommand();
         cmd.CommandText = anonymousBlock;

         // add the parameters
         cmd.Parameters.Add(paramCount);
         cmd.Parameters.Add(paramSeqName);
         cmd.Parameters.Add(paramArray);

         // execute the anonymous block
         cmd.ExecuteNonQuery();
         
         List<decimal> sequences = new List<decimal>();
         ((OracleDecimal[]) paramArray.Value).ToList().ForEach(v => sequences.Add((decimal) v));

         return sequences.ToArray();
      }

      #endregion


      #region Private stuff
      /// <summary>
      /// Loads and returns the app.config file.
      /// </summary>
      private static Config Config
      {
         get
         {
            if (config == null)
            {
               // Init config information
               Uri uri = new Uri(Assembly.GetAssembly(typeof(InstantDbAccess)).GetName().CodeBase);
               string filePath = uri.LocalPath + ".config";
               config = new Config(filePath);
               config.GroupName = null;
            }

            return config;
         }
      }

      /// <summary>
      /// Returns the configuration value for the given entry
      /// </summary>
      /// <param name="key"></param>
      /// <returns></returns>
      private static string GetValue(string key)
      {
         return Config.GetValue("appSettings", key, string.Empty);
      }

      #endregion

   }
}
