using System;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using Statix;
using Subtext.TestLibrary;

namespace StatixIntegrationTests
{
    [TestClass]
    public class ThemeSelectorTests
    {
        [TestMethod]
        public void Bp2s_Skin_By_Marker()
        {
            ThemeSelector.BnpParibasMarker = "bp2s";
            ThemeSelector.NewedgeMarker = "newedge";

            string themeName;
            var master = ThemeSelector.SelectTheme(new Uri("http://www.bnpparibas.com"), out themeName);

            Assert.AreEqual("General", themeName);
            Assert.AreEqual("/Site.master", master);

            master = ThemeSelector.SelectTheme(new Uri("http://domain.com/bp2s/"), out themeName);

            Assert.AreEqual("Bp2s", themeName);
            Assert.AreEqual("/Bp2s.master", master);
        }

        [TestMethod]
        public void Newedge_Skin_By_Marker()
        {
            ThemeSelector.BnpParibasMarker = "bp2s";
            ThemeSelector.NewedgeMarker = "newedge";

            string themeName;
            var master = ThemeSelector.SelectTheme(new Uri("http://www.bnpparibas.com"), out themeName);

            Assert.AreEqual("General", themeName);
            Assert.AreEqual("/Site.master", master);

            master = ThemeSelector.SelectTheme(new Uri("http://domain.com/newedge/"), out themeName);

            Assert.AreEqual("Newedge", themeName);
            Assert.AreEqual("/Newedge.master", master);
        }
    }
}
