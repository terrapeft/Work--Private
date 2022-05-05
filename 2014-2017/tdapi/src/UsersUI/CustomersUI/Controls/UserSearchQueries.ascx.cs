using System;
using System.Linq;
using System.Web.UI;
using System.Web.UI.WebControls;
using UsersDb.DataContext;
using UsersDb.Helpers;
using Action = System.Action;

namespace CustomersUI.Controls
{
    public partial class UserSearchQueries : UserControl
    {
        public Action LoadQueryRequest;
        public Action DeleteQueryRequest;

        public int QueryId;

        protected void restoreQueryLink_OnCommand(object sender, CommandEventArgs e)
        {
            try
            {
                //Session[Constants.CurrentUserQueryCacheKey] = null;
                QueryId = Convert.ToInt32(e.CommandArgument);
                LoadQueryRequest.Invoke();
            }
            catch (Exception ex)
            {
                Logger.LogError(ex);
            }
        }

        public void Rebind()
        {
            radGrid1.Rebind();
        }

        protected void queryDataSource_OnQueryCreated(object sender, QueryCreatedEventArgs e)
        {
            var queries = e.Query.Cast<UserSearchQuery>();
            e.Query = queries.Where(q => q.UserId == UsersDataContext.CurrentSessionUser.Id);
        }
    }
}