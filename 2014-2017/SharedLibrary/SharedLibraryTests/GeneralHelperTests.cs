using System;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using SharedLibrary;

namespace SharedLibraryTests
{
    [TestClass]
    public class ExtensionMethodsTests
    {
        [TestMethod]
        public void ReplaceIgnoreCase_Test()
        {
            var data = @"asdfg Hkkkkdd 99\t..\wff\nff";
            var lookFor = @"\t..\w";
            var replaceWith = @"\W\W\W";

            Assert.AreEqual(@"asdfg Hkkkkdd 99\W\W\Wff\nff", data.ReplaceIgnoreCase(lookFor, replaceWith));
        }

        [TestMethod]
        public void Test()
        {
            var t = string.Format("{0}", 1, 2);
        }
    }
}
