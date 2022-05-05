using System;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations;
using System.Web.DynamicData;
using System.Web.Routing;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.Expressions;

namespace UsersUI
{
	public partial class Edit : System.Web.UI.Page
	{
		protected MetaTable table;

		protected void Page_Init(object sender, EventArgs e)
		{
			table = DynamicDataRouteHandler.GetRequestMetaTable(Context);
	
			if (table.IsReadOnly)
			{
				Response.Redirect(table.ListActionPath);
			}

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

		protected void FormView1_ItemCommand(object sender, FormViewCommandEventArgs e)
		{
			if (e.CommandName == DataControlCommands.CancelCommandName)
			{
				Response.Redirect(table.GetActionPath("Details") + "?Id=" + Request.QueryString["Id"]);
			}
		}

		protected void FormView1_ItemUpdated(object sender, FormViewUpdatedEventArgs e)
		{
			if (e.Exception == null || e.ExceptionHandled)
			{
				Response.Redirect(table.ListActionPath);
			}
		}

	}
}
