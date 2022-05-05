using System.IO;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;
using System.Xml;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using SharedLibrary;

namespace SpansTests
{
    [TestClass]
    public class ExtensionsTests
    {
        [TestMethod]
        public void Parse_Double_Test()
        {
            var t = "  4.004";
            double tt;
            double.TryParse(t, out tt);
            Assert.IsTrue(tt == 0, "Check conversion doesn't work initially");

            t = t.EnsureDecimalSeparator();
            double.TryParse(t, out tt);
            Assert.IsTrue(tt == 4.004, "Check result");
        }

        [TestMethod]
        public void Parse_SignedDouble_Test()
        {
            var t = "  +4.004";
            double tt;
            double.TryParse(t, out tt);
            Assert.IsTrue(tt == 0, "Check conversion doesn't work initially");

            t = t.EnsureDecimalSeparator();
            double.TryParse(t, out tt);
            Assert.IsTrue(tt == 4.004, "Check result");
        }

        [TestMethod]
        public void Parse_NegativeDouble_Test()
        {
            var t = "  -4.004";
            double tt;
            double.TryParse(t, out tt);
            Assert.IsTrue(tt == 0, "Check conversion doesn't work initially");

            t = t.EnsureDecimalSeparator();
            double.TryParse(t, out tt);
            Assert.IsTrue(tt == -4.004, "Check result");
        }
    }
}
