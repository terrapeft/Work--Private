using System;
using System.ComponentModel;
using System.Windows.Forms;
using Jnj.ThirdDimension.Util.UsageLog;
using Jnj.ThirdDimension.Mt.Data;
using System.Data;
using Jnj.ThirdDimension.Base;
using System.IO;
using Jnj.ThirdDimension.Data;
using Jnj.ThirdDimension.Utils.BarcodeSeries;
using System.Reflection;
using System.Runtime.Remoting;
using Jnj.ThirdDimension.Mt.Chem;
using Jnj.ThirdDimension.BusinessLayer.BarcodeSeries;
using Jnj.ThirdDimension.Data.BarcodeSeries;
using Jnj.ThirdDimension.Lims.Interface;
using System.Data.Objects;
using System.Linq;
using System.Collections;
using System.Configuration;
using Jnj.ThirdDimension.Controls.BarcodeSeries;


namespace Jnj.ThirdDimension.Explorer.BarcodeSeries
{
   /// <summary>
   /// Acceptance wizard
   /// </summary>
   public partial class BaseWizard : Form, IExplorerPlugin, IWizard
   {

      protected string helpPage = null;
      protected bool initialized = false;
      protected IWizardControlView controlView;
      protected SeriesDataLayer dataLayer;

      #region Constructors

      /// <summary>
      /// Initializes a new instance of the <see cref="ConfigurationManagerWizard"/> class.
      /// </summary>
      public BaseWizard()
      {
         try
         {
            InitializeComponent();
         }
         catch (Exception ex)
         {
            MessagesHelper.ReportError(ex, true);
         }
      }

      #endregion


      #region Virtual properties and methods

      /// <summary>
      /// The type name as defined in derived class.
      /// </summary>
      [Browsable(false)]
      public virtual string TypeName
      {
         get { throw new NotImplementedException(); }
      }

      /// <summary>
      /// We have to override this method.
      /// </summary>
      /// <returns></returns>
      protected virtual bool OnRun()
      {
         throw new NotImplementedException();
      }


      /// <summary>
      /// Provides minimum rights required to run plugin.
      /// </summary>
      /// <returns>A mask of all rights.</returns>
      protected virtual UInt64 RequiredRights
      {
         get { throw new NotImplementedException(); }
      }

      #endregion


      #region Private and protected methods

      /// <summary>
      /// Wait dialog will be created. It will be raised automatically after 0.5 sec delay.
      /// </summary>
      protected static AsynchronousWaitDialog WaitDialog(string message)
      {
         return AsynchronousWaitDialog.ShowWaitDialog(message, false);
      }

      protected bool Authenticate()
      {
         try
         {
            using (WaitDialog("Authentication"))
            {
#if ArcadiaDebug
               string username = "wcedeno";
               string domain = "NA";
#else
               string username = Explorer.Configuration.Abcd.UserInfo.UserName;
               string domain = Explorer.Configuration.Abcd.UserInfo.DomainName;
#endif
               decimal appId = decimal.Parse(XmlUtils.GetNodeValue(Handler.Parameters["applicationId"], string.Empty));
               string rn = XmlUtils.GetNodeValue(Handler.Parameters["dsn"], string.Empty);

               dataLayer = ArmsAccessor.Instance.Authorize(username, domain, appId, rn, RequiredRights);

               if (dataLayer == null) return false;

               this.Text = WizardHelper.SetTitle(this.Text,
                                                 dataLayer.SecurityContext.User.FullName,
                                                 dataLayer.SecurityContext.ConnectionString);
            }
            return true;
         }
         catch (Exception ex)
         {
            if (ex.InnerException != null)
            {
               Reporter.ReportError(ex.InnerException, true);
            }
            Reporter.ReportError(ex, true);
         }

         return false;
      }

      #endregion


      #region Event handlers

      /// <summary>
      /// <summary>
      /// Prevents wizard's closing attempts when any dialog was opened and closed from the inside of it.
      /// </summary>
      /// <param name="sender"></param>
      /// <param name="e"></param>
      protected void Wizard_FormClosing(object sender, FormClosingEventArgs e)
      {
         if (DialogResult == DialogResult.OK && e.CloseReason == CloseReason.None)
         {
            e.Cancel = true;
         }
         else if (controlView != null)
         {
            controlView.Reset();
         }
      }

      #endregion


      #region IExplorerPlugin Members

      public void Run(IExplorer explorer, ExplorerPluginHandler handler)
      {
         Explorer = explorer;
         Handler = handler;

         if (!initialized)
         {
            LoadParameters(handler.Parameters);
            initialized = true;
         }

         try
         {
            // Setup Remoting, an error could be caused from calling this multiple times.
            string assName = Assembly.GetExecutingAssembly().Location + ".config";
            RemotingConfiguration.Configure(assName, false);
         }
         catch (Exception ex)
         {
            MessagesHelper.ReportError(ex, false);
         }

         if (!Authenticate())
         {
            throw new ApplicationException("Access denied! Please request access to this application.");
         }

         if (!OnRun()) return;

         if (explorer == null)
         {
            // for out of 3DX debugging
            ShowDialog();
         }
         else
         {
            ShowDialog(explorer.MainForm);
         }
      }

      #endregion


      #region IWizard Members

      public IExplorer Explorer
      {
         get;
         set;
      }

      public ExplorerPluginHandler Handler
      {
         get;
         set;
      }

      public void LoadParameters(System.Xml.XmlElement parameters)
      {
         // Add custom deserialization here. 
         // To retrieve config values use XmlUtils conveninece methods, for example:
         // bool showProperties = XmlUtils.GetNodeValue(parameters["showProperties"], true);

         string helpUrl = ConfigurationManager.AppSettings["helpUrl"];
         string wizardHelpPage = XmlUtils.GetNodeValue(Handler.Parameters["helpPage"], string.Empty);
         helpPage = helpUrl + wizardHelpPage;
      }

      public void SaveParameters(System.Xml.XmlElement node)
      {
         throw new NotImplementedException();
      }

      #endregion


      #region Helper methods

      /// <summary>
      /// Creates 3DX table from a set of data tables and provided columns. Assumes all data tables have the same size.
      /// Supports long, double, DateTime and string columns.
      /// </summary>
      /// <param name="name"></param>
      /// <param name="dts"></param>
      /// <param name="dtCols"></param>
      /// <param name="tdxCols"></param>
      /// <param name="tblTypes"></param>
      /// <returns></returns>
      protected virtual Table CreateTable(string name, DataTable[] dts, DataColumn[] dtCols, string[] tdxCols, Type[] tblTypes)
      {
         string unique = Explorer.Project.Tables.GetUniqueTableName(name);
         Table tbl = Explorer.Project.Tables.AddNew(unique);

         if (dts.Length == 0) return tbl;

         DataTable srcTbl = dts[0];
         using (tbl.DisableEvents())
         {
            tbl.AddNew(srcTbl.DefaultView.Count);
            for (int j = 0; j < tdxCols.Length; j++)
            {
               if (tblTypes[j] == typeof(long))
               {
                  ValueColumn<long> lc = tbl.Columns.AddNewV<long>(tdxCols[j]);
                  for (int i = 0; i < dts[j].DefaultView.Count; i++)
                  {
                     long nv = Convert.ToInt64(dts[j].DefaultView[i][dtCols[j].Ordinal]);
                     lc[i] = nv;
                  }
               }
               else if (tblTypes[j] == typeof(double))
               {
                  ValueColumn<double> lc = tbl.Columns.AddNewV<double>(tdxCols[j]);
                  for (int i = 0; i < dts[j].DefaultView.Count; i++)
                  {
                     double nv = Convert.ToDouble(dts[j].DefaultView[i][dtCols[j].Ordinal]);
                     lc[i] = nv;
                  }
               }
               else if (tblTypes[j] == typeof(DateTime))
               {
                  ValueColumn<DateTime> lc = tbl.Columns.AddNewV<DateTime>(tdxCols[j]);
                  for (int i = 0; i < dts[j].DefaultView.Count; i++)
                  {
                     object val = dts[j].DefaultView[i][dtCols[j].Ordinal];
                     if (val != DBNull.Value)
                     {
                        lc[i] = (DateTime)val;
                     }
                  }
               }
               else // Must be a string
               {
                  if (dtCols[j].ColumnName.ToUpper() == "SMILES")
                  {
                     ReferenceColumn<Molecule> mc = tbl.Columns.AddNewR<Molecule>(tdxCols[j]);
                     for (int i = 0; i < dts[j].DefaultView.Count; i++)
                     {
                        string smiles = dts[j].DefaultView[i][dtCols[j].Ordinal].ToString();
                        if (smiles == "0") smiles = string.Empty;
                        mc[i] = new Molecule(smiles);
                     }
                  }
                  else
                  {
                     ReferenceColumn<string> lc = tbl.Columns.AddNewR<string>(tdxCols[j]);
                     for (int i = 0; i < dts[j].DefaultView.Count; i++)
                     {
                        lc[i] = dts[j].DefaultView[i][dtCols[j].Ordinal].ToString();
                     }
                  }
               }
            }
         }

         return tbl;
      }

      #endregion

   }
}