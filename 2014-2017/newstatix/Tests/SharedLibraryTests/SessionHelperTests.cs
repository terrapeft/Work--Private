using System;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using SharedLibrary.Session;
using Subtext.TestLibrary;

namespace SharedLibraryTests
{
    [TestClass]
    public class SessionHelperTests
    {
        [TestMethod]
        public void AddToSession_Test()
        {
            using (new HttpSimulator().SimulateRequest())
            {
                SessionHelper.Add("test_123", "123");

                var check = SessionHelper.Get<string>("test_123");
                Assert.IsNotNull(check, "Session object must have value.");
            }
        }

        [TestMethod]
        public void GetFromSession_Predicate_Test()
        {
            using (new HttpSimulator().SimulateRequest())
            {
                var check = SessionHelper.Get("test_123", () => "123");
                Assert.AreEqual("123", check, "Cache object must have value.");
            }
        }

    }
}
