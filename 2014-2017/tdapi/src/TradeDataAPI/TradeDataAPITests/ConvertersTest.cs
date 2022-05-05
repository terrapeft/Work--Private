using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using Microsoft.VisualStudio.TestTools.UnitTesting;

namespace ExportDataServiceTests
{
    using System.IO;
    using System.Reflection;

    using TradeDataAPI.Converters;

    using UsersDb.Helpers;

    [TestClass]
    public class ConvertersTest
    {
        [ClassInitialize]
        public static void Initialize(TestContext tc)
        {
            //CreateDataContextWithConnectionString(Config.EFConnectionString);
        }

        public string AssemblyDirectory()
        {
            string codeBase = Assembly.GetExecutingAssembly().CodeBase;
            UriBuilder uri = new UriBuilder(codeBase);
            string path = Uri.UnescapeDataString(uri.Path);
            return Path.GetDirectoryName(path);
        }



        [TestMethod]
        public void DefaultConverter_GetTableName_Test()
        {
            var real = DbHelper.GetTableName(new[] { "" }.ToList(), "Table");
            var expected = "Table0";

            Assert.AreEqual(expected, real, "test name 1");
        }

        [TestMethod]
        public void DefaultConverter_GetTableName_Test_2()
        {
            var real = DbHelper.GetTableName(new[] { "Table", "Table0", "Table10" }.ToList(), "Table2");
            var expected = "Table11";

            Assert.AreEqual(expected, real, "test name 2");
        }

        [TestMethod]
        public void DefaultConverter_GetTableName_Test_3()
        {
            var real = DbHelper.GetTableName(new[] { "Table", "Protection10", "Availability0" }.ToList(), "Table");
            var expected = "Table0";

            Assert.AreEqual(expected, real, "test name 3");
        }

        [TestMethod]
        public void DefaultConverter_GetTableName_Test_4()
        {
            var real = DbHelper.GetTableName(new[] { "Table", "Protection10", "Availability0" }.ToList(), "Availability0");
            var expected = "Availability1";

            Assert.AreEqual(expected, real, "test name 4");
        }

        [TestMethod]
        public void DefaultConverter_GetTableName_Test_5()
        {
            var real = DbHelper.GetTableName(new[] { "Table", "Protection10", "Availability0" }.ToList(), "Availability30");
            var expected = "Availability1";

            Assert.AreEqual(expected, real, "test name 5");
        }

        [TestMethod]
        public void DefaultConverter_GetTableName_Test_6()
        {
            var list = new List<string>();
            var existedTables = new[] { "Table" };

            for (var k = 0; k < 4; k++)
            {
                var addedTables = list.Select(t2 => t2);
                var real = DbHelper.GetTableName(existedTables.Concat(addedTables).ToList(), "Table");
                list.Add(real);
            }

            var expected = new[] { "Table", "Table0", "Table1", "Table2", "Table3" };

            Assert.IsFalse(expected.Except(list).Except(new[] { "Table" }).Any(), "test name 6_1");
            Assert.IsFalse(list.Except(expected).Any(), "test name 6_2");
        }


        #region CSV converter

        [TestMethod]
        public void CsvConverter_ReturnsCsv_Test()
        {
            var rp = new RequestParameters { SearchParameters = { Export = { Csv = { Delimiter = ",", ShowColumnNames = true, ForceQuotes = false } } } };
            var sut = new CsvConverter(rp);
            string result;
            sut.Convert(GetDataSetWithNumberOfTables(1), out result);
            var expected = "Id,Name,Date\r\n0,Monday;," + TestDate + "\r\n";

            Assert.AreEqual(expected, result, "CSV string is unexpected. [2]");
        }

        [TestMethod]
        public void CsvConverter_EscapesValues_Test()
        {
            var rp = new RequestParameters { SearchParameters = { Export = { Csv = { Delimiter = ",", ShowColumnNames = true, ForceQuotes = false } } } };
            var sut = new CsvConverter(rp);
            string result;
            sut.Convert(GetDataSetWithNumberOfTables(1, true), out result);
            var expected = "Id,Name,Date\r\n0,\"~!@#$%^&*()_+=-?/\\\"\"'<>|[]{}(),.&amp;&gt; &lt;\\r\\n\\t\"," + TestDate + "\r\n";

            Assert.AreEqual(expected, result, "CSV escaped string is unexpected. [5]");
        }

        [TestMethod]
        public void CsvConverter_Quotes_Custom_Delimiter_And_Skips_Column_Names_Test()
        {
            var rp = new RequestParameters { SearchParameters = { Export = { Csv = { Delimiter = ";", ShowColumnNames = false, ForceQuotes = false } } } };
            var sut = new CsvConverter(rp);
            string result = null;
            sut.Convert(GetDataSetWithNumberOfTables(1), out result);
            var expected = "0;\"Monday;\";" + TestDate + "\r\n";

            Assert.AreEqual(expected, result, "CSV custom delimiter or column names are wrong. [7]");
        }

        [TestMethod]
        public void CsvConverter_No_Delimiter_Specified_Test()
        {
            var rp = new RequestParameters { SearchParameters = { Export = { Csv = { ShowColumnNames = false, ForceQuotes = false } } } };
            var sut = new CsvConverter(rp);
            string result = null;
            sut.Convert(GetDataSetWithNumberOfTables(1), out result);
            var expected = "0,Monday;," + TestDate + "\r\n";

            Assert.AreEqual(expected, result, "CSV custom delimiter should be set by default to comma. [8]");
        }

        [TestMethod]
        public void CsvConverter_Force_Quotes_Test()
        {
            var rp = new RequestParameters { SearchParameters = { Export = { Csv = { ShowColumnNames = false, ForceQuotes = true } } } };
            var sut = new CsvConverter(rp);
            string result = null;
            sut.Convert(GetDataSetWithNumberOfTables(1), out result);
            var expected = "\"0\",\"Monday;\",\"" + TestDate + "\"\r\n";

            Assert.AreEqual(expected, result, "CSV force quotes option with unexpected output. [9]");
        }

        [TestMethod]
        public void CsvConverter_Null_AsParameter_Test()
        {
            var rp = new RequestParameters { SearchParameters = { Export = { Csv = { ShowColumnNames = false, ForceQuotes = false } } } };
            var sut = new CsvConverter(rp);
            string result = null;
            sut.Convert(null, out result);
            var expected = "Data set is null or contains no tables.";

            Assert.AreEqual(expected, result, "Null as parameter. [10]");
        }

        [TestMethod]
        public void CsvConverter_Empty_DataSet_AsParameter_Test()
        {
            var rp = new RequestParameters { SearchParameters = { Export = { Csv = { ShowColumnNames = false, ForceQuotes = false } } } };
            var sut = new CsvConverter(rp);
            string result = null;
            sut.Convert(new DataSet(), out result);
            var expected = "Data set is null or contains no tables.";

            Assert.AreEqual(expected, result, "Empty DataSet. [11]");
        }

        [TestMethod]
        public void CsvConverter_Empty_Table_AsParameter_Test()
        {
            var rp = new RequestParameters { SearchParameters = { Export = { Csv = { ShowColumnNames = false, ForceQuotes = false } } } };
            var sut = new CsvConverter(rp);
            var ds = new DataSet();
            ds.Tables.Add(new DataTable());
            string result = null;
            sut.Convert(ds, out result);
            var expected = "Table is empty.";

            Assert.AreEqual(expected, result, "Empty DataTable. [12]");
        }

        [TestMethod]
        public void CsvConverter_Multiple_Tables_In_Dataset_Test()
        {
            var rp = new RequestParameters { SearchParameters = { Export = { Csv = { Delimiter = ",", ShowColumnNames = true, ForceQuotes = false } } } };
            var sut = new CsvConverter(rp);
            string result = null;
            sut.Convert(GetDataSetWithNumberOfTables(2), out result);
            var expected = "Id,Name,Date\r\n0,Monday;," + TestDate + "\r\nNewTable\r\nId,Name,Date\r\n1,Tuesday;," + TestDate.AddDays(1) + "\r\n";

            Assert.AreEqual(expected, result, "CSV string is unexpected. [2]");

        }

        #endregion

        #region JSON converter

        [TestMethod]
        public void JsonConverter_ReturnsJson_Test()
        {
            var sut = new JsonConverter(new RequestParameters());
            string result = null;
            sut.Convert(GetDataSetWithNumberOfTables(1), out result);
            var expected = "{\"Table1\":[{\"Id\":0,\"Name\":\"Monday;\",\"Date\":\"2014-09-01T00:00:00\"}]}";

            Assert.AreEqual(expected, result, "JSON string is unexpected. [1]");
        }

        [TestMethod]
        public void JsonConverter_EscapesValues_Test()
        {
            var sut = new JsonConverter(new RequestParameters());
            string result = null;
            sut.Convert(GetDataSetWithNumberOfTables(1, true), out result);
            var expected = "{\"Table1\":[{\"Id\":0,\"Name\":\"~!@#$%^&*()_+=-?/\\\\\\\"'<>|[]{}(),.&amp;&gt; &lt;\\\\r\\\\n\\\\t\",\"Date\":\"2014-09-01T00:00:00\"}]}";

            Assert.AreEqual(expected, result, "JSON escaped string is unexpcted. [4]");
        }

        #endregion

        #region XML converter

        [TestMethod]
        public void XmlConverter_ReturnsXml_Test()
        {
            var sut = new XmlConverter();
            string result = null;
            sut.Convert(GetDataSetWithNumberOfTables(1), out result);
            var expected = "<NewDataSet>\r\n  <Table1>\r\n    <Id>0</Id>\r\n    <Name>Monday;</Name>\r\n    <Date>2014-09-01T00:00:00</Date>\r\n  </Table1>\r\n</NewDataSet>";

            Assert.AreEqual(expected, result, "XML string is unexpected. [3]");
        }

        [TestMethod]
        public void XmlConverter_EscapesValues_Test()
        {
            var sut = new XmlConverter();
            string result = null;
            sut.Convert(GetDataSetWithNumberOfTables(1, true), out result);
            var expected = "<NewDataSet>\r\n  <Table1>\r\n    <Id>0</Id>\r\n    <Name>~!@#$%^&amp;*()_+=-?/\\\"'&lt;&gt;|[]{}(),.&amp;amp;&amp;gt; &amp;lt;\\r\\n\\t</Name>\r\n    <Date>2014-09-01T00:00:00</Date>\r\n  </Table1>\r\n</NewDataSet>";

            Assert.AreEqual(expected, result, "XML escaped string is unexpected. [6]");
        }

        [TestMethod]
        public void XmlConverter_Multiple_Tables_In_Dataset_Test()
        {
            var sut = new XmlConverter();
            string result = null;
            sut.Convert(GetDataSetWithNumberOfTables(2), out result);
            var expected = "<NewDataSet>\r\n  <Table1>\r\n    <Id>0</Id>\r\n    <Name>Monday;</Name>\r\n    <Date>2014-09-01T00:00:00</Date>\r\n  </Table1>\r\n  <Table2>\r\n    <Id>1</Id>\r\n    <Name>Tuesday;</Name>\r\n    <Date>2014-09-02T00:00:00</Date>\r\n  </Table2>\r\n</NewDataSet>";

            Assert.AreEqual(expected, result, "XML string is unexpected. [3]");
        }

        [TestMethod]
        public void XmlConverter_Two_Tables_Second_Table_Is_Empty_Test()
        {
            var sut = new XmlConverter();
            var ds = GetDataSetWithNumberOfTables(2);
            ds.Tables[1].Clear();
            string result = null;
            sut.Convert(ds, out result);
            var expected = "<NewDataSet>\r\n  <Table1>\r\n    <Id>0</Id>\r\n    <Name>Monday;</Name>\r\n    <Date>2014-09-01T00:00:00</Date>\r\n  </Table1>\r\n</NewDataSet>";

            Assert.AreEqual(expected, result, "XML string is unexpected. [3]");
        }

        [TestMethod]
        public void XmlConverter_Three_Tables_Second_Table_Is_Empty_Test()
        {
            var sut = new XmlConverter();
            var ds = GetDataSetWithNumberOfTables(3);
            ds.Tables[1].Clear();
            string result = null;
            sut.Convert(ds, out result);
            var expected = "<NewDataSet>\r\n  <Table1>\r\n    <Id>0</Id>\r\n    <Name>Monday;</Name>\r\n    <Date>2014-09-01T00:00:00</Date>\r\n  </Table1>\r\n  <Table3>\r\n    <Id>2</Id>\r\n    <Name>Wednesday;</Name>\r\n    <Date>2014-09-03T00:00:00</Date>\r\n  </Table3>\r\n</NewDataSet>";

            Assert.AreEqual(expected, result, "XML string is unexpected. [3]");
        }

        #endregion

        #region private stuff

        private DataSet GetDataSetWithNumberOfTables(int tablesNum, bool addSpecialSymbols = false)
        {
            var specialSymbols = "~!@#$%^&*()_+=-?/\\\"'<>|[]{}(),.&amp;&gt; &lt;\\r\\n\\t";
            var ds = new DataSet();

            for (int k = 0; k < tablesNum; k++)
            {
                var dt = new DataTable();
                dt.Columns.AddRange(new[]
            {
                new DataColumn("Id", typeof(int)),
                new DataColumn("Name", typeof(string)),
                new DataColumn("Date", typeof(DateTime)),
            });

                var r = dt.NewRow();
                r[0] = k;
                r[1] = addSpecialSymbols ? specialSymbols : TestDate.AddDays(k).DayOfWeek + ";";
                r[2] = TestDate.AddDays(k);

                dt.Rows.Add(r);
                ds.Tables.Add(dt);
            }

            return ds;
        }

        private DateTime TestDate
        {
            get
            {
                return new DateTime(2014, 09, 01, 0, 0, 0, 0, DateTimeKind.Utc);
            }
        }

        #endregion
    }
}