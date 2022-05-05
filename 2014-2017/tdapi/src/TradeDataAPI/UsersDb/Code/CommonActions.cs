using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Linq;
using SharedLibrary;
using UsersDb.DataContext;
using UsersDb.Helpers;

namespace UsersDb.Code
{
    public class CommonActions
    {
        public static Func<DataTable> LoadXymRootLevelGlobalFunc = () =>
        {
            using (var helper = new DbHelper(Config.UsersConnectionString))
            {
                helper.Connection.Open();
                var dts = helper.CallStoredProcedure("dbo.spCUIGetXymRootLevelGLOBAL");
                return dts.Tables.Count > 0 ? dts.Tables[0].Detach() : new DataTable();
            }
        };

        public static Func<string, DataTable> LoadExchangeCodesFunc = (dbAlias) =>
        {
            using (var helper = new DbHelper(DatabaseConfiguration.GetConnectionString(dbAlias)))
            {
                helper.Connection.Open();
                var dts = helper.CallStoredProcedure("dbo.spTDAppSelectExchangeCodes");
                return dts.Tables.Count > 0 ? dts.Tables[0].Detach() : new DataTable();
            }
        };

        public static Func<string, DataTable> LoadContractTypesFunc = (dbAlias) =>
        {
            using (var helper = new DbHelper(DatabaseConfiguration.GetConnectionString(dbAlias)))
            {
                helper.Connection.Open();
                var dts = helper.CallStoredProcedure("dbo.spTDAppSelectContractTypes");
                return dts.Tables.Count > 0 ? dts.Tables[0].Detach() : new DataTable();
            }
        };

        public static Func<List<KeyValuePair<int, string>>> LoadDatabasesAliases = () =>
        {
            var dc = new UsersDataContext();
            return dc.DatabaseConfigurations
                .ToList()
                .Select(dd => new KeyValuePair<int, string>(dd.Id, dd.Alias))
                .ToList();
        };

        public static Func<string, KeyValuePair<string, string>> LoadUserDetails = (connectionStr) =>
        {
            var connStr = ConfigurationManager.ConnectionStrings[connectionStr].ConnectionString;
            var username = UsersDataContext.CurrentSessionUser?.Username;
            if (username == null)
                return new KeyValuePair<string, string>();

            using (var dbh = new DbHelper(connStr))
            {
                dbh.Connection.Open();
                var userData = dbh.CallStoredProcedure("spUserDetails", new Dictionary<string, object> { { "@username", username } });

                if (userData == null || userData.Tables.Count == 0 || userData.Tables[0].Rows.Count == 0)
                {
                    throw new Exception("Invalid user data.");
                }

                var pwd = userData.Tables[0].Rows[0]["Password"].ToString();

                return new KeyValuePair<string, string>(username, pwd);
            }
        };

        public static Func<string, DataTable> LoadTableColumnsFunc = (tableName) =>
        {
            using (var helper = new DbHelper(Config.UsersConnectionString))
            {
                helper.Connection.Open();
                var dts = helper.CallStoredProcedure("dbo.spCUIGetTableColumns", new Dictionary<string, object>
                {
                    {"@tableName", tableName}
                });

                return dts.Tables.Count > 0 ? dts.Tables[0].Detach() : new DataTable();
            }
        };

        public static Func<string, string, List<string>> LoadStoredProcedures = (dbAlias, currentMethod) =>
        {
            var dc = new UsersDataContext();
            var db = dc.DatabaseConfigurations
                .FirstOrDefault(d => d.Alias.Equals(dbAlias, StringComparison.OrdinalIgnoreCase));

            var list = new List<string>();

            if (db != null)
            {
                var query = $"select name from sys.procedures where name like '{db.StoredProcPrefix}%'";
                var dh = new DbHelper(db.ConnectionString);

                // get stored procedures, provide friendly name
                list = dh.GetTable(query).Rows
                    .Cast<DataRow>()
                    .Select(r => r["name"].ToStringOrEmpty().Replace(db.StoredProcPrefix, db.StoredProcMethodPrefix))
                    .ToList();

                // remove stored procedures, which already have assigned methods
                var existed = dc.Methods
                    .Where(m => m.DatabaseConfiguration.Alias.Equals(dbAlias, StringComparison.OrdinalIgnoreCase))
                    .Select(m => m.Name)
                    .ToList();

                // leave current method (the one which is in edit mode when calling this method) 
                // but only if it's in a list
                existed = existed
                    .Except(new[] { currentMethod })
                    .ToList();

                list = list.Except(existed).ToList();
            }

            return list;
        };

    }
}
