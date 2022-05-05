using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.DynamicData;
using System.Web.UI;
using System.Web.UI.WebControls;
using UsersDb.DataContext;

namespace UsersUI.DynamicData.Filters
{
    public partial class UserRoleFilter : QueryableFilterUserControl
    {
        private const string AllValueString = "All";

        private new MetaChildrenColumn Column
        {
            get
            {
                return (MetaChildrenColumn)base.Column;
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (DropDownList1.Items.Count == 0)
            {
                using (var dc = new UsersDataContext())
                {
                    var roles = dc.Roles
                        .ToList() // avoid "Only parameterless constructors and initializers are supported in LINQ to Entities" error
                        .OrderBy(r => r.Name)
                        .Select(r => new KeyValuePair<int?, string>(r.Id, r.Name))
                        .ToList();

                    roles.Insert(0, new KeyValuePair<int?, string>(null, AllValueString));

                    DropDownList1.DataSource = roles;
                    DropDownList1.DataTextField = "Value";
                    DropDownList1.DataValueField = "Key";
                    DropDownList1.DataBind();
                }
            }
        }

        protected void DropDownList1_SelectedIndexChanged(object sender, EventArgs e)
        {
            OnFilterChanged();
        }

        public override IQueryable GetQueryable(IQueryable source)
        {
            var selectedValue = DropDownList1.SelectedValue;
            if (!string.IsNullOrEmpty(selectedValue))
            {
                var id = int.Parse(selectedValue);
                var src = source as IQueryable<User>;
                if (src != null)
                {
                    return src.Where(u => u.Roles.Where(r => !r.IsDeleted).Any(r => r.Id == id));
                }
            }

            return source;
        }
    }
}