using System.Web.UI;
using Statix.Controls.Search.Classes;

namespace Statix.Controls.Search
{
    public partial class _ContainsDDL : UserControl, IOperator
    {
        public string Value
        {
            get
            {
                switch (dropDownList1.SelectedItem.Value.ToLower())
                {
                    case "contains":
                        return "LIKE '%' + @{0} + '%'";
                    case "not contains":
                        return "NOT LIKE '%' + @{0} + '%'";
                    case "equals":
                        return "= @{0}";
                    case "not equals":
                        return "!= @{0}";
                    default:
                        return null;
                };
            }

            set { dropDownList1.SelectedValue = value; }
        }

        public void Clear()
        {
            dropDownList1.ClearSelection();
        }
    }
}