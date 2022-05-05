using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SharedLibrary;
using SharedLibrary.Passwords;
using UsersDb;
using UsersDb.DataContext;

namespace CustomersUI.Pages
{
    public partial class VerifyEmail : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            var val = Request.QueryString["ud"];

            try
            {
                using (var dc = new UsersDataContext())
                {
                    var trial = dc.Trials.SingleOrDefault(c => c.VerificationCode.Equals(val));

                    if (trial == null)
                    {
                        throw new Exception("The verification code is invalid.");
                    }

                    if (trial.TrialStart == null)
                    {
                        var user = trial.User;
                        user.IsActive = true;
                        trial.TrialStart = DateTime.UtcNow;
                        trial.TrialEnd = trial.TrialStart.Value.AddDays(ServiceConfig.Trial_Period_In_Days);

                        trial.SubscriptionRequest.IsFulfilled = true;
                        trial.SubscriptionRequest.Accepted = true;

                        dc.SaveChanges();
                    }

                    Global.RedirectToPage(string.Format("/account?username={0}", trial.User.Username));
                }
            }
            catch (Exception ex)
            {
                errorMessagePanel.Visible = true;
                errorMessageText.InnerText = ex.Message;
            }
        }
    }
}