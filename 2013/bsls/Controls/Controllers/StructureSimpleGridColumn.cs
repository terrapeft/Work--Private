#region Copyright (C) 1994-2011, Johnson & Johnson PRD, LLC.
//---------------------------------------------------------------------------*
//
//    PictureSimpleGridColumn.cs: Editable structure column, which allows to 
//                                use a molecule sketcher in edit mode.
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

namespace Jnj.ThirdDimension.Controls.BarcodeSeries
{
   
   /// <summary>
   /// Editable structure column, which allows to use a molecule sketcher in edit mode.
   /// </summary>
   public class StructureSimpleGridColumn : SimpleGridBoundColumn, ICustomGridColumn
   {
      public static readonly string CellType = "StructureCell";

      public StructureSimpleGridColumn()
      {
         this.StyleInfo.CellType = StructureSimpleGridColumn.CellType;
      }

      public void RegisterColumn()
      {
         StructureCellModel.DefaultHeight = 22;
         StructureCellModel.DefaultWidth = 50;
         base.RegisterModel(this.StyleInfo.CellType, new StructureCellModel2(base.GridModel));
      }


   }

   /// <summary>
   /// Cell model.
   /// </summary>
   public class StructureCellModel2 : StructureCellModel
   {
      public StructureCellModel2(GridModel gridModel)
         : base(gridModel)
      {
      }

      public override GridCellRendererBase CreateRenderer(GridControlBase control)
      {
         return new StructureCellRenderer2(control, this);
      }
   }

   /// <summary>
   /// Cell renderer with sketcher in edit mode.
   /// </summary>
   public class StructureCellRenderer2 : StructureCellRenderer
   {

      /// <summary>
      /// 
      /// </summary>
      /// <param name="grid"></param>
      /// <param name="cellModel"></param>
      public StructureCellRenderer2(GridControlBase grid, StructureCellModel2 cellModel)
         : base(grid, cellModel)
      {
      }

      /// <summary>
      /// 
      /// </summary>
      /// <param name="rowIndex"></param>
      /// <param name="colIndex"></param>
      /// <param name="e"></param>
      protected override void OnDoubleClick(int rowIndex, int colIndex, MouseEventArgs e)
      {
         this.EditStructure();
      }

      /// <summary>
      /// 
      /// </summary>
      /// <param name="style"></param>
      /// <returns></returns>
      private Molecule RetrieveMolecule(GridStyleInfo style)
      {
         if (style.CellValue is String)
         {
            return new Molecule((string)style.CellValue);
         }
         return null;
      }

      /// <summary>
      /// 
      /// </summary>
      private void EditStructure()
      {
         if (!base.CurrentCell.HasCurrentCell)
         {
            return;
         }
         GridStyleInfo style = base.Grid.Model[base.CurrentCell.RowIndex, base.CurrentCell.ColIndex];
         Molecule data = RetrieveMolecule(style);
         using (SketcherDialog dialog = new SketcherDialog())
         {
            dialog.TheSketcher.EditingMode = SketcherEditingMode.ValidMolecule;
            dialog.TheSketcher.Settings.AutoSwitchToBondTool = true;
            dialog.TheSketcher.Settings.AutoSwitchToPrevTool = false;

            if (data != null)
            {
               try
               {
                  dialog.TheSketcher.BinaryEncodedMolecule = data.BinaryEncoded;
               }
               catch (Exception)
               {
               }
            }

         TryAgain:

            if ((dialog.ShowDialog((Form)Jnj.ThirdDimension.Explorer.ExplorerUtils.Explorer) != DialogResult.OK))
            {
               return;
            }

            Molecule molecule2 = new Molecule();
            molecule2.BinaryEncoded = dialog.TheSketcher.BinaryEncodedMolecule;
            data = molecule2;
            if (data.IsEmpty)
            {
               data = null;
            }
            else if (!data.IsValid)
            {
               switch (ConfirmationDialog.Show("The structure is invalid/corrupt. Exit without saving?", "Error", MessageBoxButtons.YesNo, MessageBoxIcon.Question))
               {
                  case DialogResult.Yes:
                     goto Exit;

                  case DialogResult.No:
                     goto TryAgain;

                  case DialogResult.Cancel:
                     return;
               }

            }
            style.CellValue = molecule2.Smiles;
         }

      Exit:
         return;
      }
   }
}
