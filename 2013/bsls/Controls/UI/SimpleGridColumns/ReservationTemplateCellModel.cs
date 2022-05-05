#region Copyright (C) 1994-2010, Johnson & Johnson PRD, LLC.
//---------------------------------------------------------------------------*
//
//    ButtonEditCellModel.cs
//
//---
//
//    Copyright (C) 1994-2009, Johnson & Johnson PRD, LLC.
//    All Rights Reserved.
//
//    Roman Osykin, 03/2010
//
//---------------------------------------------------------------------------*/
#endregion
using System;
using System.Diagnostics;
using System.Drawing;
using System.Windows.Forms;
using Syncfusion.Windows.Forms.Grid;

namespace Jnj.ThirdDimension.Controls.BarcodeSeries
{
   /// <summary>
   /// Implements the data/model part for a ButtonEdit cell
   /// </summary>
   /// 

   #region CellModel
   [Serializable]
   public class ReservationTemplateCellModel : GridTextBoxCellModel
   {
      private ImageList buttonImageList;

      /// <summary>
      /// Initializes a new <see cref="ButtonEditCellModel"/> object 
      /// and stores a reference to the <see cref="GridModel"/> this cell belongs to.
      /// </summary>
      /// <param name="grid">The <see cref="GridModel"/> for this cell model.</param>	
      /// <param name="imgList">Image list with image for a button, must contain at least 1 image.</param>
      /// <remarks>
      /// You typically access cell models through the <see cref="GridModel.CellModels"/>
      /// property of the <see cref="GridModel"/> class.
      /// </remarks>
      public ReservationTemplateCellModel(GridModel grid)
         : base(grid)
      {
         AllowFloating = false;

      }

      /// <override/>
      //public override GridCellRendererBase CreateRenderer(GridControlBase control)
      //{
      //   return new ButtonEditCellRenderer(control, this, buttonImageList);
      //}

      public override bool ApplyFormattedText(GridStyleInfo style, string text, int textInfo)
      {
         return base.ApplyFormattedText(style, text, textInfo);
      }
   }

   #endregion

   //#region CellRenderer
   ///// <summary>
   ///// Implements the renderer part for the ButtonEditCellRenderer
   ///// </summary>
   ///// 
   //public class ButtonEditCellRenderer : GridTextBoxCellRenderer
   //{
   //   /// <summary>
   //   /// Initializes a new <see cref="ButtonEditCellRenderer"/> object for the given GridControlBase
   //   /// and <see cref="ButtonEditCellModel"/>.
   //   /// </summary>
   //   /// <param name="grid">The <see cref="GridControlBase"/> that display this cell renderer.</param>
   //   /// <param name="cellModel">The <see cref="ButtonEditCellModel"/> that holds data for this cell renderer that should
   //   /// be shared among views.</param>
   //   /// <remarks>References to GridControlBase, 
   //   /// and GridTextBoxCellModel will be saved.</remarks>
   //   public ButtonEditCellRenderer(GridControlBase grid, GridTextBoxCellModel cellModel, ImageList imgList)
   //      : base(grid, cellModel)
   //   {
   //      ButtonEditCellButton button = new ButtonEditCellButton(this, imgList);
   //      button.Clicked += button_Clicked;
   //      AddButton(button);
   //   }

   //   void button_Clicked(object sender, GridCellEventArgs e)
   //   {
   //      this.Grid.CurrentCell.MoveTo(RowIndex, ColIndex);
   //   }

   //}
   //#endregion


}