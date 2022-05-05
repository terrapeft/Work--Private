using System;
using System.Collections.Generic;
using System.Configuration;

namespace SpansLib
{
    public static class AppSettings 
	{
	    private static Configuration _cfg = ConfigurationManager.OpenExeConfiguration(typeof(AppSettings).Assembly.Location);
        private static AppSettingsSection _appSettings;

        private static AppSettingsSection SettingsSection
        {
            get
            {
                if (_appSettings == null)
                {
                    // when working in Quartz folder
                    _appSettings = (AppSettingsSection)_cfg.GetSection("appSettings");
                }
                if (_appSettings.Settings.Count == 0)
                {
                    // when working with UI
                    _cfg = ConfigurationManager.OpenExeConfiguration(ConfigurationUserLevel.None);
                    _appSettings = (AppSettingsSection)_cfg.GetSection("appSettings");
                }

                return _appSettings;
            }
        }


		/// <summary>
        /// Like "e:\cme\ftp\data\"
        /// </summary>
		public static string FtpMirrorPath { get { return SettingsSection.Settings["FtpMirrorPath"].Value; }}

		/// <summary>
        /// Like "Jobs\Sources\spanFile.xsd"
        /// </summary>
		public static string SpanSchemaFile { get { return SettingsSection.Settings["SpanSchemaFile"].Value; }}

		/// <summary>
        /// Like "Sources\spanFile.xsd"
        /// </summary>
		public static string UI_SpanSchemaFile { get { return SettingsSection.Settings["UI_SpanSchemaFile"].Value; }}

		/// <summary>
        /// Like "Jobs\Sources\spanFile.sql"
        /// </summary>
		public static string SpanSqlFile { get { return SettingsSection.Settings["SpanSqlFile"].Value; }}

		/// <summary>
        /// Like "Jobs\Sources\Config.sql"
        /// </summary>
		public static string ConfigSqlFile { get { return SettingsSection.Settings["ConfigSqlFile"].Value; }}

		/// <summary>
        /// Like "Logs\SqLXmlBulkLoadError.xml"
        /// </summary>
		public static string SqlXmlBulkLoadErrorFile { get { return SettingsSection.Settings["SqlXmlBulkLoadErrorFile"].Value; }}
        /// <summary>
        /// Like "1200000"
        /// </summary>
		public static int FtpTimeoutInMilliseconds { get { return int.Parse(SettingsSection.Settings["FtpTimeoutInMilliseconds"].Value); }}

		/// <summary>
        /// Like "anonymous"
        /// </summary>
		public static string FtpLogin { get { return SettingsSection.Settings["FtpLogin"].Value; }}

		/// <summary>
        /// Like "anonymous"
        /// </summary>
		public static string FtpPassword { get { return SettingsSection.Settings["FtpPassword"].Value; }}

		/// <summary>
        /// Like "smtp.fowtradedata.com"
        /// </summary>
		public static string SmtpHost { get { return SettingsSection.Settings["SmtpHost"].Value; }}
        /// <summary>
        /// Like "25"
        /// </summary>
		public static int SmtpPort { get { return int.Parse(SettingsSection.Settings["SmtpPort"].Value); }}
        /// <summary>
        /// Like "False"
        /// </summary>
		public static bool EnableSsl { get { return bool.Parse(SettingsSection.Settings["EnableSsl"].Value); }}

		/// <summary>
        /// Like "SCoughlan@fowtradedata.com,vitaly.chupaev@arcadia.spb.ru"
        /// </summary>
		public static string Recipient { get { return SettingsSection.Settings["Recipient"].Value; }}

		/// <summary>
        /// Like "noreply@fowtradedata.com"
        /// </summary>
		public static string Sender { get { return SettingsSection.Settings["Sender"].Value; }}

		/// <summary>
        /// 
        /// </summary>
		public static string Password { get { return SettingsSection.Settings["Password"].Value; }}
        /// <summary>
        /// Like "1251"
        /// </summary>
		public static int XmlReadEncoding { get { return int.Parse(SettingsSection.Settings["XmlReadEncoding"].Value); }}
        /// <summary>
        /// Like "65001"
        /// </summary>
		public static int XmlWriteEncoding { get { return int.Parse(SettingsSection.Settings["XmlWriteEncoding"].Value); }}

		/// <summary>
        /// Like "[Success] SPAN Quartz Server Report [{0}]"
        /// </summary>
		public static string SubjectTemplateSuccess { get { return SettingsSection.Settings["SubjectTemplateSuccess"].Value; }}

		/// <summary>
        /// Like "[Failure] SPAN Quartz Server Report [{0}]"
        /// </summary>
		public static string SubjectTemplateFailed { get { return SettingsSection.Settings["SubjectTemplateFailed"].Value; }}

		/// <summary>
        /// Like "Jobs\EmailTemplates\SyncReport.html"
        /// </summary>
		public static string BodyTemplate { get { return SettingsSection.Settings["BodyTemplate"].Value; }}

		/// <summary>
        /// Like "Jobs\EmailTemplates\ErrorItem.html"
        /// </summary>
		public static string ErrorItemTemplate { get { return SettingsSection.Settings["ErrorItemTemplate"].Value; }}

		/// <summary>
        /// Like "Jobs\EmailTemplates\LogItem.html"
        /// </summary>
		public static string LogItemTemplate { get { return SettingsSection.Settings["LogItemTemplate"].Value; }}

		/// <summary>
        /// Like "Jobs\EmailTemplates\MissedElement.html"
        /// </summary>
		public static string MissedElementsTemplate { get { return SettingsSection.Settings["MissedElementsTemplate"].Value; }}
		/// <summary>
        /// Like ".spn;.xml"
        /// </summary>
        public static IEnumerable<string> XmlFormats { get { return SettingsSection.Settings["XmlFormats"].Value.Split(new [] {';'}, StringSplitOptions.RemoveEmptyEntries); }}
		/// <summary>
        /// Like ".csv;.pa6;.pa5;.pa3;.pa2"
        /// </summary>
        public static IEnumerable<string> TextFormats { get { return SettingsSection.Settings["TextFormats"].Value.Split(new [] {';'}, StringSplitOptions.RemoveEmptyEntries); }}

		/// <summary>
        /// Like "ftp://ftp.cmegroup.com/pub/span/util"
        /// </summary>
		public static string FtpUtilsUrl { get { return SettingsSection.Settings["FtpUtilsUrl"].Value; }}

		/// <summary>
        /// Like "ftp://ftp.cmegroup.com/pub/span/data"
        /// </summary>
		public static string FtpDataUrl { get { return SettingsSection.Settings["FtpDataUrl"].Value; }}
		/// <summary>
        /// Like "OrgMast.xml;CMEcntrSpecs.xml;MarginRates.xml;product_calendar.xml"
        /// </summary>
        public static IEnumerable<string> FtpFiles { get { return SettingsSection.Settings["FtpFiles"].Value.Split(new [] {';'}, StringSplitOptions.RemoveEmptyEntries); }}
        /// <summary>
        /// Like "4"
        /// </summary>
		public static int FtpNumberOfThreads { get { return int.Parse(SettingsSection.Settings["FtpNumberOfThreads"].Value); }}

		/// <summary>
        /// Like "nvarchar(2000)"
        /// </summary>
		public static string DefaultStringColumnType { get { return SettingsSection.Settings["DefaultStringColumnType"].Value; }}

		/// <summary>
        /// Like "_FileId"
        /// </summary>
		public static string FileIdFieldName { get { return SettingsSection.Settings["FileIdFieldName"].Value; }}

		/// <summary>
        /// Like "_LineNumber"
        /// </summary>
		public static string LineNumberFieldName { get { return SettingsSection.Settings["LineNumberFieldName"].Value; }}

		/// <summary>
        /// Like "_ParentLineNumber"
        /// </summary>
		public static string ParentLineNumberFieldName { get { return SettingsSection.Settings["ParentLineNumberFieldName"].Value; }}

		/// <summary>
        /// Like "import_Error"
        /// </summary>
		public static string ErrorTableName { get { return SettingsSection.Settings["ErrorTableName"].Value; }}

		/// <summary>
        /// Like "import_"
        /// </summary>
		public static string ImportTablesPrefix { get { return SettingsSection.Settings["ImportTablesPrefix"].Value; }}

		/// <summary>
        /// Like "metadata=res://*/Db.SpansConfig.csdl|res://*/Db.SpansConfig.ssdl|res://*/Db.SpansConfig.msl;provider=System.Data.SqlClient;provider connection string="{0}""
        /// </summary>
		public static string SpansEntitiesConnStrTemplate { get { return SettingsSection.Settings["SpansEntitiesConnStrTemplate"].Value; }}

		/// <summary>
        /// Like "update import_Log set StartDateUtc = '{1}' where Id = {0}"
        /// </summary>
		public static string SetJobStartTimeTemplate { get { return SettingsSection.Settings["SetJobStartTimeTemplate"].Value; }}

		/// <summary>
        /// Like "       with flags as ( 	      SELECT 1 [exists] FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_FindMissedElements]') AND type in (N'P', N'PC') 	      union all 	      SELECT 1 [exists] FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ftp_Batches]') AND type in (N'U') 	      union all 	      SELECT 1 [exists] FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[cfg_RecordTableName]') AND type in (N'U') 	      union all 	      SELECT 1 [exists] FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[import_Log]') AND type in (N'U')       )       select count(*)        from flags"
        /// </summary>
		public static string HasConfigTables { get { return SettingsSection.Settings["HasConfigTables"].Value; }}
        /// <summary>
        /// Like "4"
        /// </summary>
		public static int HasConfigTablesExpectedCount { get { return int.Parse(SettingsSection.Settings["HasConfigTablesExpectedCount"].Value); }}

		/// <summary>
        /// Like "       with flags as ( 	      SELECT 1 [exists] FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spanFile]') AND type in (N'U')       )       select count(*)        from flags"
        /// </summary>
		public static string HasXmlTables { get { return SettingsSection.Settings["HasXmlTables"].Value; }}
        /// <summary>
        /// Like "1"
        /// </summary>
		public static int HasXmlTablesExpectedCount { get { return int.Parse(SettingsSection.Settings["HasXmlTablesExpectedCount"].Value); }}

		/// <summary>
        /// Like " IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[{0}]') AND type in (N'U')) CREATE TABLE [dbo].[{0}] ( "
        /// </summary>
		public static string TableCreateSqlFormatOpen { get { return SettingsSection.Settings["TableCreateSqlFormatOpen"].Value; }}

		/// <summary>
        /// Like " IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[{0}]') AND type in (N'U')) DROP TABLE [dbo].[{0}] GO CREATE TABLE [dbo].[{0}] ( "
        /// </summary>
		public static string TableDropAndCreateSqlFormatOpen { get { return SettingsSection.Settings["TableDropAndCreateSqlFormatOpen"].Value; }}

		/// <summary>
        /// Like ") GO "
        /// </summary>
		public static string TableDropOrCreateSqlFormatClose { get { return SettingsSection.Settings["TableDropOrCreateSqlFormatClose"].Value; }}

		/// <summary>
        /// Like "insert into dbo.paFile (batchId, filename) output inserted.Id values ({0}, '{1}') "
        /// </summary>
		public static string FileMappingInsertSqlFormat { get { return SettingsSection.Settings["FileMappingInsertSqlFormat"].Value; }}

		/// <summary>
        /// Like " IF COL_LENGTH('{0}','{1}') IS NULL BEGIN   DELETE FROM dbo.{0}   ALTER TABLE {0} ADD [{1}] int not null END GO "
        /// </summary>
		public static string MasterRecordIdSqlFormat { get { return SettingsSection.Settings["MasterRecordIdSqlFormat"].Value; }}

		/// <summary>
        /// Like " IF COL_LENGTH('{0}','{1}') IS NULL          BEGIN   DELETE FROM dbo.{0}   ALTER TABLE {0} ADD [{1}] int identity(1, 1)   ALTER TABLE {0} ADD CONSTRAINT [PK_{0}] primary key ({1}) END GO "
        /// </summary>
		public static string FileIdForMasterTableSqlFormat { get { return SettingsSection.Settings["FileIdForMasterTableSqlFormat"].Value; }}

		/// <summary>
        /// Like "Complete."
        /// </summary>
		public static string ReportComplete { get { return SettingsSection.Settings["ReportComplete"].Value; }}

		/// <summary>
        /// Like "Success"
        /// </summary>
		public static string ReportJobSuccess { get { return SettingsSection.Settings["ReportJobSuccess"].Value; }}

		/// <summary>
        /// Like "Failure"
        /// </summary>
		public static string ReportJobFailure { get { return SettingsSection.Settings["ReportJobFailure"].Value; }}

		/// <summary>
        /// Like "List "
        /// </summary>
		public static string ReportFtpListDirectory { get { return SettingsSection.Settings["ReportFtpListDirectory"].Value; }}

		/// <summary>
        /// Like "Started downloading "
        /// </summary>
		public static string ReportFtpDownloadFile { get { return SettingsSection.Settings["ReportFtpDownloadFile"].Value; }}

		/// <summary>
        /// Like " already exists, download was skipped"
        /// </summary>
		public static string ReportSkipDownload { get { return SettingsSection.Settings["ReportSkipDownload"].Value; }}

		/// <summary>
        /// Like "Canceled"
        /// </summary>
		public static string ReportCanceled { get { return SettingsSection.Settings["ReportCanceled"].Value; }}

		/// <summary>
        /// Like "Ready to start, local path: "
        /// </summary>
		public static string ReportSyncStart { get { return SettingsSection.Settings["ReportSyncStart"].Value; }}

		/// <summary>
        /// Like "Ignore folders: "
        /// </summary>
		public static string ReportSyncIgnoreFolders { get { return SettingsSection.Settings["ReportSyncIgnoreFolders"].Value; }}

		/// <summary>
        /// Like "Ignore file types: "
        /// </summary>
		public static string ReportSyncIgnoreFiles { get { return SettingsSection.Settings["ReportSyncIgnoreFiles"].Value; }}

		/// <summary>
        /// Like "Files date for download, started from: "
        /// </summary>
		public static string ReportSyncStartTime { get { return SettingsSection.Settings["ReportSyncStartTime"].Value; }}

		/// <summary>
        /// Like "Overwrite files: "
        /// </summary>
		public static string ReportSyncOverwrite { get { return SettingsSection.Settings["ReportSyncOverwrite"].Value; }}

		/// <summary>
        /// Like "--------------- Files to download: {0}, total size: {1} "
        /// </summary>
		public static string ReportSyncFilesToDownloadTemplate { get { return SettingsSection.Settings["ReportSyncFilesToDownloadTemplate"].Value; }}

		/// <summary>
        /// Like "No missing files found for date {0}."
        /// </summary>
		public static string ReportSyncUpToDateTemplate { get { return SettingsSection.Settings["ReportSyncUpToDateTemplate"].Value; }}

		/// <summary>
        /// Like "No files found for date {0}."
        /// </summary>
		public static string ReportSyncNoFilesTemplate { get { return SettingsSection.Settings["ReportSyncNoFilesTemplate"].Value; }}

		/// <summary>
        /// Like "Ready to start, overwrite data: "
        /// </summary>
		public static string ReportDataStart { get { return SettingsSection.Settings["ReportDataStart"].Value; }}

		/// <summary>
        /// Like "Files found: "
        /// </summary>
		public static string ReportDataFilesFound { get { return SettingsSection.Settings["ReportDataFilesFound"].Value; }}

		/// <summary>
        /// Like "Files to process: "
        /// </summary>
		public static string ReportDataFilesToProcess { get { return SettingsSection.Settings["ReportDataFilesToProcess"].Value; }}

		/// <summary>
        /// Like "Started uploading "
        /// </summary>
		public static string ReportDataUploadFile { get { return SettingsSection.Settings["ReportDataUploadFile"].Value; }}

		/// <summary>
        /// Like "No reader or writer was found"
        /// </summary>
		public static string ReportDataUnknownFormat { get { return SettingsSection.Settings["ReportDataUnknownFormat"].Value; }}

		/// <summary>
        /// Like "{0}: already in database"
        /// </summary>
		public static string ReportDataSkipInsertTemplate { get { return SettingsSection.Settings["ReportDataSkipInsertTemplate"].Value; }}

		/// <summary>
        /// Like "Unzip "
        /// </summary>
		public static string ReportDataUnzipFile { get { return SettingsSection.Settings["ReportDataUnzipFile"].Value; }}

		/// <summary>
        /// Like "Error: "
        /// </summary>
		public static string ReportDataErrorPrefix { get { return SettingsSection.Settings["ReportDataErrorPrefix"].Value; }}

		/// <summary>
        /// Like "Invalid xml in file {0}."
        /// </summary>
		public static string ReportXmlCheckerInvalidXmlTemplate { get { return SettingsSection.Settings["ReportXmlCheckerInvalidXmlTemplate"].Value; }}

		/// <summary>
        /// Like "File was read with '{0}' encoding and overwritten as '{1}'"
        /// </summary>
		public static string ReportXmlCheckerReencodeTemplate { get { return SettingsSection.Settings["ReportXmlCheckerReencodeTemplate"].Value; }}

		/// <summary>
        /// Like "Unknown record type"
        /// </summary>
		public static string ReportPaUnknownRecord { get { return SettingsSection.Settings["ReportPaUnknownRecord"].Value; }}

		/// <summary>
        /// Like "Unknown record type: '{0}'"
        /// </summary>
		public static string ReportPaUnknownRecordTemplate { get { return SettingsSection.Settings["ReportPaUnknownRecordTemplate"].Value; }}

		/// <summary>
        /// Like "Unknown file format: '{0}'"
        /// </summary>
		public static string ReportPaUnknownFileTemplate { get { return SettingsSection.Settings["ReportPaUnknownFileTemplate"].Value; }}

		/// <summary>
        /// Like "Ready to start, FTP path: {0}"
        /// </summary>
		public static string ReportDocsStartTemplate { get { return SettingsSection.Settings["ReportDocsStartTemplate"].Value; }}

		/// <summary>
        /// Like "Local path: {0}"
        /// </summary>
		public static string ReportDocsLocalPathTemplate { get { return SettingsSection.Settings["ReportDocsLocalPathTemplate"].Value; }}

		/// <summary>
        /// Like "Download files: {0}"
        /// </summary>
		public static string ReportDocsDownloadListTemplate { get { return SettingsSection.Settings["ReportDocsDownloadListTemplate"].Value; }}

		/// <summary>
        /// Like "Started downloading {0}"
        /// </summary>
		public static string ReportDocsStartDownloadFileTemplate { get { return SettingsSection.Settings["ReportDocsStartDownloadFileTemplate"].Value; }}

		/// <summary>
        /// Like "Sql file: {0}"
        /// </summary>
		public static string ReportDocsSqlFileTemplate { get { return SettingsSection.Settings["ReportDocsSqlFileTemplate"].Value; }}

		/// <summary>
        /// Like "Xslt file: {0}"
        /// </summary>
		public static string ReportDocsXsltFileTemplate { get { return SettingsSection.Settings["ReportDocsXsltFileTemplate"].Value; }}

		/// <summary>
        /// Like "Xsd file: {0}"
        /// </summary>
		public static string ReportDocsXsdFileTemplate { get { return SettingsSection.Settings["ReportDocsXsdFileTemplate"].Value; }}

		/// <summary>
        /// Like "Xml file: {0}"
        /// </summary>
		public static string ReportDocsXmlFileTemplate { get { return SettingsSection.Settings["ReportDocsXmlFileTemplate"].Value; }}

		/// <summary>
        /// Like "Xml transformed file: {0}"
        /// </summary>
		public static string ReportDocsXmlTransformedFileTemplate { get { return SettingsSection.Settings["ReportDocsXmlTransformedFileTemplate"].Value; }}

		/// <summary>
        /// Like "Start transformation."
        /// </summary>
		public static string ReportDocsStartTransformation { get { return SettingsSection.Settings["ReportDocsStartTransformation"].Value; }}

		/// <summary>
        /// Like "Start bulk load."
        /// </summary>
		public static string ReportDocsStartBulkLoad { get { return SettingsSection.Settings["ReportDocsStartBulkLoad"].Value; }}

		/// <summary>
        /// Like "[!] Error processing {0}"
        /// </summary>
		public static string ReportDocsErrorForLogTableTemplate { get { return SettingsSection.Settings["ReportDocsErrorForLogTableTemplate"].Value; }}

		/// <summary>
        /// Like "Ready to start installation."
        /// </summary>
		public static string ReportInstallStart { get { return SettingsSection.Settings["ReportInstallStart"].Value; }}

		/// <summary>
        /// Like "Script {0}, overwrite: {1}"
        /// </summary>
		public static string ReportInstallRunScriptTemplate { get { return SettingsSection.Settings["ReportInstallRunScriptTemplate"].Value; }}

		/// <summary>
        /// Like "Job start was not logged and file information was not found."
        /// </summary>
		public static string ErrorJobFinishedIncorrectly { get { return SettingsSection.Settings["ErrorJobFinishedIncorrectly"].Value; }}
    }
}

