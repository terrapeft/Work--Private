using System;
using System.Net;
using System.Net.Mail;
using System.Text;
using System.Threading.Tasks;
using SharedLibrary.Elmah;

namespace SharedLibrary.SmtpClient
{
    /// <summary>
    /// Helper for email handling.
    /// </summary>
    public class EmailHelper
    {
        private readonly string _host;
        private readonly int _port;
        private readonly bool _enableSsl;
        private readonly string _password;

        /// <summary>
        /// Initializes a new instance of the <see cref="EmailHelper"/> class.
        /// </summary>
        /// <param name="host">The host.</param>
        /// <param name="port">The port.</param>
        /// <param name="enableSsl">Enable SSL.</param>
        /// <param name="password">The password.</param>
        public EmailHelper(string host, int port, bool enableSsl, string password = null)
        {
            _host = host;
            _port = port;
            _enableSsl = enableSsl;
            _password = password;
        }

        /// <summary>
        /// Sends the mail.
        /// </summary>
        /// <param name="message">The message.</param>
        public void SendMail(MailMessage message)
        {
            var client = new System.Net.Mail.SmtpClient
            {
                Host = _host,
                Port = _port,
                UseDefaultCredentials = string.IsNullOrWhiteSpace(_password),
                DeliveryMethod = SmtpDeliveryMethod.Network,
                EnableSsl = _enableSsl
            };

            if (!client.UseDefaultCredentials)
                client.Credentials = new NetworkCredential(message.From.Address, _password);

            client.Send(message);
        }

        /// <summary>
        /// Builds the message.
        /// </summary>
        /// <param name="recipients">The recipients.</param>
        /// <param name="subject">The subject.</param>
        /// <param name="body">The body.</param>
        /// <returns></returns>
        public MailMessage ComposeMessage(string sender, string recipients, string subject, string body)
        {
            return new MailMessage(sender, recipients, subject, body)
            {
                BodyEncoding = Encoding.UTF8,
                DeliveryNotificationOptions = DeliveryNotificationOptions.OnFailure
            };
        }

        /// <summary>
        /// Sends mail in a parallel thread.
        /// </summary>
        /// <param name="message">The message.</param>
        public void SendMailAsync(MailMessage message)
        {
            Task.Factory.StartNew(() =>
            {
                try
                {
                    SendMail(message);
                }
                catch (Exception ex)
                {
                    Logger.LogError(ex);
                }

            });

            Task.WaitAll();
        }
    }
}