#region Copyright (C) 1994-2010, Johnson & Johnson PRD, LLC.
//---------------------------------------------------------------------------*
//
//    TinyXmlSerializer.cs: This class is in charge of serialization process for BSLS Series templates.
//
//---
//
//    Copyright (C) 1994-2009, Johnson & Johnson PRD, LLC.
//    All Rights Reserved.
//
//    Vitaly Chupaev, 01/2011
//
//---------------------------------------------------------------------------*/
#endregion
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Xml;
using Jnj.ThirdDimension.Base;
using System.IO;
using Jnj.ThirdDimension.Data.BarcodeSeries;

namespace Jnj.ThirdDimension.BusinessLayer.BarcodeSeries
{
   /// <summary>
   /// This class is in charge of serialization process for BSLS Series templates.
   /// It produces the xml which is compatible with XmlSerializer and they both are interchangeable.
   /// </summary>
   public class TinyXmlSerializer
   {

      /// <summary>
      /// Returns the string in xml format.
      /// </summary>
      /// <typeparam name="T"></typeparam>
      /// <param name="o"></param>
      /// <returns></returns>
      public string Serialize<T>(T o) where T: ITinySerializable
      {
         if (o is SeriesTemplate) return GetTemplateString(o);
         if (o is SeriesConnectionData) return GetConnectionString(o);
         
         throw new Exception("Unknown type was specified for serialization.");
      }

      /// <summary>
      /// Returns the instance of T.
      /// </summary>
      /// <typeparam name="T"></typeparam>
      /// <param name="xml"></param>
      /// <returns></returns>
      public T Deserialize<T>(string xml) where T : ITinySerializable
      {
         if (typeof(T) == typeof(SeriesTemplate)) return (T)GetTemplate(xml);
         if (typeof(T) == typeof(SeriesConnectionData)) return (T)GetConnection(xml);

         throw new Exception("Unknown type was specified for serialization.");
      }



      #region Serialize

      private string GetTemplateString(object o)
      {
         /*
            <Parts>
               <Part Text="hello world-" />
               <Part Sequence="#" />
               <Part Text="-" />
               <Part Date="yyyy" />
               <Part Date="MMMM" />
               <Part Date="dd" />
            </Parts>
         */

         string xml;
         var t = (SeriesTemplate)o;
         var settings = new XmlWriterSettings() { Encoding = Encoding.UTF8 };

         // Using MemoryStream is necessary to have the "utf-8" in xml attribute "Encoding", 
         // instead of "utf-16", which is no way to override for StringBuilder.
         // Utf-16 causes the exception when reading xml back: "There is no Unicode byte order mark. Cannot switch to Unicode".
         using (var ms = new MemoryStream())
         {
            using (var writer = XmlWriter.Create(ms, settings))
            {
               // Root element
               writer.WriteStartElement("Parts");

               // Parts
               foreach (var p in t.Parts)
               {
                  writer.WriteStartElement("Part");
                  writer.WriteStartAttribute(IsDate(p) ? "Date" : p.IsSequence ? "Sequence" : "Text");
                  writer.WriteString(IsDate(p) ? p.Date : p.IsSequence ? p.Sequence : p.Text);
                  writer.WriteEndAttribute();
                  writer.WriteEndElement();
               }

               writer.WriteEndElement(); // </Parts>
               writer.Flush();
            }
            
            using (var sr = new StreamReader(ms))
            {
               ms.Position = 0;
               xml = sr.ReadToEnd();
               sr.Close();
            }
         }
         
         return xml;
      }

      private string GetConnectionString(object o)
      {
         /*
          
            <Conn SeqRn="ABCDTest" TabRn="ABCDTest" SeqAcc="series_user_g" TabAcc="series_user_g" />
           
         */

         string xml;
         var c = (SeriesConnectionData)o;
         var settings = new XmlWriterSettings() { Encoding = Encoding.UTF8 };

         // Using MemoryStream is necessary to have the "utf-8" in xml attribute "Encoding", 
         // instead of "utf-16", which is no way to override for StringBuilder.
         // Utf-16 causes the exception when reading xml back: "There is no Unicode byte order mark. Cannot switch to Unicode".
         using (var ms = new MemoryStream())
         {
            using (var writer = XmlWriter.Create(ms, settings))
            {
               // Root element
               writer.WriteStartElement("Conn");

               writer.WriteStartAttribute("SeqRn");
               writer.WriteString(c.SequenceResourceName);
               writer.WriteEndAttribute();

               writer.WriteStartAttribute("TabRn");
               writer.WriteString(c.TableResourceName);
               writer.WriteEndAttribute();

               writer.WriteStartAttribute("SeqAcc");
               writer.WriteString(c.SequenceAccount);
               writer.WriteEndAttribute();

               writer.WriteStartAttribute("TabAcc");
               writer.WriteString(c.TableAccount);
               writer.WriteEndAttribute();

               writer.WriteEndElement(); // </Conn>
               writer.Flush();
            }

            using (var sr = new StreamReader(ms))
            {
               ms.Position = 0;
               xml = sr.ReadToEnd();
               sr.Close();
            }
         }

         return xml;
      }

      #endregion


      #region Deserialize

      private ITinySerializable GetConnection(string xml)
      {
         var sc = new SeriesConnectionData();
         var doc = new XmlDocument();
         doc.LoadXml(xml);

         var root = doc.DocumentElement;
         sc.SequenceAccount = root.Attributes["SeqAcc"].Value;
         sc.SequenceResourceName = root.Attributes["SeqRn"].Value;
         sc.TableAccount = root.Attributes["TabAcc"].Value;
         sc.TableResourceName = root.Attributes["TabRn"].Value;

         return sc;
      }

      private ITinySerializable GetTemplate(string xml)
      {
         var st = new SeriesTemplate();
         var ps = new List<SeriesTemplate.Part>();
         var doc = new XmlDocument();
         doc.LoadXml(xml);

         var root = doc.DocumentElement;
         var parts = root.SelectNodes("Part");

         foreach (XmlNode part in parts)
         {
            var newPart = new SeriesTemplate.Part();
            ps.Add(newPart);

            if (IsDate(part))
            {
               newPart.Date = part.Attributes["Date"].Value;
            }
            else if (IsSequence(part))
            {
               newPart.Sequence = part.Attributes["Sequence"].Value;
            }
            else
            {
               newPart.Text = part.Attributes["Text"].Value;
            }
         }

         st.Parts = ps.ToArray();
         return st;
      }

      #endregion


      #region Utils

      
      private bool IsDate(SeriesTemplate.Part p)
      {
         return p.IsDay || p.IsWeek || p.IsMonth || p.IsYear;
      }

      private bool IsDate(XmlNode part)
      {
         return part.Attributes["Date"] != null;
      }

      private bool IsSequence(XmlNode part)
      {
         return part.Attributes["Sequence"] != null;
      }


      #endregion

   }
}