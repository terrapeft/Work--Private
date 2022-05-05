using System;
using System.Linq;
using System.Web.UI;
using Db;
using Statix.Controls.Search.Classes;

namespace Statix.Controls.Search
{
    public partial class _BindableDDL : UserControl, IFilterValue
    {
        public string EntitySet
        {
            set { ddlDataSource.EntitySetName = Global.DefaultModel
                .Tables
                .First(t => t.EntityType.Name.Equals(value, StringComparison.InvariantCultureIgnoreCase))
                .Name; }
        }

        public string Select
        {
            set { ddlDataSource.Select = value; }
        }

        public string Where
        {
            set { ddlDataSource.Where = value; }
        }

        public string OrderBy
        {
            set { ddlDataSource.OrderBy = value; }
        }

        public string Value
        {
            get { return dropDownList1.SelectedValue; }
            set { dropDownList1.SelectedValue = value; }
        }

        public string DataTextField
        {
            set { dropDownList1.DataTextField = value; }
        }

        public string DataValueField
        {
            set { dropDownList1.DataValueField = value; }
        }

        public TypeCode Type { get; set; }

        protected void Page_Load(object sender, EventArgs e)
        {
            ddlDataSource.ContextType = typeof(StatixEntities);
        }

        public void Clear()
        {
            dropDownList1.ClearSelection();
        }
    }
}