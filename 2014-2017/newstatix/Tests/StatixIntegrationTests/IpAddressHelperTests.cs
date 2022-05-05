using Microsoft.VisualStudio.TestTools.UnitTesting;
using SharedLibrary.IPAddress;

namespace SharedLibraryTests
{
    [TestClass]
    public class IpAddressHelperTests
    {
        [TestMethod]
        public void Verify_GEO_Location_Service()
        {
            var result = IpAddressHelper.VerifyGeoLocation("http://www.geoplugin.net/json.gp?ip=212.0.0.1");
            Assert.AreEqual("Germany", result.CountryName);
        }
    }
}
