using System;
using System.Collections.Generic;
using System.Globalization;
using System.IO;
using System.Linq;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using SpansLib;
using SpansLib.Data;
using SpansLib.Db;
using SpansLib.Ftp;
using WinSCP;

namespace SpansTests
{
    [TestClass]
    public class BatchWriterTests
    {
        private List<string> prefList = new List<string>
            {
                ".spn",
                ".xml",
                ".pa6",
                ".pa5",
                ".pa3",
                ".pa2",
                ".zip"
            };

        [TestMethod]
        public void Prefer_Spn_Test()
        {
            var list = new List<string>
            {
                ".pa2",
                ".spn"
            };

            var t = new BatchWriter(0, FileFormat.XmlFormats);
            t.PrefList = prefList;
            var result = t.GetPreferredExtension(list);

            Assert.AreEqual(".spn", result);
        }

        [TestMethod]
        public void Prefer_Spn_No_Ext_Found_Test()
        {
            var list = new List<string>
            {
                ".txt",
                ".xsl"
            };

            var t = new BatchWriter(0, FileFormat.XmlFormats);
            t.PrefList = prefList;
            var result = t.GetPreferredExtension(list);

            Assert.AreEqual(".txt", result);

        }

        [TestMethod]
        public void Prefer_Spn_Somewhere_In_The_Middle_Test()
        {
            var list = new List<string>
            {
                ".pa3",
                ".pa6",
                ".zip",
                ".xsl"
            };

            var t = new BatchWriter(0, FileFormat.XmlFormats);
            t.PrefList = prefList;
            var result = t.GetPreferredExtension(list);

            Assert.AreEqual(".pa6", result);

        }

        [TestMethod]
        public void FilterFiles_Xml_DoesNotMatchDate_Test()
        {
            var list = CreateFilesSet(DateTime.Today.AddDays(-1));

            var t = new BatchWriter(string.Empty, FileFormat.XmlFormats, DateTime.Today);
            t.PrefList = prefList;
            var result = t.FilterFiles(list, new List<KeyValuePair<string, DateTime>>(), null);

            Assert.IsFalse(result.Any());

            CleanFilesSet(list);
        }

        [TestMethod]
        public void FilterFiles_Pa_DoesNotMatchDate_Test()
        {
            var list = CreateFilesSet(DateTime.Today.AddDays(-1));

            var t = new BatchWriter(string.Empty, FileFormat.PositionalFormats, DateTime.Today);
            t.PrefList = prefList;
            var result = t.FilterFiles(list, new List<KeyValuePair<string, DateTime>>(), null);

            Assert.IsFalse(result.Any());

            CleanFilesSet(list);
        }

        [TestMethod]
        public void FilterFiles_Pa_MultipleChoice_Test()
        {
            var list = CreateFilesSet(DateTime.Today);

            var t = new BatchWriter(string.Empty, FileFormat.PositionalFormats, DateTime.Today);
            t.PrefList = prefList;
            var result = t.FilterFiles(list, new List<KeyValuePair<string, DateTime>>(), null);

            Assert.IsTrue(result.Count == 2);
            Assert.AreEqual(Path.Combine(Environment.CurrentDirectory, "1.pa6"), result[0]);

            CleanFilesSet(list);
        }

        [TestMethod]
        public void FilterFiles_Xml_MultipleChoice_Test()
        {
            var list = CreateFilesSet(DateTime.Today);

            var t = new BatchWriter(string.Empty, FileFormat.XmlFormats, DateTime.Today);
            t.PrefList = prefList;
            var result = t.FilterFiles(list, new List<KeyValuePair<string, DateTime>>(), null);

            Assert.IsTrue(result.Count == 2);
            Assert.AreEqual(Path.Combine(Environment.CurrentDirectory, "1.spn"), result[0]);

            CleanFilesSet(list);
        }


        [TestMethod]
        public void FilterFiles_Xml_Append_And_Choice_Test()
        {
            var list = CreateFilesSet(DateTime.Today);

            var t = new BatchWriter(string.Empty, FileFormat.XmlFormats, DateTime.Today);
            t.PrefList = prefList;

            var existedList = new List<KeyValuePair<string, DateTime>>
            {
                new KeyValuePair<string, DateTime>("1.spn", DateTime.Today)
            };

            var result = t.FilterFiles(list, existedList, null);

            Assert.IsTrue(result.Count == 2);
            Assert.AreEqual(Path.Combine(Environment.CurrentDirectory, "1.xml"), result[0]);
            Assert.AreEqual(Path.Combine(Environment.CurrentDirectory, "2.spn"), result[1]);

            CleanFilesSet(list);
        }

        [TestMethod]
        public void FilterFiles_Xml_Append_OldFile_And_Choice_Test()
        {
            var list = CreateFilesSet(DateTime.Today);

            var t = new BatchWriter(string.Empty, FileFormat.XmlFormats, DateTime.Today);
            t.PrefList = prefList;

            var existedList = new List<KeyValuePair<string, DateTime>>
            {
                new KeyValuePair<string, DateTime>("1.spn", DateTime.Today.AddDays(-1))
            };

            var result = t.FilterFiles(list, existedList, null);

            Assert.IsTrue(result.Count == 2);
            Assert.AreEqual(Path.Combine(Environment.CurrentDirectory, "1.spn"), result[0]);
            Assert.AreEqual(Path.Combine(Environment.CurrentDirectory, "2.spn"), result[1]);

            CleanFilesSet(list);
        }

        [TestMethod]
        public void FilterFiles_Pa_Append_And_Choice_Test()
        {
            var list = CreateFilesSet(DateTime.Today);

            var t = new BatchWriter(string.Empty, FileFormat.PositionalFormats, DateTime.Today);
            t.PrefList = prefList;

            var existedList = new List<KeyValuePair<string, DateTime>>
            {
                new KeyValuePair<string, DateTime>("1.pa6", DateTime.Today)
            };

            var result = t.FilterFiles(list, existedList, null);

            Assert.IsTrue(result.Count == 2);
            Assert.AreEqual(Path.Combine(Environment.CurrentDirectory, "1.pa5"), result[0]);
            Assert.AreEqual(Path.Combine(Environment.CurrentDirectory, "2.pa6"), result[1]);

            CleanFilesSet(list);
        }

        [TestMethod]
        public void FilterFiles_Pa_Append_OldFile_And_Choice_Test()
        {
            var list = CreateFilesSet(DateTime.Today);

            var t = new BatchWriter(string.Empty, FileFormat.PositionalFormats, DateTime.Today);
            t.PrefList = prefList;

            var existedList = new List<KeyValuePair<string, DateTime>>
            {
                new KeyValuePair<string, DateTime>("1.pa6", DateTime.Today.AddDays(-1))
            };

            var result = t.FilterFiles(list, existedList, null);

            Assert.IsTrue(result.Count == 2);
            Assert.AreEqual(Path.Combine(Environment.CurrentDirectory, "1.pa6"), result[0]);
            Assert.AreEqual(Path.Combine(Environment.CurrentDirectory, "2.pa6"), result[1]);

            CleanFilesSet(list);
        }

        private List<string> CreateFilesSet(DateTime lastWriteTime)
        {
            var list = new List<string>();

            list.Add(CreateFile("1.pa2", lastWriteTime));
            list.Add(CreateFile("1.pa3", lastWriteTime));
            list.Add(CreateFile("1.pa5", lastWriteTime));
            list.Add(CreateFile("1.pa6", lastWriteTime));
            list.Add(CreateFile("1.pa2.zip", lastWriteTime));
            list.Add(CreateFile("1.pa3.zip", lastWriteTime));
            list.Add(CreateFile("1.pa5.zip", lastWriteTime));
            list.Add(CreateFile("1.pa6.zip", lastWriteTime));
            list.Add(CreateFile("1.xml", lastWriteTime));
            list.Add(CreateFile("1.spn", lastWriteTime));
            list.Add(CreateFile("1.xml.zip", lastWriteTime));
            list.Add(CreateFile("1.spn.zip", lastWriteTime));
            list.Add(CreateFile("2.pa2", lastWriteTime));
            list.Add(CreateFile("2.pa3", lastWriteTime));
            list.Add(CreateFile("2.pa5", lastWriteTime));
            list.Add(CreateFile("2.pa6", lastWriteTime));
            list.Add(CreateFile("2.pa2.zip", lastWriteTime));
            list.Add(CreateFile("2.pa3.zip", lastWriteTime));
            list.Add(CreateFile("2.pa5.zip", lastWriteTime));
            list.Add(CreateFile("2.pa6.zip", lastWriteTime));
            list.Add(CreateFile("2.xml", lastWriteTime));
            list.Add(CreateFile("2.spn", lastWriteTime));
            list.Add(CreateFile("2.xml.zip", lastWriteTime));
            list.Add(CreateFile("2.spn.zip", lastWriteTime));

            return list;
        }

        private void CleanFilesSet(List<string> list)
        {
            list.ForEach(File.Delete);
        }

        private string CreateFile(string name, DateTime lastWriteTime)
        {
            File.Create(name).Close();
            File.SetLastWriteTime(name, lastWriteTime);

            return name;
        }
    }
}
