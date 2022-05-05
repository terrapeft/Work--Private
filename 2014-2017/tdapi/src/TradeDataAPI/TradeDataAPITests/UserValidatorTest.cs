using System;
using System.DirectoryServices;
using System.Linq;
using System.Security.Cryptography.X509Certificates;
using Microsoft.VisualStudio.TestTools.UnitTesting;

namespace ExportDataServiceTests
{

    using UsersDb;

    [TestClass]
    public class UserValidatorTest
    {
        [TestMethod]
        public void ParseDate_Test()
        {
            var ds = "2014-12-21T12:12:12Z";
            var dd = Convert.ToDateTime(ds, System.Globalization.CultureInfo.InvariantCulture);
        }

        [TestMethod]
        public void apppool_Test()
        {
            X509Store store = new X509Store(StoreName.TrustedPeople, StoreLocation.CurrentUser);
            store.Open(OpenFlags.ReadOnly);
            X509Certificate2Collection certificates = store.Certificates;
            var t = store.Certificates.Cast<X509Certificate2>().FirstOrDefault();
        }

    }
}
