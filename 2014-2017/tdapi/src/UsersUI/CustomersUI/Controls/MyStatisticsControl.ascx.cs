using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.UI;
using System.Web.UI.WebControls;
using Newtonsoft.Json;
using SharedLibrary;
using Telerik.Web.UI;
using UsersDb;
using UsersDb.DataContext;
using UsersDb.Helpers;

namespace CustomersUI.Controls
{
    public partial class MyStatisticsControl : UserControl
    {
        private readonly UsersDataContext dc = new UsersDataContext();

        protected void Page_Load(object sender, EventArgs e)
        {
            radGrid1.DataSource = dc.UsageStats
                .Where(s => s.UserId == dc.CurrentUserId)
                .Where(s => s.MethodId != null && s.StatusId == (int)ActionStatus.Succeeded)
                .OrderByDescending(s => s.RequestDate)
                .ToList();
        }

        protected void radGrid1_OnItemDataBound(object sender, GridItemEventArgs e)
        {
            if (e.Item.ItemType == GridItemType.Item || e.Item.ItemType == GridItemType.AlternatingItem)
            {
                var item = e.Item as GridDataItem;
                if (item != null)
                {
                    var us = item.DataItem as UsageStat;
                    if (us != null)
                    {
                        // format json
                        var label = item.FindControl("parametersLabel") as Label;
                        var args = JsonConvert.DeserializeObject<List<StoredProcParameterJson>>(us.MethodArgs);
                        if (label != null)
                        {
                            label.Text = string.Join(string.Empty, args);
                        }

                        //utc to users local time
                        var dtl = item.FindControl("dateLabel") as Label;
                       
                        if (dtl != null)
                        {
                            dtl.Text = us.RequestDate.ToUserLocalDateTimeString(dc.CurrentUser.TimeZone.Code);
                        }
                    }
                }
            }
        }
    }
}