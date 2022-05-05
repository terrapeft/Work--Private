#region Copyright (C) 1994-2009, Johnson & Johnson PRD, LLC.
//---------------------------------------------------------------------------*
//
//    IWizardControlView.cs: Interface for controls which are using controllers inherited form BaseGridController.
//
//---
//
//    Copyright (C) 1994-2009, Johnson & Johnson PRD, LLC.
//    All Rights Reserved.
//
//    Vitaly Chupaev, 12/2009
//
//---------------------------------------------------------------------------*/
#endregion
using System;
using System.Collections.Generic;
using System.Text;
using Jnj.ThirdDimension.Data.BarcodeSeries;

namespace Jnj.ThirdDimension.Controls.BarcodeSeries
{
   /// <summary>
   /// Interface for controls which are using controllers inherited form BaseGridController.
   /// </summary>
   public interface IWizardControlView
   {
      Dictionary<string, string> QueryAttributes { get; }
      decimal CurrentOrgSite { get; }
      void Reset();
      void Help();
      SeriesDataLayer DataLayer { get; set; }
   }
}
