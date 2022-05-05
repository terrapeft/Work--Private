#region Copyright (C) 1994-2009, Johnson & Johnson PRD, LLC.
//---------------------------------------------------------------------------*
//
//    SeriesDataLayer.cs: Contains database access methods for Series.
//
//---
//
//    Copyright (C) 1994-2009, Johnson & Johnson PRD, LLC.
//    All Rights Reserved.
//
//    Vitaly Chupaev, 11/2009
//
//---------------------------------------------------------------------------*/
#endregion

using System;
using Oracle.DataAccess.Client;
using System.Data;
using System.Reflection;
using AMS.Profile;
using Jnj.ThirdDimension.Utils.BarcodeSeries;

namespace Jnj.ThirdDimension.Data.BarcodeSeries
{
   public partial class SeriesDataLayer : IDataLayer
   {

      #region Members

      private const string SeqRange = "SequenceSP";
      private static readonly string SeqCurrVal = "SeqCurrVal";
      private static readonly string CreateSeq = "CreateSequence";
      private static BSDataSet dsCache;

      private DbConnectionInfo connInfo;
      private Config config;

      private DbOdpConnection provider;
      private Series series;
      private Metadata metadata;
      private Instrument instrument;
      private IDbTransaction transaction;

      public const string SEQ_SCHEMA_NAME = "ABCDSERIES100";

      private SecurityContext seqCont;
      #endregion


      #region Constructor

      public SeriesDataLayer(string connStr)
      {
         connStr = ConnectionStringHelper.DecryptedConnectionString(connStr);
         connInfo = InstantDbAccess.PrepareDBConnectionInfo(connStr, DataProviderType.ODP);

         Initialize(connInfo);
      }

      public SeriesDataLayer(DbConnectionInfo connectionInfo)
      {
         Initialize(connectionInfo);
      }

      private void Initialize(DbConnectionInfo connectionInfo)
      {
         if (dsCache == null)
         {
            // Init cahche
            dsCache = new BSDataSet();
            dsCache.DataSetName = "Series Cache";
         }

         // Init connection info
         connInfo = connectionInfo;
         ConnectionsCount = 0;

         seqCont = new SecurityContext();
         series = new Series(this);
         metadata = new Metadata(this);
         instrument = new Instrument(this);
      }

      #endregion


      #region Properties

      public int ConnectionsCount { get; set; }

      /// <summary>
      /// Provides access to data set.
      /// </summary>
      public BSDataSet DataSet
      {
         get { return dsCache; }
      }

      /// <summary>
      /// Instance of LabelSeries class.
      /// </summary>
      public Series SeriesDB
      {
         get { return series; }
      }

      /// <summary>
      /// Instance of Instrument class.
      /// </summary>
      public Instrument InstrumentDB
      {
         get { return instrument; }
      }

      /// <summary>
      /// Instance of Meatadata class.
      /// </summary>
      public Metadata MetadataDB
      {
         get { return metadata; }
      }

      /// <summary>
      /// Information about current user.
      /// </summary>
      public SecurityContext SecurityContext
      {
         get { return seqCont; }
      }

      /// <summary>
      /// Returns the configuration value for the given entry
      /// </summary>
      /// <param name="key">The name of the value.</param>
      /// <returns>The value or empty string.</returns>
      /// <summary>
      /// Returns the value of a simple setting in the configuration file.
      /// </summary>
      public string this[string key]
      {
         get
         {
            return Config.GetValue("appSettings", key, string.Empty);
         }
      }

      /// <summary>
      /// Loads and returns the app.config file.
      /// </summary>
      private Config Config
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

      #endregion


      #region Connection methods

      /// <summary>
      /// Check if connection open.
      /// </summary>
      public bool IsConnected
      {
         get
         {
            return ((provider != null) && (provider.Connection.State == ConnectionState.Open));
         }
      }

      /// <summary>
      /// Tries to connect using the specified conn string.
      /// </summary>
      /// <param name="connString">The conn string.</param>
      /// <returns/>
      public DataLayerConnection Connect()
      {
         if (!IsConnected)
         {
            provider = DbOdpConnection.Open(connInfo);
         }

         return new DataLayerConnection(provider, this);
      }


      /// <summary>
      /// Closes the connection.
      /// </summary>
      public void Disconnect()
      {
         if (IsConnected)
         {
            provider.Disconnect();
            provider = null;
         }
      }

      #endregion


      #region Base DB operations



      /// <summary>
      /// Generic method to return typed datasets from a query.
      /// </summary>
      /// <typeparam name="T"></typeparam>
      /// <param name="sql">The SQL.</param>
      /// <param name="provider">The provider.</param>
      /// <returns></returns>
      private T Get<T>(string sql) where T : DataTable, new()
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
      /// <param name="sql">The query without filter</param>
      /// <param name="filter">filtering information</param>
      /// <returns>The typed data table with records after executing query.</returns>
      public T Get<T>(string sql, string filter) where T : DataTable, new()
      {
         if (string.IsNullOrEmpty(filter))
         {
            throw new ArgumentException("Expecting filtering string when retrieving records", "filter");
         }
         return Get<T>(string.Format("{0} where {1}", sql, filter));
      }

      /// <summary>
      /// Given a data table
      /// </summary>
      /// <param name="dt"></param>
      /// <param name="col"></param>
      /// <param name="sequence"></param>
      public void SetSequenceValues(DataTable dt, int col, string sequence)
      {
         if (dt.Columns[col].DataType != typeof(decimal)) throw new ApplicationException("Expecting decimal column... ");

         // Find out how many rows need a sequence value. Must be a new row with col value <= 0.
         // Assumes the col is of decimal type.
         int count = 0;
         foreach (DataRow dr in dt.Rows)
         {
            count += (dr.RowState == DataRowState.Added && (decimal)dr[col] < 0m) ? 1 : 0;
         }

         // Get the sequence values and populate table.
         if (count > 0)
         {
            decimal[] seq = InstantDbAccess.GetSequenceValues(count, sequence, provider);

            // Populate the table with sequence values.
            count = 0;
            foreach (DataRow dr in dt.Rows)
            {
               if (dr.RowState != DataRowState.Added || (decimal)dr[col] >= 0m) continue;

               dr[col] = seq[count];
               ++count;
            }
         }
      }

      /// <summary>
      /// Gets the scalar.
      /// </summary>
      /// <param name="sql">The SQL.</param>
      /// <returns></returns>
      public object GetScalar(string sql)
      {
         OracleCommand cmd = new OracleCommand(sql, provider.Connection);
         object val = cmd.ExecuteScalar();
         return (decimal?)val;
      }

      /// <summary>
      /// Gets the scalar.
      /// </summary>
      /// <param name="sql">The SQL.</param>
      /// <param name="filter">The filter.</param>
      /// <returns></returns>
      public object GetScalar(string sql, string filter)
      {
         OracleCommand cmd = new OracleCommand(string.Format("{0} where {1}", sql, filter), provider.Connection);
         object val = cmd.ExecuteScalar();
         return (decimal?)val;
      }


      #endregion


      #region Transactions

      /// <summary>
      /// Indicates if a transaction has been started.
      /// </summary>
      public bool InTransaction
      {
         get { return transaction != null; }
      }

      /// <summary>
      /// To be used by smart class to reset transaction
      /// </summary>
      internal IDbTransaction Transaction
      {
         set
         {
            transaction = value;
         }
      }

      /// <summary>
      /// Starts a transaction
      /// </summary>
      public IDbTransaction BeginTransaction()
      {
         if (IsConnected)
         {
            transaction = provider.BeginTransaction();
         }
         else
         {
            throw new ApplicationException("Must connect before starting transaction");
         }

         return transaction;
      }

      /// <summary>
      /// Commits a transaction
      /// </summary>
      public void Commit()
      {
         transaction.Commit();
         transaction = null;
      }

      /// <summary>
      /// Rollsback changes in a transaction
      /// </summary>
      public void Rollback()
      {
         transaction.Rollback();
         transaction = null;
      }

      #endregion
   }

   /// <summary>
   /// Smart class which auto-disposes connection
   /// </summary>
   public class DataLayerConnection : IDisposable
   {
      private readonly DbOdpConnection connection;
      private readonly IDataLayer parent;

      public DataLayerConnection(DbOdpConnection connection, IDataLayer parent)
      {
         this.connection = connection;
         this.parent = parent;
         this.parent.ConnectionsCount++;
      }

      ~DataLayerConnection()
      {
         Dispose(true);
      }

      public void Dispose()
      {
         Dispose(false);
         GC.SuppressFinalize(this);
      }

      protected void Dispose(bool forceDisposing)
      {
         if (parent.ConnectionsCount == 1 || forceDisposing)
         {
            if (parent.IsConnected)
            {
               parent.Disconnect();
            }
         }
         parent.ConnectionsCount--;
      }

      public DbOdpConnection Connection
      {
         get
         {
            return connection;
         }
      }
   }
}
