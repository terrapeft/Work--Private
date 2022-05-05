using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Windows.Forms;
using Syncfusion.Windows.Forms.Grid;

namespace Jnj.ThirdDimension.Utils.BarcodeSeries
{
   public class WizardHelper
   {
      public static readonly string USERNAME_SCHEMANAME_FOR_PLUGIN_TITLE_FORMAT2 = " - {0} - {1}";
      
      /// <summary>
      /// Sets the title of the dialog with user name and db name for currently logged in user
      /// </summary>
      /// <param name="currentTitle"></param>
      /// <param name="userName"></param>
      /// <param name="dbName"></param>
      /// <returns></returns>
      public static string SetTitle(string currentTitle, string userName, string dsn)
      {
         string val = ConnectionStringHelper.GetKey("(SERVICE_NAME=", ")", dsn.Replace(" ", "").ToUpper());

         string newTitle = currentTitle;
         string tail = String.Format(USERNAME_SCHEMANAME_FOR_PLUGIN_TITLE_FORMAT2, userName, val);
         if (!currentTitle.EndsWith(tail))
         {
            newTitle += tail;
         }
         return newTitle;
      }

      /// <summary>
      /// Gets Caption of the parent form and trims the tail with user name and database
      /// </summary>
      /// <param name="ctl"></param>
      /// <returns></returns>
      public static string FindParentHeaderText(Control ctl)
      {
         if (ctl is Form) return ctl.Text;

         Control parent = ctl.Parent;
         while (parent != null)
         {
            if (!String.IsNullOrEmpty(parent.Text))
            {
               string tailSign = USERNAME_SCHEMANAME_FOR_PLUGIN_TITLE_FORMAT2.Substring(0, USERNAME_SCHEMANAME_FOR_PLUGIN_TITLE_FORMAT2.IndexOf('{'));
               string caption = parent.Text;
               if (caption.IndexOf(tailSign) > -1)
               {
                  caption = caption.Substring(0, caption.IndexOf(tailSign));
               }

               return caption;
            }
            parent = parent.Parent;
         }
         return String.Empty;
      }

      /// <summary>
      /// Updates counter of GridRecordNavigationControl.
      /// </summary>
      /// <param name="grnc"></param>
      public static void UpdateGridNavigationLabel(GridRecordNavigationControl grnc)
      {
         if (grnc.CurrentRecord > grnc.MaxRecord)
         {
            grnc.MaxLabel = "*";
         }
         else
         {
            grnc.Label = (grnc.GridControl.Model.RowCount > 999) ? "Rec." : "Record";
            grnc.MaxLabel = "of " + (grnc.GridControl.Model.RowCount - ((grnc.AllowAddNew) ? 1 : 0));
         }
      }
   }
}
