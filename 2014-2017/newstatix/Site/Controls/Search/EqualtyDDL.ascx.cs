using System;
using Statix.Controls.Search.Classes;

namespace Statix.Controls.Search
{
    public partial class _EqualtyDDL : System.Web.UI.UserControl, IOperator
    {
        public string Value
        {
            get
            { 
                switch (dropDownList1.SelectedItem.Value.ToLower())
                {
                    case "equals":
                        return "= @{0}";
                    case "not equals":
                        return "!= @{0}";
                    default:
                        return null;
                }
            }
            set { dropDownList1.SelectedValue = value; }
        }

        public void Clear()
        {
            dropDownList1.ClearSelection();
        }
    }
}