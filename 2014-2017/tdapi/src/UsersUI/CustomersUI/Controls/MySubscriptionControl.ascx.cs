using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using SharedLibrary.SmtpClient;
using UsersDb;
using UsersDb.DataContext;

namespace CustomersUI.Controls
{
    public partial class MySubscriptionControl : UserControl
    {

        #region Private members

        private readonly UsersDataContext dc = new UsersDataContext();

        #endregion


        #region Public properties

        public User User { get; set; }

        public IEnumerable<MethodGroup> RequestedToSubscribe
        {
            get
            {
                return packagesRepeater.Items
                    .Cast<RepeaterItem>()
                    .Select(ri => ri.FindControl("Checkbox1") as CheckBox)
                    .Where(chk => chk.Checked && chk.Enabled)
                    .Select(chk => Convert.ToInt32(chk.Attributes["value"]))
                    .Where(id => dc.CurrentUser.Subscriptions.All(mg => mg.MethodGroupId != id))
                    .Select(id => dc.MethodGroups.FirstOrDefault(m => m.Id == id));
            }
        }

        public IEnumerable<MethodGroup> RequestedToUnsubscribe
        {
            get
            {
                return packagesRepeater.Items
                    .Cast<RepeaterItem>()
                    .Select(ri => ri.FindControl("Checkbox1") as CheckBox)
                    .Where(chk => !chk.Checked && chk.Enabled)
                    .Select(chk => Convert.ToInt32(chk.Attributes["value"]))
                    .Where(id => dc.CurrentUser.Subscriptions.Any(mg => mg.MethodGroupId == id))
                    .Select(id => dc.MethodGroups.FirstOrDefault(m => m.Id == id));
            }
        }

        public IEnumerable<dynamic> DataSource
        {
            get
            {
                return dc.MethodGroups
                    .Where(g => !g.IsDeleted)
                    .Where(g => !g.Shared && !g.IsTrial);
            }
        }

        #endregion


        #region Event handlers

        protected void Page_Load(object sender, EventArgs e)
        {
            var sm = ScriptManager.GetCurrent(Page);
            if (sm != null)
            {
                sm.RegisterPostBackControl(saveButtonTop);
            }

            User = dc.GetUser(dc.CurrentUserId);

            multiView1.SetActiveView(listPackagesView);

            if (!IsPostBack)
            {
                packagesRepeater.DataSource = DataSource;
                packagesRepeater.DataBind();

                Bind();
            }
        }

        protected void saveButton_OnClick(object sender, EventArgs e)
        {
            var requestedGroups = RequestedToSubscribe.ToList();
            var releasedGroups = RequestedToUnsubscribe.ToList();

            if (requestedGroups.Count > 0)
            {
                var request = new SubscriptionRequest
                {
                    LastUpdate = DateTime.UtcNow,
                    UserId = dc.CurrentUserId,
                    IsFulfilled = false,
                    Notify = notifyCheckBox.Checked,
                    RequestTypeId = (int)SubscriptionRequestTypes.Add
                };

                requestedGroups.ForEach(mg => request.MethodGroups.Add(mg));

                dc.SubscriptionRequests.AddObject(request);
                multiView1.SetActiveView(afterSubmitView);
            }

            if (releasedGroups.Count > 0)
            {
                var request = new SubscriptionRequest
                {
                    LastUpdate = DateTime.UtcNow,
                    UserId = dc.CurrentUserId,
                    Notify = notifyCheckBox.Checked,
                    IsFulfilled = false,
                    RequestTypeId = (int)SubscriptionRequestTypes.Remove
                };

                releasedGroups.ForEach(mg => request.MethodGroups.Add(mg));

                dc.SubscriptionRequests.AddObject(request);
                multiView1.SetActiveView(afterSubmitView);
            }

            dc.SaveChanges();

            Bind();

            var eh = new EmailHelper(ServiceConfig.Smtp_Host, ServiceConfig.Smtp_Port, ServiceConfig.Enable_SSL);
            var message = eh.ComposeMessage(ServiceConfig.Smtp_Sender, ServiceConfig.Smtp_Recipients,
                ServiceConfig.Subscription_Request_Subject,
                ServiceConfig.Subscription_Request_Body);

            eh.SendMailAsync(message);
        }

        #endregion


        #region Private methods

        private void Bind()
        {
            // subscribed groups
            var ids = User
                .Subscriptions
                .Select(s => s.MethodGroupId)
                .ToList();
            SelectItemsByValue(ids);

            // requested groups
            ids = User.SubscriptionRequests
                .Where(r => !r.IsFulfilled)
                .SelectMany(r => r.MethodGroups.Select(g => g.Id))
                .ToList();
            DisableItemsByValue(ids);

            saveButtonTop.Text = "Send request";
            saveButtonTop.ToolTip = "Request checked items to be added to your subscription.";
        }

        private void DisableItemsByValue(List<int> values)
        {
            var list = packagesRepeater.Items
                .Cast<RepeaterItem>()
                .Select(ri => ri.FindControl("Checkbox1") as CheckBox);

            foreach (var item in values.SelectMany(value => list.Where(chk => chk.Attributes["value"] == value.ToString())))
            {
                item.Checked = true;
                item.Enabled = false;
            }

        }

        private void SelectItemsByValue(List<int> values)
        {
            var list = packagesRepeater.Items
                .Cast<RepeaterItem>()
                .Select(ri => ri.FindControl("Checkbox1") as CheckBox);

            foreach (var item in values.SelectMany(value => list.Where(chk => chk.Attributes["value"] == value.ToString())))
            {
                item.Checked = true;
            }
        }

        #endregion

        protected void packagesRepeater_OnItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                var div = e.Item.FindControl("methodsDiv") as HtmlGenericControl;
                var mg = e.Item.DataItem as MethodGroup;
                if (div != null && mg != null)
                {
                    div.InnerHtml = mg.MethodsStringified;
                }
            }
        }
    }
}