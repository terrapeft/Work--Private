using System.Collections.Generic;
using System.Data;
using UsersDb.Code;

namespace UsersDb.Helpers
{

    /// <summary>
	/// Keeps user's parameters captured from the URL.
	/// </summary>
	public class RequestParameters
	{
        public RequestParameters()
        {
            
        }

		/// <summary>
		/// Gets the full name of the stored procedure.
		/// </summary>
		public string StoredProcName
		{
			get
			{
				return MethodNameMapper.MethodToStoredProc(MethodName);
			}
		}

		/// <summary>
		/// Gets or sets the name of the method.
		/// </summary>
		public string MethodName { get; set; }

		/// <summary>
		/// Gets or sets the connection string.
		/// </summary>
		/// <value>
		/// The connection string.
		/// </value>
		public string ConnectionString { get; set; }

		/// <summary>
		/// Gets or sets the username.
		/// </summary>
		/// <value>
		/// The username.
		/// </value>
		public string Username { get; set; }

		/// <summary>
		/// Gets or sets the user id.
		/// </summary>
		/// <value>
		/// The user id.
		/// </value>
		public int? UserId { get; set; }

		/// <summary>
		/// Gets or sets the password.
		/// </summary>
		/// <value>
		/// The password.
		/// </value>
		public string Password { get; set; }

        /// <summary>
        /// Gets or sets the search parameters.
        /// </summary>
	    public SearchParametersJson SearchParameters = new SearchParametersJson(true);

        /// <summary>
        /// Gets or sets the stored procedure parameters.
        /// </summary>
        public List<StoredProcParameterJson> MethodArguments = new List<StoredProcParameterJson>();


        /// <summary>
        /// Gets or sets the data filters.
        /// </summary>
        /// <value>
        /// The data filters.
        /// </value>
        public DataTable DataFilters { get; set; }
    }

    public enum ResultType
	{
        None = 0,
		Json = 1,
		Xml = 2,
		Csv = 3,
		Help = 4,
		List = 5,
		Count = 6
	}
}
