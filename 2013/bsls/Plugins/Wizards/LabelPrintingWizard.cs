#region Copyright (C) 1994-2009, Johnson & Johnson PRD, LLC.
//---------------------------------------------------------------------------*
//
//    LabelPrintingWizard.cs: Wizard for printing label series.
//
//---
//
//    Copyright (C) 1994-2009, Johnson & Johnson PRD, LLC.
//    All Rights Reserved.
//
//    Vitaly Chupaev, 11/2009
//
//---------------------------------------------------------------------------*/
#endregion
using System;
using System.ComponentModel;
using System.Windows.Forms;
using Jnj.ThirdDimension.Util.UsageLog;
using Jnj.ThirdDimension.Mt.Data;
using System.Data;
using Jnj.ThirdDimension.Base;
using System.IO;
using System.Reflection;
using Jnj.ThirdDimension.Controls.BarcodeSeries;
using Jnj.ThirdDimension.BusinessLayer.BarcodeSeries;
using Jnj.ThirdDimension.Data.BarcodeSeries;
using Jnj.ThirdDimension.Utils.BarcodeSeries;


namespace Jnj.ThirdDimension.Explorer.BarcodeSeries
{
   /// <summary>
   /// Acceptance wizard
   /// </summary>
   public partial class LabelPrintingWizard : BaseWizard
   {

      #region Constructors

      /// <summary>
      /// Initializes a new instance of the <see cref="ConfigurationManagerWizard"/> class.
      /// </summary>
      public LabelPrintingWizard()
      {
         using (WaitDialog("Initializing"))
         {
            InitializeComponent();
            universalPrinting1.DoSomeWork += universalPrinting1_DoSomeWork;
            universalPrinting1.ImportRequest += universalPrinting1_ImportRequest;
            universalPrinting1.ExportTo3DX += universalPrinting1_ExportTo3DX;
            controlView = universalPrinting1;
         }
      }

      #endregion

      #region Public properties and indexers

      /// <summary>
      /// The type name as defined in derived class.
      /// </summary>
      [Browsable(false)]
      public override string TypeName
      {
         get 
         {
            return GetType().Name; 
         }
      }

      #endregion

      #region Private and protected methods

      /// <summary>
      /// We have to override this method.
      /// </summary>
      /// <returns></returns>
      protected override bool OnRun()
      {
         try
         {
            universalPrinting1.HelpUrl = helpPage;
            universalPrinting1.Init(dataLayer);
         }
         catch (Exception ex)
         {
            Reporter.ReportError(ex, true);
         }

         return true;
      }

      /// <summary>
      /// Provides minimum rights required to run plugin.
      /// </summary>
      /// <returns>A mask of all rights.</returns>
      protected override UInt64 RequiredRights
      {
         get
         {
#if ArcadiaRelease
            return 0;
#else
            return (UInt64)(UserRights.GenerateSeries | UserRights.PrintLabels);
#endif
         }
      }

      #endregion

      #region Event handlers

      /// <summary>
      /// Handles custom events from the hosted control
      /// </summary>
      /// <param name="work"></param>
      void universalPrinting1_DoSomeWork(LabelPrinting.Work work)
      {
         try
         {
            if ((work & LabelPrinting.Work.DisableAll) == LabelPrinting.Work.DisableAll)
            {
               printButton.Enabled = false;
               generateBarcodesButton.Enabled = false;
               barItemLoad.Enabled = false;
               barItemSave.Enabled = false;
            }
            if ((work & LabelPrinting.Work.DisablePrint) == LabelPrinting.Work.DisablePrint)
            {
               printButton.Enabled = false;
            }
            if ((work & LabelPrinting.Work.DisableSaveLoad) == LabelPrinting.Work.DisableSaveLoad)
            {
               barItemLoad.Enabled = false;
               barItemSave.Enabled = false;
            }
            if ((work & LabelPrinting.Work.EnableBarcodesGeneration) == LabelPrinting.Work.EnableBarcodesGeneration)
            {
               generateBarcodesButton.Enabled = true;
            }
            if ((work & LabelPrinting.Work.EnablePrint) == LabelPrinting.Work.EnablePrint)
            {
               printButton.Enabled = true;
            }
            if ((work & LabelPrinting.Work.EnableSave) == LabelPrinting.Work.EnableSave)
            {
               barItemSave.Enabled = true;
            }
            if ((work & LabelPrinting.Work.EnableSaveLoad) == LabelPrinting.Work.EnableSaveLoad)
            {
               barItemLoad.Enabled = true;
               barItemSave.Enabled = true;
            }
         }
         catch (Exception ex)
         {
            MessagesHelper.ReportError(ex, true);
         }
      }

      void universalPrinting1_ExportTo3DX(object sender, BaseWizardControl.TdxExportEventArgs e)
      {
         try
         {
            ExportHelper tdxHelper = new ExportHelper();
            ExportData ed = tdxHelper.GetExportData(e.SourceTable, e.GridColumns);
            CreateTable(e.TdxViewName, ed.SourceTables, ed.SourceColumns, ed.TargetColumns, ed.SourceTypes);
         }
         catch (Exception ex)
         {
            MessagesHelper.ReportError(ex, true);
         }
      }

      void universalPrinting1_ImportRequest(object sender, ImportEventArgs e)
      {
         try
         {
            // Mapping dialog
            IMapTableToDataTableDialog dlg = new MapTableToDataTableDialog
                                                {
                                                   Explorer = Explorer
                                                };

            if (dlg.ShowDialog() == DialogResult.OK)
            {
               e.Cancel = false;
               e.IsFileImport = dlg.IsFileImport;

               if (dlg.IsFileImport)
               {
                  e.FileName = dlg.FileName;
               }
               else
               {
                  e.Table = ImportHelper.PrepareForImportFrom3DXTable(dlg.MappedColumns, dlg.GetSourceData());
               }
            }
         }
         catch (Exception ex)
         {
            Reporter.ReportError(ex, true);
         }
      }

      /// <summary>
      /// Closes the wizard.
      /// </summary>
      /// <param name="sender"></param>
      /// <param name="e"></param>
      private void cancelButton_Click(object sender, EventArgs e)
      {
         this.Close();
      }

      /// <summary>
      /// Resets all controls to initial state.
      /// </summary>
      /// <param name="sender"></param>
      /// <param name="e"></param>
      private void barItemReset_Click(object sender, EventArgs e)
      {
         try
         {
            universalPrinting1.Reset();
         }
         catch (Exception ex)
         {
            Reporter.ReportError(ex, true);
         }
      }

      /// <summary>
      /// Imports data.
      /// </summary>
      /// <param name="sender"></param>
      /// <param name="e"></param>
      private void barItemLoad_Click(object sender, EventArgs e)
      {
         try
         {
            universalPrinting1.Import();
         }
         catch (Exception ex)
         {
            Reporter.ReportError(ex, true);
         }
      }

      /// <summary>
      /// Exports data.
      /// </summary>
      /// <param name="sender"></param>
      /// <param name="e"></param>
      private void barItemSave_Click(object sender, EventArgs e)
      {
         try
         {
            universalPrinting1.Save();
         }
         catch (Exception ex)
         {
            Reporter.ReportError(ex, true);
         }
      }

      /// <summary>
      /// Prints grid.
      /// </summary>
      /// <param name="sender"></param>
      /// <param name="e"></param>
      private void printButton_Click(object sender, EventArgs e)
      {
         try
         {
            universalPrinting1.Print();
         }
         catch (Exception ex)
         {
            Reporter.ReportError(ex, true);
         }
      }

      /// <summary>
      /// Opens help page
      /// </summary>
      /// <param name="sender"></param>
      /// <param name="e"></param>
      private void barItemHelp_Click(object sender, EventArgs e)
      {
         try
         {
            universalPrinting1.Help();
         }
         catch (Exception ex)
         {
            Reporter.ReportError(ex, true);
         }
      }

      private void generateBarcodesButton_Click(object sender, EventArgs e)
      {
         try
         {
            universalPrinting1.GenerateBarcodes();
         }
         catch (Exception ex)
         {
            Reporter.ReportError(ex, true);
         }

      }

      #endregion

   }
}