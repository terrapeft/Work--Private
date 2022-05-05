using Jnj.ThirdDimension.Utils.BarcodeSeries;
using NUnit.Framework;
using System;

namespace BslsUnitTests
{
   
    /// <summary>
    ///This is a test class for SqlHelperTest and is intended
    ///to contain all SqlHelperTest Unit Tests
    ///</summary>
   [TestFixture]
   public class SqlHelperTest
   {

      /// <summary>
      ///A test for SelectMax
      ///</summary>
      [Test]
      public void JoinTest()
      {
         string query = "select field from table";
         string filter = "where x = 1";
         Assert.AreEqual("select field from table where x = 1", SqlHelper.Join(query, filter), "Assert 1");

         query = "select field from table";
         filter = "x = 1";
         Assert.AreEqual("select field from table where x = 1", SqlHelper.Join(query, filter), "Assert 2");

         query = "select field from table where y = 3";
         filter = "where x = 1";
         Assert.AreEqual("select field from table where y = 3 and x = 1", SqlHelper.Join(query, filter), "Assert 3");

         query = "select field from table where y = 3";
         filter = "x = 1";
         Assert.AreEqual("select field from table where y = 3 and x = 1", SqlHelper.Join(query, filter), "Assert 4");

         query = "select field from table where y = 3 and xy = 6";
         filter = "x = 1";
         Assert.AreEqual("select field from table where y = 3 and xy = 6 and x = 1", SqlHelper.Join(query, filter), "Assert 5");
      }

      /// <summary>
      ///A test for SelectMax
      ///</summary>
      [Test]
      public void SelectMaxTest()
      {
         string query = "select field from table";
         string expected = "select max(field) from table";
         string actual = SqlHelper.SelectMax(query);
         
         Assert.AreEqual(expected, actual);
      }

      /// <summary>
      ///A test for SelectCount
      ///</summary>
      [Test]
      public void SelectCountTestWithFilter()
      {
         string sql = "select a, b as f, c from table";

         string filter = "abc = 'COATS'";

         string expected = "select count(*) from table where abc = 'COATS'";
         string actual = SqlHelper.SelectCount(sql, filter);
         
         Assert.AreEqual(expected, actual);
      }

      /// <summary>
      ///A test for SelectCount
      ///</summary>
      [Test]
      public void SelectCountTestWithConditionAndFilter()
      {
         string sql = "select a, b as f, c from table where a.x = f.y";

         string filter = "a.bc = 'COATS'";

         string expected = "select count(*) from table where a.x = f.y and a.bc = 'COATS'";
         string actual = SqlHelper.SelectCount(sql, filter);

         Assert.AreEqual(expected, actual);
      }

      /// <summary>
      ///A test for SelectCount
      ///</summary>
      [Test]
      public void SelectCountSimpleTest()
      {
         string sql = "select a, b as f, c from table";
         string expected = "select count(*) from table";
         string actual = SqlHelper.SelectCount(sql);
         
         Assert.AreEqual(expected, actual);
      }

      /// <summary>
      ///A test for GetSelectField
      ///</summary>
      [Test]
      public void GetFieldTest()
      {
         string query = "select barcode from table";
         string expected = "barcode";
         string actual = SqlHelper.GetField(query);
         
         Assert.AreEqual(expected, actual);
      }

      /// <summary>
      ///A test for GetSelectField
      ///</summary>
      [Test]
      public void GetTableTest()
      {
         string query = "select barcode from schema.table";
         string expected = "table";
         string actual = SqlHelper.GetTable(query);

         Assert.AreEqual(expected, actual, "Assert 1");


         query = "select barcode from table";
         expected = "table";
         actual = SqlHelper.GetTable(query);

         Assert.AreEqual(expected, actual, "Assert 2");

         query = null;
         expected = "";
         actual = SqlHelper.GetTable(query);

         Assert.AreEqual(expected, actual, "Assert 3");

      }


      /// <summary>
      ///A test for GetSelectField
      ///</summary>
      [Test]
      public void GetSchemaTest()
      {
         string query = "select barcode from schema.table";
         string expected = "schema";
         string actual = SqlHelper.GetSchema(query);

         Assert.AreEqual(expected, actual, "Assert 1");


         query = "select barcode from table";
         expected = "";
         actual = SqlHelper.GetSchema(query);

         Assert.AreEqual(expected, actual, "Assert 2");

         query = null;
         expected = "";
         actual = SqlHelper.GetSchema(query);

         Assert.AreEqual(expected, actual, "Assert 3");

      }

      /// <summary>
      ///A test for GetSelectField
      ///</summary>
      [Test]
      public void GetFullTableNameTest()
      {
         string query = "select barcode from schema.table";
         string expected = "schema.table";
         string actual = SqlHelper.GetFullTableName(query);

         Assert.AreEqual(expected, actual, "Assert 1");


         query = "select barcode from table";
         expected = "table";
         actual = SqlHelper.GetFullTableName(query);

         Assert.AreEqual(expected, actual, "Assert 2");

         query = null;
         expected = "";
         actual = SqlHelper.GetFullTableName(query);

         Assert.AreEqual(expected, actual, "Assert 3");

      }

      /// <summary>
      ///A test for GetSelectField
      ///</summary>
      [Test]
      public void EnsureSequenceNameTest()
      {
         string seqName = "!@^%1# $ c d _______________________12 ";
         string expected = "a_1#_$_c_d____________________";
         string actual = SqlHelper.EnsureSequenceName(seqName);

         Assert.AreEqual(expected, actual, "Assert 1");

         seqName = "abcdefghigklmnopqrstuvwxyz1234567890";
         string concat = "_seq";
         expected = "abcdefghigklmnopqrstuvwxyz_seq";
         actual = SqlHelper.EnsureSequenceName(seqName, concat);

         Assert.AreEqual(expected, actual, "Assert 2");

         seqName = "abcdefghigklmnopqrstuvwxyz1234567890";
         concat = "1234abcdefghigklmnopqrstuvwxyz";
         expected = "ab1234abcdefghigklmnopqrstuvwx";
         actual = SqlHelper.EnsureSequenceName(seqName, concat);

         Assert.AreEqual(expected, actual, "Assert 3");

         seqName = "1abcdefghigklmnopqrstuvwxyz123456789";
         concat = "1234abcdefghigklmnopqrstuvwxyz";
         expected = "a_1234abcdefghigklmnopqrstuvwx";
         actual = SqlHelper.EnsureSequenceName(seqName, concat);

         Assert.AreEqual(expected, actual, "Assert 4");

         seqName = "123^%#$@!";
         concat = "_seq";
         expected = "a_123#$_seq";
         actual = SqlHelper.EnsureSequenceName(seqName, concat);

         Assert.AreEqual(expected, actual, "Assert 5");

         bool catched = false;
         try
         {
            seqName = "!@^%";
            SqlHelper.EnsureSequenceName(seqName);
         }
         catch(ArgumentOutOfRangeException)
         {
            // Resharper UI does not understand ExpectedException or even Assert.Pass
            Assert.True(true);
            catched = true;
         }

         if (catched == false) Assert.Fail("Assert 6");
      }

   }
}
