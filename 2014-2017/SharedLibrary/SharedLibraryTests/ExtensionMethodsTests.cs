using System;
using System.IO;
using System.Linq;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using SharedLibrary;
using SharedLibrary.Common;

namespace SharedLibraryTests
{
    [TestClass]
    public class GeneralHelperTests
    {
        [TestMethod]
        public void Split_Test()
        {
            var str = "&=";
            var pair = str.Split('&')
                            .Select(i => i.Split('='))
                            .FirstOrDefault(p => p[0].Equals("p1", StringComparison.OrdinalIgnoreCase));

            //Assert.IsTrue(fn.EndsWith("Dir"));
        }


        [TestMethod]
        public void EnsureFolderName_NoFolder_Test()
        {
            var folder = Path.Combine(Environment.CurrentDirectory, "Dir");
            var fn = GeneralHelper.EnsureFolderName(folder);

            Assert.IsTrue(fn.EndsWith("Dir"));
        }

        [TestMethod]
        public void EnsureFolderName_Subfolder_Test()
        {
            var folder = Path.Combine(Environment.CurrentDirectory, "Dir(1)");
            var path = Directory.CreateDirectory(folder).CreateSubdirectory("Dir").FullName;
            var fn = GeneralHelper.EnsureFolderName(path);

            Directory.Delete(folder, true);

            Assert.IsTrue(fn.EndsWith(@"Dir(1)\Dir(1)"));
        }

        [TestMethod]
        public void EnsureFolderName_OneIteration_Test()
        {
            var folder = Path.Combine(Environment.CurrentDirectory, "Dir");
            Directory.CreateDirectory(folder);

            var fn = GeneralHelper.EnsureFolderName(folder);

            Directory.Delete(folder);

            Assert.IsTrue(fn.EndsWith("Dir(1)"));
        }

        [TestMethod]
        public void EnsureFolderName_SeveralIterations_Test()
        {
            var folder = Path.Combine(Environment.CurrentDirectory, "Dir");

            Directory.CreateDirectory(folder);
            var fn1 = GeneralHelper.EnsureFolderName(folder);

            Directory.CreateDirectory(fn1);
            var fn2 = GeneralHelper.EnsureFolderName(folder);

            Directory.Delete(folder);
            Directory.Delete(fn1);

            Assert.IsTrue(fn2.EndsWith("Dir(2)"));
        }
    }
}
