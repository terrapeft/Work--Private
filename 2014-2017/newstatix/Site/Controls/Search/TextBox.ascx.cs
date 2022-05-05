using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Statix.Controls.Search.Classes;

namespace Statix.Controls.Search
{
    public partial class _TextBox : UserControl, IFilterValue
    {
        private TypeCode typeCode = TypeCode.String;

        public string Value
        {
            get { return textBox1.Text; }
        }

        public TypeCode Type
        {
            get { return typeCode; }
            set { typeCode = value; }
        }

        public void Clear()
        {
            textBox1.Text = string.Empty;
        }
    }
}