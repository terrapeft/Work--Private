using System;
using System.Web;

namespace SharedLibrary.Session
{
    /// <summary>
    /// Work with session.
    /// </summary>
    public class SessionHelper
    {
        /// <summary>
        /// Adds the specified name to HttpContext.Current.Session.
        /// </summary>
        /// <param name="name">The name.</param>
        /// <param name="value">The value.</param>
        public static void Add(string name, object value)
        {
            if (HttpContext.Current != null && HttpContext.Current.Session != null)
            {
                HttpContext.Current.Session[name] = value;
            }
        }

        /// <summary>
        /// Gets the specified name.
        /// </summary>
        /// <typeparam name="T"></typeparam>
        /// <param name="name">The name.</param>
        /// <returns></returns>
        public static T Get<T>(string name)
        {
            return Get(name, () => default(T));
        }

        /// <summary>
        /// Tries to get value by name, if value is null invokes provided function.
        /// </summary>
        /// <param name="name">The name.</param>
        /// <param name="getValueFunc">The get value function.</param>
        /// <returns></returns>
        public static T Get<T>(string name, Func<T> getValueFunc)
        {
            if (HttpContext.Current != null && HttpContext.Current.Session != null)
            {
                var val = HttpContext.Current.Session[name];
                if (val == null)
                {
                    val = getValueFunc.Invoke();
                    HttpContext.Current.Session[name] = val;
                }

                return (T)val;
            }

            // return Func value even if Session is not available
            return getValueFunc.Invoke();
        }
    }
}