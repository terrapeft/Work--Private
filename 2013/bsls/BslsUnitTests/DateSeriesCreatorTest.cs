using Jnj.ThirdDimension.BusinessLayer.BarcodeSeries;
using Jnj.ThirdDimension.BusinessLayer.BarcodeSeries.Creators;
using System;
using System.Collections.Generic;
using NU = NUnit.Framework;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using Jnj.ThirdDimension.Data.BarcodeSeries;
using System.Security;
using System.Globalization;

namespace BslsUnitTests
{
    
    
    /// <summary>
    ///This is a test class for DateSeriesCreatorTest and is intended
    ///to contain all DateSeriesCreatorTest Unit Tests
    ///</summary>
   [NU.TestFixture]
   public class DateSeriesCreatorTest
   {


      /// <summary>
      ///A test for GetValues for template "text yyyy-MM-dd".
      ///</summary>
      [NU.Test()]
      public void GetValuesTest1()
      {
         string seriesDefinition = "<?xml version=\"1.0\" encoding=\"utf-8\"?><Parts xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\"><Part Text=\"123: \" /><Part Date=\"yyyy\" /><Part Text=\"-\" /><Part Date=\"MM\" /><Part Text=\"-\" /><Part Date=\"dd\" /></Parts>";
         BSDataSet.SeriesDataTable sdt = new BSDataSet.SeriesDataTable();
         BSDataSet.SeriesRow row = sdt.AddSeriesRow(1, "", "", 0, "", "", seriesDefinition, 0, "", 0, DateTime.Now, 0);

         SeriesGenerator_Accessor sg = new SeriesGenerator_Accessor(null, row);
         sg.RangeStartFromColumnName = "RANGE_START_FROM";
         SeriesDefinition sd = sg.LoadRange(false);

         DateSeriesCreator_Accessor target = new DateSeriesCreator_Accessor(row, sd, null);

         int numberOfValues = 32;
         List<string> values = target.GetValues(numberOfValues, new DateTime(2010, 1, 1));

         NU.Assert.AreEqual("123: 2010-01-01", values[0], "Assert 1");
         NU.Assert.AreEqual("123: 2010-02-01", values[values.Count - 1], "Assert 2");

      }

      /// <summary>
      ///A test for GetValues for template "text yyyy-MM text".
      ///</summary>
      [NU.Test()]
      public void GetValuesTest2()
      {
         string seriesDefinition = "<?xml version=\"1.0\" encoding=\"utf-8\"?><Parts xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\"><Part Text=\"123: \" /><Part Date=\"yyyy\" /><Part Text=\"-\" /><Part Date=\"MM\" /><Part Text=\" end\" /></Parts>";
         BSDataSet.SeriesDataTable sdt = new BSDataSet.SeriesDataTable();
         BSDataSet.SeriesRow row = sdt.AddSeriesRow(1, "", "", 0, "", "", seriesDefinition, 0, "", 0, DateTime.Now, 0);

         SeriesGenerator_Accessor sg = new SeriesGenerator_Accessor(null, row);
         sg.RangeStartFromColumnName = "RANGE_START_FROM";
         SeriesDefinition sd = sg.LoadRange(false);

         DateSeriesCreator_Accessor target = new DateSeriesCreator_Accessor(row, sd, null);

         int numberOfValues = 13;
         List<string> values = target.GetValues(numberOfValues, new DateTime(2010, 1, 1));

         NU.Assert.AreEqual("123: 2010-01 end", values[0], "Assert 1");
         NU.Assert.AreEqual("123: 2011-01 end", values[values.Count - 1], "Assert 2");

      }


      /// <summary>
      ///A test for GetValues for template "text yyyy text".
      ///</summary>
      [NU.Test()]
      public void GetValuesTest3()
      {
         string seriesDefinition = "<?xml version=\"1.0\" encoding=\"utf-8\"?><Parts xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\"><Part Text=\"123: \" /><Part Date=\"yyyy\" /><Part Text=\" end\" /></Parts>";
         BSDataSet.SeriesDataTable sdt = new BSDataSet.SeriesDataTable();
         BSDataSet.SeriesRow row = sdt.AddSeriesRow(1, "", "", 0, "", "", seriesDefinition, 0, "", 0, DateTime.Now, 0);

         SeriesGenerator_Accessor sg = new SeriesGenerator_Accessor(null, row);
         sg.RangeStartFromColumnName = "RANGE_START_FROM";
         SeriesDefinition sd = sg.LoadRange(false);

         DateSeriesCreator_Accessor target = new DateSeriesCreator_Accessor(row, sd, null);

         int numberOfValues = 10;
         List<string> values = target.GetValues(numberOfValues, new DateTime(2010, 1, 1));

         NU.Assert.AreEqual("123: 2010 end", values[0], "Assert 1");
         NU.Assert.AreEqual("123: 2019 end", values[values.Count - 1], "Assert 2");

      }


      /// <summary>
      ///A test for GetValues for template "text".
      ///</summary>
      [NU.Test()]
      public void GetValuesTest4()
      {
         string val = SecurityElement.Escape("`1234567890-=[]\\;',./~!@#$%^&*()_+{}|:\"<>?QWERTYUIOPASDFGHJKLZXCVBNMqwertyuiopasdfghjklzxcvbnm");
         //string val = "QWERTYUIOPASDFGHJKLZXCVBNMqwertyuiopasdfghjklzxcvbnm";
         string seriesDefinition = string.Format("<?xml version=\"1.0\" encoding=\"utf-8\"?><Parts xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\"><Part Text=\"{0}\" /></Parts>", val);
         BSDataSet.SeriesDataTable sdt = new BSDataSet.SeriesDataTable();
         BSDataSet.SeriesRow row = sdt.AddSeriesRow(1, "", "", 0, "", "", seriesDefinition, 0, "", 0, DateTime.Now, 0);

         SeriesGenerator_Accessor sg = new SeriesGenerator_Accessor(null, row);
         sg.RangeStartFromColumnName = "RANGE_START_FROM";
         SeriesDefinition sd = sg.LoadRange(false);

         DateSeriesCreator_Accessor target = new DateSeriesCreator_Accessor(row, sd, null);

         int numberOfValues = 1;
         List<string> values = target.GetValues(numberOfValues, new DateTime(2010, 1, 1));

         NU.Assert.AreEqual("`1234567890-=[]\\;',./~!@#$%^&*()_+{}|:\"<>?QWERTYUIOPASDFGHJKLZXCVBNMqwertyuiopasdfghjklzxcvbnm", values[0], "Assert 1");
      }

      /// <summary>
      ///A test for GetValues for template "WWdd".
      ///</summary>
      [NU.Test()]
      public void GetValuesTest5()
      {
         string seriesDefinition = "<?xml version=\"1.0\" encoding=\"utf-8\"?><Parts xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\"><Part Date=\"WW\" /><Part Date=\"dd\"/></Parts>";
         BSDataSet.SeriesDataTable sdt = new BSDataSet.SeriesDataTable();
         BSDataSet.SeriesRow row = sdt.AddSeriesRow(1, "", "", 0, "", "", seriesDefinition, 0, "", 0, DateTime.Now, 0);

         SeriesGenerator_Accessor sg = new SeriesGenerator_Accessor(null, row);
         sg.RangeStartFromColumnName = "RANGE_START_FROM";
         SeriesDefinition sd = sg.LoadRange(false);

         DateSeriesCreator_Accessor target = new DateSeriesCreator_Accessor(row, sd, null);

         int numberOfValues = 1;
         List<string> values = target.GetValues(numberOfValues);

         string expected = string.Format("{0}{1}",
            CultureInfo.CurrentCulture.Calendar.GetWeekOfYear(DateTime.Today, CalendarWeekRule.FirstFourDayWeek, DayOfWeek.Monday).ToString("0"),
            DateTime.Today.ToString("dd"));

         NU.Assert.AreEqual(expected, values[0], "Assert 1");
      }

      /// <summary>
      ///A test for GetValues for template "WWd".
      ///</summary>
      [NU.Test()]
      public void GetValuesTest6()
      {
         string seriesDefinition = "<?xml version=\"1.0\" encoding=\"utf-8\"?><Parts xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\"><Part Date=\"WW\" /><Part Date=\"d\"/></Parts>";
         BSDataSet.SeriesDataTable sdt = new BSDataSet.SeriesDataTable();
         BSDataSet.SeriesRow row = sdt.AddSeriesRow(1, "", "", 0, "", "", seriesDefinition, 0, "", 0, new DateTime(2010, 11, 1), 0);

         SeriesGenerator_Accessor sg = new SeriesGenerator_Accessor(null, row);
         sg.RangeStartFromColumnName = "RANGE_START_FROM";
         SeriesDefinition sd = sg.LoadRange(false);

         DateSeriesCreator_Accessor target = new DateSeriesCreator_Accessor(row, sd, null);

         int numberOfValues = 1;
         List<string> values = target.GetValues(numberOfValues, new DateTime(2010, 11, 1));

         string expected = string.Format("{0}{1}",
            CultureInfo.CurrentCulture.Calendar.GetWeekOfYear(new DateTime(2010, 11, 1), CalendarWeekRule.FirstFourDayWeek, DayOfWeek.Monday).ToString("0"),
            new DateTime(2010, 11, 1).Day);

         NU.Assert.AreEqual(expected, values[0], "Assert 1");
      }
   }
}
