using System;
using System.Collections.Generic;
using System.Collections.Specialized;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Web;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using Moq;
using SharedLibrary.IPAddress;
using Subtext.TestLibrary;

namespace SharedLibraryTests
{
    [TestClass]
    public class IpAddressHelperTests
    {
        [TestMethod]
        public void GetIP_Default_IP()
        {
            Assert.AreEqual("127.0.0.1", IpAddressHelper.GetIPAddress());
        }

        [TestMethod]
        public void GetIP_REMOTE_ADDR()
        {
            var request = new Mock<HttpRequestBase>();
            request.Setup(x => x.ServerVariables).Returns(new NameValueCollection {
                { "REMOTE_ADDR", "129.23.45.67" }
            });

            var context = new Mock<HttpContextBase>();
            context.SetupGet(x => x.Request).Returns(request.Object);

            Assert.AreEqual("129.23.45.67", context.Object.Request.ServerVariables["REMOTE_ADDR"]);
            
            IpAddressHelper.WebContext = context.Object;

            Assert.AreEqual("129.23.45.67", IpAddressHelper.GetIPAddress());

        }

        [TestMethod]
        public void GetIP_REMOTE_ADDR_2()
        {
            var request = new Mock<HttpRequestBase>();
            request.Setup(x => x.ServerVariables).Returns(new NameValueCollection {
                { "REMOTE_ADDR", "::1" }
            });

            var context = new Mock<HttpContextBase>();
            context.SetupGet(x => x.Request).Returns(request.Object);

            Assert.AreEqual("::1", context.Object.Request.ServerVariables["REMOTE_ADDR"]);

            IpAddressHelper.WebContext = context.Object;

            Assert.AreEqual("127.0.0.1", IpAddressHelper.GetIPAddress());

        }
    }
}
