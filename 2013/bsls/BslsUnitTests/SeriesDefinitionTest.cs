using Jnj.ThirdDimension.BusinessLayer.BarcodeSeries;
using NUnit.Framework;
using Jnj.ThirdDimension.Data.BarcodeSeries;
using System;
using System.Text;
using System.Globalization;

namespace BslsUnitTests
{


   /// <summary>
   ///This is a test class for SeriesDefinitionTest and is intended
   ///to contain all SeriesDefinitionTest Unit Tests
   ///</summary>
   [TestFixture()]
   public class SeriesDefinitionTest
   {

      /// <summary>
      ///A test for GetSequenceFormatString
      ///</summary>
      [Test()]
      public void GetSequenceFormatStringTest1()
      {
         string seriesDefinition = "<?xml version=\"1.0\" encoding=\"utf-8\"?><Parts xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\"><Part Text=\"123: \" /><Part Date=\"yyyy\" /><Part Text=\"-\" /><Part Date=\"MM\" /><Part Text=\"-\" /><Part Date=\"dd\" /></Parts>";
         string dbConnection = "<?xml version=\"1.0\" encoding=\"utf-8\"?><Conn xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" SeqRn=\"ABCDTest\" TabRn=\"ABCDTest\" SeqAcc=\"series_user_g\" TabAcc=\"series_user_g\" />";
         BSDataSet.SeriesDataTable sdt = new BSDataSet.SeriesDataTable();
         BSDataSet.SeriesRow row = sdt.AddSeriesRow(1, "", "", 0, dbConnection, "", seriesDefinition, 0, "", 0, DateTime.Now, 0);

         SeriesGenerator_Accessor sg = new SeriesGenerator_Accessor(null, row);
         sg.RangeStartFromColumnName = "RANGE_START_FROM";
         SeriesDefinition target = sg.LoadRange(false);
         
         string expected = "123: 2012-12-{0}";
         string actual;
         actual = target.GetSequenceFormatString(new DateTime(2012, 12, 12));
         Assert.AreEqual(expected, actual);
      }

      /// <summary>
      ///A test for GetSequenceFormatString
      ///</summary>
      [Test()]
      public void GetSequenceFormatStringTest2()
      {
         string seriesDefinition = "<?xml version=\"1.0\" encoding=\"utf-8\"?><Parts xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\"><Part Text=\"123: \" /><Part Date=\"yyyy\" /><Part Text=\"-\" /><Part Date=\"MM\" /><Part Text=\"-\" /><Part Date=\"dd\" /><Part Text=\"-\" /><Part Sequence=\"###\" /></Parts>";
         string dbConnection = "<?xml version=\"1.0\" encoding=\"utf-8\"?><Conn xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" SeqRn=\"ABCDTest\" TabRn=\"ABCDTest\" SeqAcc=\"series_user_g\" TabAcc=\"series_user_g\" />";
         BSDataSet.SeriesDataTable sdt = new BSDataSet.SeriesDataTable();
         BSDataSet.SeriesRow row = sdt.AddSeriesRow(1, "", "", 0, dbConnection, "", seriesDefinition, 0, "", 0, DateTime.Now, 0);

         SeriesGenerator_Accessor sg = new SeriesGenerator_Accessor(null, row);
         sg.RangeStartFromColumnName = "RANGE_START_FROM";
         SeriesDefinition target = sg.LoadRange(false);

         string expected = "123: 2012-12-12-{0:000}";
         string actual;
         actual = target.GetSequenceFormatString(new DateTime(2012, 12, 12));
         Assert.AreEqual(expected, actual);
      }

      /// <summary>
      ///A test for GetSequenceFormatString
      ///</summary>
      [Test()]
      public void GetSequenceFormatStringTest2_1()
      {
         string seriesDefinition = "<?xml version=\"1.0\" encoding=\"utf-8\"?><Parts xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\"><Part Text=\"123: \" /><Part Date=\"yyyy\" /><Part Text=\"-\" /><Part Date=\"MM\" /><Part Text=\"-\" /><Part Date=\"dd\" /><Part Text=\"-\" /><Part Sequence=\"#\" /></Parts>";
         string dbConnection = "<?xml version=\"1.0\" encoding=\"utf-8\"?><Conn xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" SeqRn=\"ABCDTest\" TabRn=\"ABCDTest\" SeqAcc=\"series_user_g\" TabAcc=\"series_user_g\" />";
         BSDataSet.SeriesDataTable sdt = new BSDataSet.SeriesDataTable();
         BSDataSet.SeriesRow row = sdt.AddSeriesRow(1, "", "", 0, dbConnection, "", seriesDefinition, 0, "", 0, DateTime.Now, 0);

         SeriesGenerator_Accessor sg = new SeriesGenerator_Accessor(null, row);
         sg.RangeStartFromColumnName = "RANGE_START_FROM";
         SeriesDefinition target = sg.LoadRange(false);

         string expected = "123: 2012-12-12-{0:0}";
         string actual;
         actual = target.GetSequenceFormatString(new DateTime(2012, 12, 12));
         Assert.AreEqual(expected, actual);
      }

      /// <summary>
      ///A test for GetSequenceFormatString
      ///</summary>
      [Test()]
      public void GetSequenceFormatStringTest3()
      {
         string seriesDefinition = "<?xml version=\"1.0\" encoding=\"utf-8\"?><Parts xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\"><Part Text=\"123: \" /></Parts>";
         string dbConnection = "<?xml version=\"1.0\" encoding=\"utf-8\"?><Conn xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" SeqRn=\"ABCDTest\" TabRn=\"ABCDTest\" SeqAcc=\"series_user_g\" TabAcc=\"series_user_g\" />";
         BSDataSet.SeriesDataTable sdt = new BSDataSet.SeriesDataTable();
         BSDataSet.SeriesRow row = sdt.AddSeriesRow(1, "", "", 0, dbConnection, "", seriesDefinition, 0, "", 0, DateTime.Now, 0);

         SeriesGenerator_Accessor sg = new SeriesGenerator_Accessor(null, row);
         sg.RangeStartFromColumnName = "RANGE_START_FROM";
         SeriesDefinition target = sg.LoadRange(false);

         string expected = "123: ";
         string actual;
         actual = target.GetSequenceFormatString();
         Assert.AreEqual(expected, actual);
      }

      /// <summary>
      /// Week is incremental field here
      ///</summary>
      [Test()]
      public void GetSequenceFormatStringTest4()
      {
         string seriesDefinition = "<?xml version=\"1.0\" encoding=\"utf-8\"?><Parts xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\"><Part Text=\"WW: \" /><Part Date=\"WW\" /></Parts>";
         string dbConnection = "<?xml version=\"1.0\" encoding=\"utf-8\"?><Conn xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" SeqRn=\"ABCDTest\" TabRn=\"ABCDTest\" SeqAcc=\"series_user_g\" TabAcc=\"series_user_g\" />";
         BSDataSet.SeriesDataTable sdt = new BSDataSet.SeriesDataTable();
         BSDataSet.SeriesRow row = sdt.AddSeriesRow(1, "", "", 0, dbConnection, "", seriesDefinition, 0, "", 0, DateTime.Now, 0);

         SeriesGenerator_Accessor sg = new SeriesGenerator_Accessor(null, row);
         sg.RangeStartFromColumnName = "RANGE_START_FROM";
         SeriesDefinition target = sg.LoadRange(false);

         string expected = "WW: {0}";
         string actual;
         actual = target.GetSequenceFormatString();
         Assert.AreEqual(expected, actual);
      }

      /// <summary>
      /// Week is a week.
      ///</summary>
      [Test()]
      public void GetSequenceFormatStringTest5()
      {
         string seriesDefinition = "<?xml version=\"1.0\" encoding=\"utf-8\"?><Parts xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\"><Part Text=\"WW: \" /><Part Date=\"WW\" /><Part Sequence=\"#\" /></Parts>";
         string dbConnection = "<?xml version=\"1.0\" encoding=\"utf-8\"?><Conn xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" SeqRn=\"ABCDTest\" TabRn=\"ABCDTest\" SeqAcc=\"series_user_g\" TabAcc=\"series_user_g\" />";
         BSDataSet.SeriesDataTable sdt = new BSDataSet.SeriesDataTable();
         BSDataSet.SeriesRow row = sdt.AddSeriesRow(1, "", "", 0, dbConnection, "", seriesDefinition, 0, "", 0, DateTime.Now, 0);

         SeriesGenerator_Accessor sg = new SeriesGenerator_Accessor(null, row);
         sg.RangeStartFromColumnName = "RANGE_START_FROM";
         SeriesDefinition target = sg.LoadRange(false);

         string expected = string.Format("WW: {0}{1}",
            CultureInfo.CurrentCulture.Calendar.GetWeekOfYear(DateTime.Today, CalendarWeekRule.FirstFourDayWeek, DayOfWeek.Monday).ToString("0"),
            "{0:0}");

         string actual;
         actual = target.GetSequenceFormatString();
         Assert.AreEqual(expected, actual);
      }

      [Test]
      public void GetValuesTest()
      {
         string seriesDefinition = "<?xml version=\"1.0\" encoding=\"utf-8\"?><Parts xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\"><Part Text=\"TEST-\" /><Part Date=\"WW\" /><Part Sequence=\"##\" /></Parts>";
         string dbConnection = "<?xml version=\"1.0\" encoding=\"utf-8\"?><Conn xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" SeqRn=\"ABCDTest\" TabRn=\"ABCDTest\" SeqAcc=\"series_user_g\" TabAcc=\"series_user_g\" />";
         SeriesDefinition seriesInfo = new SeriesDefinition();
         seriesInfo.State = SeriesDefinition.RangeState.Update;

         seriesInfo.BeginLoadData();

         seriesInfo.Template = SeriesDefinition.Deserialize<SeriesTemplate>(seriesDefinition);
         seriesInfo.SetConnection(SeriesDefinition.Deserialize<SeriesConnectionData>(dbConnection), false);

         seriesInfo.Name = "A1";
         seriesInfo.ID = 1;
         seriesInfo.ResetTypeId = 1;
         seriesInfo.Start = 12;

         seriesInfo.DBQuery = "select * from somewhere";
         seriesInfo.DBSequence = "seq";
         seriesInfo.ReservationsDT = null;

         seriesInfo.EndLoadData();

         BSDataSet.ReservationDataTable rdt = new BSDataSet.ReservationDataTable();
         BSDataSet.ReservationRow row = rdt.NewReservationRow();
         row.SERIES_ID = 1;
         row.MIN_VALUE = 100;
         row.MAX_VALUE = 101;

         string week = CultureInfo.CurrentCulture.Calendar.GetWeekOfYear(DateTime.Today, CalendarWeekRule.FirstFourDayWeek, DayOfWeek.Monday).ToString("0");
         string expected = string.Format("TEST-{0}100TEST-{0}101", week);
         string actual = string.Empty;
         seriesInfo.GetValues(row).ForEach(str => actual += str);
         Assert.AreEqual(expected, actual, "Assert 1");

         row.SERIES_ID = 2;
         expected = string.Empty;
         actual = string.Empty;
         seriesInfo.GetValues(row).ForEach(str => actual += str);
         Assert.AreEqual(expected, actual, "Assert 2");

      }

      /// <summary>
      ///A test for FilterValue2DateFormat
      ///</summary>
      [Test()]
      public void FilterValue2DateFormatTest()
      {
         string result = SeriesDefinition.FilterValue2DateFormat("name", PartType.Day);
         Assert.AreEqual("dddd", result, "Assert 1");

         result = SeriesDefinition.FilterValue2DateFormat("d", PartType.Day);
         Assert.AreEqual("%d", result, "Assert 2");

         result = SeriesDefinition.FilterValue2DateFormat("MM", PartType.Month);
         Assert.AreEqual("MM", result, "Assert 3");

         result = SeriesDefinition.FilterValue2DateFormat("name", PartType.Month);
         Assert.AreEqual("MMMM", result, "Assert 4");

         result = SeriesDefinition.FilterValue2DateFormat("##", PartType.Sequence);
         Assert.AreEqual("00", result, "Assert 5");

         result = SeriesDefinition.FilterValue2DateFormat("#", PartType.Sequence);
         Assert.AreEqual("0", result, "Assert 6");

         result = SeriesDefinition.FilterValue2DateFormat("WW", PartType.Week);
         Assert.AreEqual("00", result, "Assert 7");

         result = SeriesDefinition.FilterValue2DateFormat("W", PartType.Week);
         Assert.AreEqual("0", result, "Assert 8");

         result = SeriesDefinition.FilterValue2DateFormat("YY", PartType.Year);
         Assert.AreEqual("yy", result, "Assert 9");

         result = SeriesDefinition.FilterValue2DateFormat("WW", PartType.Text);
         Assert.AreEqual("WW", result, "Assert 10");

        
      }

      /// <summary>
      ///A test for EnsureInfoLength
      ///</summary>
      [Test()]
      public void EnsureInfoLengthTest()
      {
         string longString = new string('S', 4001);
         string expected = string.Format("<CUT>{0}</CUT>", new string('S', 3989));
         
         SeriesDefinition_Accessor target = new SeriesDefinition_Accessor();
         string actual = target.EnsureInfoLength(longString);
         
         Assert.AreEqual(expected, actual);
      }

      /// <summary>
      ///A test for FilterDateFormat2Value
      ///</summary>
      [Test()]
      public void FilterDateFormat2ValueTest()
      {
         string result = SeriesDefinition.FilterDateFormat2Value("MMMM");
         Assert.AreEqual("NAME", result, "Assert 1");

         result = SeriesDefinition.FilterDateFormat2Value("dddd");
         Assert.AreEqual("NAME", result, "Assert 2");

         result = SeriesDefinition.FilterDateFormat2Value("%d");
         Assert.AreEqual("D", result, "Assert 3");

         result = SeriesDefinition.FilterDateFormat2Value("yyy");
         Assert.AreEqual("yyy", result, "Assert 4");

         result = SeriesDefinition.FilterDateFormat2Value("YYY");
         Assert.AreEqual("YYY", result, "Assert 5");

      }


      [Test]
      public void TemplateSerializationTest()
      {
         //string expected_real_serialization = "<?xml version=\"1.0\" encoding=\"utf-8\"?><Parts xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\"><Part Text=\"TEST-\" /><Part Date=\"WW\" /><Part Sequence=\"##\" /></Parts>";
         string expectedXml = "<?xml version=\"1.0\" encoding=\"utf-8\"?><Parts><Part Text=\"TEST-\" /><Part Date=\"WW\" /><Part Sequence=\"##\" /></Parts>";
         string expectedVal = "TEST-WW##";

         SeriesTemplate st = new SeriesTemplate();
         SeriesTemplate.Part[] parts = new SeriesTemplate.Part[3];
         parts[0] = new SeriesTemplate.Part();
         parts[0].Text = "TEST-";
         
         parts[1] = new SeriesTemplate.Part();
         parts[1].Date = "WW";

         parts[2] = new SeriesTemplate.Part();
         parts[2].Sequence = "##";
         
         st.Parts = parts;

         string actualXml = SeriesDefinition.Serialize<SeriesTemplate>(st);
         Assert.AreEqual(expectedXml, actualXml, "Serialization failed");

         SeriesTemplate sd = SeriesDefinition.Deserialize<SeriesTemplate>(actualXml);
         Assert.AreEqual(expectedVal, sd.GetTemplate(), "Deserialization failed");
      }


      [Test]
      public void ConnectionSerializationTest()
      {
         string expectedXml = "<?xml version=\"1.0\" encoding=\"utf-8\"?><Conn SeqRn=\"ABCDTest1\" TabRn=\"ABCDTest2\" SeqAcc=\"series_user_g3\" TabAcc=\"series_user_g4\" />";

         var sc = new SeriesConnectionData();
         sc.SequenceAccount = "series_user_g3";
         sc.SequenceResourceName = "ABCDTest1";
         sc.TableAccount = "series_user_g4";
         sc.TableResourceName = "ABCDTest2";

         string actualXml = SeriesDefinition.Serialize<SeriesConnectionData>(sc);
         Assert.AreEqual(expectedXml, actualXml, "Serialization failed");

         var sc2 = SeriesDefinition.Deserialize<SeriesConnectionData>(actualXml);
         Assert.AreEqual("series_user_g3", sc.SequenceAccount, "sc.SequenceAccount failed");
         Assert.AreEqual("ABCDTest1", sc.SequenceResourceName, "sc.SequenceResourceName failed");
         Assert.AreEqual("series_user_g4", sc.TableAccount, "sc.TableAccount failed");
         Assert.AreEqual("ABCDTest2", sc.TableResourceName, "sc.TableResourceName failed");
      }


      [Test]
      public void GetChangesTest()
      {
         SeriesDefinition sd = new SeriesDefinition();
         
         sd.BeginLoadData();
         sd.DBQuery = "db query before";
         sd.DBSequence = "db sequence before";
         sd.ID = 1;
         sd.Name = "Name before";
         sd.ResetTypeId = 1;
         sd.Start = 1;
         sd.EndLoadData();

         Assert.AreEqual(string.Empty, sd.GetChanges(), "Assert 1");

         sd.DBQuery = "db query after";
         sd.DBSequence = "db sequence after";
         sd.ID = 2;
         sd.Name = "Name after";
         sd.ResetTypeId = 2;
         sd.Start = 2;

         string changes = sd.GetChanges();
         StringBuilder expected = new StringBuilder();
         expected.AppendFormat(SeriesDefinition_Accessor.format, "DB_CHECK_QUERY", "db query before");
         expected.AppendFormat(SeriesDefinition_Accessor.format, "DB_SEQUENCE", "db sequence before");
         expected.AppendFormat(SeriesDefinition_Accessor.format, "ID", "1");
         expected.AppendFormat(SeriesDefinition_Accessor.format, "NAME", "Name before");
         expected.AppendFormat(SeriesDefinition_Accessor.format, "RESET_TYPE_ID", "1");
         expected.AppendFormat(SeriesDefinition_Accessor.format, "RANGE_START_FROM", "1");

         Assert.AreEqual(expected.ToString(), changes, "Assert 2");

      }
   }
}
