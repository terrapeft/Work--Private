using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using Telerik.Web.UI;

namespace FowTradeDataU.umbraco.CustomWebForms
{
    public partial class TDErrors : BaseCustomPage
    {
        protected void Page_Init(object sender, EventArgs e)
        {
            Grid = requestsGrid;
        }

        protected void Grid_OnNeedDataSource(object sender, GridNeedDataSourceEventArgs e)
        {
            try
            {
                Grid.DataSource = LoadTable(AppSettings.BackEnd_DataSource_Errors);
            }
            catch (Exception ex)
            {
                SharedLibrary.Elmah.Logger.LogError(ex);

                var msg = new HtmlGenericControl()
                {
                    InnerHtml = string.Format(AlertTemplate, "Failed to load source data. Reason: ", ex.Message)
                };

                Grid.Controls.Add(msg);
            }
        }
    }
}