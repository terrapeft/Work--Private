using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations;
using System.Data.Objects.DataClasses;
using System.Data.SqlClient;
using System.ServiceModel;
using SharedLibrary.Cache;
using SharedLibrary.SmartScaffolding;
using System.Linq;
using System.Reflection;
using Microsoft.SqlServer.Management.Smo;
using SharedLibrary.Passwords;
using SharedLibrary.SmartScaffolding.Attributes;
using UsersDb.Helpers;

namespace UsersDb.DataContext
{
    [Description("Changes will take effect for any user only after his or her session is restarted!<br>NB! DB alias is hardcoded in the trial email template.")]
    [MetadataType(typeof(DatabaseConfigurationMetadata))]
    public partial class DatabaseConfiguration : IAuditable
    {
        private static List<DatabaseConfiguration> Cache
        {
            get
            {
                return CacheHelper.Get("DatabaseConfiguration", () =>
                {
                    using (var dc = new UsersDataContext())
                    {
                        var data = dc.DatabaseConfigurations.Where(d => !d.IsDeleted).ToList();
                        CacheHelper.Add("DatabaseConfiguration", data);
                        return data;
                    }
                });
            }
        }

        public override bool Equals(object obj)
        {
            var y = obj as DatabaseConfiguration;
            return _Alias == y._Alias;
        }

        public override int GetHashCode()
        {
            return Alias.GetHashCode();
        }

        public override string ToString()
        {
            return Alias;
        }

        #region Static methods

        public static string GetConnectionString(string dbAlias)
        {
            var configuration = Cache.FirstOrDefault(d => d.Alias == dbAlias);
            return configuration != null 
                ? CommonHelper.DecryptConnectionString(configuration.ConnectionString) 
                : string.Empty;
        }

        public static string GetStoredProcPrefix(string dbAlias)
        {
            var configuration = Cache.FirstOrDefault(d => d.Alias == dbAlias);
            return configuration != null ? configuration.StoredProcPrefix : string.Empty;
        }

        public static string GetStoredProcParamPrefix(string dbAlias)
        {
            var configuration = Cache.FirstOrDefault(d => d.Alias == dbAlias);
            return configuration != null ? configuration.StoredProcParamPrefix : string.Empty;
        }

        public static string GetStoredProcMethodPrefix(string dbAlias)
        {
            var configuration = Cache.FirstOrDefault(d => d.Alias == dbAlias);
            return configuration != null ? configuration.StoredProcMethodPrefix : string.Empty;
        }

        public static string GetStoredProcOwner(string dbAlias)
        {
            var configuration = Cache.FirstOrDefault(d => d.Alias == dbAlias);
            return configuration != null ? configuration.StoredProcOwner : string.Empty;
        }

        public static string GetStoredProcInformerPrefix(string dbAlias)
        {
            var configuration = Cache.FirstOrDefault(d => d.Alias == dbAlias);
            return configuration != null ? configuration.StoredProcInformerPrefix : string.Empty;
        }

        #endregion
    }

    [DisplayName("Database Configuration")]
    [TableCategory("System Settings")]
    public class DatabaseConfigurationMetadata
    {
        [OrderBy]
        public object Alias { get; set; }

        [DisplayName("Connection string")]
        [UIHint("ConnectionString")]
        public object ConnectionString { get; set; }

        [DisplayName("SP Prefix")]
        public object StoredProcPrefix { get; set; }

        [DisplayName("Parameter prefix")]
        public object StoredProcParamPrefix { get; set; }

        [DisplayName("Method prefix")]
        public object StoredProcMethodPrefix { get; set; }

        [DisplayName("Owner")]
        public object StoredProcOwner { get; set; }

        [DisplayName("Informer prefix")]
        public object StoredProcInformerPrefix { get; set; }

        [DisplayName("Default")]
        public object IsDefault { get; set; }

        [DisplayName("Deleted")]
        public object IsDeleted { get; set; }
    }

    public class DbConfItem
    {
        public string DatabaseAlias;
        public string Key;
        public string Value;
    }
}
