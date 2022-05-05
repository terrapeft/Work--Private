using System;
using System.Data.EntityClient;
using System.Data.SqlClient;
using System.Diagnostics;
using System.IO;
using System.Linq;
using System.Reflection;
using System.Security.Cryptography.X509Certificates;
using System.Text.RegularExpressions;
using System.Xml.Linq;
using System.Xml.XPath;
using Microsoft.Deployment.WindowsInstaller;
using Microsoft.Web.Administration;
using Microsoft.Win32;
using SharedLibrary.Passwords;
using SharedLibrary.WiX;

namespace WiXCustomActions
{
    /// <summary>
    /// Custom actions called from the setup during installation.
    /// </summary>
    public class CustomActions : CustomActionsBase
    {
        #region Static initialization

        static CustomActions()
        {
            GetEmbeddedResourceFunc = ReadResourceFile;
            LogFunc = Log;
        }

        /// <summary>
        /// Logs the specified message to installation log file.
        /// </summary>
        /// <param name="msg">The MSG.</param>
        private static void Log(string msg)
        {
            Session?.Log(msg.Replace("[", "[\\[]").Replace("]", "[\\]]"));
        }

        /// <summary>
        /// Reads the embedded file.
        /// </summary>
        /// <param name="resourceName">Name of the resource.</param>
        /// <returns></returns>
        private static string ReadResourceFile(string resourceName)
        {
            Log($"Going to execute SQL helper '{resourceName}'");

            var stream = Assembly.GetExecutingAssembly().GetManifestResourceStream($"{typeof(CustomActions).Namespace}.{resourceName}");
            if (stream != null)
            {
                using (var sr = new StreamReader(stream))
                {
                    return sr.ReadToEnd();
                }
            }

            return string.Empty;
        }

        #endregion

        #region Uninstall

        /// <summary>
        /// Deletes the sites from IIS, it is only about IIS registration, sites files are controlled by MSI.
        /// </summary>
        /// <param name="session">The session.</param>
        /// <returns></returns>
        [CustomAction]
        public static ActionResult DeleteSites(Session session)
        {
#if DEBUG
            StartDebugger();
#endif
            try
            {
                Session = session;

                Log("Deleting sites.");

                var appPool = session.CustomActionData["AppPool"];
                var api = session.CustomActionData["Api"];
                var admin = session.CustomActionData["AdminSite"];

                Log("Got variables, ready to search for sites.");

                var serverManager = new ServerManager();

                serverManager.Sites.FirstOrDefault(ss => ss.Name == api)?.Delete();
                serverManager.Sites.FirstOrDefault(ss => ss.Name == admin)?.Delete();
                serverManager.ApplicationPools.FirstOrDefault(p => p.Name == appPool)?.Delete();

                Log("Sites deleted.");

                serverManager.CommitChanges();

                Log("Changes committed.");
            }
            catch (Exception ex)
            {
                Log(ex.ToString());
                return ActionResult.Failure;
            }

            return ActionResult.Success;
        }

        #endregion

        #region Install

        #region Actions

        [CustomAction]
        public static ActionResult SetUpIIS(Session session)
        {
#if DEBUG
            StartDebugger();
#endif

            try
            {
                Session = session;
                Log("Setting up IIS.");

                var appPool = session.CustomActionData["AppPool"];
                var sc = session.CustomActionData["Sc"];
                var sqlServer = session.CustomActionData["Server"];
                var user = session.CustomActionData["User"];
                var pwd = session.CustomActionData["Pwd"];
                var trusted = session.CustomActionData["Trusted"] == "1";
                var useCertificate = session.CustomActionData["SSL"] == "1";
                var tdUserDbConnStr = GetSessionValue("ConnStr");

                var sites = session.CustomActionData["Sites"]
                    .Split(',')
                    .ToList();

                Log("Got variables, ready to search for sites.");

                if (!useCertificate)
                {
                    var apiSite = sites[0];
                    var path = apiSite.Split('|')[1];
                    var file = Path.Combine(path, "web.config");
                    var doc = XDocument.Parse(File.ReadAllText(file));

                    Log("Going to change the https to http in web.config.");

                    if (doc.Document != null)
                    {
                        var item = doc.Document.XPathSelectElement("//webHttpBinding/binding/security[@mode='Transport']");
                        item?.SetAttributeValue("mode", "None");

                        item = doc.Document.XPathSelectElement("//behavior[@name='serviceBehavior']/serviceMetadata");
                        item?.SetAttributeValue("httpsGetEnabled", "false");

                        Log("Done.");
                        doc.Save(file);
                    }
                }

                // create application pool
                if (!string.IsNullOrWhiteSpace(appPool))
                {
                    CreateAppPool(appPool);
                }

                // update SimpleClient config
                if (!string.IsNullOrWhiteSpace(sc.Trim('|')))
                {
                    UpdateSimpleClient(sc, sqlServer, trusted, user, pwd);
                }

                // create sites and update web.configs
                if (sites.Any())
                {
                    sites.ForEach(s =>
                    {
                        var sitePath = s.Split('|')[1];

                        CreateSite(s);
                        UpdateConnectionStrings("web.config", sitePath, sqlServer, trusted, user, pwd);
                        UpdateConnectionString(sitePath, tdUserDbConnStr, sqlServer, null, trusted, user, pwd);
                        RemoveDebugSettings(sitePath);
                    });
                }
            }
            catch (Exception ex)
            {
                Log(ex.ToString());
                return ActionResult.Failure;
            }

            return ActionResult.Success;
        }



        /// <summary>
        /// This is a deferred custom action (see definition in product.wxs) which happens after files are installed and IIS is configured.
        /// </summary>
        /// <param name="session">The session.</param>
        /// <returns></returns>
        [CustomAction]
        public static ActionResult RunScripts(Session session)
        {
#if DEBUG
            StartDebugger();
#endif
            Session = session;
            Log("Going to run SQL scripts.");

            try
            {
                var binaries = session.CustomActionData["scripts"].Split(',');
                var dbName = session.CustomActionData["Db"];
                var sqlServer = session.CustomActionData["Server"];
                var jobUSer = session.CustomActionData["JobUser"];
                var appPool = session.CustomActionData["AppPool"];
                var site = GetSessionValue("Site");
                var msi = session.CustomActionData["Msi"];
                var user = session.CustomActionData["User"];
                var pwd = session.CustomActionData["Pwd"];
                var trusted = session.CustomActionData["Trusted"] == "1";
                var dbCfgs = GetSessionValue("dbCfgs")?.Split(',').ToList();
                var cipher = GetSessionValue("Cipher");
                var reuseDb = GetSessionValue("ReuseDb") == "1";
                var mailProfile = GetSessionValue("MailProfile");
                var defaultPassword = GetSessionValue("DefaultPassword");

                var dns = site?.Split('|')[2] ?? string.Empty;
                var https = site?.Split('|')[5] ?? string.Empty;

                Log("Got session variables.");

                var conBuilder = new SqlConnectionStringBuilder { DataSource = sqlServer, InitialCatalog = "Master" };
                SetConnectionUser(conBuilder, trusted, user, pwd);

                Log($"Will use this conn str: '{conBuilder.ConnectionString}'");

                var dataFolder = string.Empty;
                var logFolder = string.Empty;
                var sqlServerName = string.Empty;

                using (var conn = new SqlConnection(conBuilder.ConnectionString))
                {
                    conn.Open();

                    bool dbExists;
                    using (var command = new SqlCommand(string.Format(ReadResourceFile("CheckForUpdate.sql"), dbName), conn))
                    {
                        dbExists = Convert.ToInt32(command.ExecuteScalar()) > -1;
                    }

                    Log("Reading SQL Server configuration with the script from 'SqlServerPaths.sql'");

                    using (var command = new SqlCommand(ReadResourceFile("SqlServerPaths.sql"), conn))
                    using (var reader = command.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            dataFolder = reader.GetString(0);
                            logFolder = reader.GetString(1);
                        }
                    }

                    // get machine name the sql server is installed on
                    using (var command = new SqlCommand(ReadResourceFile("SqlServerName.sql"), conn))
                    using (var reader = command.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            sqlServerName = reader.GetString(0);
                            Log($"Server name: {sqlServerName}");
                        }
                    }

                    // check if installing localy or remotly
                    var isLocalsServer = string.IsNullOrWhiteSpace(sqlServerName) || sqlServerName.Equals(Environment.MachineName, StringComparison.OrdinalIgnoreCase);

                    Log("Done");

                    using (var db = new Database(msi, DatabaseOpenMode.ReadOnly))
                    {
                        Log("Reading scripts from the Binary table.");

                        foreach (var name in binaries)
                        {
                            Log($"Script: {name}.");


                            var view = db.OpenView("SELECT `Data` FROM `Binary` WHERE `Name` = '{0}'", name);
                            view.Execute();

                            if (name.Equals("CreateDatabase", StringComparison.OrdinalIgnoreCase) || name.Equals("FillDatabase", StringComparison.OrdinalIgnoreCase))
                            {
                                if (reuseDb && dbExists)
                                {
                                    Log($"Skipping {dbName}, because it is already exists, and it is set to keep existed db.");
                                    continue;
                                }
                            }

                            var scriptRecord = view.Fetch();
                            var reader = new StreamReader(scriptRecord.GetStream(1)); // index starts from "1", not "0"
                            var script = reader.ReadToEnd();

                            Log("Database default file name: " + Path.Combine(dataFolder, dbName + ".mdf"));

                            var mdfFile = NextAvailableFilename(Path.Combine(dataFolder, dbName + ".mdf"), isLocalsServer ? null : conn);
                            var ldfFile = NextAvailableFilename(Path.Combine(logFolder, dbName + "_log.ldf"), isLocalsServer ? null : conn);

                            Log("New name: " + mdfFile);
                            Log("New name: " + ldfFile);

                            var accountName = trusted
                                ? GetVirtualAccountName(isLocalsServer, appPool)
                                : user;

                            Log("Virtual account for IIS - SQL Server interaction: " + accountName);

                            dbCfgs?.ForEach(c =>
                            {
                                var srv = "{" + $"{c.ToUpper()}_SERVER" + "}";
                                var usr = "{" + $"{c.ToUpper()}_USER" + "}";
                                var pwdEnc = CryptoHelper.Encrypt(pwd, cipher);
                                var cn = trusted ? "Integrated Security=True" : $"User ID={user};Password={pwdEnc}";
                                script = script.Replace(srv, sqlServer);
                                script = script.Replace(usr, cn);
                            });

                            script = script.Replace("{API_PROTOCOL}", https);
                            script = script.Replace("{API_DNS}", dns);
                            script = script.Replace("{DB_NAME}", dbName);
                            script = script.Replace("{DB_FILENAME}", mdfFile);
                            script = script.Replace("{DB_LOGNAME}", ldfFile);
                            script = script.Replace("{VIRTUAL_ACCOUNT}", accountName);
                            script = script.Replace("{JOB_USER}", jobUSer);
                            script = script.Replace("{DB_MAIL_PROFILE}", mailProfile);

                            var passwordsCount = script.Split(new[] { "{DEFAULT_PASSWORD}" }, StringSplitOptions.RemoveEmptyEntries).Length - 1;
                            if (passwordsCount > 0)
                            {
                                var ch = new CryptoHelper(10000, 32, 32);
                                for (var k = 0; k < passwordsCount; k++)
                                {
                                    var salt = ch.CreateSalt();
                                    var pwdHash = ch.CreatePasswordHash(defaultPassword, salt);
                                    script = ReplaceFirstOccurrence(script, "{SALT}", salt);
                                    script = ReplaceFirstOccurrence(script, "{DEFAULT_PASSWORD}", pwdHash);
                                }
                            }

                            // split script on GO command
                            var commandStrings = Regex.Split(script, @"^\s*GO\s*$", RegexOptions.Multiline | RegexOptions.IgnoreCase);

                            Log("Script prepared for run.");

                            commandStrings
                                .Where(commandString => commandString.Trim() != string.Empty)
                                .ToList()
                                .ForEach(s => ExecuteCommand(s, conn));

                            Log("Script parts executed.");
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                Log(ex.ToString());
                return ActionResult.Failure;
            }

            return ActionResult.Success;
        }

        private static void StartDebugger()
        {
            //Debugger.Launch();
        }

        #endregion

        #region Helpers



        /// <summary>
        /// Updates the simple client configuration.
        /// </summary>
        /// <param name="sc">Installation path.</param>
        /// <param name="sqlServer">The SQL server name.</param>
        /// <param name="trusted">Is connection trusted or not.</param>
        /// <param name="user">The user.</param>
        /// <param name="pwd">The password.</param>
        private static void UpdateSimpleClient(string sc, string sqlServer, bool trusted, string user, string pwd)
        {
            Log($"Going to update SimpleClient configuration in '{sc}'.");

            var path = sc.Split('|')[0];

            if (string.IsNullOrWhiteSpace(path))
                return;

            var protocol = sc.Split('|')[1];
            var dns = sc.Split('|')[2];

            UpdateConnectionStrings("SimpleClient.exe.config", path, sqlServer, trusted, user, pwd);

            var file = Path.Combine(path, "SimpleClient.exe.config");
            var doc = XDocument.Parse(File.ReadAllText(file));

            Log("Going to change the 'baseURL' in SimpleClient configuration file.");

            if (doc.Document != null)
            {
                var add = doc.Document.XPathSelectElement("//appSettings/add[@key='baseURL']");
                add.SetAttributeValue("value", $"{protocol}://{dns}/");

                Log("Done.");
            }

            doc.Save(file);
        }

        /// <summary>
        /// Updates the connection strings in configuration file.
        /// </summary>
        /// <param name="configFile">The configuration file.</param>
        /// <param name="sitePath">The site path.</param>
        /// <param name="sqlServer">The SQL server.</param>
        /// <param name="trusted">if set to <c>true</c> [trusted].</param>
        /// <param name="user">The user.</param>
        /// <param name="pwd">The password.</param>
        private static void UpdateConnectionStrings(string configFile, string sitePath, string sqlServer, bool trusted, string user, string pwd)
        {
            var file = Path.Combine(sitePath, configFile);

            Log($"Changing connection strings in {file}.");

            var doc = XDocument.Parse(File.ReadAllText(file));
            if (doc.Document != null)
            {
                // get all connection strings
                doc.Document.XPathSelectElements("//connectionStrings/add")
                    .ToList()
                    .ForEach(add =>
                    {
                        var provider = add.Attributes().FirstOrDefault(a => a.Name.LocalName.Equals("providerName", StringComparison.OrdinalIgnoreCase));
                        var connStr = add.Attribute("connectionString").Value;

                        Log($"Found '{connStr}'.");

                        // check provider, as different builders are used for SqlClient connection string and EntityFramework conn str
                        if (provider != null && provider.Value.IndexOf("EntityClient", StringComparison.OrdinalIgnoreCase) > -1)
                        {
                            var efConn = new EntityConnectionStringBuilder(connStr);
                            var sqlConn = new SqlConnectionStringBuilder(efConn.ProviderConnectionString) { DataSource = sqlServer };

                            SetConnectionUser(sqlConn, trusted, user, pwd);

                            efConn.ProviderConnectionString = sqlConn.ConnectionString;
                            add.SetAttributeValue("connectionString", efConn.ConnectionString);

                            Log($"We think it's an Entity Connection string, it now looks like '{efConn.ConnectionString}'.");
                        }
                        else
                        {
                            var sqlConn = new SqlConnectionStringBuilder(connStr) { DataSource = sqlServer };

                            SetConnectionUser(sqlConn, trusted, user, pwd);

                            add.SetAttributeValue("connectionString", sqlConn.ConnectionString);

                            Log($"We think it's a Sql Connection string, it now looks like '{sqlConn.ConnectionString}'.");
                        }
                    });

                doc.Save(file);

                Log("Changes are done, saved to XDocument.");
            }
        }




        #endregion

        #endregion
    }
}
