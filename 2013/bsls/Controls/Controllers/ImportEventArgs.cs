using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;

namespace Jnj.ThirdDimension.Controls.BarcodeSeries
{
   /// <summary>
   /// Arguments for <see cref="ImportRequest">ImportRequest</see> event
   /// </summary>
   public class ImportEventArgs : EventArgs
   {
      private bool cancel = true;

      /// <summary>
      /// Table containing data from 3DX table, with column names matched 3DX Table headers
      /// </summary>
      public DataTable Table { get; set; }

      /// <summary>
      /// Specifies that that import should be done from the file
      /// </summary>
      public bool IsFileImport { get; set; }

      /// <summary>
      /// Specifies if a user cancels the import process
      /// </summary>
      public bool Cancel
      {
         get { return cancel; }
         set { cancel = value; }
      }

      /// <summary>
      /// Specifies the source file in case <see cref="IsFileImport">IsFileImport</see> is true
      /// </summary>
      public string FileName { get; set; }

      /// <summary>
      /// Array of column headers of destination grid
      /// </summary>
      public string[] CurrentColumnsNames { get; set; }

      /// <summary>
      /// The list of columns which must have matching column or specified default
      /// </summary>
      public string[] MandatoryColumnsNames { get; set; }

   }
}
