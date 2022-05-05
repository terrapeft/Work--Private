using System;
using System.IO;
using System.Text;
using SharedLibrary;
using SpansLib.Db;
using SpansLib.Ftp;
using WinSCP;

namespace SpansLib.Data.XmlFormats
{
    public class DocsProcessor
    {
        private const string TransformedFolder = "Transformed";
        private const string TransformedFileSuffix = "_transformed.xml";

        /// <summary>
        /// Loads files from the specified FTP path, transforms, and inserts into database.
        /// </summary>
        /// <param name="ftpPath">The FTP path.</param>
        /// <param name="connStr">The connection string.</param>
        /// <param name="filePath">The file path.</param>
        /// <param name="serviceFiles">The service files.</param>
        /// <param name="callback">The callback.</param>
        public static void Load(string ftpPath, string connStr, string filePath, string serviceFiles, Action<string> callback)
        {
            var ftp = new FtpHelper(new Uri(ftpPath), Protocol.Ftp);
            var xbi = new SqlXmlBulkInsert(connStr);
            var db = new DbHelper(connStr);

            callback.Answer(string.Format(AppSettings.ReportDocsStartTemplate, ftpPath));
            callback.Answer(string.Format(AppSettings.ReportDocsLocalPathTemplate, filePath));
            callback.Answer(string.Format(AppSettings.ReportDocsDownloadListTemplate, serviceFiles));

            foreach (var file in AppSettings.FtpFiles)
            {
                try
                {
                    callback.Answer(string.Format(AppSettings.ReportDocsStartDownloadFileTemplate, file));
                    ftp.Download(file, ftpPath, filePath, msg => callback.Answer(msg), useBinary: false);

                    // At the moment of coding, this line and stuff was written for the CMEcntrSpecs.xml files, which containes illegal characters.
                    XmlChecker.TryFixXml(Path.Combine(filePath, file), msg => callback.Answer(msg));

                    callback.Answer(AppSettings.ReportComplete);

                    var sqlFile = ChangeExtension(serviceFiles, file, Constants.SqlExt);
                    var xsltFile = ChangeExtension(serviceFiles, file, Constants.XsltExt);
                    var xsdFile = ChangeExtension(serviceFiles, file, Constants.XsdExt);

                    callback.Answer(string.Format(AppSettings.ReportDocsSqlFileTemplate, sqlFile));
                    callback.Answer(string.Format(AppSettings.ReportDocsXsltFileTemplate, xsltFile));
                    callback.Answer(string.Format(AppSettings.ReportDocsXsdFileTemplate, xsdFile));

                    var xmlFile = Path.Combine(filePath, file);

                    callback.Answer(string.Format(AppSettings.ReportDocsXmlFileTemplate, xmlFile));

                    if (!string.IsNullOrEmpty(sqlFile) /*&& overwrite*/)
                    {
                        db.ExecuteDdl(sqlFile);
                    }

                    if (File.Exists(xsltFile))
                    {
                        var dir = Path.Combine(filePath, TransformedFolder);
                        Directory.CreateDirectory(dir);

                        var xmlTFile = Path.Combine(dir,
                            Path.GetFileNameWithoutExtension(xsltFile) + TransformedFileSuffix);
                        callback.Answer(string.Format(AppSettings.ReportDocsXmlTransformedFileTemplate, xmlTFile));

                        if (File.Exists(xmlTFile))
                        {
                            File.Delete(xmlTFile);
                        }

                        callback.Answer(AppSettings.ReportDocsStartTransformation);
                        XsltProcessing.Transform(xmlFile, xsltFile, xmlTFile);
                        callback.Answer(AppSettings.ReportComplete);

                        xmlFile = xmlTFile;
                    }

                    if (!string.IsNullOrEmpty(xsdFile))
                    {
                        callback.Answer(AppSettings.ReportDocsStartBulkLoad);
                        xbi.BulkLoad(xmlFile, xsdFile, AppSettings.SqlXmlBulkLoadErrorFile);
                        callback.Answer(AppSettings.ReportComplete);
                    }
                }
                catch (Exception ex)
                {
                    callback.Answer(string.Format(AppSettings.ReportDocsErrorForLogTableTemplate, file));
                    DbLogger.Instance.LogError(file, ex.ToString());
                }
            }
        }

        /// <summary>
        /// Changes the file extension.
        /// </summary>
        /// <param name="filePath">The file path.</param>
        /// <param name="file">The file.</param>
        /// <param name="newExtension">The new extension.</param>
        /// <returns></returns>
        private static string ChangeExtension(string filePath, string file, string newExtension)
        {
            return Path.Combine(filePath, Path.GetFileNameWithoutExtension(file) + newExtension);
        }

    }
}
