using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Diagnostics;
using System.Drawing;
using System.IO;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.ServiceModel.Web;
using System.Text;
using System.Threading;
using System.Threading.Tasks;
using System.Web;
using System.Web.UI.WebControls;
using System.Windows.Forms;
using System.Xml;
using Microsoft.Win32;
using Newtonsoft.Json;
using TradeDataAPI.Helpers;
using UsersDb;
using UsersDb.Code;
using UsersDb.DataContext;
using UsersDb.Helpers;
using Action = System.Action;
using ListBox = System.Windows.Forms.ListBox;
using ListViewItem = System.Windows.Forms.ListViewItem;
using RadioButton = System.Windows.Forms.RadioButton;
using TextBox = System.Windows.Forms.TextBox;

namespace SimpleClient
{
    public partial class Form1 : Form
    {

        private readonly bool _initializing = false;
        private Dictionary<string, BindingList<StoredProcParameterJson>> _dict = new Dictionary<string, BindingList<StoredProcParameterJson>>();
        private readonly Dictionary<string, string> _browsers = new Dictionary<string, string>();
        private Dictionary<string, string> _users = new Dictionary<string, string>();
        private CancellationTokenSource _tokenSource = new CancellationTokenSource();
        private CancellationToken _cancellationToken;
        private readonly DataTable _storedProcs = new DataTable();
        private const string SpPattern = "{0}.{1}{2}";
        private const string JsonDevider = "<-methods || users->";

        private readonly UsersDataContext _dataContext = new UsersDataContext();

        private string MethodName => spNameComboBox.SelectedValue?.ToString();

        private string DbAlias => dbComboBox.SelectedValue?.ToString();

        private bool IsMultiUserMode => multiUserCheckBox.Checked;

        private int IterationsCount => (int)iterationsNumericUpDown.Value;

        private string GetString(string alias, string procedure, Dictionary<string, object> @params = null)
        {
            var apiHelper = new TdApiHelper(new HttpRequestMessage(), AppSettings.baseURL, AppSettings.defaultUser, AppSettings.defaultPwd, "Custom error message");
            return apiHelper.GetString(alias, procedure);
        }


        public Form1()
        {
            _initializing = true;

            InitializeComponent();

            try
            {
                LoadDatabases();

                _cancellationToken = _tokenSource.Token;

                usernameComboBox.Items.Add(AppSettings.defaultUser);
                passwordTextbox.Text = AppSettings.defaultPwd;
                _users.Add(AppSettings.defaultUser, AppSettings.defaultPwd);
                usernameComboBox.SelectedIndex = 0;

                baseUrlTextBox.Text = AppSettings.baseURL;

                dataGridView1.AutoGenerateColumns = false;

                var str = GetString(AppSettings.UsersDbAlias, "GetSearchGroups");
                searchGroupsListBox.DataSource = JsonConvert
                    .DeserializeObject<JSearchGroup>(str).Table0;
                searchGroupsListBox.DisplayMember = "Name";
                searchGroupsListBox.ValueMember = "Id";
                searchGroupsListBox.SelectedIndex = -1;

                str = GetString(DbAlias, "GetExchangeCodes");
                xcodeListBox.DataSource = JsonConvert
                    .DeserializeObject<JExchanges>(str)
                    .Table0;
                xcodeListBox.DisplayMember = "ExchangeCode";
                xcodeListBox.ValueMember = "ExchangeCode";
                xcodeListBox.SelectedIndex = -1;

                str = GetString(DbAlias, "GetContractTypes");
                ctypeListBox.DataSource = JsonConvert
                    .DeserializeObject<JContractTypes>(str)
                    .Table0;
                ctypeListBox.DisplayMember = "ContractType";
                ctypeListBox.ValueMember = "ContractType";
                ctypeListBox.SelectedIndex = -1;

                LoadMethods();
                LoadParameters();

                spNameComboBox.SelectedIndex = spNameComboBox.Items.Count == 0 ? -1 : 0;

                GetUrl();

                LoadBrowsers();
            }
            catch (Exception ex)
            {
                resultTextBox.AppendText(ex.Message);
                resultTextBox.AppendText(Environment.NewLine);
            }
            finally
            {
                _initializing = false;
            }
        }

        private void LoadDatabases()
        {
            dbComboBox.DisplayMember = "Alias";
            dbComboBox.ValueMember = "Alias";
            dbComboBox.DataSource = _dataContext.DatabaseConfigurations.Where(d => !d.IsDeleted).OrderByDescending(d => d.IsDefault).ThenBy(d => d.Alias);
            dbComboBox.SelectedIndex = dbComboBox.Items.Count == 0 ? -1 : 0;

            WorkingDatabase.CreateInstance(DbAlias);
        }

        private void LoadBrowsers()
        {
            try
            {
                using (RegistryKey.OpenBaseKey(RegistryHive.LocalMachine, RegistryView.Registry32))
                {
                    var browsers32 = GetStartMenuInternetHive(@"SOFTWARE\Clients\StartMenuInternet",
                        RegistryView.Registry32);
                    var browsers64 = GetStartMenuInternetHive(@"SOFTWARE\WOW6432Node\Clients\StartMenuInternet",
                        RegistryView.Registry64);

                    browsers32
                        .ToList()
                        .ForEach(pair => _browsers.Add(pair.Key, pair.Value));

                    browsers64
                        .Except(browsers32)
                        .ToList()
                        .ForEach(pair => _browsers.Add(pair.Key, pair.Value));

                    _browsers
                        .ToList()
                        .ForEach(pair =>
                        {
                            ListItem l;
                            if (!imageList1.Images.ContainsKey(pair.Key.ToLower()))
                            {
                                imageList1.Images.Add(pair.Key, Icon.ExtractAssociatedIcon(pair.Value));
                            }

                            listView1.Items.Add(new ListViewItem(pair.Key,
                                imageList1.Images.IndexOfKey(pair.Key.ToLower())));
                        });
                }
            }
            catch (Exception ex)
            {
                resultTextBox.AppendText(ex.Message);
                resultTextBox.AppendText(Environment.NewLine);
            }
        }

        private Dictionary<string, string> GetStartMenuInternetHive(string hivePath, RegistryView regView)
        {
            resultTextBox.AppendText($"Browsers found in the hive {hivePath}:\r\n");
            var browsers = new Dictionary<string, string>();

            try
            {
                using (var hklm = RegistryKey.OpenBaseKey(RegistryHive.LocalMachine, regView))
                {
                    var webClientsRootKey = hklm.OpenSubKey(hivePath);
                    if (webClientsRootKey != null)
                    {
                        resultTextBox.AppendText($"\t{string.Join(", ", webClientsRootKey.GetSubKeyNames())}\r\n\r\n");

                        foreach (var subKeyName in webClientsRootKey.GetSubKeyNames())
                        {
                            if (webClientsRootKey.OpenSubKey(subKeyName) != null)
                            {
                                if (webClientsRootKey.OpenSubKey(subKeyName).OpenSubKey("shell") != null)
                                {
                                    if (webClientsRootKey.OpenSubKey(subKeyName).OpenSubKey("shell").OpenSubKey("open") != null)
                                    {
                                        if (webClientsRootKey.OpenSubKey(subKeyName)
                                            .OpenSubKey("shell")
                                            .OpenSubKey("open")
                                            .OpenSubKey("command") != null)
                                        {
                                            var command = (string)webClientsRootKey.OpenSubKey(subKeyName)
                                                .OpenSubKey("shell")
                                                .OpenSubKey("open")
                                                .OpenSubKey("command")
                                                .GetValue(null);

                                            browsers.Add(subKeyName.ToLower(), command.Replace("\"", ""));
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                resultTextBox.AppendText(ex.Message);
                resultTextBox.AppendText(Environment.NewLine);
            }

            return browsers;
        }

        private string Method2Sp(string methodName)
        {
            var spId = methodName.Substring(WorkingDatabase.Instance.GetStoredProcMethodPrefix().Length);
            return string.Format(SpPattern, WorkingDatabase.Instance.GetStoredProcOwner(), WorkingDatabase.Instance.GetStoredProcPrefix(), spId);
        }

        private void GetUrl()
        {
            if (MethodName == null)
                return;

            baseUrlTextBox.Text = GetUrl(
                MethodName,
                _dict.ContainsKey(MethodName) ? _dict[MethodName] : new BindingList<StoredProcParameterJson>(),
                usernameComboBox.Text,
                passwordTextbox.Text);
        }

        private string GetUrl(string methodName, BindingList<StoredProcParameterJson> methodParams, string userName, string password)
        {
            var url = new StringBuilder(ConfigurationManager.AppSettings["baseURL"].TrimEnd('/'));

            if (!clearCacheRadioButton.Checked)
                url.Append($"/{DbAlias}");

            url.Append("/");

            var isList = listRadioButton.Checked;

            if (clearCacheRadioButton.Checked)
            {
                url.Append("clearCache");
            }
            else
            {
                url.AppendFormat("{0}", IsSearchTabActive ? "GetBySymbol/" : (!isList) ? $"{EscapeValue(methodName)}/" : string.Empty);

                // format
                url.Append(
                    countRadioButton.Checked ? "count"
                        : xmlRadioButton.Checked ? "xml"
                            : jsonRadioButton.Checked ? "json"
                                : csvRadioButton.Checked ? "csv"
                                    : listRadioButton.Checked ? "list"
                                        : "help");
            }

            // user
            url.AppendFormat("?u={0}&p={1}", EscapeValue(userName), EscapeValue(password));

            if (clearCacheRadioButton.Checked)
                return url.ToString();

            if (IsSearchTabActive || !listRadioButton.Checked)
            {
                // csv
                if (csvColumnsCheckBox.Checked)
                    url.Append("&cn=true");
                if (forceQuotesCheckBox.Checked)
                    url.Append("&q=true");
                if (delimiterTextBox.Text != ",")
                    url.Append("&d=" + EscapeValue(delimiterTextBox.Text.Trim()));

                // json
                if (indentJsonCheckBox.Checked)
                    url.Append("&ij=true");
            }

            if (IsSearchTabActive)
            {
                if (searchBox.Text.Length > 0)
                    url.AppendFormat("&s={0}", EscapeValue(searchBox.Text));
                if (xcodeListBox.SelectedIndex > -1)
                    url.AppendFormat("&ec={0}", string.Join(",", GetSelectedExchangeCodes(xcodeListBox)));
                if (ctypeListBox.SelectedIndex > -1)
                    url.AppendFormat("&ct={0}", string.Join(",", GetSelectedContractTypes(ctypeListBox)));

                url.AppendFormat("&so={0}", (int)(startsWithRadio.Checked
                    ? SearchOptions.StartsWith
                    : endsWithRadio.Checked ? SearchOptions.EndsWith
                    : containsRadio.Checked ? SearchOptions.Contains
                    : SearchOptions.Equals));

                if (searchGroupsListBox.SelectedIndex > -1)
                    url.AppendFormat("&sc={0}", string.Join(",", GetSelectedSearchGroups(searchGroupsListBox)));

                if (extendResultsCheckBox.Checked)
                    url.Append("&se=1");

                if (includeRootCheckBox.Checked)
                    url.Append("&re=0");

                if (zipCheckBox.Checked)
                    url.Append("&zip=1");
            }
            else
            {
                if (methodName != null)
                {
                    if (!isList)
                    {
                        // parameters
                        if (methodParams != null && methodParams.Count > 0)
                        {
                            var pares = methodParams
                                .Where(p => !string.IsNullOrWhiteSpace(p.ParameterName))
                                .Select(p => EscapeValue(p.ParameterName) + "=" + EscapeValue(p.ParameterValue));

                            url.Append("&");
                            url.Append(string.Join("&", pares));
                        }
                    }

                    // where clause
                    for (var k = 1; k < paramsTabControl.TabCount; k++)
                    {
                        var grid = paramsTabControl.TabPages[k].Controls[0] as DataGridView;
                        var @params = grid?.DataSource as BindingList<OutputFilter>;
                        if (@params != null)
                        {
                            var values = @params.Where(v => !string.IsNullOrEmpty(v.Value)).ToList();

                            for (var z = 0; z < values.Count; z++)
                            {
                                var filter = values[z];
                                var join = (values.Count > z && z > 0) ? values[z - 1].Join : string.Empty;

                                if (!string.IsNullOrWhiteSpace(filter.Value) && !string.IsNullOrWhiteSpace(filter.Operator))
                                {
                                    var str = "t" + (k - 1) + "."
                                              + UrlQueryParser.TranslateOperator(@join)
                                              + filter.Name
                                              + UrlQueryParser.TranslateOperator(filter.Operator)
                                              + "=" + filter.Value;

                                    url.Append("&" + Uri.EscapeUriString(str));
                                }
                            }
                        }
                    }
                }
            }

            // paging
            if (usePagingCheckBox.Checked)
            {
                url.AppendFormat("&ps={0}", pageSizeNumericUpDown.Value);
                url.AppendFormat("&pn={0}", pageNumberNumericUpDown.Value);
            }

            return url.ToString();
        }

        private string EscapeValue(object obj)
        {
            if (obj == null || obj == DBNull.Value)
                return string.Empty;

            return Uri.EscapeDataString(obj.ToString());
        }

        public List<string> GetSelectedSearchGroups(ListBox lb)
        {
            return lb.SelectedItems
                .Cast<NamedPair>()
                .Select(sg => sg.Id)
                .ToList();
        }

        public List<string> GetSelectedExchangeCodes(ListBox lb)
        {
            return lb.SelectedItems
                .Cast<JExchange>()
                .Select(sg => HttpUtility.UrlEncode(sg.ExchangeCode))
                .ToList();
        }

        public List<string> GetSelectedContractTypes(ListBox lb)
        {
            return lb.SelectedItems
                .Cast<JContractType>()
                .Select(sg => HttpUtility.UrlEncode(sg.ContractType))
                .ToList();
        }

        private bool IsSearchTabActive => tabControl1.SelectedTab == searchTab;

        private void LoadMethods()
        {
            try
            {
                _storedProcs.Clear();
                spNameComboBox.DisplayMember = "name";

                if (userMethodsCheckBox.Checked)
                {
                    var id = 1;
                    new AccessHelper(_dataContext).TryAuthenticate(usernameComboBox.Text, passwordTextbox.Text,
                        out id);

                    spNameComboBox.DataSource = _dataContext
                        .GetUser(id)
                        .Methods
                        .Where(m => !m.IsDeleted)
                        .Where(m => m.DatabaseConfiguration.Alias.Equals(DbAlias, StringComparison.OrdinalIgnoreCase))
                        .Select(m => m.Name)
                        .ToList();

                    resultTextBox.AppendText($"Methods loaded for the user {usernameComboBox.Text}\r\n");
                }
                else
                {
                    spNameComboBox.DataSource = _dataContext.Methods
                        .Where(m => !m.IsDeleted && m.DatabaseConfiguration.Alias == DbAlias)
                        .Select(m => m.Name)
                        .ToList();
                }

                if (spNameComboBox.Items.Count > 0)
                {
                    spNameComboBox.SelectedIndex = 0;
                }
            }
            catch (Exception ex)
            {
                spNameComboBox.DataSource = new List<string>();
                resultTextBox.AppendText("Cannot load methods for the user: " + ex.Message);
                resultTextBox.AppendText(Environment.NewLine);
            }
        }

        /// <summary>
        /// Clears the methos output meta data.
        /// </summary>
        /// <exception cref="System.NotImplementedException"></exception>
        private void ClearMethosOutputMetaData()
        {
            while (paramsTabControl.TabCount > 1)
            {
                paramsTabControl.TabPages.RemoveAt(1);
            }
        }

        /// <summary>
        /// Loads the method output meta data.
        /// </summary>
        private void LoadMethodOutputMetaData()
        {
            var cn = WorkingDatabase.Instance.GetConnectionString();
            using (var dbHelper = new DbHelper(cn))
            {
                dbHelper.Connection.Open();
                var @params = new RequestParameters
                {
                    Username = usernameComboBox.Text,
                    Password = passwordTextbox.Text,
                    MethodName = MethodName,
                    ConnectionString = DatabaseConfiguration.GetConnectionString(cn)
                };

                @params.MethodArguments.AddRange(_dict[MethodName]);

                var data = dbHelper.GetStoredProceduresResultSetsMetaData(@params);

                for (var k = 0; k < data.Count; k++)
                {
                    var table = data[k];

                    var page = new TabPage("Table" + k);
                    var grid = new DataGridView
                    {
                        Dock = DockStyle.Fill,
                        AutoGenerateColumns = false,
                    };

                    grid.CellLeave += dataGridView1_CellLeave;
                    grid.Leave += dataGridView1_Leave;
                    grid.RowLeave += dataGridView1_CellLeave;

                    grid.Columns[grid.Columns.Add("Name", "Name")].Width = 250;
                    grid.Columns.Add("Type", "Type");
                    grid.Columns.Add("IsNullable", "Nullable");

                    var oprCol = new DataGridViewComboBoxColumn
                    {
                        DataPropertyName = "Operator",
                        DisplayStyle = DataGridViewComboBoxDisplayStyle.ComboBox,
                        FlatStyle = FlatStyle.Flat,
                        DataSource = new[] { "=", ">", "<", ">=", "<=", "like", "in", "not in", "order by" },
                        Name = "Operator"
                    };

                    var conCol = new DataGridViewComboBoxColumn
                    {
                        DataPropertyName = "Join",
                        DisplayStyle = DataGridViewComboBoxDisplayStyle.ComboBox,
                        FlatStyle = FlatStyle.Flat,
                        DataSource = new[] { "and", "or" },
                        Name = "Join"
                    };

                    var dupCol = new DataGridViewButtonColumn()
                    {
                        UseColumnTextForButtonValue = true,
                        Text = "+",
                        Width = 25,
                        Resizable = DataGridViewTriState.False
                    };
                    var removeCol = new DataGridViewButtonColumn()
                    {
                        UseColumnTextForButtonValue = true,
                        Text = "-",
                        Width = 25,
                        Resizable = DataGridViewTriState.False
                    };

                    grid.Columns
                        .Cast<DataGridViewColumn>()
                        .ToList()
                        .ForEach(c =>
                        {
                            c.DataPropertyName = c.Name;
                            c.ReadOnly = true;
                            c.CellTemplate.Style.BackColor = Color.FromArgb(235, 235, 235);
                        });

                    grid.Columns.Add(oprCol);
                    grid.Columns[grid.Columns.Add("Value", "Value")].DataPropertyName = "Value";
                    grid.Columns.Add(conCol);
                    grid.Columns.Add(dupCol);
                    grid.Columns.Add(removeCol);

                    var bl = new BindingList<OutputFilter>();
                    table.Select(r => new OutputFilter
                    {
                        Name = r.Name,
                        Type = r.Type,
                        IsNullable = r.IsNullable,
                        Value = string.Empty,
                        Operator = "=",
                        Join = "and"
                    })
                    .ToList()
                    .ForEach(bl.Add);

                    grid.DataSource = bl;
                    grid.AllowUserToAddRows = false;
                    grid.CellContentClick += (sender, e) =>
                    {
                        var senderGrid = (DataGridView)sender;
                        var column = senderGrid.Columns[e.ColumnIndex] as DataGridViewButtonColumn;
                        if (column != null && e.RowIndex >= 0)
                        {
                            if (column.Text == dupCol.Text)
                            {
                                bl.Insert(e.RowIndex + 1, OutputFilter.Clone(bl[e.RowIndex]));
                            }
                            else
                            {
                                bl.RemoveAt(e.RowIndex);
                            }
                        }
                    };

                    page.Controls.Add(grid);
                    paramsTabControl.TabPages.Add(page);
                }
            }
        }

        public class OutputFilter
        {
            public static OutputFilter Clone(OutputFilter f)
            {
                return new OutputFilter
                {
                    Name = f.Name,
                    Type = f.Type,
                    IsNullable = f.IsNullable,
                    Operator = f.Operator,
                    Value = f.Value,
                    Join = f.Join
                };
            }

            public string Name { get; set; }
            public string Type { get; set; }
            public bool IsNullable { get; set; }
            public string Operator { get; set; }
            public string Value { get; set; }
            public string Join { get; set; }
        }

        private void LoadParameters()
        {
            try
            {
                if (!_dict.ContainsKey(MethodName))
                {
                    _dict.Add(MethodName, new BindingList<StoredProcParameterJson>());
                    var cn = WorkingDatabase.Instance.GetConnectionString();

                    using (var dbHelper = new DbHelper(cn))
                    {
                        dbHelper.Connection.Open();
                        var prms = dbHelper.GetStoredProcedureParameters(Method2Sp(MethodName));

                        foreach (var parameter in prms.Where(parameter => parameter.Direction == ParameterDirection.Input || parameter.Direction == ParameterDirection.InputOutput))
                        {
                            _dict[MethodName].Add(new StoredProcParameterJson
                            {
                                ParameterName = parameter.Name.Replace(WorkingDatabase.Instance.GetStoredProcParamPrefix(), "")
                            });
                        }
                    }
                }

                dataGridView1.DataSource = _dict[MethodName];
            }
            catch (Exception ex)
            {
                resultTextBox.AppendText(ex.Message);
                resultTextBox.AppendText(Environment.NewLine);
            }
        }

        private void dataGridView1_Leave(object sender, EventArgs e)
        {
            GetUrl();
        }

        private void dataGridView1_CellLeave(object sender, DataGridViewCellEventArgs e)
        {
            GetUrl();
        }

        private void runButton_Click(object sender, EventArgs e)
        {
            var myXml = string.Empty;
            var globalStart = DateTime.Now;

            if (IsMultiUserMode)
            {
                resultTextBox.AppendText(Environment.NewLine);
                resultTextBox.AppendText(globalStart.ToString());
                resultTextBox.AppendText(Environment.NewLine);
            }

            try
            {
                GetUrl();

                if (IsMultiUserMode)
                {
                    _tokenSource = new CancellationTokenSource();
                    _cancellationToken = _tokenSource.Token;

                    var usersToGo = _dataContext.ActiveUsers
                        .Where(u => _users.Keys.Contains(u.Username));

                    ServicePointManager.ServerCertificateValidationCallback = delegate { return true; };

                    foreach (var user in usersToGo)
                    {
                        var urls = IsSearchTabActive
                            ? new List<string> { GetUrl("", new BindingList<StoredProcParameterJson>(), user.Username, _users[user.Username]) }
                            : user.MethodNames
                                .Select(method => GetUrl(
                                    method,
                                    _dict.ContainsKey(method) ? _dict[method] : new BindingList<StoredProcParameterJson>(),
                                    user.Username,
                                    _users[user.Username])).ToList();

                        var showAsString = bytesCheckBox.Checked;
                        var stringLength = (int)stringLengthNumericUpDown.Value;

                        Task.Factory.StartNew(() =>
                        {
                            try
                            {
                                for (var k = 0; k < IterationsCount; k++)
                                {
                                    foreach (var url in urls)
                                    {
                                        _cancellationToken.ThrowIfCancellationRequested();

                                        using (var client = new WebClient())
                                        {
                                            try
                                            {
                                                var start = DateTime.Now;
                                                var bytes = client.DownloadData(url);
                                                var duration = (DateTime.Now - start).TotalMilliseconds;

                                                var result = showAsString
                                                    ? Encoding.Default.GetString(bytes).Substring(0, Math.Min(stringLength, bytes.Length))
                                                    : ConvertSize(bytes.Length);

                                                var format = showAsString
                                                    ? "{4} > {0} <RESPONSE>{1}</RESPONSE> returned in {2:#,#0,.00} seconds{3}"
                                                    : "{4} > {0}.....{1} returned in {2:#,#0,.00} seconds{3}";

                                                resultTextBox.BeginInvoke(new Action(() =>
                                                {
                                                    resultTextBox.AppendText(string.Format(format, url, result, duration, Environment.NewLine, user.Username));
                                                }));
                                            }
                                            catch (WebException ex)
                                            {
                                                resultTextBox.BeginInvoke(new Action(() =>
                                                {
                                                    resultTextBox.AppendText(string.Format("{3} > {0}.....{1}{2}", url, ex.Message, Environment.NewLine, user.Username));
                                                }));
                                            }
                                            catch (WebFaultException<string> ex)
                                            {
                                                resultTextBox.BeginInvoke(new Action(() =>
                                                {
                                                    resultTextBox.AppendText(string.Format("{3} > {0}.....{1}{2}", url, ex.Message, Environment.NewLine, user.Username));
                                                }));
                                            }
                                        }
                                    }
                                }

                                resultTextBox.BeginInvoke(new Action(() =>
                                {
                                    resultTextBox.AppendText($"User {user.FullName}, finished at {DateTime.Now}");
                                    resultTextBox.AppendText(". Total time " + (DateTime.Now - globalStart).ToString(@"hh\:mm\:ss"));
                                    resultTextBox.AppendText(Environment.NewLine);
                                }));
                            }
                            catch (Exception ex)
                            {
                                resultTextBox.BeginInvoke(new Action(() =>
                                {
                                    resultTextBox.AppendText(ex.Message);
                                    resultTextBox.AppendText(Environment.NewLine);
                                }));

                            }
                        });

                        Task.WaitAll();
                    }
                }
                else
                {
                    if (IsSearchTabActive && zipCheckBox.Checked && saveZipAsFileCheckBox.Checked)
                    {
                        var filePath = Path.Combine(Environment.CurrentDirectory, "example.zip");
                        var stream = TdApiHelper.GetStream(baseUrlTextBox.Text) as MemoryStream;

                        if (File.Exists(filePath))
                        {
                            File.Delete(filePath);
                        }

                        using (var file = new FileStream(filePath, FileMode.Create, FileAccess.Write))
                        {
                            stream?.WriteTo(file);
                            stream?.Close();
                        }

                        Process.Start(filePath);

                        return;
                    }

                    var key = listView1.SelectedItems.Count > 0
                        ? listView1.SelectedItems[0].Text
                        : null;

                    if (key == null)
                    {
                        Process.Start(baseUrlTextBox.Text);
                    }
                    else
                    {
                        var startInfo = new ProcessStartInfo { FileName = _browsers[key], Arguments = baseUrlTextBox.Text };
                        Process.Start(startInfo);
                    }
                }
            }
            catch (XmlException ex)
            {
                resultTextBox.Text = myXml;
            }
            catch (Exception ex)
            {
                resultTextBox.Text = ex.ToString();
            }
        }

        static string ConvertSize(double size)
        {
            var unit = 0;
            string[] units = { "B", "KB", "MB", "GB", "TB", "PB", "EB", "ZB", "YB" };

            while (size >= 1024)
            {
                size /= 1024;
                ++unit;
            }

            return $"{size:0.#}{units[unit]}";
        }

        private void resultTextBox_KeyPress(object sender, KeyPressEventArgs e)
        {
            if (e.KeyChar == '\x1')
            {
                ((TextBox)sender).SelectAll();
                e.Handled = true;
            }
        }

        private void radioButton_CheckedChanged(object sender, EventArgs e)
        {
            spNameComboBox.Enabled = !listRadioButton.Checked;
            if (((RadioButton)sender).Checked)
            {
                GetUrl();
            }
        }

        private void textbox_TextChanged(object sender, EventArgs e)
        {
            spNameComboBox.Enabled = !listRadioButton.Checked;
            GetUrl();
        }

        private void spNameComboBox_SelectedIndexChange(object sender, EventArgs e)
        {
            try
            {
                ClearMethosOutputMetaData();
                LoadParameters();
                //LoadMethodOutputMetaData();
                GetUrl();
            }
            catch (SqlException se)
            {
                resultTextBox.AppendText(se.Message);
            }
            catch (Exception ex)
            {
                resultTextBox.AppendText(ex.ToString());
            }
        }

        private void Form1_Activated(object sender, EventArgs e)
        {
            passwordTextbox.DeselectAll();
            baseUrlTextBox.DeselectAll();
            usernameComboBox.SelectionLength = 0;
        }

        private void userMethodsCheckBox_CheckedChanged(object sender, EventArgs e)
        {
            if (_initializing) return;

            LoadMethods();
        }

        private void button1_Click(object sender, EventArgs e)
        {
            Clipboard.SetText(baseUrlTextBox.Text);
        }

        private void tabControl1_SelectedIndexChanged(object sender, EventArgs e)
        {
            listRadioButton.Enabled = !IsSearchTabActive;
            GetUrl();
        }

        private void control_SelectedIndexChanged(object sender, EventArgs e)
        {
            saveZipAsFileCheckBox.Enabled = zipCheckBox.Checked;

            GetUrl();
        }

        private void multiUserCheckBox_CheckedChanged(object sender, EventArgs e)
        {
            usernameComboBox.DropDownStyle = IsMultiUserMode ? ComboBoxStyle.DropDown : ComboBoxStyle.Simple;
            cancelButton.Visible = IsMultiUserMode;
            iterationsNumericUpDown.Enabled = IsMultiUserMode;
            bytesCheckBox.Enabled = IsMultiUserMode;
            stringLengthNumericUpDown.Enabled = IsMultiUserMode;
        }

        private void passwordTextbox_TextChanged(object sender, EventArgs e)
        {
            if (_users.ContainsKey(usernameComboBox.Text))
            {
                _users[usernameComboBox.Text] = passwordTextbox.Text;
            }

            //if (!IsMultiUserMode)
            {
                textbox_TextChanged(sender, e);
            }
        }

        private void usernameComboBox_Leave(object sender, EventArgs e)
        {
            if (IsMultiUserMode && !usernameComboBox.Items.Contains(usernameComboBox.Text))
            {
                usernameComboBox.Items.Add(usernameComboBox.Text);
                _users.Add(usernameComboBox.Text, passwordTextbox.Text);
            }

            if (!IsMultiUserMode)
            {
                _users.Clear();
                _users.Add(usernameComboBox.Text, passwordTextbox.Text);
            }
        }

        private void cancelButton_Click(object sender, EventArgs e)
        {
            _tokenSource.Cancel();
        }

        private void saveButton_Click(object sender, EventArgs e)
        {
            if (saveFileDialog1.ShowDialog() == DialogResult.OK)
            {
                try
                {
                    var mStr = JsonConvert.SerializeObject(_dict);
                    var uStr = JsonConvert.SerializeObject(_users);
                    var concat = string.Format("{0}{2}{3}{2}{1}", mStr, uStr, Environment.NewLine, JsonDevider);

                    File.WriteAllText(saveFileDialog1.FileName, concat);
                }
                catch (Exception ex)
                {
                    resultTextBox.AppendText(ex.Message);
                    resultTextBox.AppendText(Environment.NewLine);
                }
            }
        }

        private void loadButton_Click(object sender, EventArgs e)
        {
            if (openFileDialog1.ShowDialog() == DialogResult.OK)
            {
                try
                {
                    var str = File.ReadAllText(openFileDialog1.FileName);
                    if (str.IndexOf(JsonDevider) > -1)
                    {
                        var lines = str.Split(new[] { JsonDevider }, StringSplitOptions.RemoveEmptyEntries);
                        _dict = JsonConvert.DeserializeObject<Dictionary<string, BindingList<StoredProcParameterJson>>>(lines[0]);
                        _users = JsonConvert.DeserializeObject<Dictionary<string, string>>(lines[1]);

                        LoadParameters();
                        AddUsers(_users);
                        GetUrl();
                    }
                }
                catch (Exception ex)
                {
                    resultTextBox.AppendText(ex.Message);
                    resultTextBox.AppendText(Environment.NewLine);
                }
            }
        }

        private void AddUsers(Dictionary<string, string> users)
        {
            usernameComboBox.Items.Clear();

            foreach (var user in users)
            {
                usernameComboBox.Items.Add(user.Key);
            }
        }

        private void dbComboBox_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (_initializing) return;

            try
            {
                WorkingDatabase.CreateInstance(DbAlias);
                GetUrl();
                LoadMethods();
            }
            catch (Exception ex)
            {
                resultTextBox.AppendText(ex.Message);
                resultTextBox.AppendText(Environment.NewLine);
            }
        }

        private void loadOutputButton_Click(object sender, EventArgs e)
        {
            try
            {
                ClearMethosOutputMetaData();
                LoadMethodOutputMetaData();

                if (paramsTabControl.TabCount > 1)
                {
                    paramsTabControl.SelectTab(1);
                }
            }
            catch (Exception ex)
            {
                resultTextBox.AppendText(ex.Message);
                resultTextBox.AppendText(Environment.NewLine);
            }
        }

        private void pageNumberNumericUpDown_ValueChanged(object sender, EventArgs e)
        {
            GetUrl();
        }

        private void usePagingCheckBox_CheckedChanged(object sender, EventArgs e)
        {
            pageNumberNumericUpDown.Enabled = usePagingCheckBox.Checked;
            pageSizeNumericUpDown.Enabled = usePagingCheckBox.Checked;
        }

        #region classes
        class JContractTypes
        {
            public JContractType[] Table0 { get; set; }
        }

        class JContractType
        {
            public string ContractType { get; set; }
        }


        class JExchanges
        {
            public JExchange[] Table0 { get; set; }
        }

        class JExchange
        {
            public string ExchangeCode { get; set; }
        }

        class JSearchGroup
        {
            public NamedPair[] Table0 { get; set; }
        }

        class NamedPair
        {
            public string Id { get; set; }
            public string Name { get; set; }
        }

        #endregion
    }
}
