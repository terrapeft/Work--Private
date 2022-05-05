#region Copyright (C) 1994-2009, Johnson & Johnson PRD, LLC.
//---------------------------------------------------------------------------*
//
//    PinterAccessor.cs: Gives access to printing functions.
//
//---
//
//    Copyright (C) 1994-2009, Johnson & Johnson PRD, LLC.
//    All Rights Reserved.
//
//    Vitaly Chupaev, 06/2010
//
//---------------------------------------------------------------------------*/
#endregion

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Jnj.ThirdDimension.Base;
using Jnj.ThirdDimension.Data.BarcodeSeries;
using System.Data;
using Jnj.ThirdDimension.Utils.BarcodeSeries;
using Jnj.ThirdDimension.Instruments;
using Wintellect.PowerCollections;
using Jnj.ThirdDimension.Arms.Model;

namespace Jnj.ThirdDimension.BusinessLayer.BarcodeSeries
{
   public interface IPrinterAccessor
   {
      /// <summary>
      /// Gets the list of printers for specified site or the whole list for empty site.
      /// </summary>
      /// <param name="site">The site name. Leave it null or empty to get all printers.</param>
      /// <returns></returns>
      DataSet GetPrinters(string site);
      
      /// <summary>
      /// Prints the labels.
      /// </summary>
      /// <param name="printer">The printer.</param>
      /// <param name="template">The template name.</param>
      /// <param name="data">The data to print.</param>
      /// <param name="mapping">The mapping between DataTable and Template columns.</param>
      /// <param name="stopOnError">if set to <c>true</c> then printing will stop on error, otherwise the error will be ignored.</param>
      /// <returns></returns>
      bool PrintLabels(string printerUrl, string template, DataTable data, KeyValuePair<string, string>[] mapping, bool stopOnError);
   }

   public class PrinterAccessor : IPrinterAccessor
   {
      private SeriesDataLayer DataLayer { get; set; }

      /// <summary>
      /// For internal use, when authorization has been already done.
      /// </summary>
      public PrinterAccessor(SeriesDataLayer dl)
      {
         DataLayer = dl;
      }

      /// <summary>
      /// Gets the list of sites.
      /// </summary>
      /// <returns></returns>
      public List<OrgSite> GetSites()
      {
         return ArmsAccessor.Instance.GetSites();
      }

      /// <summary>
      /// Gets the user's site.
      /// </summary>
      /// <param name="userName">Name of the user.</param>
      /// <param name="domain">The domain.</param>
      /// <returns></returns>
      public string GetSite(string userName, string domain)
      {
         return ArmsAccessor.Instance.GetSite(userName, domain);
      }

      /// <summary>
      /// Gets the list of printers for specified site or the whole list for empty site.
      /// </summary>
      /// <param name="site">The site name. Leave it null or empty to get all printers.</param>
      /// <returns></returns>
      public DataSet GetPrinters(string site)
      {
         BSDataSet.InstrumentDataTable printers = null;
         string filter = string.Format("{0} = {1}",
                                       DataLayer.DataSet.Instrument.INSTRUMENT_ROLE_IDColumn.ColumnName,
                                       (int)SeriesDataLayer.InstrumentRole.BarcodePrinter);

         
         if (!site.IsEmpty())
         {
            decimal siteId = GetSiteId(site);

            if (siteId > decimal.MinValue)
            {
               filter = string.Format("{0} and {1} = {2}",
                                      filter,
                                      DataLayer.DataSet.Instrument.ORG_SITE_IDColumn.ColumnName,
                                      siteId);
            }
         }

         using (DataLayer.Connect())
         {
            printers = DataLayer.InstrumentDB.GetInstrument(filter);
         }

         UniqueConstraint pk = new UniqueConstraint(printers.IDColumn, true);
         
         DataSet ds = new DataSet();
         ds.Tables.Add(printers);
         
         return ds;
      }

      /*
      /// <summary>
      /// Gets the list of printers for specified site or the whole list for empty site.
      /// </summary>
      /// <param name="site">The site name. Leave it null or empty to get all printers.</param>
      /// <returns></returns>
      public Printer [] GetPrinters(string site)
      {
         BSDataSet.InstrumentDataTable printers = null;
         string filter = string.Format("{0} = {1}",
                                       DataLayer.DataSet.Instrument.INSTRUMENT_ROLE_IDColumn.ColumnName,
                                       (int)SeriesDataLayer.InstrumentRole.BarcodePrinter);

         
         if (!site.IsEmpty())
         {
            decimal siteId = GetSiteId(site);

            if (siteId > decimal.MinValue)
            {
               filter = string.Format("{0} and {1} = {2}",
                                      filter,
                                      DataLayer.DataSet.Instrument.ORG_SITE_IDColumn.ColumnName,
                                      siteId);
            }
         }

         using (DataLayer.Connect())
         {
            printers = DataLayer.InstrumentDB.GetInstrument(filter);
         }

         return PackPrintersIntoCollection(printers);
      }

      private Printer [] PackPrintersIntoCollection(BSDataSet.InstrumentDataTable printers)
      {
         List<Printer> list = new List<Printer>(printers.Count);
         
         foreach (BSDataSet.InstrumentRow printerRow in printers)
         {
            Printer printer = new Printer(printerRow.NAME);

            list.Add();
         }
      }
      */


      /// <summary>
      /// Prints the labels.
      /// </summary>
      /// <param name="printer">The printer.</param>
      /// <param name="template">The template name.</param>
      /// <param name="data">The data to print.</param>
      /// <param name="mapping">The mapping between DataTable and Template columns.</param>
      /// <param name="stopOnError">if set to <c>true</c> then printing will stop on error, otherwise the error will be ignored.</param>
      /// <returns></returns>
      public bool PrintLabels(string printerUrl, string template, DataTable data, KeyValuePair<string, string>[] mapping, bool stopOnError)
      {

         return PrintLabels(printerUrl, template, data, GetLabelValues(mapping), stopOnError);
      }

      /// <summary>
      /// Prints the labels.
      /// </summary>
      /// <param name="printer">The printer.</param>
      /// <param name="template">The template name.</param>
      /// <param name="data">The data to print.</param>
      /// <param name="mapping">The mapping between DataTable and Template columns.</param>
      /// <param name="stopOnError">if set to <c>true</c> then printing will stop on error, otherwise the error will be ignored.</param>
      /// <returns></returns>
      public bool PrintLabels(string printerUrl, string template, DataTable data, Pair<string, string>[] mapping, bool stopOnError)
      {
         BarcodePrinter printer = null;
         printer = (BarcodePrinter)Activator.GetObject(typeof(BarcodePrinter), printerUrl);

         using (InstrumentLock il = new InstrumentLock(printer, 0))
         {
            bool printed = true;

            foreach (DataRow row in data.Rows)
            {
               printed = printer.Print(il.ClientID, template, mapping);

               if (!printed)
               {
                  if (stopOnError) return false;
                  else continue;
               }
            }
         }

         return true;
      }

      #region Private methods

      private decimal GetSiteId(string siteName)
      {
         List<OrgSite> sites = GetSites();

         foreach (OrgSite orgSite in sites)
         {
            if (orgSite.Name == siteName)
            {
               return orgSite.Id;
            }
         }
         return decimal.MinValue;
      }

      private Pair<string, string>[] GetLabelValues(KeyValuePair<string, string>[] mapping)
      {
         Pair<string, string>[] pairs = new Pair<string, string>[mapping.Length];
         int k = 0;

         foreach (KeyValuePair<string, string> pair in mapping)
         {
            Pair<string, string> p = new Pair<string, string>(pair.Key, pair.Value);
            pairs[k++] = p;
         }

         return pairs;
      }

      #endregion

   }

   /// <summary>
   /// Defines properties for printer's template.
   /// </summary>
   public interface IPrinterTemplate
   {
      string Name { get; set; }
      string[] Variables { get; set; }
   }

   /// <summary>
   /// Defines properties for printer instrument.
   /// </summary>
   public interface IPrinter
   {
      string Name { get; set; }
      IPrinterTemplate[] Templates { get; set;}
   }

   /// <summary>
   /// 
   /// </summary>
   public class Printer : IPrinter
   {
      public Printer (string name)
      {
         Name = name;
      }

      #region IPrinter Members

      public string Name
      {
         get;
         set;
      }

      public IPrinterTemplate[] Templates
      {
         get;
         set;
      }

      #endregion
   }

   public class Template : IPrinterTemplate
   {

      #region IPrinterTemplate Members

      public string Name
      {
         get;
         set;
      }

      public string[] Variables
      {
         get;
         set;
      }

      #endregion
   }
}
