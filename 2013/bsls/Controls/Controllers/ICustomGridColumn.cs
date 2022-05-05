#region Copyright (C) 1994-2011, Johnson & Johnson PRD, LLC.
//---------------------------------------------------------------------------*
//
//    PictureSimpleGridColumn.cs: Interface for custom SimpleGrid columns.
//
//---
//
//    Copyright (C) 1994-2011, Johnson & Johnson PRD, LLC.
//    All Rights Reserved.
//
//    Vitaly Chupaev, 08/2011
//
//---------------------------------------------------------------------------*/
#endregion

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Jnj.ThirdDimension.Controls.BarcodeSeries
{
   /// <summary>
   /// Interface for custom SimpleGrid columns.
   /// </summary>
   public interface ICustomGridColumn
   {
      void RegisterColumn();
   }
}
