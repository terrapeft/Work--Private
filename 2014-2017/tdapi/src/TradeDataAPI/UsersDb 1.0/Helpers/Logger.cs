using System.Web;
using Elmah;
using System;

namespace UsersDb.Helpers
{
    public class Logger
    {
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
