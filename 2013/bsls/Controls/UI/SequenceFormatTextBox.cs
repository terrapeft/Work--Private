using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Windows.Forms;

namespace Jnj.ThirdDimension.Controls.BarcodeSeries
{
   public class SequenceFormatTextBox : TextBox
   {
      public SequenceFormatTextBox()
      {
         KeyPress += HandleKeyPress;
         TextChanged += HandleTextChanged;
         
      }

      void HandleTextChanged(object sender, EventArgs e)
      {
         if (Text.Length == 0)
         {
            Text = "#";
         }
      }

      private void HandleKeyPress(object sender, KeyPressEventArgs e)
      {
         if (e.KeyChar != '#' && !char.IsControl(e.KeyChar)) e.Handled = true;
      }
   }
}
