using System;
using System.Web.DynamicData;
using System.Web.UI.WebControls;

namespace UsersUI
{
    public partial class Details : System.Web.UI.Page
    {
        protected MetaTable table;

        protected void Page_Init(object sender, EventArgs e)
        {
            table = DynamicDataRouteHandler.GetRequestMetaTable(Context);
            FormView1.SetMetaTable(table);
            DetailsDataSource.EntityTypeFilter = table.EntityType.Name;
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            Title = table.DisplayName;
            DetailsDataSource.Include = table.ForeignKeyColumnsNames;
            BreadcrumbControl1.Table = table;
            BreadcrumbControl1.DataBind();
        }

        protected void FormView1_ItemDeleted(object sender, FormViewDeletedEventArgs e)
        {
            if (e.Exception == null || e.ExceptionHandled)
            {
                Response.Redirect(table.ListActionPath);
            }
        }

        protected void FormView1_OnDataBound(object sender, EventArgs e)
        {
            if (FormView1.DataItem != null)
            {
                var editLink = (DynamicHyperLink)FormView1.FindControl("editLink");
                var deleteButton = (ImageButton)FormView1.FindControl("deleteButton");

                editLink.Visible = !table.IsReadOnly;
                deleteButton.Visible = !table.IsReadOnly;
            }
        }
    }
}
