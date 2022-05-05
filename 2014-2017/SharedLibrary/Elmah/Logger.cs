using System;
using System.Web;
using Elmah;

namespace SharedLibrary.Elmah
{
    /// <summary>
    /// Simple log helper.
    /// </summary>
    public class Logger
    {
        /// <summary>
        /// Logs the exception and throws it if not in a silent mode.
        /// </summary>
        /// <param name="ex">The exception.</param>
        /// <param name="silently">if set to <c>true</c> [silently].</param>
        public static void LogError(Exception ex, bool silently = true)
        {
            if (HttpContext.Current == null) 
            {
                ErrorLog.GetDefault(null).Log(new Error(ex));
            }
            else
            {
                ErrorSignal.FromCurrentContext().Raise(ex);
            }

            if (! silently) throw ex;
        }
    }
}
