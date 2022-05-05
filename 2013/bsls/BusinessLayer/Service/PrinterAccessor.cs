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
using System.Runtime.Serialization;

namespace Jnj.ThirdDimension.BusinessLayer.BarcodeSeries
{
   public interface IPrinterAccessor
   {
      /// <summary>
      /// Gets templates and template variables for the specified printer.
      /// </summary>
      /// <param name="printerName">Printer name.</param>
      /// <returns></returns>
      PrinterInfo GetPrinterInfo(string printerName);


      /// <summary>
      /// Gets the list of printers for specified site or the whole list for empty site.
      /// </summary>
      /// <param name="site">The site.</param>
      /// <returns></returns>
      string [] GetPrintersList(string site);
      
      /// <summary>
      /// Prints the labels.
      /// </summary>
      /// <param name="printer">The printer.</param>
      /// <param name="template">The template name.</param>
      /// <param name="data">The data to print.</param>
      /// <param name="mapping">The mapping between DataTable and Template columns.</param>
      /// <param name="stopOnError">if set to <c>true</c> then printing will stop on error, otherwise the error will be ignored.</param>
      /// <returns></returns>
      bool PrintLabels(string printerUrl, string template, DataTable data, bool stopOnError);
   }

   public class PrinterAccessor : IPrinterAccessor
   {
      private BSDataSet.InstrumentDataTable printers;

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
      public string[] GetPrintersList(string site)
      {
         List<string> printerNames = new List<string>();

         LoadPrinters(CreateFilter(site));

         foreach (BSDataSet.InstrumentRow row in printers.Rows)
         {
            printerNames.Add(row.NAME);
         }

         return printerNames.OrderBy(n => n).ToArray();
      }

      /// <summary>
      /// Gets templates and template variables for the specified printer.
      /// </summary>
      /// <param name="printerName"></param>
      /// <returns></returns>
      public PrinterInfo GetPrinterInfo (string printerName)
      {
         PrinterInfo printer = new PrinterInfo(printerName);
         BSDataSet.InstrumentRow printerRow = null;

         if (printers == null || printers.Rows.Find(printerName) == null)
         {
            LoadPrinters(CreateFilter());
         }
         
         printerRow = GetPrinterRow(printerName);

         if (printerRow != null)
         {
            BarcodePrinter prn = (BarcodePrinter) Activator.GetObject(typeof (BarcodePrinter), printerRow.URL);
            printer.Name = printerRow.NAME;
            printer.Id = printerRow.ID;
            printer.Url = printerRow.URL;
            printer.Templates = GetPrinterTemplates(prn);
            return printer;
         }
         
         return null;
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
      public bool PrintLabels(string printerUrl, string template, DataTable data, bool stopOnError)
      {
         BarcodePrinter printer = null;
         printer = (BarcodePrinter)Activator.GetObject(typeof(BarcodePrinter), printerUrl);

         using (InstrumentLock il = new InstrumentLock(printer, 0))
         {
            bool printed = true;
            var pairs = new Pair<string, string>[data.Columns.Count];

            foreach (DataRow row in data.Rows)
            {
                
                int k = 0;

                foreach (DataColumn col in data.Columns)
                {
                    var p = new Pair<string, string>(col.ColumnName, row[col].ToString());
                    pairs[k++] = p;
                }

                printed = printer.Print(il.ClientID, template, pairs);

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

      private PrinterTemplate[] GetPrinterTemplates(BarcodePrinter prn)
      {
         List<PrinterTemplate> templs = new List<PrinterTemplate>();
         prn.Templates.Foreach(t => templs.Add(new PrinterTemplate(t, prn.GetTemplateVariables(t))));
         return templs.ToArray();
      }

      private BSDataSet.InstrumentRow GetPrinterRow(string printerName)
      {
         if (printers == null) return null;

         return (BSDataSet.InstrumentRow)printers.Rows.Find(printerName);
      }

      private string CreateFilter()
      {
         return CreateFilter(string.Empty);
      }

      private string CreateFilter(string site)
      {
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

         return filter;
      }

      private void LoadPrinters(string filter)
      {
         using (DataLayer.Connect())
         {
            printers = DataLayer.InstrumentDB.GetInstrument(filter);
            UniqueConstraint pk = new UniqueConstraint(printers.NAMEColumn, true);
            printers.Constraints.Add(pk);
         }
      }

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
   /// 
   /// </summary>
   [DataContract]
   public class PrinterInfo
   {
      public PrinterInfo(string name)
      {
         Name = name;
      }

      #region IPrinter Members
      [DataMember]
      public string Name { get; set; }
      [DataMember]
      public string Url { get; set; }
      [DataMember]
      public decimal Id { get; set; }
      [DataMember]
      public PrinterTemplate[] Templates { get; set; }

      #endregion
   }

   [DataContract]
   public class PrinterTemplate
   {

      public PrinterTemplate(string name, string[] variables)
      {
         Name = name;
         Variables = variables;
      }

      #region IPrinterTemplate Members

      [DataMember]
      public string Name
      {
         get;
         set;
      }

      [DataMember]
      public string[] Variables
      {
         get;
         set;
      }

      #endregion
   }
}
