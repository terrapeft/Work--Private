#region Copyright (C) 1994-2009, Johnson & Johnson PRD, LLC.
//---------------------------------------------------------------------------*
//
//    IBslsService.cs: BSLS WCF service contracts.
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
using System.Runtime.Serialization;
using System.ServiceModel;
using System.Text;
using System.Data;
using Jnj.ThirdDimension.Instruments;
using Jnj.ThirdDimension.BusinessLayer.BarcodeSeries;
using Jnj.ThirdDimension.Data.BarcodeSeries;

namespace Jnj.ThirdDimension.Service.BarcodeSeries
{
   /// <summary>
   /// BSLS WCF service contracts.
   /// </summary>
   [ServiceContract(SessionMode = SessionMode.Required)]
   public interface IBslsService
   {
      
      /// <summary>
      /// Establishes a connection with a database and initializes a session specific objects.
      /// </summary>
      /// <param name="wwid">The wwid.</param>
      /// <param name="password">The password.</param>
      /// <param name="encrypted">Indicates if password encrypted or not.</param>
      /// <returns></returns>
      [OperationContract(IsInitiating = true, IsTerminating = false)]
      bool OpenSession(string domain, string username, string password, bool encrypted);

      /// <summary>
      /// Establishes a connection with a database and initializes a session specific objects.
      /// </summary>
      /// <param name="domain">The domain.</param>
      /// <param name="username">The username.</param>
      /// <param name="password">The password.</param>
      /// <param name="encrypted">Indicates if password encrypted or not.</param>
      /// <returns></returns>
      [OperationContract(Name = "OpenSessionByWWID", IsInitiating = true, IsTerminating = false)]
      bool OpenSession(decimal wwid, string password, bool encrypted);

      /// <summary>
      /// Closes a database connection and disposes all session resources.
      /// </summary>
      [OperationContract(IsInitiating = false, IsTerminating = true)]
      void CloseSession();

      /// <summary>
      /// Ensures the db connection and generates a number of barcodes.
      /// </summary>
      /// <param name="seriesName">Name of the series.</param>
      /// <param name="numberOfValues">The number of values.</param>
      /// <returns>String array of barcodes.</returns>
      [OperationContract(IsInitiating = false, IsTerminating = false)]
      string[] GetBarcodes(string seriesName, int numberOfValues);

      /// <summary>
      /// Ensures the db connection and gets the list of printers.
      /// </summary>
      /// <param name="site">The site to search printers for.</param>
      /// <returns>The DataSet with one table, containing the printers information. 
      /// The table has a primary key constraint on ID column.
      /// </returns>
      [OperationContract(IsInitiating = false, IsTerminating = false)]
      string[] GetPrintersList(string site);

      /// <summary>
      /// Gets templates and template variables for the specified printer.
      /// </summary>
      /// <param name="printerName">Printer name.</param>
      /// <returns></returns>
      [OperationContract(IsInitiating = false, IsTerminating = false)]
      PrinterInfo GetPrinterInfo(string printerName);

      /// <summary>
      /// Ensures the db connection and prints the labels.
      /// </summary>
      /// <param name="printerUrl">The printer's URL.</param>
      /// <param name="template">The printer template name.</param>
      /// <param name="data">Table with data.</param>
      /// <param name="mapping">Mapping information, 'key' is a template field and 'value' stands for the column name from the data table.</param>
      /// <param name="stopOnError">if set to <c>true</c> print process will stop on first error.</param>
      /// <returns><c>True</c> if all labels were printed successfully.</returns>
      [OperationContract(IsInitiating = false, IsTerminating = false)]
      bool PrintLabels(string printerUrl, string template, string[][] data, string[] variables, bool stopOnError);

      /// <summary>
      /// Ensures the db connection and gets the site matching the specified parameters.
      /// </summary>
      /// <param name="userName">Name of the user.</param>
      /// <param name="domain">The domain.</param>
      /// <returns>The site name.</returns>
      [OperationContract(IsInitiating = false, IsTerminating = false)]
      string GetSite(string userName, string domain);

      /// <summary>
      /// Ensures the db connection and gets the sites.
      /// </summary>
      /// <returns>String array of sites names.</returns>
      [OperationContract(IsInitiating = false, IsTerminating = false)]
      string[] GetSites();

      /// <summary>
      /// Ensures the db connection and gets the list of available series.
      /// </summary>
      /// <returns>String array of sites names.</returns>
      [OperationContract(IsInitiating = false, IsTerminating = false)]
      SeriesInfo[] GetSeriesNames();

   }

   /// <summary>
   /// 
   /// </summary>
   [DataContract]
   public class TemplateFieldMap
   {
       public TemplateFieldMap(string fieldName, string fieldValue)
       {
           FieldValue = fieldValue;
           FieldName = fieldName;
       }

       [DataMember]
       public string FieldName { get; set; }

       [DataMember]
       public string FieldValue { get; set; }
   }

   /// <summary>
   /// 
   /// </summary>
   [DataContract]
   public class SeriesInfo
   {
      public SeriesInfo(string name, string template)
      {
         Name = name;
         Template = template;
      }

      [DataMember]
      public string Name { get; set; }

      [DataMember]
      public string Template { get; set; }
   }
}
