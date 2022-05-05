#region Copyright (C) 1994-2009, Johnson & Johnson PRD, LLC.
//---------------------------------------------------------------------------*
//
//    IController.cs: Interface for BaseGridController controllers which are used in UserControls.
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

namespace Jnj.ThirdDimension.Controls.BarcodeSeries
{
   /// <summary>
   /// Interface for BaseGridController controllers which are used in UserControls.
   /// </summary>
   interface IController
   {
      void Reset();
      void Submit();
      void Import();
      void Export();
      void Print();

      void SelectGrid();
      void DeselectGrid();
   }
}
