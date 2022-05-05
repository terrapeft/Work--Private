using System;
using System.Collections.Generic;
using System.Linq;
using System.ServiceModel.Web;
using System.Web.UI.WebControls;
using UsersDb.Code;
using UsersDb.DataContext;

namespace UsersUI.Controls
{
	using System.Data;
    using System.Web.UI;
	using System.Web.UI.HtmlControls;
    using System.Xml.Xsl;


    using UsersDb;
	using UsersDb.Helpers;

	using InformersControls.Footers;
	using Helpers;

	public partial class Informers : System.Web.UI.UserControl
	{
		private DbHelper dbHelper;

		protected void Page_Load(object sender, EventArgs e)
		{
			dbHelper = new DbHelper(Config.UsersConnectionString);
			dbHelper.Connection.Open();

			repeaterDataSource.Where = "it.UserId is null or it.UserId = " + new UsersDataContext().CurrentUserId;
		}

		protected void repeater_ItemDataBound(object sender, RepeaterItemEventArgs e)
		{
			if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
			{
				var di = (Informer)e.Item.DataItem;
				var ctx = (Xml)e.Item.FindControl("contentXml");
				var args = new XsltArgumentList();

				var dc = new UsersDataContext();
                var spname = dc.Methods
                    .FirstOrDefault(m => m.Id == di.ContentProviderId)
                    .Name
                    .Replace(WorkingDatabase.Instance.GetStoredProcMethodPrefix(), WorkingDatabase.Instance.GetStoredProcInformerPrefix());

				if (di.XsltParameters != null)
				{
					var @params = XsltHelper.SplitXsltParameters(di.XsltParameters);

					if (@params.Any())
					{
						foreach (var pair in @params)
						{
							args.AddParam(pair.Key, "", pair.Value);
						}
					}
				}

				ctx.TransformArgumentList = args;

				if (dbHelper != null)
				{
                    var ds = dbHelper.CallStoredProcedure(spname, WorkingDatabase.Instance.GetStoredProcParamPrefix(), new Dictionary<string, object>());

					ctx.DocumentContent = ds.GetXml();
					ctx.TransformSource = "~/Content/Xslt/Informers/" + di.Xslt;
				}

				if (di.ShowFooter)
				{
					var method = dc.Methods.FirstOrDefault(m => m.Id == di.ContentProviderId);

					var footer = (HtmlGenericControl)e.Item.FindControl("footerDiv");
					footer.Visible = di.ShowFooter;
					footer.Attributes.Add("style", di.FooterStyle);
					footer.Style.Add("background-color", di.FooterColor);

					var footerCtl = (ErrorResults)Page.LoadControl("~/Controls/InformersControls/Footers/ErrorResults.ascx");
					if (method != null) 
					{
						footerCtl.AppName = method.Name.Equals("GetCUIErrors", StringComparison.InvariantCultureIgnoreCase)
									? "CustomersUI"
									: method.Name.Equals("GetAUIErrors", StringComparison.InvariantCultureIgnoreCase) ? "AdministrativeUI" : "WebAPI";

					    if (method.Name.Equals("GetAPIFailedCalls", StringComparison.InvariantCultureIgnoreCase)
                            || method.Name.Equals("GetAPIErrors", StringComparison.InvariantCultureIgnoreCase))
					    {
					        footerCtl.ExceptionType = Uri.EscapeDataString(typeof (WebFaultException).ToString());
                            footerCtl.Include = method.Name.Equals("GetAPIFailedCalls", StringComparison.InvariantCultureIgnoreCase);
					    }
					}
					
					footer.Controls.Add(footerCtl);
				}
			}
		}

		protected void cancelChangesButton_OnClick(object sender, ImageClickEventArgs e)
		{
			this.DataBind();
		}

		protected void Page_Unload(EventArgs e)
		{
			if (dbHelper != null && dbHelper.Connection.State == ConnectionState.Open)
			{
				dbHelper.Connection.Close();
			}
		}
	}
}