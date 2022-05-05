using System;
using System.IO;
using System.Linq;
using System.Net.Mail;
using System.Text;
using Quartz.Util;
using SharedLibrary.SmtpClient;
using SpansLib.Data;
using SpansLib.Db;

namespace SpansLib
{
    public class Supervisor
    {
        /// <summary>
        /// Runs the analyzis of jobs' logs and errors.
        /// Sends email with results
        /// </summary>
        /// <param name="connStr">The connection string.</param>
        /// <param name="hours">The hours.</param>
        /// <param name="logBuilder">The log builder.</param>
        public static void Run(string connStr, int hours, StringBuilder logBuilder)
        {
            var en = SpansEntities.GetInstance();
            var date = DateTime.UtcNow.AddHours(-hours);

            // load all required data from db
            var recentImportLogs = en.ImportLogs
                .Where(l => l.EndDateUtc != null && l.EndDateUtc >= date)
                .ToList();
            var recentErrors = en.Errors
                .Where(l => l.UpdatedUtc != null && l.UpdatedUtc >= date)
                .ToList();
            var missedFields = en.FindMissedElements()
                .ToList();

            // load templates from files
            var bodyTemplate = File.ReadAllText(AppSettings.BodyTemplate);
            var logItemTemplate = File.ReadAllText(AppSettings.LogItemTemplate);
            var errorItemTemplate = File.ReadAllText(AppSettings.ErrorItemTemplate);
            var missedFieldsTemplate = File.ReadAllText(AppSettings.MissedElementsTemplate);

            // create mail helper
            MailMessage message = null;
            var eh = new EmailHelper(AppSettings.SmtpHost, AppSettings.SmtpPort, AppSettings.EnableSsl, AppSettings.Password.TrimEmptyToNull());

            // concatenate log items using log item template
            var logText = recentImportLogs
                .Where(l => l.Trace != null && l.Trace.Trim().Length > 0)
                .Aggregate(new StringBuilder(), (k, v) => k.Append(
                    string.Format(logItemTemplate, v.Id, v.TriggerName, v.StartDateUtc.ToLocalTime(),
                        v.Trace.Replace(Environment.NewLine, Constants.HtmlNewLine),
                        ((TimeSpan)(v.EndDateUtc - v.StartDateUtc)).ToString("hh\\:mm\\:ss")
                    )));

            // concatenate error items using error item template
            var errText = recentErrors
                .Where(l => l.Information != null && l.Information.Trim().Length > 0)
                .Aggregate(new StringBuilder(), (k, v) => k.Append(
                    string.Format(errorItemTemplate, v.Id, v.FileName, v.UpdatedUtc.ToLocalTime(), v.Information.Replace(Environment.NewLine, Constants.HtmlNewLine))));

            // concatenate missed fields items using template
            var missedText = missedFields
                .Aggregate(new StringBuilder(), (k, v) => k.Append(
                    string.Format(missedFieldsTemplate, v.TableName)));

            // put it all together into the message using body template
            message = eh.ComposeMessage(AppSettings.Sender, AppSettings.Recipient,
                string.Format(recentErrors.Any() || missedFields.Any() ? AppSettings.SubjectTemplateFailed : AppSettings.SubjectTemplateSuccess, DateTime.Now),
                string.Format(bodyTemplate,
                    recentErrors.Count, errText,
                    recentImportLogs.Count, logText,
                    missedFields.Count, missedText));

            message.IsBodyHtml = true;

            eh.SendMail(message);
        }
    }
}
