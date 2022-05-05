using System;
using System.Linq;
using CommonControls.Pages;
using UsersDb.DataContext;

namespace CustomersUI.Pages
{
    public partial class Account : BasePage
	{
		private User _user;
		protected readonly UsersDataContext context = new UsersDataContext();

		protected new User User => this._user ?? (this._user = this.context.GetUser(this.context.CurrentUserId));

        protected bool ShowRequestsHistory => User.SubscriptionRequests.Any();

        protected void Page_Init(object sender, EventArgs e)
		{
		    historyRequests.Visible = ShowRequestsHistory;
			userInfo.Entity = User;
			companyInfo.Entity = User.Company;
			
			historyRequests.Entities = _user.SubscriptionRequests.OrderByDescending(r => r.LastUpdate);
            userInfo.TimeZoneCode = 
                companyInfo.TimeZoneCode = 
                historyRequests.TimeZoneCode = _user.TimeZone.Code;
		}
	}
}