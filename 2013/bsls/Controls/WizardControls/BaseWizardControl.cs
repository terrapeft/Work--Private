using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Drawing;
using System.Data;
using System.Linq;
using System.Text;
using System.Windows.Forms;
using System.Collections;
using Jnj.ThirdDimension.Utils.BarcodeSeries;
using System.Diagnostics;
using Jnj.ThirdDimension.Data.BarcodeSeries;

namespace Jnj.ThirdDimension.Controls.BarcodeSeries
{
   public partial class BaseWizardControl : UserControl, IWizardControlView
   {

      private IGridDataBoundGridValidator inputValidator;   // user input validator

      public BaseWizardControl()
      {
         InitializeComponent();
      }

      #region Properties

      /// <summary>
      /// Link to help page.
      /// </summary>
      public string HelpUrl { get; set; }


      #endregion


      #region Virtual methods
      /// <summary>
      /// Resets the control.
      /// </summary>
      public virtual void Reset()
      {
         throw new Exception("You have to implement this method in derived class.");
      }

      /// <summary>
      /// Saves Label Series props to database.
      /// </summary>
      public virtual bool Save()
      {
         throw new Exception("You have to implement this method in derived class.");
      }

      /// <summary>
      /// Initializes the control.
      /// </summary>
      public virtual void Init(SeriesDataLayer dl)
      {
         throw new Exception("You have to implement this method in derived class.");
      }

      /// <summary>
      /// Imports data from csv file.
      /// </summary>
      public virtual void Import()
      {
         throw new Exception("You have to implement this method in derived class.");
      }

      /// <summary>
      /// Shows help page.
      /// </summary>
      public void Help()
      {
         if (HelpUrl.Length > 0)
         {
            Process.Start(HelpUrl);
         }
      }

      #endregion


      #region 3DX export

      protected void OnImportRequest(ImportEventArgs args)
      {
         if (ImportRequest != null)
         {
            ImportRequest(this, args);
         }
      }

      protected void OnTdxExport(TdxExportEventArgs args)
      {
         if (ExportTo3DX != null)
         {
            ExportTo3DX(this, args);
         }
      }

      protected void OnSomeWorkOccured(LabelPrinting.Work work)
      {
         if (DoSomeWork != null)
         {
            DoSomeWork(work);
         }
      }

      protected virtual TdxExportEventArgs GetExportingArguments()
      {
         throw new Exception("You need to implement this method in derived class.");
      }

      #endregion


      #region Common methods

      /// <summary>
      /// Wait dialog will be created. It will be raised automatically after 0.5 sec delay.
      /// </summary>
      protected AsynchronousWaitDialog WaitDialog(string message)
      {
         return AsynchronousWaitDialog.ShowWaitDialog(message, false);
      }

      /// <summary>
      /// Wait dialog will be created. It will be raised automatically after 0.5 sec delay.
      /// </summary>
      protected AsynchronousWaitDialog WaitDialog(string message, bool allowCancel)
      {
         return AsynchronousWaitDialog.ShowWaitDialog(message, allowCancel);
      }

      #endregion


      #region Events stuff

      /// <summary>
      /// Occurs when control ready to export data to 3DX
      /// </summary>
      public event EventHandler<TdxExportEventArgs> ExportTo3DX;

      /// <summary>
      /// Occures when this control need to receive import arguments from the wizard.
      /// </summary>
      public event EventHandler<ImportEventArgs> ImportRequest;

      /// <summary>
      /// Used to perform some actions in wizard on user events.
      /// </summary>
      public event DoSomeWorkHandler DoSomeWork;

      /// <summary>
      /// Event arguments for ExportingTo3DX event
      /// </summary>
      public class TdxExportEventArgs : EventArgs
      {
         public DataTable SourceTable;
         public ICollection GridColumns;
         public string TdxViewName;
      }

      /// <summary>
      /// Delegate for <see cref="DoSomeWork"/> event.
      /// </summary>
      /// <param name="work"></param>
      public delegate void DoSomeWorkHandler(Work work);

      #endregion


      #region Enums

      [Flags]
      /// <summary>
      /// Used to send commands to wizard.
      /// </summary>
      public enum Work
      {
         EnablePrint = 1,
         EnableSave = 2,
         EnableBarcodesGeneration = 4,
         EnableSaveLoad = 8,
         DisablePrint = 16,
         DisableSaveLoad = 32,
         DisableAll = 64,
      }

      #endregion


      #region IWizardControlView Members

      public virtual Dictionary<string, string> QueryAttributes
      {
         get { throw new NotImplementedException(); }
      }

      public virtual decimal CurrentOrgSite
      {
         get { throw new NotImplementedException(); }
      }

      public virtual SeriesDataLayer DataLayer { get; set; }

      #endregion
   }
}
