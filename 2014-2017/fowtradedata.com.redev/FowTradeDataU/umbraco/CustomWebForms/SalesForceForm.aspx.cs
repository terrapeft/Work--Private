using System;
using System.Collections.Generic;
using System.Collections.Specialized;
using System.IO;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Net.Mail;
using System.Text;
using System.Web;
using System.Web.Security;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using SharedLibrary.Common;
using SharedLibrary.Elmah;
using SharedLibrary.SmtpClient;
using TDUmbracoMembership;

namespace FowTradeDataU.umbraco.CustomWebForms
{
    public partial class SalesForceForm : Page
    {
        private UmbracoMembersEntities _dc;
        private MembershipUser _currentUser;
        private string _attIds = string.Empty;

        #region Public properties

        public UmbracoMembersEntities DataContext
        {
            get { return _dc ?? (_dc = new UmbracoMembersEntities()); }
        }

        public MembershipUser CurrentUser
        {
            get { return _currentUser ?? (_currentUser = HttpContext.Current.Session["CurrentUser"] as MembershipUser); }
        }

        public string QueryTypesJson
        {
            get
            {
                var queryTypes = DataContext.HierarchicalDdls
                    .Where(q => q.Parent == null)
                    .ToList();

                var sb = new StringBuilder("{");

                for (var j = 0; j < queryTypes.Count; j++)
                {
                    var q = queryTypes[j];
                    PrintElement(sb, q, 1, j == queryTypes.Count - 1);
                }

                sb.Append("}");
                return sb.ToString();
            }
        }

        public string CurrentUserName
        {
            get { return CurrentUser == null ? string.Empty : CurrentUser.UserName; }
        }

        public string CurrentUserEmail
        {
            get { return CurrentUser == null ? string.Empty : CurrentUser.ProviderUserKey.ToString(); }
        }

        #endregion

        #region Handle request length error
        protected override void OnError(EventArgs e)
        {
            var err = Server.GetLastError();
            if (err is HttpException)
            {
                if ((err as HttpException).WebEventCode == 3004)
                {
                    // especially for the attachemnts size exceeding
                    // transfer or there will be an error page shown
                    Server.Transfer(Context.Request.Url.LocalPath + "?3004");
                }
            }

            base.OnError(e);
        }

        #endregion

        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                // not authenticated
                if (CurrentUser == null)
                {
                    Response.Clear();
                    Header.Controls.Add(new LiteralControl(@"
                                            <script type='text/javascript'>
                                                top.location = '/login';
                                                parent.location = '/login';
                                            </script>
                                        "));

                    salesForceForm.Visible = false;
                    return;
                }

                // check for the 'Maximum request length exceeded' exception
                if (Request.QueryString.Count > 0 && Request.QueryString[0] == "3004")
                {
                    fileError.Visible = true;
                    fileInput.Attributes["class"] = fileInput.Attributes["class"] + " has-error";
                }

                // this is a ddl with dynamic name, configured via the web.config
                impact.ID = AppSettings.SalesForce_Impact_Name;
                impact.Name = AppSettings.SalesForce_Impact_Name;

                // bind server controls
                if (!IsPostBack)
                {
                    BindList(priority, DataContext.DdlOptions.Where(d => d.DropDownListId == (int)DdlTypes.Priority));
                    BindList(impact, DataContext.DdlOptions.Where(d => d.DropDownListId == (int)DdlTypes.Impact));
                }
                else // save the posted request
                {
                    // gather the form keys except __viewstate[..] and empty ones.
                    var keys = Request.Form.AllKeys
                        .Where(k => !k.StartsWith("__") && !k.StartsWith(submitButton.Name))
                        .Select(k => new KeyValuePair<string, string>(k, Request.Form[k]))
                        .Where(p => !string.IsNullOrEmpty(p.Value))
                        .ToList();

                    // save the request to DB, get the ID back
                    var request = LogRequest(keys);

                    if (request != null)
                    {
                        // save files
                        var company = "Default";
                        var member = DataContext.Members.FirstOrDefault(m => m.Username == CurrentUser.ProviderUserKey.ToString());
                        if (member != null)
                        {
                            company = member.Company.Name;
                        }

                        string path;
                        var files = SaveFiles(request.Id, company, out path);

                        if (!string.IsNullOrEmpty(files))
                        {
                            // update the keys with attachemnt ID, this goes to the SalesForce
                            keys.Add(new KeyValuePair<string, string>(AppSettings.SalesForce_Form_AttachmentId_Name, request.Id.ToString()));
                        }

                        // post the form to the SalesForce, grab the server response
                        string result;
                        var success = PostToSalesForce(keys, out result);

                        // update request locally with files path and form posting response
                        var h = DataContext.SupportRequestsHistories.FirstOrDefault(i => i.Id == request.Id);
                        if (h != null)
                        {
                            h.RequestFiles = files;
                            h.SalesForcePostResult = result;

                            DataContext.SaveChanges();
                        }

                        // send email to Admin only if there are attachments
                        if (!string.IsNullOrEmpty(files))
                        {
                            SendMail(request, path);
                        }

                        // collapse the request form, notify user of status
                        var message = success ? subject.Value : SiteConfig.SF_Form_Failed;
                        var status = success ? "Success" : "Error";
                        ScriptManager.RegisterStartupScript(this,
                            this.GetType(),
                            "PostPOST",
                            string.Format("SwitchPanels('{0}', '{1}');", status, HttpUtility.JavaScriptStringEncode(message)),
                            true);
                    }
                }
            }
            catch (Exception ex)
            {
                Logger.LogError(ex);

                ScriptManager.RegisterStartupScript(this,
                    this.GetType(),
                    "ErrorNotification",
                    string.Format("SwitchPanels('Error', '{0}');", HttpUtility.JavaScriptStringEncode(SiteConfig.SF_Form_Failed)),
                    true);
            }
        }

        /// <summary>
        /// Sends the notification email about new support request.
        /// </summary>
        /// <param name="request">The request.</param>
        /// <param name="path">The path.</param>
        private void SendMail(SupportRequestsHistory request, string path)
        {
            var eh = new EmailHelper(
                SiteConfig.Smtp_Host_NoCache,
                SiteConfig.Smtp_Port_NoCache,
                SiteConfig.Smtp_Enable_SSL_NoCache,
                SiteConfig.Smtp_Password_NoCache);

            var requestData = BuildRequestForm(request);

            var msg = eh.ComposeMessage(
                SiteConfig.Smtp_Sender_NoCache,
                SiteConfig.Smtp_Recipients_NoCache,
                string.Format(SiteConfig.Smtp_Notification_Email_Subject_NoCache, request.GetFormValue("subject")),
                null);

            var fTempl = string.Empty;
            if (!string.IsNullOrEmpty(path))
            {
                var files = Directory.GetFiles(path).ToList();
                if (files.Count > 0)
                {
                    foreach (var file in files)
                    {
                        msg.Attachments.Add(new Attachment(file));
                    }

                    fTempl = BuildFilesTemplate(path, files.Select(Path.GetFileName).ToList());
                }
            }

            msg.Body = HttpUtility.HtmlDecode(string.Format(SiteConfig.Smtp_Body_NoCache, requestData, fTempl));
            msg.IsBodyHtml = SiteConfig.Smtp_Body_Is_Html_NoCache;

            eh.SendMail(msg);
        }

        private string BuildRequestForm(SupportRequestsHistory request)
        {
            var sb = new StringBuilder();

            request.Names.ForEach(n =>
            {
                var name = GetAlias(n);
                if (string.IsNullOrEmpty(name))
                {
                    name = n;
                }

                sb.AppendFormat(SiteConfig.Smtp_Body_Form_Line_NoCache, name, request.GetFormValue(n));
            });

            return sb.ToString();
        }

        public string GetAlias(string name)
        {
            var map = _dc.SalesforceFieldsMappings.FirstOrDefault(m => m.Name.Equals(name, StringComparison.OrdinalIgnoreCase));
            return map == null ? null : map.Alias;
        }

        /// <summary>
        /// Adds files to the template using SiteConfig's lines templates.
        /// </summary>
        /// <param name="path">The path.</param>
        /// <param name="files">The files.</param>
        /// <returns></returns>
        private string BuildFilesTemplate(string path, List<string> files)
        {
            var sb = new StringBuilder();
            sb.AppendFormat(SiteConfig.Smtp_Body_Folder_Line_NoCache, path);

            for (var k = 0; k < files.Count - 1; k++)
            {
                sb.AppendFormat(SiteConfig.Smtp_Body_File_Line_NoCache, files[k]);
            }

            sb.AppendFormat(SiteConfig.Smtp_Body_Last_File_Line_NoCache, files[files.Count - 1]);

            return sb.ToString();
        }

        /// <summary>
        /// Saves request to the local database before sending data to SalesForce.
        /// </summary>
        /// <param name="form">The form.</param>
        /// <returns></returns>
        private SupportRequestsHistory LogRequest(IEnumerable<KeyValuePair<string, string>> form)
        {
            var member = DataContext.Members.FirstOrDefault(m => m.Username == CurrentUser.ProviderUserKey.ToString());
            var h = new SupportRequestsHistory { RequestData = string.Join("&", form.Select(p => string.Format("{0}={1}", p.Key, Uri.EscapeDataString(p.Value)))) };

            if (member != null)
            {
                h.MemberId = member.MemberId;
            }

            DataContext.SupportRequestsHistories.Add(h);
            DataContext.SaveChanges();

            return h;
        }

        /// <summary>
        /// Posts the key collection to the SalesForce page.
        /// </summary>
        /// <param name="keys">The keys.</param>
        /// <param name="result">The post result.</param>
        /// <returns></returns>
        private bool PostToSalesForce(IEnumerable<KeyValuePair<string, string>> keys, out string result)
        {
            var content = new FormUrlEncodedContent(keys);
            using (var client = new HttpClient())
            {
                var response = client.PostAsync(AppSettings.SalesForce_Form_Action, content).Result;
                //var response = client.PostAsync("http://print.dev/PrintForm.aspx", content).Result;
                result = response.IsSuccessStatusCode ? response.StatusCode.ToString() : response.ToString();
                response.EnsureSuccessStatusCode();
                return response.IsSuccessStatusCode;
            }
        }

        /// <summary>
        /// Saves the files attached to the support request.
        /// </summary>
        /// <param name="requestId">The request identifier.</param>
        /// <param name="company">The company name.</param>
        /// <param name="path">The path to files.</param>
        /// <returns></returns>
        /// <exception cref="System.Web.HttpException">3004;Content too long.</exception>
        private string SaveFiles(int requestId, string company, out string path)
        {
            path = string.Empty;
            var files = new List<string>();

            // check if there are any non-empty files
            // if the request length is exceeded, it has been already caught by the system, and we would not get here
            var contentSize = Request.Files.AllKeys
                .Select(f => Request.Files[f])
                .Where(f => f != null)
                .Sum(f => f.ContentLength);

            // do not create a storage folder if there are no files in request
            if (contentSize <= 0) return string.Empty;

            // create a path as Root\Company\Id
            var id = requestId.ToString();
            var requestPath = GeneralHelper.EnsureFolderName(Path.Combine(SiteConfig.Attachments_Root_NoCache, company, id));
            files.Add(requestPath);

            Directory.CreateDirectory(requestPath);

            // now download all files
            for (var k = 0; k < Request.Files.AllKeys.Count(f => Request.Files[f].ContentLength > 0); k++)
            {
                var file = Request.Files[k];
                var fileName = Path.GetFileName(file.FileName);
                var myData = new byte[file.ContentLength];
                file.InputStream.Read(myData, 0, file.ContentLength);
                WriteToFile(Path.Combine(requestPath, fileName), ref myData);

                files.Add(fileName);
            }

            path = requestPath;
            return string.Join(",", files);
        }

        /// <summary>
        /// Writes binary data to file.
        /// </summary>
        /// <param name="strPath">The string path.</param>
        /// <param name="buffer">The buffer.</param>
        private void WriteToFile(string strPath, ref byte[] buffer)
        {
            var newFile = new FileStream(strPath, FileMode.Create);
            newFile.Write(buffer, 0, buffer.Length);
            newFile.Close();
        }

        /// <summary>
        /// Binds the list.
        /// </summary>
        /// <param name="htmlSelect">The ddl.</param>
        /// <param name="options">The options.</param>
        private void BindList(HtmlSelect htmlSelect, IQueryable<DdlOption> options)
        {
            var selected = options.FirstOrDefault(o => o.IsDefault == true);

            htmlSelect.DataSource = options.OrderBy(o => o.OrderBy).ToList();
            htmlSelect.DataTextField = "Name";
            htmlSelect.DataValueField = "Value";
            htmlSelect.DataBind();

            var item = htmlSelect.Items.Cast<ListItem>().FirstOrDefault(i => selected != null && i.Value == (selected.Value ?? string.Empty));
            if (item != null)
            {
                htmlSelect.SelectedIndex = htmlSelect.Items.IndexOf(item);
            }
        }

        #region Generate JSON for cascading ddls

        /// <summary>
        /// Builds JSON for 3-level ddls cascade.
        /// </summary>
        /// <param name="sb">The sb.</param>
        /// <param name="t">The t.</param>
        /// <param name="level">The level.</param>
        /// <param name="lastOnLevel">if set to <c>true</c> [last on level].</param>
        private void PrintElement(StringBuilder sb, HierarchicalDdl t, int level, bool lastOnLevel)
        {
            sb.AppendFormat("\"{0}={1}\"", t.DdlOption.Name, t.DdlOption.Value);
            if (level == 2 && t.Children.Count == 0) sb.Append(": []");
            if (level == 2 && t.Children.Count == 0 && !lastOnLevel) sb.Append(",");
            if (level == 3 && !lastOnLevel) sb.Append(",");

            if (t.Children.Count > 0)
            {
                sb.Append(level == 1 ? ": {" : ": [");

                for (var k = 0; k < t.Children.Count; k++)
                {
                    var tt = t.Children.ToArray()[k];
                    PrintElement(sb, tt, GetLevel(tt), k == t.Children.Count - 1);
                }

                var bracket = level == 1 ? "}" : "]";
                if ((level == 1 || level == 2) && !lastOnLevel) bracket += ",";

                sb.Append(bracket);
            }
            else if (level == 1)
            {
                sb.Append(":{}");
            }
        }

        private int GetLevel(HierarchicalDdl node)
        {
            if (node.Parent == null) return 1;
            return node.Parent.Parent == null ? 2 : 3;
        }

        #endregion
    }
}