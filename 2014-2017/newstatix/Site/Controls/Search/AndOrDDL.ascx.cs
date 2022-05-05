using System;
using System.Web.UI;
using Statix.Controls.Search.Classes;

namespace Statix.Controls.Search
{
    public partial class _AndOrDDL : UserControl, IConcatenator
    {
        public string Value
        {
            get {

                // compare to what is expected, to prevent unexpected values
                return dropDownList1.SelectedValue == "and" 
                    ? "AND" : dropDownList1.SelectedValue == "or" 
                        ? "OR" 
                        : null; 
            }
            set { dropDownList1.SelectedValue = value; }
        }

        public void Clear()
        {
            dropDownList1.ClearSelection();
        }
    }
}