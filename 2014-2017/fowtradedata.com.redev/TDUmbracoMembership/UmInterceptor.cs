using System.Data;
using System.Data.Common;
using System.Data.Entity.Infrastructure.Interception;

namespace TDUmbracoMembership
{
    /// <summary>
    /// Main goal of this class, at least at this point, to open the SQL Server symmetric key in the background, before retrieving data from the service.
    /// </summary>
    public class UmInterceptor : IDbCommandInterceptor
    {
        public void NonQueryExecuting(DbCommand command, DbCommandInterceptionContext<int> interceptionContext)
        {
            //throw new NotImplementedException();
        }

        public void NonQueryExecuted(DbCommand command, DbCommandInterceptionContext<int> interceptionContext)
        {
            //throw new NotImplementedException();
        }

        public void ReaderExecuting(DbCommand command, DbCommandInterceptionContext<DbDataReader> interceptionContext)
        {
            // When working with password decryption on SQL Server side, the chipher key must be open and it will affect queries during the session.
            // As it is not known in advance, when EF will close or open connection, the key is opened before each data request.
            using (var cmd = command.Connection.CreateCommand())
            {
                cmd.Transaction = command.Transaction;
                cmd.CommandText = "dbo.spOpenPasswordsKey";
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.ExecuteNonQuery();
            }
        }

        public void ReaderExecuted(DbCommand command, DbCommandInterceptionContext<DbDataReader> interceptionContext)
        {
            //throw new NotImplementedException();
        }

        public void ScalarExecuting(DbCommand command, DbCommandInterceptionContext<object> interceptionContext)
        {
            //throw new NotImplementedException();
        }

        public void ScalarExecuted(DbCommand command, DbCommandInterceptionContext<object> interceptionContext)
        {
            //throw new NotImplementedException();
        }
    }
}
