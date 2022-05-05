#region Copyright (C) 1994-2009, Johnson & Johnson PRD, LLC.
//---------------------------------------------------------------------------*
//
//    BslsService.cs: WCF service for BSLS.
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
using Jnj.ThirdDimension.Instruments;
using System.Data;
using Jnj.ThirdDimension.BusinessLayer.BarcodeSeries;
using Jnj.ThirdDimension.Data.BarcodeSeries;
using System.Configuration;
using System.Reflection;
using Jnj.ThirdDimension.Base;
using AMS.Profile;
using Jnj.ThirdDimension.Arms.Model;

namespace Jnj.ThirdDimension.Service.BarcodeSeries
{

   /// <summary>
   /// BSLS WCF service.
   /// </summary>
   public class BslsService : IBslsService
   {

      #region Members

      private object key = new object();
      private bool? doLoging = null;
      private ConnectionInfo connInfo;
      private SeriesDataLayer dataLayer;
      private PrinterAccessor printer;
      private SeriesAccessor seriesAccessor;
      private SeriesGenerator generator;
      private Config config;
      private UserV user;
      private Jnj.ThirdDimension.Arms.Model.Application app;

      #endregion

      
      #region Properties

      SeriesDataLayer DataLayer
      {
         get
         {
            if (dataLayer == null)
            {
               Logger.ReportError("Session was closed unexpectedly.");
               throw new Exception("Session was closed unexpectedly.");
            }
            return dataLayer;
         }
      }

      /// <summary>
      /// Gets the SeriesAccessor instance without specifying the series name.
      /// </summary>
      /// <value>The printing client.</value>
      private SeriesAccessor SeriesClient
      {
         get
         {
            if (seriesAccessor == null)
            {
               seriesAccessor = new SeriesAccessor(DataLayer);
            }
            return seriesAccessor;
         }
      }

      /// <summary>
      /// Gets the PrinterAccessor instance.
      /// </summary>
      /// <value>The printing client.</value>
      private PrinterAccessor PrintingClient
      {
         get
         {
            if (printer == null)
            {
               printer = new PrinterAccessor(DataLayer);
            }
            return printer;
         }
      }

      #endregion


      #region Contract methods

      /// <summary>
      /// Establishes a connection with a database and initializes a session specific objects.
      /// </summary>
      /// <param name="domain">The domain.</param>
      /// <param name="username">The username.</param>
      /// <param name="password">The password.</param>
      /// <param name="encrypted">Indicates if password encrypted or not.</param>
      /// <returns></returns>
      public bool OpenSession(string domain, string username, string password, bool encrypted)
      {
         if (DoLoging) Logger.ReportInfo("OpenSession", "Opening session.");
         
         lock (key)
         {
            if (IsUserKnown)
            {
               return true;
            }

            try
            {
               connInfo = new ConnectionInfo();
               connInfo.UserName = username;
               connInfo.Domain = domain;
               connInfo.Password = password;
               connInfo.Encrypted = encrypted;

               #region Authorize
#if ArcadiaDebug
               connInfo.ApplicationId = Convert.ToInt32(GetValue("arcadiaApplicationId"));
               connInfo.ResourceName = GetValue("arcadiaResourceName");
#else
               connInfo.ApplicationId = Convert.ToInt32(GetValue("applicationId"));
               connInfo.ResourceName = GetValue("resourceName");
#endif
               if (DoLoging) Logger.ReportInfo("OpenSession", string.Format(@"Authorizing {0}\{1}.",
                                                              connInfo.Domain,
                                                              connInfo.UserName));
               // create dataLayer and check that user is configured to use the application
               dataLayer = ArmsAccessor.Instance.Authorize(
                  connInfo.UserName,
                  connInfo.Domain,
                  connInfo.ApplicationId,
                  connInfo.ResourceName,
                  0,
                  out user,
                  out app
                  );

               if (user == null) throw new Exception(string.Format(@"User '{0}\{1}' was not found in ARMS.", connInfo.Domain, connInfo.UserName));
               if (app == null) throw new Exception(string.Format(@"Application Id '{0}' was not found in ARMS.", connInfo.ApplicationId));
               if (dataLayer == null) throw new Exception(string.Format(@"Authorization did not pass for '{0}\{1}', AppId: {2}, Resource Name: {3}", connInfo.Domain, connInfo.UserName, connInfo.ApplicationId, connInfo.ResourceName));
               
               // establish a connection
               using (dataLayer.Connect())
               {
               }

               #endregion
            }
            catch(Exception ex)
            {
               Logger.ReportError(ex);
               throw;
            }

            if (DoLoging) Logger.ReportInfo("OpenSession", string.Format("Authorized: {0}.", (dataLayer != null)));

            return (dataLayer != null);
         }
      }

      /// <summary>
      /// Establishes a connection with a database and initializes a session specific objects.
      /// </summary>
      /// <param name="wwid">The wwid.</param>
      /// <param name="password">The password.</param>
      /// <param name="encrypted">Indicates if password encrypted or not.</param>
      /// <returns></returns>
      public bool OpenSession(decimal wwid, string password, bool encrypted)
      {
         if (DoLoging) Logger.ReportInfo("OpenSession", "Opening session.");

         lock (key)
         {
            if (IsUserKnown)
            {
               return true;
            }

            try
            {
               connInfo = new ConnectionInfo();
               connInfo.Wwid = wwid;
               connInfo.Password = password;
               connInfo.Encrypted = encrypted;

               #region Authorize
#if ArcadiaDebug
               connInfo.ApplicationId = Convert.ToInt32(GetValue("arcadiaApplicationId"));
               connInfo.ResourceName = GetValue("arcadiaResourceName");
#else
               connInfo.ApplicationId = Convert.ToInt32(GetValue("applicationId"));
               connInfo.ResourceName = GetValue("resourceName");
#endif

               if (DoLoging) Logger.ReportInfo("OpenSession", string.Format("Authorizing by wwid: {0}.", wwid));

               // create dataLayer and check that user is configured to use the application
               dataLayer = ArmsAccessor.Instance.Authorize(
                  connInfo.Wwid,
                  connInfo.ApplicationId,
                  connInfo.ResourceName,
                  0,
                  out user,
                  out app);

               if (user == null) throw new Exception(string.Format(@"User with wwid '{0}' was not found in ARMS.", wwid));
               if (app == null) throw new Exception(string.Format(@"Application Id '{0}' was not found in ARMS.", connInfo.ApplicationId));
               if (dataLayer == null) throw new Exception(string.Format(@"Authorization did not pass for '{0}\{1}', AppId: {2}, Resource Name: {3}", connInfo.Domain, connInfo.UserName, connInfo.ApplicationId, connInfo.ResourceName));

               // establish a connection
               using (dataLayer.Connect())
               {
               }

               #endregion
            }
            catch(Exception ex)
            {
               Logger.ReportError(ex);
               throw;
            }

            return (dataLayer != null);
         }
      }

      /// <summary>
      /// Closes a database connection and disposes all session resources.
      /// </summary>
      public void CloseSession()
      {
         if (DoLoging) Logger.ReportInfo("CloseSession", "Closing session.");

         lock (key)
         {
            DataLayer.Disconnect();

            connInfo = null;
            dataLayer = null;
            printer = null;
            generator = null;
            seriesAccessor = null;
            user = null;
         }
      }

      /// <summary>
      /// Ensures the db connection and generates a number of barcodes.
      /// </summary>
      /// <param name="seriesName">Name of the series.</param>
      /// <param name="numberOfValues">The number of values.</param>
      /// <returns>String array of barcodes.</returns>
      public string[] GetBarcodes(string seriesName, int numberOfValues)
      {
         if (DoLoging) Logger.ReportInfo("GetBarcodes", "Starting.");

         lock (key)
         {
            try
            {
               List<string> values = new List<string>();

               if (!ArmsAccessor.Instance.IsAuthorized(user, app, (ulong)UserRights.GenerateSeries))
                  throw new Exception("You need GenerateSeries rights to use the method.");

               using (DataLayer.Connect())
               {
                  generator = new SeriesGenerator(DataLayer, seriesName);
                  values = generator.GenerateUniqueBarcodes(numberOfValues);

                  return values.ToArray();
               }
            }
            catch (Exception ex)
            {
               Logger.ReportError(ex);
               throw;
            }
         }
      }

      /// <summary>
      /// Ensures the db connection and gets the list of printers.
      /// </summary>
      /// <param name="site">The site to search printers for.</param>
      /// <returns>The DataSet with one table, containing the printers information. 
      /// The table has a primary key constraint on ID column.
      /// </returns>
      public string [] GetPrintersList(string site)
      {
         if (DoLoging) Logger.ReportInfo("GetPrintersList", "Starting.");

         lock (key)
         {
            try
            {
               using (DataLayer.Connect())
               {
                  string[] list = PrintingClient.GetPrintersList(site);
                  return list;
               }
            }
            catch (Exception ex)
            {
               Logger.ReportError(ex);
               throw;
            }
         }
      }

      /// <summary>
      /// Gets templates and template variables for the specified printer.
      /// </summary>
      /// <param name="printerName">Printer name.</param>
      /// <returns></returns>
      public PrinterInfo GetPrinterInfo(string printerName)
      {
         if (DoLoging) Logger.ReportInfo("GetPrinterInfo", "Starting.");

         lock (key)
         {
            try
            {
               using (DataLayer.Connect())
               {
                  return PrintingClient.GetPrinterInfo(printerName);
               }
            }
            catch (Exception ex)
            {
               Logger.ReportError(ex);
               throw;
            }
         }
      }

      /// <summary>
      /// Ensures the db connection and prints the labels.
      /// </summary>
      /// <param name="printerUrl">The printer's URL.</param>
      /// <param name="template">The printer template name.</param>
      /// <param name="data">Table with data.</param>
      /// <param name="mapping">Mapping information, 'key' is a template field and 'value' stands for the column name from the data table.</param>
      /// <param name="stopOnError">if set to <c>true</c> print process will stop on first error.</param>
      /// <returns><c>True</c> if all labels were printed successfully.</returns>
      public bool PrintLabels(string printerUrl, string template, string[][] data, string[] variables, bool stopOnError)
      {
         if (DoLoging) Logger.ReportInfo("PrintLabels", "Starting.");

         lock (key)
         {
            try
            {
               if (!ArmsAccessor.Instance.IsAuthorized(user, app, (ulong)UserRights.PrintLabels))
                  throw new Exception("You need PrintLabels rights to use the method.");

               using (DataLayer.Connect())
               {
                   DataTable dt;
                   List<KeyValuePair<string, string>> map;

                   Convert2dArrayToTable(data, variables, out dt);
                   //RemapTemplate(dt, variables, out map);

                   return PrintingClient.PrintLabels(printerUrl, template, dt, stopOnError);
               }
            }
            catch (Exception ex)
            {
               Logger.ReportError(ex);
               throw;
            }
         }
      }

      /// <summary>
      /// Ensures the db connection and gets the site matching the specified parameters.
      /// </summary>
      /// <param name="userName">Name of the user.</param>
      /// <param name="domain">The domain.</param>
      /// <returns>The site name.</returns>
      public string GetSite(string userName, string domain)
      {
         if (DoLoging) Logger.ReportInfo("GetSite", "Starting.");

         lock (key)
         {
            try
            {
               using (DataLayer.Connect())
               {
                  return PrintingClient.GetSite(userName, domain);
               }
            }
            catch (Exception ex)
            {
               Logger.ReportError(ex);
               throw;
            }
         }
      }


      /// <summary>
      /// Ensures the db connection and gets the sites.
      /// </summary>
      /// <returns>String array of sites names.</returns>
      public string[] GetSites()
      {
         if (DoLoging) Logger.ReportInfo("GetSites", "Starting.");

         lock (key)
         {
            try
            {
               using (DataLayer.Connect())
               {
                  List<string> l = new List<string>();
                  PrintingClient.GetSites().ForEach(x => l.Add(x.Name));
                  return l.ToArray();
               }
            }
            catch (Exception ex)
            {
               Logger.ReportError(ex);
               throw;
            }
         }
      }

      /// <summary>
      /// Ensures the db connection and gets the list of available series.
      /// </summary>
      /// <returns>String array of sites names.</returns>
      public SeriesInfo[] GetSeriesNames()
      {
         if (DoLoging) Logger.ReportInfo("GetSeriesNames", "Starting.");

         lock (key)
         {
            try
            {
               using (DataLayer.Connect())
               {
                  BSDataSet.SeriesDataTable snDT = SeriesClient.GetSeriesNames();
                  List<SeriesInfo> series = new List<SeriesInfo>();

                  if (snDT != null)
                  {
                     snDT.Foreach(r => series.Add(new SeriesInfo(r.NAME, r["__TEMPLATE"].ToString())));
                  }

                  return series.ToArray();
               }
            }
            catch (Exception ex)
            {
               Logger.ReportError(ex);
               throw;
            }
         }
      }

      #endregion


      #region Private stuff

      /// <summary>
      /// Converts array of TemplateFieldMap to KeyValuePair<string, string> list.
      /// Template's FieldName is a key, ColIdx is a value.
      /// </summary>
      /// <param name="data">The data.</param>
      /// <param name="mapping">The mapping.</param>
      /// <param name="map">The map.</param>
      private void RemapTemplate(DataTable data, string [] variables, out List<KeyValuePair<string, string>> values)
      {
         values = new List<KeyValuePair<string, string>>(variables.Length);

         foreach (DataRow row in data.Rows)
         {
             foreach (string var in variables)
             {
                 values.Add(new KeyValuePair<string, string>(var, row[var].ToString()));
             }
         }
      }


      /// <summary>
      /// Converts the 2D array to table. Columns are gotten names based on index value: "1", "2", etc.
      /// </summary>
      /// <param name="data">The data.</param>
      /// <param name="mapping">The mapping.</param>
      /// <param name="dt">The dt.</param>
      private void Convert2dArrayToTable(string[][] data, string[] mapping, out DataTable dt)
      {
         dt = new DataTable();
         var max = data.Max(i => i.Length);

         // create columns
         for (int k = 0; k < max; k++)
         {
            dt.Columns.Add(mapping[k], typeof(string));
         }

         // add data
         for (int rowI = 0; rowI < data.Length; rowI++)
         {
            DataRow r = dt.NewRow();
            for (int colI = 0; colI < data[rowI].Length; colI++)
            {
               r[colI] = data[rowI][colI];
            }
            dt.Rows.Add(r);
         }
      }

      private bool IsUserKnown
      {
         get
         {
            return (user != null);
         }
      }

      private bool DoLoging
      {
         get
         {
            if (doLoging == null)
            {
               string stringVal = GetValue("LogInfo");
               int intVal;
               if (int.TryParse(stringVal, out intVal))
               {
                  doLoging = (intVal == 1);
               }
               else
               {
                  doLoging = false;
               }
            }
            return (bool)doLoging;
         }
      }

      /// <summary>
      /// Returns the configuration value for the given entry
      /// </summary>
      /// <param name="key"></param>
      /// <returns></returns>
      private string GetValue(string key)
      {
         return Config.GetValue("appSettings", key, string.Empty);
      }

      /// <summary>
      /// Loads and returns the app.config file.
      /// </summary>
      private Config Config
      {
         get
         {
            if (config == null)
            {
               // Init config information
               Uri uri = new Uri(Assembly.GetAssembly(typeof(BslsService)).GetName().CodeBase);
               string filePath = uri.LocalPath + ".config";
               config = new Config(filePath);
               config.GroupName = null;
            }

            return config;
         }
      }

      #endregion
   }

   /// <summary>
   /// Accumulates neccessary information about the current user.
   /// </summary>
   public class ConnectionInfo
   {
      public ConnectionInfo()
      {
         Wwid = -1;
         ApplicationId = -1;
      }

      /// <summary>
      /// Gets or sets the name of the user.
      /// </summary>
      /// <value>The username (do not mix up with the full name).</value>
      public string UserName
      {
         get; set;
      }

      /// <summary>
      /// Gets or sets the user domain.
      /// </summary>
      /// <value>The domain.</value>
      public string Domain
      {
         get; set;
      }

      /// <summary>
      /// Gets or sets the password.
      /// </summary>
      /// <value>The domain.</value>
      public string Password
      {
         get; set;
      }

      /// <summary>
      /// Indicates if password is encrypted.
      /// </summary>
      /// <value>The domain.</value>
      public bool Encrypted
      {
         get;
         set;
      }

      /// <summary>
      /// Gets or sets the ApplicationId.
      /// </summary>
      /// <value>The ApplicationId, as it is specified for the ResourceSystem.</value>
      public decimal ApplicationId
      {
         get; set;
      }

      /// <summary>
      /// Gets or sets the wwid.
      /// </summary>
      /// <value>The wwid.</value>
      public decimal Wwid
      {
         get;
         set;
      }

      /// <summary>
      /// Gets or sets the ResourceName.
      /// </summary>
      /// <value>The ResourceName.</value>
      public string ResourceName
      {
         get; set;
      }

      /// <summary>
      /// Gets or sets the user rights.
      /// </summary>
      /// <value>The mask.</value>
      public ulong UserRights
      {
         get; set;
      }
   }

}
