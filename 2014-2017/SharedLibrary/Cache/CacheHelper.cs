using System;
using System.Configuration;
using System.Threading.Tasks;
using System.Web;

namespace SharedLibrary.Cache
{
    /// <summary>
    /// Simplifies some common tasks with System.Web.Caching.Cache class.
    /// </summary>
    public class CacheHelper
    {
        /// <summary>
        /// Adds value to the cache for the specified period without sliding expiration.
        /// </summary>
        /// <param name="name">The key.</param>
        /// <param name="value">The value.</param>
        /// <param name="expirationMinutes">The expiration minutes, 120 by default.</param>
        public static void Add(string name, object value, double? expirationMinutes = null)
        {
            if (expirationMinutes == null)
            {
                expirationMinutes = Convert.ToInt32(ConfigurationManager.AppSettings["cacheExpirationTime"] ?? "120");
            }

            Cache.Insert(name, value, null, DateTime.UtcNow.AddMinutes(expirationMinutes.Value), System.Web.Caching.Cache.NoSlidingExpiration);
        }

        /// <summary>
        /// Returns value from application cache.
        /// </summary>
        /// <param name="name">The key.</param>
        /// <returns></returns>
        public static object Get(string name)
        {
            return Cache[name];
        }

        /// <summary>
        /// Tries to obtain the value from the cache by key, if it was not found invokes the function, stores result to the cache and returns it.
        /// </summary>
        /// <typeparam name="T"></typeparam>
        /// <param name="name">The key.</param>
        /// <param name="getValueFunc">The function to obtain value.</param>
        /// <param name="skipCaching">Do not put to cache if true. False by default</param>
        /// <returns></returns>
        public static T Get<T>(string name, Func<T> getValueFunc, bool skipCaching = false)
        {
            var val = Cache[name];
            if (val == null)
            {
                val = getValueFunc.Invoke();
                if (!skipCaching) Add(name, val);
            }

            return (T)val;
        }

        public static T Get<T>(string name, object arg, Func<object,T> getValueFunc, bool skipCaching = false)
        {
            var val = Cache[name];
            if (val == null)
            {
                val = getValueFunc.Invoke(arg);
                if (!skipCaching) Add(name, val);
            }

            return (T)val;
        }

        /// <summary>
        /// Tries to obtain the value from the cache by key, if it was not found invokes the function, stores result to the cache and returns it.
        /// </summary>
        /// <param name="name">The key.</param>
        /// <param name="param1">The function parameter.</param>
        /// <param name="getValueFunc">The function to obtain value.</param>
        /// <param name="skipCaching">Do not put to cache if true. False by default</param>
        /// <returns></returns>
        public static TResult Get<T1,TResult>(string name, T1 param1, Func<T1, TResult> getValueFunc, bool skipCaching = false)
        {
            var val = Cache[$"{name}_{param1}"];
            if (val == null)
            {
                val = getValueFunc.Invoke(param1);
                if (!skipCaching) Add(name, val);
            }

            return (TResult)val;
        }

        /// <summary>
        /// Tries to obtain the value from the cache by key, if it was not found invokes the function, stores result to the cache and returns it.
        /// </summary>
        /// <param name="name">The key.</param>
        /// <param name="param1">The function parameter.</param>
        /// <param name="param2">The function parameter.</param>
        /// <param name="getValueFunc">The function to obtain value.</param>
        /// <param name="skipCaching">Do not put to cache if true. False by default</param>
        /// <returns></returns>
        public static TResult Get<T1, T2, TResult>(string name, T1 param1, T2 param2, Func<T1, T2, TResult> getValueFunc, bool skipCaching = false)
        {
            var val = Cache[$"{name}_{param1}_{param2}"];
            if (val == null)
            {
                val = getValueFunc.Invoke(param1, param2);
                if (!skipCaching) Add(name, val);
            }

            return (TResult)val;
        }
        /// <summary>
        /// Tries to asynchronously obtain the value from the cache by key, if it was not found then invokes the function and stores result to the cache.
        /// </summary>
        /// <param name="name">The key.</param>
        /// <param name="getValueFunc">The function to obtain value.</param>
        /// <returns></returns>
        public static void LoadAsync<T>(string name, Func<T> getValueFunc)
        {
            Task.Factory.StartNew(() =>
            {
                Get(name, getValueFunc);
            });

            Task.WaitAll();
        }

        /// <summary>
        /// Tries to asynchronously obtain the value from the cache by key, if it was not found then invokes the function and stores result to the cache.
        /// </summary>
        /// <param name="name">The key.</param>
        /// <param name="param1">The function parameter.</param>
        /// <param name="getValueFunc">The function to obtain value.</param>
        /// <returns></returns>
        public static void LoadAsync<T1, TResult>(string name, T1 param1, Func<T1, TResult> getValueFunc)
        {
            Task.Factory.StartNew(() =>
            {
                Get(name, param1, getValueFunc);
            });

            Task.WaitAll();
        }
        /// <summary>
        /// Gets the Cache from context.
        /// </summary>
        public static System.Web.Caching.Cache Cache
        {
            get
            {
                return (HttpContext.Current == null) ? HttpRuntime.Cache : HttpContext.Current.Cache;
            }
        }
    }
}