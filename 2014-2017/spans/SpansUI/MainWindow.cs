using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading;
using System.Threading.Tasks;
using System.Windows.Forms;
using System.Xml.Linq;
using SpansLib.Data;
using SpansLib.Data.XmlFormats;
using SpansLib.Db;
using SpansLib.Ftp;
using SpansUI.Xml;
using WinSCP;
using SharedLibrary;

namespace SpansUI
{
    public partial class MainWindow : Form
    {
        private SchemaNode _node;
        private string _oledbConnStr;
        private string _dbSmoConnStr;

        private CancellationTokenSource _tokenSource = new CancellationTokenSource();
        private CancellationToken _cancellationToken;

        public MainWindow()
        {
            InitializeComponent();

            _cancellationToken = _tokenSource.Token;

            var path = sourceFolderTextBox.Text;

            LoadSourceFiles(path);
            LoadSourceFilesToListView(path);

            _oledbConnStr = ConfigurationManager.ConnectionStrings["SpansDb"].ConnectionString;
            _dbSmoConnStr = ConfigurationManager.ConnectionStrings["SpansDbSmo"].ConnectionString;

            insertResultsTextBox.AppendText("SqlXml connection string: " + _oledbConnStr + "\r\n");
            insertResultsTextBox.AppendText("SMO connection string: " + _dbSmoConnStr + "\r\n");

            localPathTextBox.Text = AppSettings.FtpMirrorPath;
            ftpPathTextBox.Text = AppSettings.FtpDataUrl;

            schemaComboBox.SelectedIndex = schemaComboBox.Items.Count - 1;
            tabControl1.SelectTab(ftpTabPage);
            tabControl1_SelectedIndexChanged(null, null);
        }

        #region Private methods

        /// <summary>
        /// Loads the source files to ListViews.
        /// </summary>
        /// <param name="path"></param>
        private void LoadSourceFilesToListView(string path)
        {
            sqlFileListView.DataSource = Directory.GetFiles(path, "*.sql");
            xsltFileListView.DataSource = Directory.GetFiles(path, "*.xslt");
            xmlFileListView.DataSource = Directory.GetFiles(path, "*.xml");
            xsdFileListView.DataSource = Directory.GetFiles(path, "*.xsd");
        }

        /// <summary>
        /// Loads the source files for the Development tab.
        /// </summary>
        /// <param name="newXsd">if set to <c>true</c> [new XSD].</param>
        private void LoadSourceFiles(string path, bool newXsd = false)
        {
            schemaComboBox.DataSource = null;
            schemaComboBox.DataSource = Directory.GetFiles(path, "*.xsd");

            xsltComboBox.DataSource = null;
            xsltComboBox.DataSource = Directory.GetFiles(path, "*.xslt");

            if (newXsd) return;

            sourceComboBox.DataSource = null;
            sourceComboBox.DataSource = Directory.GetFiles(path, "*.xml");
        }

        /// <summary>
        /// Builds the SQL script.
        /// </summary>
        private void BuildSql()
        {
            if (schemaComboBox.SelectedItem == null) return;

            resultsTextBox.Clear();
            schemaTreeView.Nodes.Clear();

            var reader = new XDocumentReader(schemaComboBox.SelectedItem.ToString());
            _node = reader.BuildTree();

            schemaTreeView.Nodes.Add(SchemaNodeToTreeNode(new TreeNode(), _node));
            schemaTreeView.ExpandAll();

        }

        /// <summary>
        /// Loads ShemaNode tree to the Tree control.
        /// </summary>
        /// <param name="tn">The tn.</param>
        /// <param name="nd">The nd.</param>
        /// <returns></returns>
        private TreeNode SchemaNodeToTreeNode(TreeNode tn, SchemaNode nd)
        {
            if (nd.IsConstant)
            {
                tn.Text = nd.Name + string.Format(" [{0}], Ignore", nd.Level);
            }
            else
            {
                var name = string.IsNullOrEmpty(nd.DbName) ? nd.Name : nd.DbName;
                var relationships = string.Join(" ", nd.Relationships);
                tn.Text = name + string.Format(" [{0}], [{1}]{2}",
                    nd.Level,
                    nd.DataType,
                    string.IsNullOrEmpty(relationships) ? string.Empty : ", [" + relationships + "]");
            }

            foreach (var child in nd.Children)
            {
                tn.Nodes.Add(SchemaNodeToTreeNode(new TreeNode(), child));
            }

            return tn;
        }

        /// <summary>
        /// Starts the progress for async operations.
        /// </summary>
        private void StartProgress()
        {
            _tokenSource = new CancellationTokenSource();
            _cancellationToken = _tokenSource.Token;

            toolStripStatusLabel1.Text = string.Empty;
            toolStripProgressBar1.Style = ProgressBarStyle.Marquee;
            bulkInsertButton.Enabled = false;
            ftpButton.Enabled = false;
            spanFtpButton.Enabled = false;
            listFtpFilesButton.Enabled = false;
            openFileButton.Enabled = false;
            uploadBatchButton.Enabled = false;
            syncButton.Enabled = false;
        }

        /// <summary>
        /// Stops the progress.
        /// </summary>
        private void StopProgress()
        {
            toolStripStatusLabel1.Text = string.Empty;
            toolStripProgressBar1.Style = ProgressBarStyle.Continuous;
            bulkInsertButton.Enabled = true;
            ftpButton.Enabled = true;
            spanFtpButton.Enabled = true;
            listFtpFilesButton.Enabled = true;
            openFileButton.Enabled = true;
            uploadBatchButton.Enabled = true;
            syncButton.Enabled = true;
        }

        private void StoppingProgress()
        {
            toolStripStatusLabel1.Text = "Cancelling ...";
        }

        #endregion

        #region Events handling

        /// <summary>
        /// Handles the Click event of the bulkInsertButton control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="EventArgs"/> instance containing the event data.</param>
        private void bulkInsertButton_Click(object sender, EventArgs e)
        {
            if (xmlFileListView.SelectedItem == null || xsdFileListView.SelectedItem == null)
            {
                insertResultsTextBox.AppendText("The XML and XSD should be selected to proceed.\r\n");
                return;
            }

            StartProgress();

            var xmlPath = Path.Combine(Application.StartupPath, xmlFileListView.SelectedItem.ToString());
            var sqlFile = (sqlFileListView.SelectedItem ?? string.Empty).ToString();
            var xsltFile = (xsltFileListView.SelectedItem ?? string.Empty).ToString();
            var xsdFile = (xsdFileListView.SelectedItem ?? string.Empty).ToString();
            var autoTables = createTablesCheckBox.Checked;

            Task.Factory.StartNew(() =>
            {
                try
                {
                    var xbi = new SqlXmlBulkInsert(_dbSmoConnStr);
                    var db = new DbHelper(_dbSmoConnStr);

                    if (!string.IsNullOrEmpty(sqlFile) && !autoTables)
                    {
                        //db.ExecuteDdl(sqlFile);
                    }

                    if (!string.IsNullOrEmpty(xmlPath) && !string.IsNullOrEmpty(xsltFile))
                    {
                        var file = new FileInfo(xsltFile);
                        var dir = Path.Combine(file.DirectoryName, "Transformed");
                        Directory.CreateDirectory(dir);
                        var path = Path.Combine(dir,
                            file.Name.Substring(0, file.Name.LastIndexOf('.')) + "_Transformed.xml");

                        if (File.Exists(path))
                        {
                            File.Delete(path);
                        }

                        XsltProcessing.Transform(
                            xmlPath,
                            Path.Combine(Application.StartupPath, xsltFile),
                            path);

                        xmlPath = path;
                    }

                    if (!string.IsNullOrEmpty(xsdFile))
                    {
                        //xbi.BulkLoad(xmlPath, Path.Combine(Application.StartupPath, xsdFile), AppSettings.SqlXmlBulkLoadErrorFile);
                    }

                    BeginInvoke(new Action(() =>
                    {
                        StopProgress();
                        insertResultsTextBox.AppendText(string.Format("[{0}] '{1}' has been uploaded\r\n",
                            DateTime.Now.ToShortTimeString(), xmlPath));
                    }));

                }
                catch (Exception ex)
                {
                    BeginInvoke(new Action(() =>
                    {
                        StopProgress();
                        insertResultsTextBox.AppendText("\r\n------------------------------------------\r\n" + ex +
                                                        "\r\n------------------------------------------\r\n");
                    }));
                }
            });
        }

        /// <summary>
        /// Handles the Click event of the generateXsdButton control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="EventArgs"/> instance containing the event data.</param>
        private void generateXsdButton_Click(object sender, EventArgs e)
        {
            try
            {
                if (sourceComboBox.SelectedItem == null) return;

                var reader = new XsdSchemaReader();
                var result = reader.GenerateXsd(sourceComboBox.SelectedItem.ToString());
                //resultsTextBox.Clear();
                resultsTextBox.AppendText(result + "\r\n");

                LoadSourceFiles(sourceFolderTextBox.Text, true);
            }
            catch (Exception ex)
            {
                resultsTextBox.AppendText("\r\n------------------------------------------\r\n" + ex +
                                          "\r\n------------------------------------------\r\n");
            }
        }

        /// <summary>
        /// Handles the Click event of the sqlButton control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="EventArgs"/> instance containing the event data.</param>
        private void sqlButton_Click(object sender, EventArgs e)
        {
            try
            {
                BuildSql();

                var gen = new SqlXmlSchemaGenerator();
                var result = gen.GenerateSql(_node);

                resultsTextBox.Clear();
                resultsTextBox.AppendText(result + "\r\n");
                resultsTextBox.AppendText("\r\n\r\n -- !!!!!!!!!!!!!! Run this script manually for the Spans database.");
            }
            catch (Exception ex)
            {
                resultsTextBox.AppendText("\r\n------------------------------------------\r\n" + ex +
                                          "\r\n------------------------------------------\r\n");
            }
        }

        /// <summary>
        /// Handles the SelectedIndexChanged event of the schemaComboBox control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="EventArgs"/> instance containing the event data.</param>
        private void schemaComboBox_SelectedIndexChanged(object sender, EventArgs e)
        {
            schemaTreeView.Nodes.Clear();

            if (schemaComboBox.SelectedItem != null)
            {
                var reader = new XDocumentReader(schemaComboBox.SelectedItem.ToString());
                _node = reader.BuildTree();

                schemaTreeView.Nodes.Add(SchemaNodeToTreeNode(new TreeNode(), _node));
                schemaTreeView.ExpandAll();
            }
        }

        /// <summary>
        /// Handles the SelectedIndexChanged event of the sourceComboBox control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="EventArgs"/> instance containing the event data.</param>
        private void sourceComboBox_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (sourceComboBox.SelectedItem == null) return;

            var xmlFile = sourceComboBox.SelectedItem.ToString();
            schemaComboBox.SelectedIndex = schemaComboBox.FindString(xmlFile.Substring(0, xmlFile.LastIndexOf('.')));
            xsltComboBox.SelectedIndex = xsltComboBox.FindString(xmlFile.Substring(0, xmlFile.LastIndexOf('.')));
        }

        /// <summary>
        /// Handles the Click event of the xpath control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="EventArgs"/> instance containing the event data.</param>
        private void xpath_Click(object sender, EventArgs e)
        {
            string str = resultsTextBox.Text;
            if (str.Length == 0)
            {
                str = File.ReadAllText(schemaComboBox.SelectedItem.ToString());
            }
            xpathResultTextBox.Text = XsltProcessing.GetXPathResults(xpathTextBox.Text, str);
        }

        /// <summary>
        /// Handles the Click event of the transformButton control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="EventArgs"/> instance containing the event data.</param>
        private void transformButton_Click(object sender, EventArgs e)
        {
            try
            {
                if (sourceComboBox.SelectedItem == null || xsltComboBox.SelectedItem == null) return;

                var file = new FileInfo(sourceComboBox.SelectedItem.ToString());
                var path = file.FullName.Substring(0, file.FullName.LastIndexOf('.')) + " Transformed.xml";

                if (File.Exists(path))
                {
                    File.Delete(path);
                }

                XsltProcessing.Transform(sourceComboBox.SelectedItem.ToString(), xsltComboBox.SelectedItem.ToString(),
                    path);
            }
            catch (Exception ex)
            {
                resultsTextBox.AppendText("\r\n------------------------------------------\r\n" + ex +
                                          "\r\n------------------------------------------\r\n");
            }
        }

        /// <summary>
        /// Handles the SelectedIndexChanged event of the xmlFileListView control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="EventArgs"/> instance containing the event data.</param>
        private void xmlFileListView_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (xmlFileListView.SelectedItems.Count == 0) return;

            var xmlFile = xmlFileListView.SelectedItems[0].ToString();

            while (xsdFileListView.SelectedIndex !=
                   xsdFileListView.FindString(xmlFile.Substring(0, xmlFile.LastIndexOf('.'))))
            {
                xsdFileListView.SelectedIndex =
                    xsdFileListView.FindString(xmlFile.Substring(0, xmlFile.LastIndexOf('.')));
            }

            while (xsltFileListView.SelectedIndex !=
                   xsltFileListView.FindString(xmlFile.Substring(0, xmlFile.LastIndexOf('.'))))
            {
                // because not every time the SelectedIndex has a value, which was assigned;
                xsltFileListView.SelectedIndex =
                    xsltFileListView.FindString(xmlFile.Substring(0, xmlFile.LastIndexOf('.')));
            }

            while (sqlFileListView.SelectedIndex !=
                   sqlFileListView.FindString(xmlFile.Substring(0, xmlFile.LastIndexOf('.'))))
            {
                sqlFileListView.SelectedIndex =
                    sqlFileListView.FindString(xmlFile.Substring(0, xmlFile.LastIndexOf('.')));
            }
        }

        /// <summary>
        /// Handles the Click event of the ftpButton control.
        /// </summary>
        /// <param name="sender">The source of the event.</param>
        /// <param name="e">The <see cref="EventArgs"/> instance containing the event data.</param>
        private async void ftpButton_Click(object sender, EventArgs e)
        {
            StartProgress();

            var ftpUrl = ftpPathTextBox.Text;
            var ftpFiles = AppSettings.FtpFiles;

            insertResultsTextBox.AppendText("FTP Url: " + ftpUrl + "\r\n");
            insertResultsTextBox.AppendText("FTP files: " + string.Join(", ", ftpFiles) + "\r\n");

            await Task.Factory.StartNew(() =>
            {
                try
                {
                    var ftp = new FtpHelper(new Uri(ftpPathTextBox.Text), Protocol.Ftp);
                    var filePath = "Sources";

                    foreach (var file in ftpFiles)
                    {
                        if (_cancellationToken.IsCancellationRequested)
                            break;

                        ftp.Download(file, ftpPathTextBox.Text, filePath, s => BeginInvoke(new Action(() =>
                        {
                            insertResultsTextBox.AppendText(file + ": " + s);
                            insertResultsTextBox.AppendText(Environment.NewLine);
                        })), useBinary: false);

                        BeginInvoke(new Action(() =>
                        {
                            insertResultsTextBox.AppendText(file + " has been downloaded.");
                            insertResultsTextBox.AppendText(Environment.NewLine);
                        }));
                    }
                }
                catch (Exception ex)
                {
                    BeginInvoke(new Action(() =>
                    {
                        StopProgress();
                        insertResultsTextBox.AppendText(ex.ToString());
                        insertResultsTextBox.AppendText(Environment.NewLine);
                    }));
                }
            });

            StopProgress();
            xmlFileListView.DataSource = Directory.GetFiles(sourceFolderTextBox.Text, "*.xml");
        }

        private async void listFtpFilesButton_Click(object sender, EventArgs e)
        {
            StartProgress();

            spanResultsTextBox.AppendText("SPAN FTP Url: " + ftpPathTextBox.Text + Environment.NewLine);

            await Task.Factory.StartNew(async () =>
            {
                try
                {
                    var date = DateTime.Today.AddDays(-(int)monthsNumericUpDown.Value);

                    using (var ftp = new FtpHelper(new Uri(ftpPathTextBox.Text), Protocol.Ftp,
                            AppSettings.FtpNumberOfThreads))
                    {
                        await ftp.InvokeFileListing(
                            msg =>
                                BeginInvoke(new Action(() => spanResultsTextBox.AppendText(msg + Environment.NewLine))),
                            (batchId, files) => BeginInvoke(new Action(() =>
                            {
                                var sb = new StringBuilder();
                                files.ToList()
                                    .ForEach(
                                        f => sb.AppendFormat("{0}/{1}{2}", f.Key, f.Value.Name, Environment.NewLine));

                                spanResultsTextBox.AppendText(sb.ToString());
                                spanResultsTextBox.AppendText(Environment.NewLine);

                                spanResultsTextBox.AppendText("Total files: ");
                                spanResultsTextBox.AppendText(files.Count() + Environment.NewLine);

                                spanResultsTextBox.AppendText("Total size: ");
                                spanResultsTextBox.AppendText(files.Sum(p => p.Value.Length).ToPrettySize() +
                                                              Environment.NewLine);

                                batchIdTextBox.Text = batchId.ToString();

                                StopProgress();
                            })),
                            _cancellationToken,
                            date,
                            "2013;2014;test;.archive_scripts".ToList(";")
                            );
                    }
                }
                catch (OperationCanceledException)
                {
                    BeginInvoke(new Action(() =>
                    {
                        StopProgress();
                        spanResultsTextBox.AppendText("Cancelled");
                        spanResultsTextBox.AppendText(Environment.NewLine);
                    }));
                }
                catch (Exception ex)
                {
                    BeginInvoke(new Action(() =>
                    {
                        StopProgress();
                        spanResultsTextBox.AppendText(ex.ToString());
                        spanResultsTextBox.AppendText(Environment.NewLine);
                    }));
                }
            });
        }

        private async void spanFtpButton_Click(object sender, EventArgs e)
        {
            StartProgress();

            spanResultsTextBox.AppendText("Start downloading" + Environment.NewLine);

            await Task.Factory.StartNew(() =>
            {
                try
                {
                    using (var ftp = new FtpHelper(new Uri(ftpPathTextBox.Text), Protocol.Ftp, AppSettings.FtpNumberOfThreads))
                    {
                        Directory.CreateDirectory(localPathTextBox.Text);

                        ftp.DownloadBatchFiles(
                            ftpPathTextBox.Text,
                            localPathTextBox.Text,
                            int.Parse(batchIdTextBox.Text),
                            f => BeginInvoke(new Action(() => spanResultsTextBox.AppendText(f + Environment.NewLine))));
                    }
                }
                catch (OperationCanceledException)
                {
                    BeginInvoke(new Action(() =>
                    {
                        StopProgress();
                        spanResultsTextBox.AppendText("Cancelled");
                        spanResultsTextBox.AppendText(Environment.NewLine);
                    }));
                }
                catch (Exception ex)
                {
                    BeginInvoke(new Action(() =>
                    {
                        StopProgress();
                        spanResultsTextBox.AppendText(ex.ToString());
                        spanResultsTextBox.AppendText(Environment.NewLine);
                    }));
                }
            }, _cancellationToken);

            StopProgress();
        }

        private void CancelButton_Click(object sender, EventArgs e)
        {
            _tokenSource.Cancel();
            StoppingProgress();
        }

        #endregion

        private async void openFileButton_Click(object sender, EventArgs e)
        {
            if (openFileDialog1.ShowDialog() == DialogResult.OK)
            {
                StartProgress();
                var fns = openFileDialog1.FileNames;
                var ovrw = overwriteCheckBox.Checked;

                await Task.Factory.StartNew(() =>
                {
                    try
                    {
                        foreach (var fn in fns)
                        {
                            if (_cancellationToken.IsCancellationRequested)
                                break;

                            var ext = (Path.GetExtension(fn) ?? string.Empty);
                            if (ext.Equals(Constants.SpnExt, StringComparison.OrdinalIgnoreCase))
                            {
                                BeginInvoke(new Action(() => spanResultsTextBox.AppendText(fn + "...")));
                                var xsdFile = Path.Combine(Application.StartupPath, AppSettings.SpanSchemaFile);
                                var processor = new SpnFileProcessor();

                                //TODO: overwrite logic
                                processor.BulkLoad(_dbSmoConnStr, xsdFile, fn, validateCheckBox.Checked);
                                BeginInvoke(new Action(() => spanResultsTextBox.AppendText("Done.\r\n")));
                            }
                            else
                            {
                                var reader = FileFactory.GetReader(fn);
                                var writer = FileFactory.GetWriter(fn);
                                _invoker.Invoke(string.Format("Start processing '{0}' ... ", fn), "Done.\r\n",
                                    spanResultsTextBox,
                                    () => writer.UploadData(_dbSmoConnStr, reader, !ovrw));
                            }
                        }
                    }
                    catch (Exception ex)
                    {
                        BeginInvoke(new Action(() =>
                        {
                            spanResultsTextBox.AppendText(ex + "\r\n");
                            StopProgress();
                        }));
                    }
                }, _cancellationToken);

                StopProgress();
            }
        }

        private async void syncButton_Click(object sender, EventArgs e)
        {
            StartProgress();
            var localPath = localPathTextBox.Text;
            var ftpPath = ftpPathTextBox.Text;
            var daysBack = -(int)monthsNumericUpDown.Value;
            var overwrite = overwriteCheckBox.Checked;

            spanResultsTextBox.AppendText(string.Format("Sync folders '{0}' and '{1}' ...\r\n", ftpPath, localPath));

            await Task.Factory.StartNew(() =>
            {
                try
                {
                    var ftp = new FtpHelper(new Uri(ftpPath), Protocol.Ftp);
                    ftp.SyncFolders(
                        localPath,
                        msg => BeginInvoke(new Action(() => spanResultsTextBox.AppendText(msg + "\r\n"))),
                        _cancellationToken,
                        DateTime.Today.AddDays(daysBack),
                        overwrite,
                        "2013;2014;test;.archive_scripts".ToList(";"));
                }
                catch (Exception ex)
                {
                    BeginInvoke(new Action(() =>
                    {
                        spanResultsTextBox.AppendText(ex + "\r\n");
                        StopProgress();
                    }));
                }
            });

            spanResultsTextBox.AppendText("Done");
            StopProgress();
        }

        private async void uploadBatchButton_Click(object sender, EventArgs e)
        {
            StartProgress();

            spanResultsTextBox.AppendText("\r\nUploading batch files to database  ...\r\n");
            var batchId = batchIdTextBox.Text;
            var path = localPathTextBox.Text;
            var overwrite = overwriteCheckBox.Checked;
            var date = DateTime.Today.AddDays(-(int)monthsNumericUpDown.Value);

            await Task.Factory.StartNew(() =>
            {
                try
                {
                    var bw = !string.IsNullOrEmpty(batchId)
                        ? new BatchWriter(int.Parse(batchId), FileFormat.XmlFormats)
                        : new BatchWriter(path, FileFormat.XmlFormats, date);

                    bw.Process(_dbSmoConnStr, _cancellationToken, file => BeginInvoke(new Action(() => spanResultsTextBox.AppendText(file + "\r\n"))), !overwrite);
                }
                catch (Exception ex)
                {
                    BeginInvoke(new Action(() =>
                    {
                        spanResultsTextBox.AppendText(ex + "\r\n");
                        StopProgress();
                    }));
                }
            });

            spanResultsTextBox.AppendText("Done");
            StopProgress();
        }

        private void button3_Click(object sender, EventArgs e)
        {
            var ds = new DataSet();
            ds.ReadXmlSchema(@"E:\stash\spans\Sources\spanrisk.xsd");
            //ds.ReadXml(@"E:\CME\FTP\asxclf\ASXCLFEndOfDayRiskParameterFile150624.spn");

        }

        private void chooseLocalFolderButton_Click(object sender, EventArgs e)
        {
            folderBrowserDialog1.RootFolder = Environment.SpecialFolder.Desktop;
            folderBrowserDialog1.SelectedPath = localPathTextBox.Text;
            SendKeys.Send("{TAB}{TAB}{RIGHT}");

            if (folderBrowserDialog1.ShowDialog() == DialogResult.OK)
            {
                localPathTextBox.Text = folderBrowserDialog1.SelectedPath;
            }
        }

        private void tabControl1_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (tabControl1.SelectedTab == tabPage1)
            {
                ftpPathTextBox.Text = SpansLib.AppSettings.FtpUtilsUrl;
            }

            else if (tabControl1.SelectedTab == ftpTabPage)
            {
                ftpPathTextBox.Text = SpansLib.AppSettings.FtpDataUrl;
            }
        }

        private async void button3_Click_1(object sender, EventArgs e)
        {
            StartProgress();

            spanResultsTextBox.AppendText("\r\nAnalyzing  ...\r\n");
            var path = localPathTextBox.Text;

            List<string> results = new List<string>();

            await Task.Factory.StartNew(() =>
            {
                try
                {
/*
                    var sa = new SequenceAnalyzer();
                    sa.Run(path, "*.pa2", cancellationToken,
                        f => BeginInvoke(new Action(() => spanResultsTextBox.AppendText(f + "\r\n"))),
                        list => results = list);
*/
                }
                catch (Exception ex)
                {
                    BeginInvoke(new Action(() =>
                    {
                        spanResultsTextBox.AppendText(ex + "\r\n");
                        StopProgress();
                    }));
                }
            });

            var sb = new StringBuilder();
            results.ForEach(f => sb.Append(f + "\r\n"));

            spanResultsTextBox.AppendText(sb.ToString());
            spanResultsTextBox.AppendText("Done");
            StopProgress();
        }

        private Action<string, string, Control, Action> _invoker = (startMsg, endMsg, textbox, task) =>
        {
            textbox.BeginInvoke(new Action(() => ((TextBox)textbox).AppendText(startMsg)));
            task.Invoke();
            textbox.BeginInvoke(new Action(() => ((TextBox)textbox).AppendText(endMsg)));
        };

        private async void StartSpanAction(Action goWith, string startStr = "", string endStr = "")
        {
            StartProgress();

            spanResultsTextBox.AppendText("\r\n" + startStr + "\r\n");

            await Task.Factory.StartNew(() =>
            {
                try
                {
                    goWith.Invoke();
                }
                catch (Exception ex)
                {
                    BeginInvoke(new Action(() =>
                    {
                        spanResultsTextBox.AppendText(ex + "\r\n");
                        StopProgress();
                    }));
                }
            });

            spanResultsTextBox.AppendText(endStr);
            StopProgress();
        }

        private void button4_Click(object sender, EventArgs e)
        {
            folderBrowserDialog1.RootFolder = Environment.SpecialFolder.Desktop;
            folderBrowserDialog1.SelectedPath = localPathTextBox.Text;
            SendKeys.Send("{TAB}{TAB}{RIGHT}");

            if (folderBrowserDialog1.ShowDialog() == DialogResult.OK)
            {
                localPathTextBox.Text = folderBrowserDialog1.SelectedPath;
            }
        }

        private void renameXsdElemsButton_Click(object sender, EventArgs e)
        {
            var xdoc = XDocument.Load(schemaComboBox.SelectedItem.ToString());
            var check = new List<string>();

            foreach (var el in xdoc.Elements().Descendants().Where(n => n.HasAttribute("relation")))
            {
                var paths = new List<string>();
                var elPar = el.Parent;

                paths.Add(el.GetAttribute("name", el.GetAttribute("ref")));


                while (elPar != null)
                {
                    var val = elPar.GetAttribute("name", elPar.GetAttribute("ref"));
                    if (val != null)
                        paths.Add(val);

                    elPar = elPar.Parent;
                }

                paths.Reverse();
                if (paths[0] == "spanFile")
                {
                    check.Add(string.Join("", paths));
                }
            }
        }
    }
}
