using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Statix.Controls.Search.Classes;

namespace Statix.Controls.Search
{
    public partial class _Label : System.Web.UI.UserControl, IField
    {
        public string Value { get; set; }

        public string Text
        {
            set { label1.Text = value; }
        }

        public void Clear()
        {
            
        }
    }
}