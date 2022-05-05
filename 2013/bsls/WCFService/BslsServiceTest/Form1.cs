#region Copyright (C) 1994-2009, Johnson & Johnson PRD, LLC.
//---------------------------------------------------------------------------*
//
//    BslsServiceTest.cs: Test application for BSLS WCF service.
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
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;
using BslsServiceTest.BslsServiceReference2;
using Jnj.ThirdDimension.Instruments;
using Jnj.ThirdDimension.Service.BarcodeSeries;
using AMS.Profile;
using System.Reflection;

namespace BslsServiceTest
{
   public partial class Form1 : Form
   {
      private BslsServiceClient client;

      public Form1()
      {
         InitializeComponent();
         LoadConfiguration();
      }

      private void LoadConfiguration()
      {
#if DEBUG
         appTextBox.Text = GetValue("arcadiaApplicationId");
         rnTextBox.Text = GetValue("arcadiaResourceName");
#else
         appTextBox.Text = GetValue("applicationId");
         rnTextBox.Text = GetValue("resourceName");
#endif
      }


      /// <summary>
      /// Closes session.
      /// </summary>
      void Form1_Closing(object sender, System.ComponentModel.CancelEventArgs e)
      {
         try
         {
            if (client != null)
            {
               client.CloseSession();
               client.Close();
            }
         }
         catch {}
      }

      /// <summary>
      /// Gets list of printers.
      /// </summary>
      private void button3_Click(object sender, EventArgs e)
      {
         StartProgress();
         try
         {
            string [] list = client.GetPrintersList(siteTextBox.Text.Trim());
            listBox.DataSource = list;

            PrintResult(list.Length + " printers were retrieved.");
         }
         catch (Exception ex)
         {
            PrintResult(ex.Message);
         }
         finally
         {
            EndProgress();
         }
      }

      /// <summary>
      /// Prints labels.
      /// </summary>
      private void button1_Click_1(object sender, EventArgs e)
      {
         StartProgress();
         try
         {
            if (listBox.SelectedItem == null)
               PrintResult("Retrieve printers first and then select one in the list box.");

            string printerName = (string)listBox.SelectedItem;
            PrinterInfo pInfo = client.GetPrinterInfo(printerName);
            
            if (pInfo == null) PrintResult("Printer is unavailable");

            PrinterTemplate template = pInfo.Templates[0];
            
            List<TemplateFieldMap> l = new List<TemplateFieldMap>();

            string [][] data = new string[1][];
            data[0] = new string[template.Variables.Length];

            for (int k = 0; k < template.Variables.Length; k++)
            {
               data[0][k] = "test data " + k;
               l.Add(new TemplateFieldMap(data[0][k], k));
            }

            // print
            client.PrintLabels(pInfo.Url, template.Name, data, l.ToArray(), false);

            // show results
            PrintResult(string.Format("Printed on {0}, \r\ntemplate was selected automatically: {1},\r\nmapping was done automatically, template fields:",
                                           pInfo.Name,
                                           template));

            for (int k = 0; k < template.Variables.Length; k++)
            {
               PrintResult(template.Variables[k]);
            }

            PrintResult("");
         }
         catch (Exception ex)
         {
            PrintResult(ex.Message);
         }
         finally
         {
            EndProgress();
         }
      }

      /// <summary>
      /// Opens session.
      /// </summary>
      private void button2_Click_1(object sender, EventArgs e)
      {
         PrintResult("Authorizing");
         StartProgress();
         
         try
         {
            client = new BslsServiceClient("NetTcpBinding_IBslsService");

            bool ok = client.OpenSession(logDomainTextBox.Text, logUserTextBox.Text, string.Empty, false);

            if (ok)
            {
               PrintResult("Connected.");
            }
            else
            {
               PrintResult("Connection error.");
            }
         }
         catch (Exception ex)
         {
            PrintResult(ex.Message);
         }
         finally
         {
            EndProgress();
         }
      }

      /// <summary>
      /// Clears results textbox.
      /// </summary>
      private void button4_Click(object sender, EventArgs e)
      {
         resultTextBox.Text = string.Empty;
      }

      /// <summary>
      /// Generates barcodes.
      /// </summary>
      private void button5_Click(object sender, EventArgs e)
      {
         StartProgress();
         try
         {
            string [] b = client.GetBarcodes(barcodeTextBox.Text, 3);

            if (b == null)
            {
               PrintResult("Nothing was returned from service, you may want to check Event Log for errors");
               return;
            }

            PrintResult("Barcodes were generated:");
            for (int k = 0; k < b.Length; k++)
            {
               PrintResult(b[k]);
            }

         }
         catch (Exception ex)
         {
            PrintResult(ex.Message);
         }
         finally
         {
            EndProgress();
         }
      }

      private void button6_Click(object sender, EventArgs e)
      {
         StartProgress();
         try
         {
            Form1_Closing(null, null);
            PrintResult("Closed");
         }
         catch (Exception ex)
         {
            PrintResult(ex.Message);
         }
         finally
         {
            EndProgress();
         }
      }

      private void getSeriesButton_Click(object sender, EventArgs e)
      {
         StartProgress();
         try
         {
            SeriesInfo[] series = client.GetSeriesNames();
            List<string> list = new List<string>();
            foreach (SeriesInfo si in series)
            {
               list.Add(string.Format("{0} - {1}", si.Name, si.Template));
            }
            listBox.DataSource = list;

            PrintResult(series.Length + " series were retrieved.");
         }
         catch (Exception ex)
         {
            PrintResult(ex.Message);
         }
         finally
         {
            EndProgress();
         }
      }

      private void button7_Click(object sender, EventArgs e)
      {
         StartProgress();
         try
         {
            if (userTextBox.Text.Trim().Length == 0)
            {
               string[] sites = client.GetSites();
               listBox.DataSource = sites;

               PrintResult(sites.Length + " sites were retrieved.");
            }
            else
            {
               string [] sites = new string[1];
               sites[0] = client.GetSite(userTextBox.Text, domainTextBox.Text);
               listBox.DataSource = sites;
            }
         }
         catch (Exception ex)
         {
            PrintResult(ex.Message);
         }
         finally
         {
            EndProgress();
         }
      }

      #region Stuff
      
      private void StartProgress()
      {
         this.Text += "***";
         Application.DoEvents();
      }

      private void EndProgress()
      {
         this.Text = this.Text.TrimEnd('*');
      }


      private void PrintResult(string msg)
      {
         resultTextBox.Text += msg + "\r\n";
         resultTextBox.Select(resultTextBox.Text.Length, 0);
         resultTextBox.ScrollToCaret();
      }

      #endregion

      #region Read config

      private Config config;

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

      /// <summary>
      /// Returns the configuration value for the given entry
      /// </summary>
      /// <param name="key"></param>
      /// <returns></returns>
      private string GetValue(string key)
      {
         return Config.GetValue("appSettings", key, string.Empty);
      }


      #endregion

   }
}
