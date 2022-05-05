using Jnj.ThirdDimension.BusinessLayer.BarcodeSeries;
using Jnj.ThirdDimension.BusinessLayer.BarcodeSeries.Creators;
using System;
using System.Collections.Generic;
using Jnj.ThirdDimension.Data.BarcodeSeries;
using System.Security;
using NUnit.Framework;
using Jnj.ThirdDimension.Controls.BarcodeSeries;

namespace BslsUnitTests
{
   [TestFixture]
   public class MappingsCollectionTest
   {
      [Test()]
      public void IsValidTest_AllRequired()
      {
         string [] mandatoryColumns = new string[] {"dest1", "dest2"};

         MapTemplateDialog.MappingsCollection mc = new MapTemplateDialog.MappingsCollection(mandatoryColumns);
         mc.Add(new MapTemplateDialog.Mapping("", "dest2", ""));
         mc.Add(new MapTemplateDialog.Mapping("source1", "dest1", ""));

         Assert.IsFalse(mc.IsValid(), "Assert 1");

         mc.Clear();
         mc.Add(new MapTemplateDialog.Mapping("source1", "dest1", ""));
         mc.Add(new MapTemplateDialog.Mapping("source3", "", "12"));

         Assert.IsFalse(mc.IsValid(), "Assert 2");

         mc.Clear();
         mc.Add(new MapTemplateDialog.Mapping("source1", "dest1", ""));
         mc.Add(new MapTemplateDialog.Mapping("source2", "dest2", ""));
         mc.Add(new MapTemplateDialog.Mapping("", "", ""));

         Assert.IsTrue(mc.IsValid(), "Assert 3");

         mc.Clear();
         mc.Add(new MapTemplateDialog.Mapping("source1", "dest1", ""));
         mc.Add(new MapTemplateDialog.Mapping("source2", "", ""));
         mc.Add(new MapTemplateDialog.Mapping("", "dest2", "12"));

         Assert.IsTrue(mc.IsValid(), "Assert 4");

      }


      [Test()]
      public void IsValidTest_NoRequired()
      {
         string[] mandatoryColumns = new string[0];

         MapTemplateDialog.MappingsCollection mc = new MapTemplateDialog.MappingsCollection(mandatoryColumns);
         mc.Add(new MapTemplateDialog.Mapping("", "", ""));

         Assert.IsFalse(mc.IsValid(), "Assert 1");

         mc.Clear();
         mc.Add(new MapTemplateDialog.Mapping("source1", "", ""));
         mc.Add(new MapTemplateDialog.Mapping("", "", "12"));

         Assert.IsFalse(mc.IsValid(), "Assert 2");

         mc.Clear();
         mc.Add(new MapTemplateDialog.Mapping("source1", "dest1", ""));
         mc.Add(new MapTemplateDialog.Mapping("source3", "", "12"));

         Assert.IsTrue(mc.IsValid(), "Assert 3");
      }


      [Test()]
      public void MappingTest()
      {
         string[] mandatoryColumns = new string[0];

         MapTemplateDialog.MappingsCollection mc = new MapTemplateDialog.MappingsCollection(mandatoryColumns);
         mc.Add(new MapTemplateDialog.Mapping("source", "destination", "default"));
         mc.Add(new MapTemplateDialog.Mapping("source", "", "default"));
         mc.Add(new MapTemplateDialog.Mapping("", "destination", "default"));

         Assert.IsTrue(mc[0].SourceName == "source" &&
                       mc[0].DestinationName == "destination" &&
                       mc[0].DefaultValue == "default", "Assert 1");

         Assert.IsTrue(mc[1].SourceName == "source" &&
                       mc[1].DestinationName == "" &&
                       mc[1].DefaultValue == "default", "Assert 2");

         Assert.IsTrue(mc[2].SourceName == "default" &&
                       mc[2].DestinationName == "destination" &&
                       mc[2].DefaultValue == "default", "Assert 3");


      }
   }
}
