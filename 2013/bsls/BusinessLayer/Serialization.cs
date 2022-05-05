#region Copyright (C) 1994-2010, Johnson & Johnson PRD, LLC.
//---------------------------------------------------------------------------*
//
//    Serialization.cs: File contains several small classes for series specific serialization.
//
//---
//
//    Copyright (C) 1994-2009, Johnson & Johnson PRD, LLC.
//    All Rights Reserved.
//
//    Vitaly Chupaev, 04/2010
//
//---------------------------------------------------------------------------*/
#endregion

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Xml.Serialization;
using Jnj.ThirdDimension.Data.BarcodeSeries;
using Jnj.ThirdDimension.Data;

namespace Jnj.ThirdDimension.BusinessLayer.BarcodeSeries
{

   /// <summary>
   /// The contract to restrict custom serialization for classes derived from this interface.
   /// </summary>
   public interface ITinySerializable
   {
   }

   [Serializable]
   [XmlRoot(ElementName = "Conn", Namespace = "", DataType = "")]
   public class SeriesConnectionData : ITinySerializable
   {
      [XmlAttribute("SeqRn")]
      public string SequenceResourceName { get; set; }

      [XmlAttribute("TabRn")]
      public string TableResourceName { get; set; }

      [XmlAttribute("SeqAcc")]
      public string SequenceAccount { get; set; }

      [XmlAttribute("TabAcc")]
      public string TableAccount { get; set; }
   }


   /// <summary>
   /// Entity class for Label Series.
   /// </summary>
   [Serializable]
   [XmlRoot(ElementName = "Parts", Namespace = "", DataType = "")]
   public class SeriesTemplate : ITinySerializable
   {
      public SeriesTemplate()
      {
         Parts = new Part[0];
      }

      /// <summary>
      /// Template of barcode.
      /// </summary>
      [Serializable]
      public class Part
      {

         #region Stuff

         [XmlIgnore]
         public bool IsDay
         {
            get
            {
               return (!string.IsNullOrEmpty(Date) && Date.StartsWith("d"));
            }
         }

         [XmlIgnore]
         public bool IsWeek
         {
            get
            {
               return (!string.IsNullOrEmpty(Date) && Date.StartsWith("W"));
            }
         }

         [XmlIgnore]
         public bool IsMonth
         {
            get
            {
               return (!string.IsNullOrEmpty(Date) && Date.StartsWith("M"));
            }
         }

         [XmlIgnore]
         public bool IsYear
         {
            get
            {
               return (!string.IsNullOrEmpty(Date) && Date.StartsWith("y"));
            }
         }

         [XmlIgnore]
         public bool IsSequence
         {
            get
            {
               return !string.IsNullOrEmpty(Sequence);
            }
         }

         /// <summary>
         /// Gets the value.
         /// </summary>
         /// <returns></returns>
         public PartType GetValue(out string value)
         {
            if (!string.IsNullOrEmpty(Date))
            {
               value = Date;

               if (IsDay) return PartType.Day;
               if (IsWeek) return PartType.Week;
               if (IsMonth) return PartType.Month;
               if (IsYear) return PartType.Year;
            }
            if (!string.IsNullOrEmpty(Text))
            {
               value = Text;
               return PartType.Text;
            }

            value = Sequence;
            return PartType.Sequence;
         }
         
         #endregion

         [XmlAttribute]
         public string Date { get; set; }

         [XmlAttribute]
         public string Text { get; set; }

         [XmlAttribute]
         public string Sequence { get; set; }
      }


      /// <summary>
      /// Contains series format: text and generated parts of barcode.
      /// </summary>
      [XmlElement("Part")]
      public Part[] Parts { get; set; }

      public string GetTemplate()
      {
         StringBuilder sb = new StringBuilder();
         if (Parts != null)
         {
            string value;
            foreach (SeriesTemplate.Part part in Parts)
            {
               part.GetValue(out value);
               sb.Append(value);
            }
         }
         return sb.ToString();
      }
   }
}
