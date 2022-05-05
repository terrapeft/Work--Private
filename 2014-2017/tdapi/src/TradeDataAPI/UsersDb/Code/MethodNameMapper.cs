using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using UsersDb.Code;

namespace UsersDb.Helpers
{
	/// <summary>
	/// Just helper.
	/// </summary>
	public class MethodNameMapper
	{
		/// <summary>
		/// Translates a method name to a stored procedure name.
		/// </summary>
		/// <param name="methodName">Name of the method.</param>
		/// <returns></returns>
		public static string MethodToStoredProc(string methodName)
		{
		    var mPref = WorkingDatabase.Instance.GetStoredProcMethodPrefix();
		    var owner = WorkingDatabase.Instance.GetStoredProcOwner();
		    var pref = WorkingDatabase.Instance.GetStoredProcPrefix();
            
            var m = methodName.StartsWith(mPref)
				? methodName.Substring(mPref.Length)
				: methodName;
			return string.Format("{0}.{1}{2}", owner, pref, m);
		}
	}
}
