using System;
using System.Web.UI;
using Statix.Controls.Search.Classes;

namespace Statix.Controls.Search
{
    public partial class _GreaterOrLessDDL : UserControl, IOperator
    {
        public string ForcedValue { get; set; }

        public string Value
        {
            get
            {
                var val = string.IsNullOrEmpty(ForcedValue) ? dropDownList1.SelectedItem.Value.ToLower() : ForcedValue.ToLower();
                switch (val)
                {
                    case "greaterorequals":
                        return ">= @{0}";
                    case "greater than":
                        return "> @{0}";
                    case "less than":
                        return "< @{0}";
                    case "equals":
                        return "= @{0}";
                    case "not equals":
                        return "!= @{0}";
                    default:
                        return null;
                }; ;
            }
            set { dropDownList1.SelectedValue = value; }
        }

        public void Clear()
        {
            dropDownList1.ClearSelection();
        }
    }
}