using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Jnj.Windows.Forms;

namespace Jnj.ThirdDimension.Controls.BarcodeSeries
{
   class ReservationTemplateGridBoundColumn : SimpleGridBoundColumn, ICustomGridColumn
   {
      public static readonly string CellType = "ReservationTemplateCell";

      public ReservationTemplateGridBoundColumn()
      {
         this.StyleInfo.CellType = ReservationTemplateGridBoundColumn.CellType;
      }

      public void RegisterColumn()
      {
         base.RegisterModel(this.StyleInfo.CellType, new ReservationTemplateCellModel(base.GridModel));
      }
   }
}
