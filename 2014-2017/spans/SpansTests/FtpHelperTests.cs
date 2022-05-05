using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using SpansLib.Db;
using SpansLib.Ftp;
using WinSCP;

namespace SpansTests
{
    [TestClass]
    public class FtpHelperTests
    {
        [TestMethod]
        public void Prefer_Zipped_Same_Name_Test()
        {
            var f1 = (RemoteFileInfo)Activator.CreateInstance(typeof(RemoteFileInfo), true);
            f1.GetType().GetProperty("Name").SetValue(f1, "f1.pa2");

            var f2 = (RemoteFileInfo)Activator.CreateInstance(typeof(RemoteFileInfo), true);
            f2.GetType().GetProperty("Name").SetValue(f2, "f1.spn");

            var f3 = (RemoteFileInfo)Activator.CreateInstance(typeof(RemoteFileInfo), true);
            f3.GetType().GetProperty("Name").SetValue(f3, "f1.zip");

            var list = new List<KeyValuePair<string, RemoteFileInfo>>
            {
                new KeyValuePair<string, RemoteFileInfo>("src/", f1),
                new KeyValuePair<string, RemoteFileInfo>("src/", f2),
                new KeyValuePair<string, RemoteFileInfo>("src/", f3)
            };

            var result = FtpHelper.SelectPreferredFiles(list, "zip");

            Assert.IsTrue(result.Count == 1);
            Assert.AreEqual("f1.zip", result.First().Value.Name);
        }

        [TestMethod]
        public void Prefer_Zipped_Zip_Added_Test()
        {
            var f1 = (RemoteFileInfo)Activator.CreateInstance(typeof(RemoteFileInfo), true);
            f1.GetType().GetProperty("Name").SetValue(f1, "f1.pa2");

            var f2 = (RemoteFileInfo)Activator.CreateInstance(typeof(RemoteFileInfo), true);
            f2.GetType().GetProperty("Name").SetValue(f2, "f1.pa2.zip");

            var list = new List<KeyValuePair<string, RemoteFileInfo>>
            {
                new KeyValuePair<string, RemoteFileInfo>("src/", f1),
                new KeyValuePair<string, RemoteFileInfo>("src/", f2),
            };

            var result = FtpHelper.SelectPreferredFiles(list, ".zip");

            Assert.IsTrue(result.Count == 1);
            Assert.AreEqual("f1.pa2.zip", result.First().Value.Name);
        }

        [TestMethod]
        public void Prefer_Zipped_NoZip_Test()
        {
            var f1 = (RemoteFileInfo)Activator.CreateInstance(typeof(RemoteFileInfo), true);
            f1.GetType().GetProperty("Name").SetValue(f1, "f1.pa2");

            var f2 = (RemoteFileInfo)Activator.CreateInstance(typeof(RemoteFileInfo), true);
            f2.GetType().GetProperty("Name").SetValue(f2, "f1.spn");

            var list = new List<KeyValuePair<string, RemoteFileInfo>>
            {
                new KeyValuePair<string, RemoteFileInfo>("src/", f1),
                new KeyValuePair<string, RemoteFileInfo>("src/", f2),
            };

            var result = FtpHelper.SelectPreferredFiles(list, "zip");

            Assert.IsTrue(result.Count == 2);
            Assert.AreEqual("f1.pa2", result.First().Value.Name);
            Assert.AreEqual("f1.spn", result.Skip(1).First().Value.Name);
        }

        [TestMethod]
        public void Prefer_Zipped_OtherFiles_Test()
        {
            var f1 = (RemoteFileInfo)Activator.CreateInstance(typeof(RemoteFileInfo), true);
            f1.GetType().GetProperty("Name").SetValue(f1, "f1.pa2");

            var f2 = (RemoteFileInfo)Activator.CreateInstance(typeof(RemoteFileInfo), true);
            f2.GetType().GetProperty("Name").SetValue(f2, "f2.spn");

            var f3 = (RemoteFileInfo)Activator.CreateInstance(typeof(RemoteFileInfo), true);
            f3.GetType().GetProperty("Name").SetValue(f3, "f1.zip");

            var list = new List<KeyValuePair<string, RemoteFileInfo>>
            {
                new KeyValuePair<string, RemoteFileInfo>("src/", f1),
                new KeyValuePair<string, RemoteFileInfo>("src/", f2),
                new KeyValuePair<string, RemoteFileInfo>("src/", f3)
            };

            var result = FtpHelper.SelectPreferredFiles(list, "zip");

            Assert.IsTrue(result.Count == 2);
            Assert.AreEqual("f1.zip", result.First().Value.Name);
            Assert.AreEqual("f2.spn", result.Skip(1).First().Value.Name);
        }

        [TestMethod]
        public void Prefer_Zipped_SameFilesInDifferentFolders_Test()
        {
            var f1 = (RemoteFileInfo)Activator.CreateInstance(typeof(RemoteFileInfo), true);
            f1.GetType().GetProperty("Name").SetValue(f1, "f1.pa2");

            var f2 = (RemoteFileInfo)Activator.CreateInstance(typeof(RemoteFileInfo), true);
            f2.GetType().GetProperty("Name").SetValue(f2, "f1.pa2");

            var f3 = (RemoteFileInfo)Activator.CreateInstance(typeof(RemoteFileInfo), true);
            f3.GetType().GetProperty("Name").SetValue(f3, "f1.zip");

            var list = new List<KeyValuePair<string, RemoteFileInfo>>
            {
                new KeyValuePair<string, RemoteFileInfo>("src/", f1),
                new KeyValuePair<string, RemoteFileInfo>("src2/", f2),
                new KeyValuePair<string, RemoteFileInfo>("src2/", f3)
            };

            var result = FtpHelper.SelectPreferredFiles(list, ".zip");

            Assert.IsTrue(result.Count == 2);
            Assert.AreEqual("f1.zip", result.First().Value.Name);
            Assert.AreEqual("f1.pa2", result.Skip(1).First().Value.Name);
        }

        [TestMethod]
        public void GetFilePaths_Root_Test()
        {
            var f = FtpHelper.GetFilePaths("/pub/span/data/cee/123.zip", "c:\\data\\cee", new Uri("ftp://host.com/pub/span/data/cee"));

            Assert.AreEqual("123.zip", f.FileName);
            Assert.AreEqual("c:\\data\\cee", f.FullDiskPath);
            Assert.AreEqual("ftp://host.com/pub/span/data/cee", f.FullFtpPath);
        }

        [TestMethod]
        public void GetFilePaths_SubFolder_Test()
        {
            var f = FtpHelper.GetFilePaths("/pub/span/data/cee/xml/123.zip", "c:\\data\\cee", new Uri("ftp://host.com/pub/span/data/cee"));

            Assert.AreEqual("123.zip", f.FileName);
            Assert.AreEqual("c:\\data\\cee\\xml", f.FullDiskPath);
            Assert.AreEqual("ftp://host.com/pub/span/data/cee/xml", f.FullFtpPath);
        }

        [TestMethod]
        public void GetFilePaths_NoSubFolder_Test()
        {
            var f = FtpHelper.GetFilePaths("123.zip", "c:\\data", new Uri("ftp://host.com/"));
            var f2 = FtpHelper.Combine(f.FullFtpPath, f.FileName);

            Assert.AreEqual("123.zip", f.FileName);
            Assert.AreEqual("c:\\data", f.FullDiskPath);
            Assert.AreEqual("ftp://host.com/", f.FullFtpPath);

            Assert.AreEqual("ftp://host.com/123.zip", f2);
        }
    }
}
