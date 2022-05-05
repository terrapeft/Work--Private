using System;
using System.Collections.Generic;
using System.Data.EntityClient;
using System.Data.SqlClient;
using System.Diagnostics;
using System.IO;
using System.Linq;
using System.Reflection;
using System.Security.AccessControl;
using System.Security.Cryptography.X509Certificates;
using System.Security.Principal;
using System.Text;
using System.Text.RegularExpressions;
using System.Threading.Tasks;
using System.Xml.Linq;
using System.Xml.XPath;
using Microsoft.Web.Administration;
using Microsoft.Win32;
using SharedLibrary.JSON;

namespace SharedLibrary.WiX
{
    /// <summary>
    /// 
    /// </summary>
    public abstract class CustomActionsBase
    {
        protected const string AppPoolUserScript = "apppooluserscript";
        protected const string TdAppPoolUserScript = "tdapppooluserscript";
        protected const string EncryptionScript = "encrypttradedatausersdatabase";

        protected static Func<string, string> GetEmbeddedResourceFunc;
        protected static Action<string> LogFunc;
        protected static Microsoft.Deployment.WindowsInstaller.Session Session;


        /// <summary>
        /// Gets the value from from the installation session.
        /// If variable doesn't exist, returns null.
        /// </summary>
        /// <param name="key">The key.</param>
        /// <returns></returns>
        protected static string GetSessionValue(string key)
        {
            return Session != null && Session.CustomActionData.ContainsKey(key)
                ? Session.CustomActionData[key]
                : null;
        }

        /// <summary>
        /// Executes the command.
        /// </summary>
        /// <param name="commandString">The command string.</param>
        /// <param name="conn">The connection.</param>
        protected static void ExecuteCommand(string commandString, SqlConnection conn)
        {
            LogFunc($"Script content\n------------------------------\n{EscapeOutput(commandString)}\n------------------------------\n");

            using (var command = new SqlCommand(commandString, conn))
            {
                command.CommandTimeout = 6400;
                command.ExecuteNonQuery();
            }
        }

        /// <summary>
        /// Escapes square brackets, because otherwise installer treats them as variables and replaces with empty string.
        /// </summary>
        /// <param name="value">The value.</param>
        /// <returns></returns>
        protected static string EscapeOutput(string value)
        {
            return value?.Replace("[", @"[\[]").Replace("]", @"[\]]");
        }

        /// <summary>
        /// Checks if directory exists and has files and creates another folder with appended index.
        /// Otherwise creates new directory with provided name.
        /// Then sets the security to allow Modify for All.
        /// </summary>
        /// <param name="folder">The backup dir.</param>
        protected static string SetupDirectory(string folder)
        {
            if (Directory.Exists(folder) && Directory.GetFiles(folder).Any())
            {
                folder = GetNextFilename(folder.TrimEnd('\\') + " ({0})");
            }

            Directory.CreateDirectory(folder);

            var sec = Directory.GetAccessControl(folder);
            var everyone = new SecurityIdentifier(WellKnownSidType.WorldSid, null);
            sec.AddAccessRule(new FileSystemAccessRule(everyone,
                FileSystemRights.Modify | FileSystemRights.Synchronize,
                InheritanceFlags.ContainerInherit | InheritanceFlags.ObjectInherit,
                PropagationFlags.None, AccessControlType.Allow));

            Directory.SetAccessControl(folder, sec);
            return folder;
        }

        /// <summary>
        /// Checks if file exists - localy with File.Exits, remotly with Sql Server's stored procedure.
        /// </summary>
        /// <param name="conn">The connection.</param>
        /// <param name="path">The path.</param>
        /// <returns></returns>
        protected static bool FileExists(SqlConnection conn, string path)
        {
            if (conn == null)
                return File.Exists(path) || Directory.Exists(path);

            using (var command = new SqlCommand(string.Format(GetEmbeddedResourceFunc("SqlServerFileExists.sql"), path), conn))
            {
                return Convert.ToInt32(command.ExecuteScalar()) > 0;
            }
        }

        /// <summary>
        /// Returns next available filename e.g. file.txt, file(1).txt.
        /// </summary>
        /// <param name="path">The path.</param>
        /// <param name="conn"></param>
        /// <returns></returns>
        protected static string NextAvailableFilename(string path, SqlConnection conn = null)
        {
            if (!FileExists(conn, path))
                return path;

            // If path has extension then insert the number pattern just before the extension and return next filename
            return Path.HasExtension(path)
                ? GetNextFilename(path.Insert(path.LastIndexOf(Path.GetExtension(path), StringComparison.Ordinal), "({0})"))
                : GetNextFilename(path + "({0})");
        }

        /// <summary>
        /// Gets the next filename.
        /// </summary>
        /// <param name="pattern">The pattern.</param>
        /// <param name="conn"></param>
        /// <returns></returns>
        protected static string GetNextFilename(string pattern, SqlConnection conn = null)
        {
            var tmp = string.Format(pattern, 1);
            if (tmp == pattern)
                throw new ArgumentException("The pattern must include an index place-holder", nameof(pattern));

            if (!FileExists(conn, tmp))
                return tmp; // short-circuit if no matches

            int min = 1, max = 2;

            while (FileExists(conn, string.Format(pattern, max)))
            {
                min = max;
                max *= 2;
            }

            while (max != min + 1)
            {
                var pivot = (max + min) / 2;
                if (FileExists(conn, string.Format(pattern, pivot)))
                    min = pivot;
                else
                    max = pivot;
            }

            return string.Format(pattern, max);
        }

        /// <summary>
        /// Gets the name of the virtual account.
        /// It will be an Application Pool user name for local machine and the machine domain name for the remote one.
        /// </summary>
        /// <param name="isLocalsServer">if set to <c>true</c> [is locals server].</param>
        /// <param name="appPoolName">Name of the application pool.</param>
        /// <returns></returns>
        protected static string GetVirtualAccountName(bool isLocalsServer, string appPoolName)
        {
            return isLocalsServer
                ? $"IIS APPPOOL\\{appPoolName}"
                : $"{Environment.UserDomainName}\\{Environment.MachineName}$";
        }

        /// <summary>
        /// Updates the rewriting rule with provided DNS.
        /// </summary>
        /// <param name="configFile">The configuration file.</param>
        /// <param name="site">The site.</param>
        protected static void UpdateUrlRewritingRule(string configFile, string site)
        {
            var sitePath = site.Split('|')[1];
            var dns = site.Split('|')[2];
            var ruleName = site.Split('|')[6];

            var fullName = Path.Combine(sitePath, "config", configFile);

            LogFunc($@"Going to update file '{fullName}'.");

            if (!File.Exists(fullName))
            {
                LogFunc("File doesn't exist.");
                return;
            }

            var doc = XDocument.Parse(File.ReadAllText(fullName));

            if (doc.Document != null)
            {
                SetRuleValue(doc, ruleName, dns);
                LogFunc("Done.");
            }

            doc.Save(fullName);
        }

        /// <summary>
        /// Sets the rule value.
        /// </summary>
        /// <param name="doc">The document.</param>
        /// <param name="ruleName">Name of the rule.</param>
        /// <param name="dns">The DNS.</param>
        protected static void SetRuleValue(XDocument doc, string ruleName, string dns)
        {
            LogFunc($@"Changing rewrite rule '{ruleName}' virtualUrl to '{dns}' DNS.");

            // ignore xmlns in xpath
            var xpath = $"//*[local-name()='add'][@name='{ruleName}']";
            var attr = "virtualUrl";
            if (doc?.Document != null)
            {
                var node = doc.Document.XPathSelectElement(xpath);
                var currentValue = node.Attribute(attr).Value;
                var newValue = Regex.Replace(currentValue, @"(http://\.\*)([A-Za-z0-9\.]*)(/{0,1}\*\$)", $"$1{dns}$3");
                LogFunc($"Old value: {currentValue}, New value: {newValue}");
                node.SetAttributeValue(attr, newValue);
            }
        }

        /// <summary>
        /// Sets the appSettings value.
        /// </summary>
        /// <param name="doc">The document.</param>
        /// <param name="key">The key.</param>
        /// <param name="value">The value.</param>
        protected static void SetAppSettingsValue(XDocument doc, string key, string value)
        {
            if (doc.Document != null)
            {
                SetElement(doc, $"//appSettings/add[@key='{key}']", "value", value);
            }
        }

        /// <summary>
        /// Sets the application settings value.
        /// </summary>
        /// <param name="fullPath">The full path.</param>
        /// <param name="appKey">The application key.</param>
        /// <param name="value">The value.</param>
        protected static void SetAppSettingsValue(string fullPath, string appKey, string value)
        {
            LogFunc($"Setting '{appKey}' to '{value}'.");

            if (!File.Exists(fullPath))
            {
                LogFunc($"File '{fullPath}' doesn't exist.");
                return;
            }

            var doc = XDocument.Parse(File.ReadAllText(fullPath));
            if (doc.Document != null)
            {
                SetAppSettingsValue(doc, appKey, value);
                doc.Save(fullPath);
            }
        }

        /// <summary>
        /// Sets the application settings values.
        /// </summary>
        /// <param name="fullPath">The full path.</param>
        /// <param name="replacePattern">The replace pattern.</param>
        /// <param name="value">The value.</param>
        protected static void SetAppSettingsValues(string fullPath, string replacePattern, string value)
        {
            LogFunc($"Changing app settings by pattern '{replacePattern}' with value {value}.");

            if (!File.Exists(fullPath))
            {
                LogFunc($"File '{fullPath}' doesn't exist.");
                return;
            }

            var doc = XDocument.Parse(File.ReadAllText(fullPath));
            if (doc.Document != null)
            {
                // get all items
                doc.Document.XPathSelectElements("//appSettings/add")
                    .ToList()
                    .ForEach(el => el.SetAttributeValue(el.Attribute("value").Name, Regex.Replace(el.Attribute("value").Value, replacePattern, value)));

                doc.Save(fullPath);
                LogFunc("Changes are done, saved to XDocument.");
            }
        }

        /// <summary>
        /// Sets the authentication/forms domain in web.config for SSO.
        /// </summary>
        protected static void SetAuthenticationDomain(string site, string authDomain)
        {
            var sitePath = site.Split('|')[1];
            var fullName = Path.Combine(sitePath, "web.config");

            LogFunc($@"Is about to update file '{fullName}'.");

            if (!File.Exists(fullName))
            {
                LogFunc("File doesn't exist.");
                return;
            }

            var doc = XDocument.Parse(File.ReadAllText(fullName));
            SetElement(doc, "//authentication/forms", "domain", authDomain);
            doc.Save(fullName);
            LogFunc("Changes are done, saved to XDocument.");
        }

        /// <summary>
        /// Sets the element.
        /// </summary>
        /// <param name="doc">The document.</param>
        /// <param name="xpath">The xpath.</param>
        /// <param name="attr">The attribute to set.</param>
        /// <param name="value">The value.</param>
        protected static void SetElement(XObject doc, string xpath, string attr, string value)
        {
            if (doc?.Document != null)
            {
                var add = doc.Document.XPathSelectElement(xpath);
                add?.SetAttributeValue(attr, value);
            }
        }

        /// <summary>
        /// Opens connection and tries to change database to the provided name.
        /// </summary>
        /// <param name="conBuilder">The con builder.</param>
        /// <param name="dbName">Name of the database.</param>
        /// <returns></returns>
        protected static bool IsUpdated(SqlConnectionStringBuilder conBuilder, string dbName)
        {
            using (var conn = new SqlConnection(conBuilder.ConnectionString))
            {
                conn.Open();

                try
                {
                    conn.ChangeDatabase(dbName);
                    using (var command = new SqlCommand(GetEmbeddedResourceFunc("CheckForUpdate.sql"), conn))
                    {
                        return Convert.ToInt32(command.ExecuteScalar()) == 1;
                    }
                }
                catch
                {
                    conn.Close();
                    return false;
                }
            }
        }


        /// <summary>
        /// Creates the site.
        /// </summary>
        /// <param name="site">The site.</param>
        protected static void CreateSite(string site)
        {
            try
            {
                LogFunc($"Ready to start with site {site}");

                //var siteName = site.Split('|')[0];

                // use dns as site name
                var siteName = site.Split('|')[2];

                if (Session?.CustomActionData == null)
                    throw new Exception("No session data found.");

                if (string.IsNullOrWhiteSpace(siteName))
                    return;

                var root = GetSessionValue("Root");
                var appPool = GetSessionValue("AppPool");

                var useCertificate = GetSessionValue("SSL") == "1";
                var store = GetSessionValue("Store");
                var location = GetSessionValue("StoreLocation");
                var thumb = GetSessionValue("Thumb");

                var sitePath = site.Split('|')[1];
                var dns = site.Split('|')[2];
                var ip = site.Split('|')[3];
                var port = site.Split('|')[4];
                var https = site.Split('|')[5];

                LogFunc("Got session variables");

                using (var serverManager = new ServerManager())
                {
                    if (serverManager.Sites.Any(s => s.Name == siteName))
                    {
                        LogFunc($"'{site}' site already exists, skipping it now.");
                        return;
                    }

                    var config = serverManager.GetApplicationHostConfiguration();

                    var sitesSection = config.GetSection("system.applicationHost/sites");
                    var sitesCollection = sitesSection.GetCollection();

                    var siteElement = sitesCollection.CreateElement("site");
                    siteElement["name"] = siteName;
                    siteElement["id"] = sitesCollection.Max(s => Convert.ToInt32(s.Attributes["id"].Value)) + 1;
                    siteElement["serverAutoStart"] = true;

                    LogFunc("Site element created.");

                    var applicationDefaultsElement = siteElement.GetChildElement("applicationDefaults");
                    applicationDefaultsElement["applicationPool"] = appPool;

                    LogFunc("Application pool assigned.");

                    if (https.Equals("http", StringComparison.OrdinalIgnoreCase))
                    {
                        var bindingsCollection = siteElement.GetCollection("bindings");
                        var bindingElement = bindingsCollection.CreateElement("binding");
                        bindingElement["protocol"] = https;
                        bindingElement["bindingInformation"] = $"{ip}:{port}:{dns}";

                        bindingsCollection.Add(bindingElement);

                        LogFunc("Http binding added to collection.");
                    }

                    var siteCollection = siteElement.GetCollection();

                    var applicationElement = siteCollection.CreateElement("application");
                    applicationElement["path"] = @"/";

                    var applicationCollection = applicationElement.GetCollection();
                    var virtualDirectoryElement = applicationCollection.CreateElement("virtualDirectory");
                    virtualDirectoryElement["path"] = @"/";
                    virtualDirectoryElement["physicalPath"] = Path.Combine(root, sitePath);

                    LogFunc("Application path assigned.");

                    applicationCollection.Add(virtualDirectoryElement);

                    siteCollection.Add(applicationElement);
                    LogFunc("Aplication added to collection.");

                    sitesCollection.Add(siteElement);
                    LogFunc("Site added to collection.");

                    if (https.Equals("https", StringComparison.OrdinalIgnoreCase))
                    {
                        var accessSection = config.GetSection("system.webServer/security/access", siteName);
                        accessSection["sslFlags"] = string.Empty; // "Ssl,SslRequireCert";
                    }

                    serverManager.CommitChanges();

                    if (https.Equals("https", StringComparison.OrdinalIgnoreCase) && useCertificate)
                    {
                        LogFunc("Going to assign the HTTPS certificate.");

                        string storeName;
                        var cert = GetCertificate(store, location, thumb, out storeName);

                        if (cert != null)
                        {
                            LogFunc($"Certificate with thumb '{thumb}' found, adding binding with certificate.");
                            serverManager.Sites[siteName].Bindings.Add($"{ip}:{port}:{dns}", cert.GetCertHash(), storeName);
                        }
                        else
                        {
                            LogFunc($"Certificate with thumb '{thumb}' not found, adding binding without certificate.");
                            serverManager.Sites[siteName].Bindings.Add($"{ip}:{port}:{dns}", https);
                        }

                        serverManager.CommitChanges();

                        LogFunc("Binding committed.");
                    }
                }

                AddToHosts(ip, dns);
            }
            catch (Exception ex)
            {
                LogFunc(ex.ToString());
                throw;
            }
        }


        /// <summary>
        /// Adds record to hosts file.
        /// </summary>
        /// <param name="ip">The ip.</param>
        /// <param name="dns">The DNS.</param>
        protected static void AddToHosts(string ip, string dns)
        {
            var hostsFile = Path.Combine(Environment.GetFolderPath(Environment.SpecialFolder.System), "drivers/etc/hosts");

            RemoveDnsRecords(hostsFile, dns);

            // if provided string is not an IP address (but wildcard for example), do not add to hosts
            System.Net.IPAddress fake;
            if (!System.Net.IPAddress.TryParse(ip, out fake))
                return;

            var record = $"{ip}\t{dns}";

            LogFunc($"Adding to hosts '{record}'.");

            using (var w = File.AppendText(hostsFile))
            {
                w.WriteLine(record + " # Added programmatically during setup");
            }
        }

        /// <summary>
        /// Сleans up hosts file - removes old record for provided DNS.
        /// </summary>
        /// <param name="hostsFile">The hosts file.</param>
        /// <param name="dns">The DNS.</param>
        protected static void RemoveDnsRecords(string hostsFile, string dns)
        {
            var sb = new StringBuilder();
            var hasChanges = false;
            var bak = File.ReadAllText(hostsFile);

            using (var stream = File.OpenText(hostsFile))
            {
                string line;
                while ((line = stream.ReadLine()) != null)
                {
                    if (!line.StartsWith("#") && line.Contains(dns))
                    {
                        hasChanges = true;
                    }
                    else
                    {
                        sb.AppendLine(line);
                    }
                }
            }

            if (hasChanges)
            {
                if (!string.IsNullOrWhiteSpace(bak))
                {
                    File.WriteAllText(GetNextFilename(hostsFile + "{0}.bak"), bak);
                }

                File.WriteAllText(hostsFile, sb.ToString());
            }
        }

        /// <summary>
        /// Gets the connection string from config file.
        /// </summary>
        /// <param name="fullPath">The full path.</param>
        /// <param name="connStrName">Name of the connection string.</param>
        /// <returns></returns>
        protected static string GetConnectionString(string fullPath, string connStrName)
        {
            LogFunc($"Reading connection string in {fullPath}.");

            if (!File.Exists(fullPath))
            {
                LogFunc("File doesn't exist.");
                return null;
            }

            var doc = XDocument.Parse(File.ReadAllText(fullPath));

            var cn = doc.Document?.XPathSelectElement($"//connectionStrings/add[@name='{connStrName}']");
            return cn?.Attribute("connectionString").Value;
        }

        /// <summary>
        /// Updates the connection strings in configuration file.
        /// </summary>
        /// <param name="sitePath">The site path.</param>
        /// <param name="connString">The connection string name.</param>
        /// <param name="sqlServer">The SQL server.</param>
        /// <param name="initialCatalog">Name of the database.</param>
        /// <param name="trusted">Trusted connection, when is true.</param>
        /// <param name="user">The user.</param>
        /// <param name="pwd">The password.</param>
        /// <param name="filename">The filename.</param>
        protected static void UpdateConnectionString(string sitePath, string connString, string sqlServer, string initialCatalog, bool trusted, string user, string pwd, string filename = "web.config")
        {
            var file = Path.Combine(sitePath, filename);

            LogFunc($"Changing connection strings in {file}.");

            if (!File.Exists(file))
            {
                LogFunc("File doesn't exist.");
                return;
            }

            var name = connString.IndexOf(':') == -1
                ? connString
                : connString.Split(new[] { ":" }, StringSplitOptions.RemoveEmptyEntries)[0];

            var dbName = connString.IndexOf(':') == -1
                ? initialCatalog
                : connString.Split(new[] { ":" }, StringSplitOptions.RemoveEmptyEntries)[1];

            var doc = XDocument.Parse(File.ReadAllText(file));
            if (doc.Document != null)
            {
                // get all connection strings
                doc.Document.XPathSelectElements($"//connectionStrings/add[@name='{name}']")
                    .ToList()
                    .ForEach(add =>
                    {
                        var provider = add.Attributes().FirstOrDefault(a => a.Name.LocalName.Equals("providerName", StringComparison.OrdinalIgnoreCase));
                        var connStr = add.Attribute("connectionString").Value;

                        LogFunc($"Found '{connStr}'.");

                        // check provider, as different builders are used for SqlClient connection string and EntityFramework conn str
                        if (provider != null && provider.Value.IndexOf("EntityClient", StringComparison.OrdinalIgnoreCase) > -1)
                        {
                            var efConn = new EntityConnectionStringBuilder(connStr);
                            var sqlConn = new SqlConnectionStringBuilder(efConn.ProviderConnectionString)
                            {
                                DataSource = sqlServer,
                                InitialCatalog = dbName
                            };

                            SetConnectionUser(sqlConn, trusted, user, pwd);

                            efConn.ProviderConnectionString = sqlConn.ConnectionString;
                            add.SetAttributeValue("connectionString", efConn.ConnectionString);

                            LogFunc($"We think it's an Entity Connection string, it now looks like '{efConn.ConnectionString}'.");
                        }
                        else
                        {
                            var sqlConn = new SqlConnectionStringBuilder(connStr)
                            {
                                DataSource = sqlServer,
                                InitialCatalog = dbName
                            };

                            SetConnectionUser(sqlConn, trusted, user, pwd);

                            add.SetAttributeValue("connectionString", sqlConn.ConnectionString);

                            LogFunc($"We think it's a Sql Connection string, it now looks like '{sqlConn.ConnectionString}'.");
                        }
                    });

                doc.Save(file);

                LogFunc("Changes are done, saved to XDocument.");
            }
        }



        /// <summary>
        /// Updates a connection string to use trusted connection or user/pwd pare.
        /// </summary>
        /// <param name="sqlConn">The SQL connection.</param>
        /// <param name="trusted">if set to <c>true</c> [trusted].</param>
        /// <param name="user">The user.</param>
        /// <param name="pwd">The password.</param>
        protected static void SetConnectionUser(SqlConnectionStringBuilder sqlConn, bool trusted, string user, string pwd)
        {
            if (!trusted)
            {
                sqlConn.UserID = user;
                sqlConn.Password = pwd;
                sqlConn.Remove("Integrated Security");
            }
            else
            {
                sqlConn.Remove("User ID");
                sqlConn.Remove("Password");
                sqlConn.IntegratedSecurity = true;
            }
        }


        /// <summary>
        /// Removes the debug settings from web.config.
        /// </summary>
        /// <param name="path">The path.</param>
        protected static void RemoveDebugSettings(string path)
        {
            var fullName = Path.Combine(path, "web.config");
            LogFunc($@"Going to remove debug settings in '{fullName}'.");

            if (!File.Exists(fullName))
            {
                LogFunc("File doesn't exist.");
                return;
            }

            var doc = XDocument.Parse(File.ReadAllText(fullName));

            //https://our.umbraco.org/forum/ourumb-dev-forum/bugs/61824-ClientDependency-problem

            // Commented, because with this setting, the Umbraco doesn't work for unclear reason
            //SetElement(doc, "//compilation[@debug='true']", "debug", "false");

            SetElement(doc, "//customErrors[@mode='Off']", "mode", "On");
            SetElement(doc, "//httpErrors[@errorMode='Off']", "errorMode", "Custom");

            doc.Save(fullName);

            LogFunc("Done");
        }

        /// <summary>
        /// Creates the application pool.
        /// </summary>
        /// <param name="appPoolName">Name of the application pool.</param>
        protected static void CreateAppPool(string appPoolName)
        {
            LogFunc($"Going to create application pool '{appPoolName}'.");

            using (var serverManager = new ServerManager())
            {
                var config = serverManager.GetApplicationHostConfiguration();
                var applicationPoolsSection = config.GetSection("system.applicationHost/applicationPools");
                var applicationPoolsCollection = applicationPoolsSection.GetCollection();

                LogFunc("Collection loaded.");

                if (applicationPoolsCollection.All(c => !((string)c.Attributes["name"].Value).Equals(appPoolName, StringComparison.OrdinalIgnoreCase)))
                {
                    LogFunc($"No '{appPoolName}' application pool found, adding new.");

                    var addElement = applicationPoolsCollection.CreateElement("add");
                    addElement["name"] = appPoolName;
                    addElement["autoStart"] = true;
                    addElement["managedPipelineMode"] = @"Integrated";
                    addElement["managedRuntimeVersion"] = GetIIsVersion().Major >= 7 ? "v4.0" : "v2.0";
                    applicationPoolsCollection.Add(addElement);

                    LogFunc("Ready to commit.");
                    serverManager.CommitChanges();
                    LogFunc("Committed.");
                }
            }

            LogFunc("Application pool created");
        }

        /// <summary>
        /// Gets the IIS version.
        /// </summary>
        /// <returns></returns>
        protected static Version GetIIsVersion()
        {
            using (var componentsKey = Registry.LocalMachine.OpenSubKey(@"Software\Microsoft\InetStp", false))
            {
                if (componentsKey != null)
                {
                    var majorVersion = (int)componentsKey.GetValue("MajorVersion", -1);
                    var minorVersion = (int)componentsKey.GetValue("MinorVersion", -1);

                    if (majorVersion != -1 && minorVersion != -1)
                    {
                        return new Version(majorVersion, minorVersion);
                    }
                }

                return new Version(0, 0);
            }
        }

        /// <summary>
        /// Opens connection and tries to change database to the provided name.
        /// </summary>
        /// <param name="conBuilder">The con builder.</param>
        /// <param name="dbName">Name of the database.</param>
        /// <returns></returns>
        protected static bool DbExists(SqlConnectionStringBuilder conBuilder, string dbName)
        {
            using (var conn = new SqlConnection(conBuilder.ConnectionString))
            {
                conn.Open();

                try
                {
                    conn.ChangeDatabase(dbName);
                    conn.Close();
                }
                catch
                {
                    conn.Close();
                    return false;
                }
            }

            return true;
        }

        /// <summary>
        /// Looks for a certificate in a X.509 store.
        /// </summary>
        /// <param name="store">The store.</param>
        /// <param name="location">The location.</param>
        /// <param name="thumbprint">The thumbprint to search by.</param>
        /// <param name="storeName">Name of the store.</param>
        /// <returns></returns>
        protected static X509Certificate2 GetCertificate(string store, string location, string thumbprint, out string storeName)
        {
            thumbprint = JsonHelper.CleanUp(thumbprint).Replace(" ", string.Empty);

            var name = (StoreName)int.Parse(store);
            var loc = (StoreLocation)int.Parse(location);

            var st = new X509Store(name, loc);
            st.Open(OpenFlags.ReadOnly);
            storeName = st.Name;

            return st.Certificates
                .Cast<X509Certificate2>()
                .Where(c => c.Thumbprint != null)
                .FirstOrDefault(c => c.Thumbprint.Equals(thumbprint, StringComparison.OrdinalIgnoreCase));
        }

        /// <summary>
        /// Replaces the first occurrence of substring.
        /// </summary>
        /// <param name="text">The text.</param>
        /// <param name="search">The search.</param>
        /// <param name="replace">The replace.</param>
        /// <returns></returns>
        protected static string ReplaceFirstOccurrence(string text, string search, string replace)
        {
            int pos = text.IndexOf(search);
            if (pos < 0)
            {
                return text;
            }
            return text.Substring(0, pos) + replace + text.Substring(pos + search.Length);
        }
    }
}
