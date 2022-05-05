using System;
using System.Web.UI.WebControls;

namespace Statix.Controls.Search.Classes
{
    public class SearchRadioButtonList : RadioButtonList, IFilterValue
    {
        private TypeCode typeCode = TypeCode.String;

        public RadionButtonListMode Mode { get; set; }

        public string Value
        {
            get
            {
                return SelectedItem == null ? null : SelectedItem.Value;
            }
        }

        public void Clear()
        {
            ClearSelection();
        }

        public TypeCode Type
        {
            get
            {
                return Mode == RadionButtonListMode.FieldValue
                    ? typeCode
                    : Mode == RadionButtonListMode.CompareWithToday
                        ? TypeCode.DateTime
                    : TypeCode.String;
            }
            set { typeCode = value; }
        }
    }
}