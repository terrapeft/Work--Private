using Jnj.ThirdDimension.Controls.BarcodeSeries;
using Jnj.ThirdDimension.Data.BarcodeSeries;
using System.Windows.Forms;
using NUnit.Framework;
using System;
using System.Globalization;
using System.Drawing;

namespace BslsUnitTests
{
    
    
    /// <summary>
    ///This is a test class for SeriesTemplateEditorTest and is intended
    ///to contain all SeriesTemplateEditorTest Unit Tests
    ///</summary>
   [TestFixture()]
   [RequiresSTA()]
   public class SeriesTemplateEditorTest
   {

      /// <summary>
      ///A test for ConstructExample
      ///</summary>
      [Test()]
      public void ConstructExampleTest()
      {
         SeriesTemplateEditor_Accessor target = new SeriesTemplateEditor_Accessor(); // TODO: Initialize to an appropriate value

         // named values
         // my text: yy-MM-W-d-#
         target.AddTemplateTextBox("my text: ", PartType.Text);
         target.AddTemplateComboBox("YY", PartType.Year);
         target.AddTemplateTextBox("-", PartType.Text);
         target.AddTemplateComboBox("MM", PartType.Month);
         target.AddTemplateTextBox("-", PartType.Text);
         target.AddTemplateComboBox("W", PartType.Week);
         target.AddTemplateTextBox("-", PartType.Text);
         target.AddTemplateComboBox("D", PartType.Day);
         target.AddTemplateTextBox("-", PartType.Text);
         target.AddTemplateTextBox(PartType.Sequence);

         target.RangeStart = 1244;
         target.ConstructExample();

         string expected = string.Format("my text: {0}-{1}-{2}-{3}-1244", 
            DateTime.Today.ToString("yy"), 
            DateTime.Today.ToString("MM"), 
            CultureInfo.CurrentCulture.Calendar.GetWeekOfYear(DateTime.Today, CalendarWeekRule.FirstFourDayWeek, DayOfWeek.Monday).ToString("0"),
            DateTime.Today.ToString("%d") 
            );

         Assert.AreEqual(expected, target.ExampleLabel.Text, "Label is incorrect.");

      }

      [Test()]
      public void CreateTemplateExampleTest()
      {
         SeriesTemplateEditor_Accessor target = new SeriesTemplateEditor_Accessor(); // TODO: Initialize to an appropriate value

         // named values
         // my text: yy-MM-W-d-#
         target.AddTemplateTextBox("my text: ", PartType.Text);
         target.AddTemplateComboBox("YY", PartType.Year);
         target.AddTemplateTextBox("-", PartType.Text);
         target.AddTemplateComboBox("MM", PartType.Month);
         target.AddTemplateTextBox("-", PartType.Text);
         target.AddTemplateComboBox("W", PartType.Week);
         target.AddTemplateTextBox("-", PartType.Text);
         target.AddTemplateComboBox("D", PartType.Day);
         target.AddTemplateTextBox("-", PartType.Text);
         target.AddTemplateTextBox(PartType.Sequence);

         target.RangeStart = 1244;
         target.ConstructExample();

         string expected = string.Format("my text: {0}-{1}-{2}-{3}-1244",
            DateTime.Today.ToString("yy"),
            DateTime.Today.ToString("MM"),
            CultureInfo.CurrentCulture.Calendar.GetWeekOfYear(DateTime.Today, CalendarWeekRule.FirstFourDayWeek, DayOfWeek.Monday).ToString("0"),
            DateTime.Today.ToString("%d")
            );

         Assert.AreEqual(expected, target.CreateTemplateExample(), "Label is incorrect.");
      }

      [Test()]
      public void RemoveControlTest()
      {
         SeriesTemplateEditor_Accessor target = new SeriesTemplateEditor_Accessor(); // TODO: Initialize to an appropriate value

         // named values
         // my text: yy-MM-W-d-#
         target.AddTemplateTextBox("text1", PartType.Text);
         target.AddTemplateTextBox("text2", PartType.Text);

         Assert.IsTrue(target.desktopPanel.Controls[1].Location.X > target.MARGIN, "X position is incorrect. [1]");
         Assert.IsTrue(target.desktopPanel.Controls[1].Location.Y == target.MARGIN, "Y position is incorrect. [1]");

         target.RemoveControl(target.desktopPanel.Controls[0]);

         Assert.AreEqual("text2", target.desktopPanel.Controls[0].Text, "Invalid control.");
         Assert.AreEqual(target.MARGIN, target.desktopPanel.Controls[0].Location.X, "X position is incorrect. [2]");
         Assert.AreEqual(target.MARGIN, target.desktopPanel.Controls[0].Location.Y, "Y position is incorrect." [2]);
      }

      [Test]
      public void ControlPositioningTest()
      {
         SeriesTemplateEditor_Accessor target = new SeriesTemplateEditor_Accessor();
         int posX = target.MARGIN;

         // create control to pass as paramater
         Control ctl = target.CreateFilterTextBox("", PartType.Text);
         int width1 = GetControlWidth(ctl);
         Assert.AreEqual(target.MARGIN, target.GetFilterPosition(width1).X, "Assert 1");

         // add another control with the same content to panel
         target.AddTemplateTextBox("", PartType.Text);
         posX += width1 + target.MARGIN;

         ctl = target.CreateFilterTextBox(" long text to move the carret to next row", PartType.Text);
         int width2 = GetControlWidth(ctl);
         Point position = target.GetFilterPosition(width2);
         Assert.AreEqual(posX, position.X, "Assert 2");
         Assert.AreEqual(target.MARGIN, position.Y, "Assert 3");

         // add another control with the same content to panel
         target.AddTemplateTextBox(" long text to move the carret to next row", PartType.Text);
         posX += width2 + target.MARGIN;

         ctl = target.CreateFilterCombo(PartType.Year);
         int width3 = GetControlWidth(ctl);
         position = target.GetFilterPosition(width3);
         Assert.AreEqual(posX, position.X, "Assert 4");
         Assert.AreEqual(target.MARGIN, position.Y, "Assert 5");

         // add another control with the same content to panel
         target.AddTemplateComboBox(PartType.Year);
         posX += target.TEMPLATE_WIDTH + target.MARGIN;

         ctl = target.CreateFilterCombo(PartType.Month);
         int width4 = GetControlWidth(ctl);
         position = target.GetFilterPosition(width4);
         Assert.AreEqual(target.MARGIN, position.X, "Assert 6");
         Assert.AreEqual(target.MARGIN*2 + ctl.Height, position.Y, "Assert 7");

      }

      private int GetControlWidth(Control ctl)
      {
         Graphics g = Graphics.FromHwnd(IntPtr.Zero);
         int size = g.MeasureString(ctl.Text + "_", ctl.Font).ToSize().Width;
         return size < 25 ? 25 : size;
      }


       /// <summary>
      ///A test for GetAvailableValues
      ///</summary>
      [Test()]
      public void GetAvailableValuesTest()
      {
         SeriesTemplateEditor_Accessor target = new SeriesTemplateEditor_Accessor(); // TODO: Initialize to an appropriate value

         Assert.AreEqual(new object[] { "YYYY", "YY"}, target.GetAvailableValues(PartType.Year), "Year");
         Assert.AreEqual(new object[] { "NAME", "MMM", "MM" }, target.GetAvailableValues(PartType.Month), "Month");
         Assert.AreEqual(new object[] { "WW", "W" }, target.GetAvailableValues(PartType.Week), "Week");
         Assert.AreEqual(new object[] { "NAME", "DDD", "DD", "D" }, target.GetAvailableValues(PartType.Day), "Day");
      }

      /// <summary>
      ///A test for GetFilterPattern
      ///</summary>
      [Test()]
      public void GetFilterPatternTest()
      {
         SeriesTemplateEditor_Accessor target = new SeriesTemplateEditor_Accessor(); // TODO: Initialize to an appropriate value
         Control ctl = target.CreateFilterCombo(PartType.Week);
         Assert.AreEqual("WW", target.GetFilterPattern(ctl), "Week");

         ctl = target.CreateFilterCombo(PartType.Month);
         Assert.AreEqual("MMMM", target.GetFilterPattern(ctl), "Month");

         ctl = target.CreateFilterCombo(PartType.Year);
         Assert.AreEqual("yyyy", target.GetFilterPattern(ctl), "Year");

         ctl = target.CreateFilterCombo(PartType.Day);
         Assert.AreEqual("dddd", target.GetFilterPattern(ctl), "Day 1");

         ctl = target.CreateFilterCombo("D", PartType.Day);
         Assert.AreEqual("%d", target.GetFilterPattern(ctl), "Day 2");

         ctl = target.CreateFilterTextBox("#", PartType.Sequence);
         Assert.AreEqual("#", target.GetFilterPattern(ctl), "Sequence");

         ctl = target.CreateFilterTextBox("come get some", PartType.Text);
         Assert.AreEqual("come get some", target.GetFilterPattern(ctl), "Text");
      }

      /// <summary>
      ///A test for GetFilterValue
      ///</summary>
      [Test()]
      public void GetFilterValueTest()
      {
         SeriesTemplateEditor_Accessor target = new SeriesTemplateEditor_Accessor(); // TODO: Initialize to an appropriate value
         target.RangeStart = 13587;

         Control ctl = target.CreateFilterCombo(PartType.Week);
         Assert.AreEqual(CultureInfo.CurrentCulture.Calendar.GetWeekOfYear(DateTime.Today, CalendarWeekRule.FirstFourDayWeek, DayOfWeek.Monday).ToString("0"), 
            target.GetFilterValue(ctl), "Week");

         ctl = target.CreateFilterCombo(PartType.Month);
         Assert.AreEqual(DateTime.Today.ToString("MMMM"), target.GetFilterValue(ctl), "Month");

         ctl = target.CreateFilterCombo(PartType.Year);
         Assert.AreEqual(DateTime.Today.ToString("yyyy"), target.GetFilterValue(ctl), "Year");

         ctl = target.CreateFilterCombo(PartType.Day);
         Assert.AreEqual(DateTime.Today.ToString("dddd"), target.GetFilterValue(ctl), "Day 1");

         ctl = target.CreateFilterCombo("D", PartType.Day);
         Assert.AreEqual(DateTime.Today.ToString("%d"), target.GetFilterValue(ctl), "Day 2");

         ctl = target.CreateFilterTextBox("#", PartType.Sequence);
         Assert.AreEqual("13587", target.GetFilterValue(ctl), "Sequence");

         ctl = target.CreateFilterTextBox("come get some", PartType.Text);
         Assert.AreEqual("come get some", target.GetFilterValue(ctl), "Text");
      }

      /// <summary>
      ///A test for GetFilterRegExp
      ///</summary>
      [Test()]
      [RequiresSTA()]
      public void GetFilterRegExpTest1()
      {
         SeriesTemplateEditor_Accessor target = new SeriesTemplateEditor_Accessor(); // TODO: Initialize to an appropriate value

         // default values
         // my text: yyyy-MMMM-WW-dddd-#
         target.AddTemplateTextBox("my text: ", PartType.Text);
         target.AddTemplateComboBox(PartType.Year);
         target.AddTemplateTextBox("-", PartType.Text);
         target.AddTemplateComboBox(PartType.Month);
         target.AddTemplateTextBox("-", PartType.Text);
         target.AddTemplateComboBox(PartType.Week);
         target.AddTemplateTextBox("-", PartType.Text);
         target.AddTemplateComboBox(PartType.Day);
         target.AddTemplateTextBox("-", PartType.Text);
         target.AddTemplateTextBox(PartType.Sequence);

         string expected = @"^(?<text0>my text: )(?<year>\d{4})(?<text2>-)(?<month>\w{3,9})(?<text4>-)(?<week>\d{2})(?<text6>-)(?<day>\w{3,9})(?<text8>-)(?<sequence>\d+)$";
         string actual = target.GetFilterRegExp();

         Assert.AreEqual(expected, actual);
      }

      /// <summary>
      ///A test for GetFilterRegExp
      ///</summary>
      [Test()]
      [RequiresSTA()]
      public void GetFilterRegExpTest2()
      {
         SeriesTemplateEditor_Accessor target = new SeriesTemplateEditor_Accessor(); // TODO: Initialize to an appropriate value

         // named values
         // my text: yyyy-MMMM-WW-dddd-#
         target.AddTemplateTextBox("my text: ", PartType.Text);
         target.AddTemplateComboBox(PartType.Year);
         target.AddTemplateTextBox("-", PartType.Text);
         target.AddTemplateComboBox("NAME", PartType.Month);
         target.AddTemplateTextBox("-", PartType.Text);
         target.AddTemplateComboBox(PartType.Week);
         target.AddTemplateTextBox("-", PartType.Text);
         target.AddTemplateComboBox("NAME", PartType.Day);
         target.AddTemplateTextBox("-", PartType.Text);
         target.AddTemplateTextBox(PartType.Sequence);

         string expected = @"^(?<text0>my text: )(?<year>\d{4})(?<text2>-)(?<month>\w{3,9})(?<text4>-)(?<week>\d{2})(?<text6>-)(?<day>\w{3,9})(?<text8>-)(?<sequence>\d+)$";
         string actual = target.GetFilterRegExp();

         Assert.AreEqual(expected, actual);
      }

      /// <summary>
      ///A test for GetFilterRegExp
      ///</summary>
      [Test()]
      public void GetFilterRegExpTest3()
      {
         SeriesTemplateEditor_Accessor target = new SeriesTemplateEditor_Accessor(); // TODO: Initialize to an appropriate value

         // named values
         // my text: yyyy-MMM-WW-ddd-#
         target.AddTemplateTextBox("my text: ", PartType.Text);
         target.AddTemplateComboBox(PartType.Year);
         target.AddTemplateTextBox("-", PartType.Text);
         target.AddTemplateComboBox("MMM", PartType.Month);
         target.AddTemplateTextBox("-", PartType.Text);
         target.AddTemplateComboBox("WW", PartType.Week);
         target.AddTemplateTextBox("-", PartType.Text);
         target.AddTemplateComboBox("DDD", PartType.Day);
         target.AddTemplateTextBox("-", PartType.Text);
         target.AddTemplateTextBox(PartType.Sequence);

         string expected = @"^(?<text0>my text: )(?<year>\d{4})(?<text2>-)(?<month>\w{3})(?<text4>-)(?<week>\d{2})(?<text6>-)(?<day>\w{3})(?<text8>-)(?<sequence>\d+)$";
         string actual = target.GetFilterRegExp();

         Assert.AreEqual(expected, actual);
      }

      /// <summary>
      ///A test for GetFilterRegExp
      ///</summary>
      [Test()]
      public void GetFilterRegExpTest4()
      {
         SeriesTemplateEditor_Accessor target = new SeriesTemplateEditor_Accessor(); // TODO: Initialize to an appropriate value

         // named values
         // my text: yy-MM-W-dd-#
         target.AddTemplateTextBox("my text: ", PartType.Text);
         target.AddTemplateComboBox("YY", PartType.Year);
         target.AddTemplateTextBox("-", PartType.Text);
         target.AddTemplateComboBox("MM", PartType.Month);
         target.AddTemplateTextBox("-", PartType.Text);
         target.AddTemplateComboBox("W", PartType.Week);
         target.AddTemplateTextBox("-", PartType.Text);
         target.AddTemplateComboBox("DD", PartType.Day);
         target.AddTemplateTextBox("-", PartType.Text);
         target.AddTemplateTextBox(PartType.Sequence);

         string expected = @"^(?<text0>my text: )(?<year>\d{2})(?<text2>-)(?<month>\d{1,2})(?<text4>-)(?<week>\d{1})(?<text6>-)(?<day>\d{1,2})(?<text8>-)(?<sequence>\d+)$";
         string actual = target.GetFilterRegExp();

         Assert.AreEqual(expected, actual);
      }

      /// <summary>
      ///A test for GetFilterRegExp
      ///</summary>
      [Test()]
      public void GetFilterRegExpTest5()
      {
         SeriesTemplateEditor_Accessor target = new SeriesTemplateEditor_Accessor(); // TODO: Initialize to an appropriate value

         // named values
         // my text: yy-MM-W-d-#
         target.AddTemplateTextBox("my text: ", PartType.Text);
         target.AddTemplateComboBox("YY", PartType.Year);
         target.AddTemplateTextBox("-", PartType.Text);
         target.AddTemplateComboBox("MM", PartType.Month);
         target.AddTemplateTextBox("-", PartType.Text);
         target.AddTemplateComboBox("W", PartType.Week);
         target.AddTemplateTextBox("-", PartType.Text);
         target.AddTemplateComboBox("D", PartType.Day);
         target.AddTemplateTextBox("-", PartType.Text);
         target.AddTemplateTextBox(PartType.Sequence);

         string expected = @"^(?<text0>my text: )(?<year>\d{2})(?<text2>-)(?<month>\d{1,2})(?<text4>-)(?<week>\d{1})(?<text6>-)(?<day>\d{1,2})(?<text8>-)(?<sequence>\d+)$";
         string actual = target.GetFilterRegExp();

         Assert.AreEqual(expected, actual);
      }


      /// <summary>
      ///A test for IsDatePart
      ///</summary>
      [Test()]
      public void IsDatePartTest()
      {
         SeriesTemplateEditor_Accessor target = new SeriesTemplateEditor_Accessor(); // TODO: Initialize to an appropriate value
         
         Control ctl = target.CreateFilterCombo(PartType.Day);
         Assert.AreEqual(true, target.IsDatePart(ctl), "Day");
         
         ctl = target.CreateFilterCombo(PartType.Week);
         Assert.AreEqual(true, target.IsDatePart(ctl), "Week");

         ctl = target.CreateFilterCombo(PartType.Month);
         Assert.AreEqual(true, target.IsDatePart(ctl), "Month");

         ctl = target.CreateFilterCombo(PartType.Year);
         Assert.AreEqual(true, target.IsDatePart(ctl), "Year");

         ctl = target.CreateFilterTextBox(PartType.Sequence);
         Assert.AreEqual(false, target.IsDatePart(ctl), "Sequence");

         ctl = target.CreateFilterTextBox(PartType.Text);
         Assert.AreEqual(false, target.IsDatePart(ctl), "Text");

      }

      /// <summary>
      ///A test for IsSequencePart
      ///</summary>
      [Test()]
      public void IsSequencePartTest()
      {
         SeriesTemplateEditor_Accessor target = new SeriesTemplateEditor_Accessor(); // TODO: Initialize to an appropriate value

         Control ctl = target.CreateFilterCombo(PartType.Day);
         Assert.AreEqual(false, target.IsSequencePart(ctl), "Day");

         ctl = target.CreateFilterCombo(PartType.Week);
         Assert.AreEqual(false, target.IsSequencePart(ctl), "Week");

         ctl = target.CreateFilterCombo(PartType.Month);
         Assert.AreEqual(false, target.IsSequencePart(ctl), "Month");

         ctl = target.CreateFilterCombo(PartType.Year);
         Assert.AreEqual(false, target.IsSequencePart(ctl), "Year");

         ctl = target.CreateFilterTextBox(PartType.Sequence);
         Assert.AreEqual(true, target.IsSequencePart(ctl), "Sequence");

         ctl = target.CreateFilterTextBox(PartType.Text);
         Assert.AreEqual(false, target.IsSequencePart(ctl), "Text");
      }
   }
}
