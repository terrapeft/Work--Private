using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Reflection;
using System.Text;
using AMS.Profile;
using Jnj.ThirdDimension.Mt.Util;
using Jnj.ThirdDimension.Utils.BarcodeSeries;

namespace Jnj.ThirdDimension.Data.BarcodeSeries
{
    public class InventoryDataLayer : IDataLayer
    {
        private DbConnectionInfo connInfo;
        private Config config;
        private DbOdpConnection provider;

        /// <summary>
        /// Initializes a new instance of the <see cref="InventoryDataLayer" /> class.
        /// </summary>
        /// <param name="connStr">The connection string with user and encrypted password.</param>
        public InventoryDataLayer(string connStr)
        {
            connStr = ConnectionStringHelper.DecryptedConnectionString(connStr);
            connInfo = InstantDbAccess.PrepareDBConnectionInfo(connStr, DataProviderType.ODP);

            ConnectionsCount = 0;
        }

        /// <summary>
        /// Returns records for Instrument containers that match the given filter.
        /// </summary>
        /// <param name="filter">The filtering criteria to use for the query.</param>
        /// <returns>A table with records found.</returns>
        public InventoryDataSet.InstrumentDataTable GetBarcodePrinters(string filter)
        {
            return string.IsNullOrEmpty(filter)
                ? Get<InventoryDataSet.InstrumentDataTable>(this["inventoryInstrumentsSql"])
                : Get<InventoryDataSet.InstrumentDataTable>(this["inventoryInstrumentsSql"], filter);
        }

        /// <summary>
        /// Returns records for Instrument containers.
        /// </summary>
        /// <returns>A table with records found.</returns>
        public InventoryDataSet.InstrumentDataTable GetBarcodePrinters()
        {
           return Get<InventoryDataSet.InstrumentDataTable>(this["inventoryInstrumentsSql"]);
        }

        public InventoryDataSet.InstrumentDataTable GetInstrumentTypesForPrinters()
        {
           return Get<InventoryDataSet.InstrumentDataTable>(this["inventoryInstrumentTypesSql"]);
        }

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
            string query = sql.ToLower().Contains(" where ")
                ? string.Format("{0} and {1}", sql, filter)
                : string.Format("{0} where {1}", sql, filter);
            return Get<T>(query);
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

        #region Connection methods

        public int ConnectionsCount { get; set; }

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
    }
}
