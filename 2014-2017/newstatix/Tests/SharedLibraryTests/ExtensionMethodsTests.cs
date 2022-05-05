using System;
using System.Collections.Generic;
using System.Collections.Specialized;
using System.Data;
using System.Web;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using SharedLibrary;
using SharedLibrary.IPAddress;
using Subtext.TestLibrary;

namespace SharedLibraryTests
{
    [TestClass]
    public class ExtensionMethodsTests
    {
        [TestMethod]
        public void Sql_NotInList_Test()
        {
            var expected = "field1 not in ('1', '2', '3')";
            var result = (new List<string> { "1", "2", "3" }).NotInList("field1", true);
            Assert.AreEqual(expected, result, "Incorrect quoted NOT IN expression.");

            expected = "field1 not in (1, 2)";
            result = (new List<string> { "1", "2" }).NotInList("field1", false);
            Assert.AreEqual(expected, result, "Incorrect NOT IN expression.");
        }

        [TestMethod]
        public void Collection_To_DataTable_Test()
        {
            var result = (new List<string> { "1", "2", "3" }).ToTable("field2");
            Assert.IsNotNull(result);
            Assert.AreEqual(1, result.Columns.Count);
            Assert.AreEqual("field2", result.Columns[0].ColumnName);
            Assert.AreEqual(3, result.Rows.Count);
        }

        [TestMethod]
        public void Object_ToStringOrEmpty_Test()
        {
            DataTable t = null;
            Assert.AreEqual(string.Empty, t.ToStringOrEmpty());

            string s = null;
            Assert.AreEqual(string.Empty, s.ToStringOrEmpty());

            var e = DBNull.Value;
            Assert.AreEqual(string.Empty, e.ToStringOrEmpty());

            var l = new DataColumn("col");
            Assert.AreEqual("col", l.ToStringOrEmpty());

            s = "123";
            Assert.AreEqual("123", s.ToStringOrEmpty());
        }

        [TestMethod]
        public void String_SplitStringOnCaps_Test()
        {
            var expected = "Some SHORT String";
            var result = "SomeSHORTString".SplitStringOnCaps();
            Assert.AreEqual(expected, result);

            expected = "Some SHORTSt Ring";
            result = "SomeSHORTStRing".SplitStringOnCaps(false);
            Assert.AreEqual(expected, result);
        }

        [TestMethod]
        public void String_ToList_Test()
        {
            var r = "1,2,3".ToList();
            Assert.AreEqual(3, r.Count);

            r = "1 2 3 4".ToList(" ");
            Assert.AreEqual(4, r.Count);

            r = "1%202,3 4".ToList(unescape: true);
            Assert.AreEqual(2, r.Count);
            Assert.AreEqual("1 2", r[0]);

            r = "1%202 3".ToList(" ", true);
            Assert.AreEqual(2, r.Count);
            Assert.AreEqual("1 2", r[0]);
        }
    }
}
