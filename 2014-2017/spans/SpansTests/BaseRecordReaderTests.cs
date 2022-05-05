using System;
using System.Globalization;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using SpansLib.Data.PositionalFormats.RecordReaders;
using SpansLib.Db;
using SpansLib.Ftp;
using WinSCP;

namespace SpansTests
{
    [TestClass]
    public class BaseRecordReaderTests
    {
        [TestMethod]
        public void GetValue_Time_Test()
        {
            var sut = new BaseRecordReader();
            var accessor = new PrivateObject(sut, new PrivateType(typeof(BaseRecordReader)));

            var line = "1234";
            var def = new RecordDefinition()
            {
                DataType = "time(4)", DateFormat = "HHmm", StartPosition = 1, FieldLength = 4
            };

            var expected = new TimeSpan(12, 34, 0);
            var result = accessor.Invoke("GetValue", line, def);

            Assert.IsInstanceOfType(result, typeof(TimeSpan));
            Assert.AreEqual(expected.TotalMilliseconds, ((TimeSpan)result).TotalMilliseconds);
        }

        [TestMethod]
        public void GetValue_Date_Test()
        {
            var sut = new BaseRecordReader();
            var accessor = new PrivateObject(sut, new PrivateType(typeof(BaseRecordReader)));

            var line = "20150612";
            var def = new RecordDefinition
            {
                DataType = "date",
                DateFormat = "yyyyMMdd",
                StartPosition = 1,
                FieldLength = 8
            };

            var expected = new DateTime(2015, 6, 12);
            var result = accessor.Invoke("GetValue", line, def);

            Assert.IsInstanceOfType(result, typeof(DateTime));
            Assert.AreEqual(expected, (DateTime)result);
        }

        [TestMethod]
        public void GetValue_Int_Test()
        {
            var sut = new BaseRecordReader();
            var accessor = new PrivateObject(sut, new PrivateType(typeof(BaseRecordReader)));

            var line = "1234567890";
            var def = new RecordDefinition
            {
                DataType = "int",
                StartPosition = 1,
                FieldLength = 10
            };

            var expected = 1234567890;
            var result = accessor.Invoke("GetValue", line, def);

            Assert.IsInstanceOfType(result, typeof(Int32));
            Assert.AreEqual(expected, (Int32)result);
        }

        [TestMethod]
        public void GetValue_Long_Test()
        {
            var sut = new BaseRecordReader();
            var accessor = new PrivateObject(sut, new PrivateType(typeof(BaseRecordReader)));

            var line = "1234567890123456";
            var def = new RecordDefinition
            {
                DataType = "bigint",
                StartPosition = 1,
                FieldLength = 16
            };

            var expected = 1234567890123456;
            var result = accessor.Invoke("GetValue", line, def);

            Assert.IsInstanceOfType(result, typeof(Int64));
            Assert.AreEqual(expected, (Int64)result);
        }

        [TestMethod]
        public void GetValue_Decimal1_Test()
        {
            var sut = new BaseRecordReader();
            var accessor = new PrivateObject(sut, new PrivateType(typeof(BaseRecordReader)));

            var line = "1234567";
            var def = new RecordDefinition
            {
                DataType = "decimal(7,4)",
                StartPosition = 1,
                FieldLength = 7
            };

            var expected = 123.4567m;
            var result = accessor.Invoke("GetValue", line, def);

            Assert.IsInstanceOfType(result, typeof(decimal));
            Assert.AreEqual(expected, (decimal)result);
        }

        [TestMethod]
        public void GetValue_Decimal2_Test()
        {
            var sut = new BaseRecordReader();
            var accessor = new PrivateObject(sut, new PrivateType(typeof(BaseRecordReader)));

            var line = "1234567";
            var def = new RecordDefinition
            {
                DataType = "decimal ( 7,  4 ) ",
                StartPosition = 1,
                FieldLength = 7
            };

            var expected = 123.4567m;
            var result = accessor.Invoke("GetValue", line, def);

            Assert.IsInstanceOfType(result, typeof(decimal));
            Assert.AreEqual(expected, (decimal)result);
        }

        [TestMethod]
        public void GetValue_FullString_Test()
        {
            var sut = new BaseRecordReader();
            var accessor = new PrivateObject(sut, new PrivateType(typeof(BaseRecordReader)));

            // line length 4
            var line = "full";

            var def = new RecordDefinition
            {
                DataType = "nvarchar(4)",
                StartPosition = 1,
                FieldLength = 4 // field length 4
            };

            var expected = "full";
            var result = accessor.Invoke("GetValue", line, def);

            Assert.AreEqual(expected, (string)result);
        }

        [TestMethod]
        public void GetValue_ShorterString1_Test()
        {
            var sut = new BaseRecordReader();
            var accessor = new PrivateObject(sut, new PrivateType(typeof(BaseRecordReader)));

            // line length 2
            var line = "az";

            var def = new RecordDefinition
            {
                DataType = "nvarchar(4)",
                StartPosition = 1,
                FieldLength = 4 // field length still 4
            };

            var expected = "az";
            var result = accessor.Invoke("GetValue", line, def);

            Assert.AreEqual(expected, (string)result);
        }

        [TestMethod]
        public void GetValue_ShorterString2_Test()
        {
            var sut = new BaseRecordReader();
            var accessor = new PrivateObject(sut, new PrivateType(typeof(BaseRecordReader)));

            var line = "az";

            var def = new RecordDefinition
            {
                DataType = "nvarchar(4)",
                StartPosition = 2,
                FieldLength = 4
            };

            var expected = "z";
            var result = accessor.Invoke("GetValue", line, def);

            Assert.AreEqual(expected, (string)result);
        }

        [TestMethod]
        public void GetValue_WrongPosition1_Test()
        {
            var sut = new BaseRecordReader();
            var accessor = new PrivateObject(sut, new PrivateType(typeof(BaseRecordReader)));

            var line = "az";

            var def = new RecordDefinition
            {
                DataType = "nvarchar(4)",
                StartPosition = 3,
                FieldLength = 4
            };

            var expected = DBNull.Value;
            var result = accessor.Invoke("GetValue", line, def);

            Assert.AreEqual(expected, result);
        }

        [TestMethod]
        public void GetValue_WrongPosition2_Test()
        {
            var sut = new BaseRecordReader();
            var accessor = new PrivateObject(sut, new PrivateType(typeof(BaseRecordReader)));

            var line = "az";

            var def = new RecordDefinition
            {
                DataType = "nvarchar(4)",
                StartPosition = 10,
                FieldLength = 4
            };

            var expected = DBNull.Value;
            var result = accessor.Invoke("GetValue", line, def);

            Assert.AreEqual(expected, result);
        }

    }
}
