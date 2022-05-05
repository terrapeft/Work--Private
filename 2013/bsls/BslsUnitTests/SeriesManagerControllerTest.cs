using Jnj.ThirdDimension.Controls.BarcodeSeries;
using Jnj.ThirdDimension.BusinessLayer.BarcodeSeries;
using System;
using NUnit.Framework;
using UT = Microsoft.VisualStudio.TestTools.UnitTesting;
using System.Collections.Generic;
using System.Text.RegularExpressions;

namespace BslsUnitTests
{
    
    
    /// <summary>
    ///This is a test class for SeriesManagerControllerTest and is intended
    ///to contain all SeriesManagerControllerTest Unit Tests
    ///</summary>
   [TestFixture]
   public class SeriesManagerControllerTest
   {

      /// <summary>
      ///A test for StripOutDate
      ///</summary>
      [Test]
      public void ReservationDateTimeTest()
      {
         string regexp = @"(?<text1>marriage: )(?<day>\d{1,2})(?<text2>-)(?<month>\d{1,2})(?<text3>-)(?<year>\d{4})(?<text4>;)";
         Regex r = new Regex(regexp);
         MatchCollection matches = r.Matches("marriage: 24-03-2010;");
         Match match = matches[0];

         SeriesManagerController_Accessor sut = new SeriesManagerController_Accessor();
         DateTime dt = sut.GetReservationDateTime(match.Groups);

         Assert.AreEqual(new DateTime(2010, 03, 24), dt);
      }

      private SeriesTemplate.Part[] PartsSet ()
      {
         List<SeriesTemplate.Part> l = new List<SeriesTemplate.Part>();
         SeriesTemplate.Part p = new SeriesTemplate.Part();
         p.Date = "dd";
         l.Add(p);

         p = new SeriesTemplate.Part();
         p.Text = "some text";
         l.Add(p);

         p = new SeriesTemplate.Part();
         p.Date = "MM";
         l.Add(p);

         p = new SeriesTemplate.Part();
         p.Date = "yyyy";
         l.Add(p);

         p = new SeriesTemplate.Part();
         p.Text = "another text";
         l.Add(p);


         return l.ToArray();
      }
   }
}
