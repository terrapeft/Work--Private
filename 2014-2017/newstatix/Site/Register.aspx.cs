using System;
using System.Net;
using System.Net.Mail;
using System.ServiceModel.Web;
using System.Web.Services.Description;
using Db;
using Db.Helpers;
using SharedLibrary.Elmah;
using SharedLibrary.IPAddress;
using SharedLibrary.SmtpClient;

namespace Statix
{
    public partial class _Register : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs args)
        {
            try
            {
                Page.Form.DefaultFocus = txtUserName.ClientID;
                WebActivityLogger.Write(Request, Page.Theme);
            }
            catch (Exception ex)
            {
                Logger.LogError(ex, true);
            }
        }

        protected void btnSubmit_OnClick(object sender, EventArgs e)
        {
            try
            {
                var errMsg = string.IsNullOrWhiteSpace(txtUserName.Text) ? Resources.Name_Field_Empty : string.Empty;
                errMsg += string.IsNullOrWhiteSpace(txtUserEmail.Text) ? Resources.Email_Field_Empty : string.Empty;

                if (!string.IsNullOrWhiteSpace(txtUserEmail.Text))
                {
                    errMsg += !IsValidEmail(txtUserEmail.Text) ? Resources.Invalid_Email : string.Empty;
                }

                if (errMsg.Length > 0)
                {
                    throw new Exception(errMsg);
                }

                var eh = new EmailHelper(ServiceConfig.Smtp_Host, ServiceConfig.Smtp_Port, ServiceConfig.Enable_SSL);
                var message = eh.ComposeMessage(Resources.Reg_Email_Sender, Resources.Reg_Email_Recipient,
                     string.Format(Resources.Reg_Email_Subject, txtUserName.Text, txtUserEmail.Text),
                     string.Format(Resources.Reg_Email_Body, txtUserName.Text, txtUserEmail.Text));
                
                eh.SendMail(message);

                confirmationLabel.Visible = true;
                confirmationLabel.Text = Resources.Reg_Email_Confirmation_Message;
            }
            catch (Exception ex)
            {
                Logger.LogError(ex, true);
                
                confirmationLabel.Visible = true;
                confirmationLabel.Text = string.Format(Resources.Reg_Email_Error_Message, ex.Message);
            }
        }

        private bool IsValidEmail(string address)
        {
            try
            {
                new MailAddress(address);
                return true;
            }
            catch (Exception)
            {
                return false;
            }
        }
    }
}
