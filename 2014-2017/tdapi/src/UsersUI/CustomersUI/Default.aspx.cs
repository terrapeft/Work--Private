using System;
using System.Data.Objects;
using System.Diagnostics;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using CustomersUI;
using CustomersUI.Trial;
using SharedLibrary;
using SharedLibrary.Passwords;
using UsersDb;
using UsersDb.DataContext;
using UsersDb.Helpers;

namespace UsersUI
{
    public partial class _Default : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            //Debugger.Launch();
            try
            {
                if (HttpContext.Current.User.Identity.IsAuthenticated)
                {
                    using (var dc = new UsersDataContext())
                    {
                        var user = dc.CurrentUser;
                        if (user != null)
                        {
                            var isTrial = user.Roles.Where(r => !r.IsDeleted).Any(r => r.Id == (int)UserRoles.TrialUser);

                            if (isTrial)
                            {
                                Global.RedirectToPage("/account");
                            }
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                Logger.LogError(ex);
            }
        }

        protected void OnCommand(object sender, CommandEventArgs e)
        {
            try
            {
                errorMessagePanel.Visible = false;
                infoPanel.Visible = false;

                using (var dc = new UsersDataContext())
                {
                    var hasUser = new ObjectParameter("hasUser", typeof(bool));
                    dc.spTrialCheckUsername(emailTextBox.Value, hasUser);
                    if ((bool)hasUser.Value)
                    {
                        ShowTrialError(Resources.Trial_Email_Exists);
                        return;
                    }
                }

                var subs = new TrialSubscription(nameTextBox.Value, emailTextBox.Value, companyTextBox.Value, phoneTextBox.Value);
                subs.StartTrial();

                infoPanel.Visible = true;
                infoText.InnerHtml = string.Format(Resources.Submit_Trial_Request_Success, nameTextBox.Value);

            }
            catch (Exception ex)
            {
                Logger.LogError(ex);
                ShowTrialError(ex);
            }
        }

        private void ShowTrialError(Exception ex)
        {
            ShowTrialError(Resources.Submit_Trial_Error);
        }

        private void ShowTrialError(string message)
        {
            errorMessagePanel.Visible = true;
            errorMessageText.InnerText = message;
        }
    }
}
