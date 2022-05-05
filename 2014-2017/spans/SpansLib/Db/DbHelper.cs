using System;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using Microsoft.SqlServer.Management.Common;
using Microsoft.SqlServer.Management.Smo;
using SharedLibrary;

namespace SpansLib.Db
{
    public class DbHelper : IDisposable
    {
        private readonly string _сonnectionString;

        public DbHelper(string сonnectionString)
        {
            _сonnectionString = сonnectionString;
        }

        public void ExecuteDdl(string sqlPath)
        {
            var connection = new SqlConnection(_сonnectionString);
            var server = new Server(new ServerConnection(connection));
            server.ConnectionContext.ExecuteNonQuery(File.ReadAllText(sqlPath));
        }

        public void ExecuteScript(string sql)
        {
            var connection = new SqlConnection(_сonnectionString);
            var server = new Server(new ServerConnection(connection));
            server.ConnectionContext.ExecuteNonQuery(sql);
        }

        public object ExecuteScalar(string sql)
        {
            using (var cmd = new SqlCommand(sql, new SqlConnection(_сonnectionString)))
            {
                cmd.Connection.Open();
                return cmd.ExecuteScalar();
            }
        }

        public void BulkInsert(DataSet ds)
        {
            foreach (DataTable dt in ds.Tables)
            {
                using (var copy = new SqlBulkCopy(_сonnectionString, SqlBulkCopyOptions.TableLock | SqlBulkCopyOptions.KeepNulls))
                {
                    copy.BatchSize = 500;
                    copy.BulkCopyTimeout = 3600;
                    copy.DestinationTableName = string.Format("[dbo].[{0}]", dt.TableName);
                    copy.NotifyAfter = 100;
                    copy.WriteToServer(dt.EmptyCellsToNull());
                    copy.Close();
                }
            }
        }

        public void Dispose()
        {
        }
    }
}
