using System;
using System.Web.UI;
using Statix.Controls.Search.Classes;

namespace Statix.Controls.Search
{
    public partial class _Calendar : UserControl, IFilterValue
    {
        private TypeCode typeCode = TypeCode.DateTime;

        public string Value
        {
            get { return string.IsNullOrWhiteSpace(dateTextBox.Value) ? null : dateTextBox.Value.Replace('/', '-'); }
        }

        public TypeCode Type
        {
            get { return typeCode; }
            set { typeCode = value; }
        }

        public void Clear()
        {
            dateTextBox.Value = string.Empty;
        }
    }
}