using System;
using System.Web.DynamicData;
using System.Web.UI.WebControls;
using UsersDb;
using UsersUI.Helpers;

namespace UsersUI
{
	public partial class Insert : System.Web.UI.Page
	{
		protected MetaTable table;

		protected void Page_Init(object sender, EventArgs e)
		{
		    //var dataContext = new UsersDataContext();

		    //if (table.Name != dataContext.GetEntitySetName(typeof (IP)))
		    //{
		        Response.Redirect("/");
		        return;
		    //}

		    table = DynamicDataRouteHandler.GetRequestMetaTable(Context);

			if (table.IsReadOnly)
			{
				Response.Redirect(table.ListActionPath);
			}

			FormView1.SetMetaTable(table, table.GetColumnValuesFromRoute(Context));
			DetailsDataSource.EntityTypeFilter = table.EntityType.Name;
		}

		protected void Page_Load(object sender, EventArgs e)
		{
			Title = table.DisplayName;
		}

		protected void FormView1_ItemCommand(object sender, FormViewCommandEventArgs e)
		{
			if (e.CommandName == DataControlCommands.CancelCommandName)
			{
				Response.Redirect(table.ListActionPath);
			}
		}

		protected void FormView1_ItemInserted(object sender, FormViewInsertedEventArgs e)
		{
			if (e.Exception == null || e.ExceptionHandled)
			{
				Response.Redirect(table.ListActionPath);
			}
		}

	}
}
