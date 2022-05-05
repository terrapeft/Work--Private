#region Copyright (C) 1994-2009, Johnson & Johnson PRD, LLC.
//---------------------------------------------------------------------------*
//
//    SeriesManagerWizard.cs: Wizard for managing label series.
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
using Jnj.ThirdDimension.Data;
using Jnj.ThirdDimension.Utils.BarcodeSeries;
using Jnj.ThirdDimension.BusinessLayer.BarcodeSeries;
using System.Collections.Generic;
using Jnj.ThirdDimension.Data.BarcodeSeries;


namespace Jnj.ThirdDimension.Explorer.BarcodeSeries
{
   /// <summary>
   /// Acceptance wizard
   /// </summary>
   public partial class SeriesManagerWizard : BaseWizard
   {

      #region Constructors

      /// <summary>
      /// Initializes a new instance of the <see cref="ConfigurationManagerWizard"/> class.
      /// </summary>
      public SeriesManagerWizard()
      {
         try
         {
            InitializeComponent();
            controlView = seriesManager;
         }
         catch (Exception ex)
         {
            MessagesHelper.ReportError(ex, true);
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
         get { return GetType().Name; }
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
            seriesManager.HelpUrl = helpPage;
            seriesManager.Init(dataLayer);
         }
         catch (Exception ex)
         {
            MessagesHelper.ReportError(ex, true);
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
            return (UInt64)(UserRights.ManageSeries | UserRights.ReserveSeries);
#endif
         }
      }


      #endregion

      #region Event handlers

      /// <summary>
      /// Accepts changes, stores them in db.
      /// </summary>
      /// <param name="sender"></param>
      /// <param name="e"></param>
      private void submitButton_Click(object sender, EventArgs e)
      {
         try
         {
            seriesManager.Save();
         }
         catch (Exception ex)
         {
            Reporter.ReportError(ex, true);
         }
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
            seriesManager.Reset();
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
            seriesManager.Help();
         }
         catch (Exception ex)
         {
            Reporter.ReportError(ex, true);
         }
      }

      #endregion
   }
}