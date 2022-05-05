using System.Web.DynamicData;
using System.Web.UI;
using SharedLibrary.SmartScaffolding;
using SharedLibrary.SmartScaffolding.Attributes;

namespace UsersUI.Controls
{
    public partial class BreadcrumbControl : UserControl
    {
        public MetaTable Table { get; set; }
        public string Path { get; set; }

        public override void DataBind()
        {
            var cat = Table.Attributes.GetAttributeOrDefault<TableCategoryAttribute>().Category;
            var id = Request.QueryString["Id"];

            if (cat != null)
            {
                Path = cat + "&nbsp;/&nbsp;";
            }

            Path += (id == null) ? Table.DisplayName : string.Format("<a href=\"/{0}/List.aspx\">{1}</a>", Table.Name, Table.DisplayName);

            if (id != null)
            {
                Path += "&nbsp;/&nbsp;ID " + id;
            }
        }
    }
}