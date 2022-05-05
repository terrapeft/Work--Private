using System;
using System.Data.Metadata.Edm;
using System.Data.Objects;
using System.Data.SqlClient;
using System.Linq;
using System.Linq.Expressions;
using SharedLibrary.Passwords;

namespace UsersDb.Helpers
{
	public static class CommonHelper
	{
		/// <summary>
		/// Ceils x to the nearest integer which is multiple of n.
		/// </summary>
		/// <param name="x"></param>
		/// <param name="n"></param>
		/// <returns></returns>
		public static int CeilN(int x, int n)
		{
			return ((x + n - 1) / n) * n;
		}


        /// <summary>
        /// Gets the name.
        /// </summary>
        /// <param name="exp">The exp.</param>
        /// <returns></returns>
        public static string GetName(Expression<Func<object>> exp)
        {
            var body = exp.Body as MemberExpression;

            if (body == null)
            {
                var ubody = (UnaryExpression)exp.Body;
                body = ubody.Operand as MemberExpression;
            }

            return body.Member.Name;
        }


        /// <summary>
        /// Returns entity set name for a given entity type
        /// </summary>
        /// <returns>String name of the entity set.</returns>
        public static string GetEntitySetName(this ObjectContext context, Type entityType)
        {
            var container = context.MetadataWorkspace.GetEntityContainer(context.DefaultContainerName, DataSpace.CSpace);
            var esb = container.BaseEntitySets.FirstOrDefault(item => item.ElementType.Name.Equals(entityType.Name));
            return esb != null ? esb.Name : String.Empty;
        }

        /// <summary>
        /// Returns decrypted connection string.
        /// </summary>
        /// <param name="connectionString">The connection string.</param>
        /// <returns></returns>
	    public static string DecryptConnectionString(string connectionString)
        {
            if (string.IsNullOrWhiteSpace(connectionString))
                return string.Empty;

            var builder = new SqlConnectionStringBuilder(connectionString);

            if (!string.IsNullOrEmpty(builder.Password))
            {
                builder.Password = CryptoHelper.Decrypt(builder.Password, Config.ConnectionStringCipherKey);
            }

            return builder.ConnectionString;
	    }

        /// <summary>
        /// Encrypts the connection string.
        /// </summary>
        /// <param name="connectionString">The connection string.</param>
        /// <returns></returns>
	    public static string EncryptConnectionString(string connectionString)
	    {
            if (string.IsNullOrWhiteSpace(connectionString))
                return string.Empty;

            var builder = new SqlConnectionStringBuilder(connectionString);

            if (!string.IsNullOrWhiteSpace(builder.Password))
            {
                builder.Password = CryptoHelper.Encrypt(builder.Password, Config.ConnectionStringCipherKey);
            }

            return builder.ConnectionString;
	    }
	}
}