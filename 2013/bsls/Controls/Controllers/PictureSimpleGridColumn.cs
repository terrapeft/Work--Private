#region Copyright (C) 1994-2011, Johnson & Johnson PRD, LLC.
//---------------------------------------------------------------------------*
//
//    PictureSimpleGridColumn.cs: Editable picture column, which allows to 
//                                load pictures by double click.
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
using Jnj.ThirdDimension.Mt.Chem;
using Jnj.ThirdDimension.Base;
using System.Windows.Forms;
using Syncfusion.Windows.Forms.Grid;
using Jnj.ThirdDimension.Gt;
using Jnj.Windows.Forms;
using Jnj.ThirdDimension.Controls.Grid;
using Jnj.ThirdDimension.Data;
using System.IO;


namespace Jnj.ThirdDimension.Controls.BarcodeSeries
{

   /// <summary>
   /// Editable picture column, which allows to load pictures by double click.
   /// </summary>
   public class PictureSimpleGridColumn : SimpleGridBoundColumn, ICustomGridColumn
   {
      public static readonly string CellType = "PictureCell";

      public PictureSimpleGridColumn()
      {
         this.StyleInfo.CellType = PictureSimpleGridColumn.CellType;
      }

      public void RegisterColumn()
      {
         base.RegisterModel(this.StyleInfo.CellType, new PictureCellModel2(base.GridModel));
      }
   }

   
   /// <summary>
   /// Cell model.
   /// </summary>
   public class PictureCellModel2 : PictureCellModel
   {
      public PictureCellModel2(GridModel gridModel)
         : base(gridModel)
      {
      }

      public override GridCellRendererBase CreateRenderer(GridControlBase control)
      {
         return new PictureCellRenderer2(control, this);
      }
   }

   /// <summary>
   /// Cell renderer with loading dialog.
   /// </summary>
   public class PictureCellRenderer2 : PictureCellRenderer
   {
      public PictureCellRenderer2(GridControlBase grid, PictureCellModel2 cellModel)
         : base(grid, cellModel)
      {
      }

      protected override void OnDoubleClick(int rowIndex, int colIndex, MouseEventArgs e)
      {
         LoadPicture();
      }

      private void LoadPicture()
      {
         GridStyleInfo style = base.Grid.Model[base.CurrentCell.RowIndex, base.CurrentCell.ColIndex];
         if (!style.ReadOnly)
         {
            OpenFileDialog dialog = new OpenFileDialog();
            dialog.Filter = "All Graphic Files | *.bmp;*.jpg;*.jpeg;*.wmf;*.emf;*.png;*.ico;*gif;*.tif;*.tiff|Bitmap Files (*.bmp) | *.bmp|Icon Files (*.ico) | *.ico|GIF Files (*.gif) | *.gif|JPEG Files (*.jpg, *.jpeg) | *.jpg;*.jpeg|PNG Files (*.png) | *.png|TIFF Files (*.tif, *.tiff) | *.tif;*.tiff|Windows Metafiles (*.wmf, *.emf) | *.wmf;*.emf";
            if (dialog.ShowDialog() == DialogResult.OK)
            {
               PictureData data = new PictureData();
               data.Data = File.ReadAllBytes(dialog.FileName);
               style.CellValue = data;
            }
         }
      }

      protected override void OnDraw(System.Drawing.Graphics g, System.Drawing.Rectangle cellRect, int rowIndex, int colIndex, GridStyleInfo style)
      {
         var data = style.CellValue as PictureData;
         if (data != null)
         {
            using (System.Drawing.Bitmap bitmap = new System.Drawing.Bitmap(new MemoryStream(data.Data)))
            {
               System.Drawing.Rectangle drawingRect = new System.Drawing.Rectangle(0, 0, bitmap.Width, bitmap.Height);

               if (bitmap.Width > cellRect.Width || bitmap.Height > cellRect.Height)
               {
                  var bmpRatio = (double)Math.Max(bitmap.Width, bitmap.Height) / (double)Math.Min(bitmap.Width, bitmap.Height);

                  double newRectHeight;
                  double newRectWidth;

                  if (cellRect.Width > cellRect.Height)
                  {
                     newRectHeight = cellRect.Height;
                     newRectWidth = cellRect.Height * bmpRatio;
                  }
                  else
                  {
                     newRectHeight = cellRect.Width * bmpRatio;
                     newRectWidth = cellRect.Width;
                  }

                  drawingRect.Width = (int)newRectWidth;
                  drawingRect.Height = (int)newRectHeight;
               }

               drawingRect.X = cellRect.X + (cellRect.Width - drawingRect.Width) / 2;
               drawingRect.Y = cellRect.Y + (cellRect.Height - drawingRect.Height) / 2;

               g.DrawImage(bitmap, drawingRect);
            }
            base.OnDraw(g, cellRect, rowIndex, colIndex, style);
         }
      }
   }

}
