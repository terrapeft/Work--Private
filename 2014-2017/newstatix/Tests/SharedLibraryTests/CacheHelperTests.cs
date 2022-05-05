using System;
using System.Web.Caching;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using SharedLibrary.Cache;

namespace SharedLibraryTests
{
    [TestClass]
    public class CacheHelperTests
    {
        [TestMethod]
        public void AddCache_Test()
        {
            CacheHelper.Cache.Remove("test_123");
            var check = CacheHelper.Get("test_123");
            Assert.IsNull(check, "Cache object must be null.");

            CacheHelper.Add("test_123", "123");

            check = CacheHelper.Get("test_123");
            Assert.IsNotNull(check, "Cache object must have value.");
        }

        [TestMethod]
        public void GetCache_Predicate_Test()
        {
            CacheHelper.Cache.Remove("test_123");
            var check = CacheHelper.Get("test_123", () => "123");
            Assert.AreEqual("123", check, "Cache object must have value.");
        }

        [TestMethod]
        public void NoCache_Predicate_Test()
        {
            CacheHelper.Cache.Remove("test_123");
            var check = CacheHelper.Get("test_123", () => "123");
            Assert.AreEqual("123", check, "Cache object must have value.");
        }

        [TestMethod]
        public void Cache_Predicate_WithParam_Test()
        {
            CacheHelper.Cache.Remove("test_123");
            var check = CacheHelper.Get("test_123", "abc", getString);
            Assert.AreEqual("123abc", check, "Cache object must have value.");
        }


        public static Func<string, string> getString = (str) => "123" + str;

    }
}
