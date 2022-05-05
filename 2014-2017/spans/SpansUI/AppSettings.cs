using System;
using System.Collections.Generic;
using System.Configuration;

namespace SpansUI
{
    public static class AppSettings 
	{
		public static string FtpMirrorPath { get { return ConfigurationManager.AppSettings["UI_FtpMirrorPath"] ?? ConfigurationManager.AppSettings["FtpMirrorPath"]; }}
		public static string SpanSchemaFile { get { return ConfigurationManager.AppSettings["UI_SpanSchemaFile"] ?? ConfigurationManager.AppSettings["SpanSchemaFile"]; }}
		public static string SpanSqlFile { get { return ConfigurationManager.AppSettings["UI_SpanSqlFile"] ?? ConfigurationManager.AppSettings["SpanSqlFile"]; }}
		public static string ConfigSqlFile { get { return ConfigurationManager.AppSettings["UI_ConfigSqlFile"] ?? ConfigurationManager.AppSettings["ConfigSqlFile"]; }}
		public static string SqlXmlBulkLoadErrorFile { get { return ConfigurationManager.AppSettings["UI_SqlXmlBulkLoadErrorFile"] ?? ConfigurationManager.AppSettings["SqlXmlBulkLoadErrorFile"]; }}
		public static int FtpTimeoutInMilliseconds { get { return int.Parse(ConfigurationManager.AppSettings["FtpTimeoutInMilliseconds"]); }}
		public static string FtpLogin { get { return ConfigurationManager.AppSettings["UI_FtpLogin"] ?? ConfigurationManager.AppSettings["FtpLogin"]; }}
		public static string FtpPassword { get { return ConfigurationManager.AppSettings["UI_FtpPassword"] ?? ConfigurationManager.AppSettings["FtpPassword"]; }}
		public static string SmtpHost { get { return ConfigurationManager.AppSettings["UI_SmtpHost"] ?? ConfigurationManager.AppSettings["SmtpHost"]; }}
		public static int SmtpPort { get { return int.Parse(ConfigurationManager.AppSettings["SmtpPort"]); }}
		public static bool EnableSsl { get { return bool.Parse(ConfigurationManager.AppSettings["EnableSsl"]); }}
		public static string Recipient { get { return ConfigurationManager.AppSettings["UI_Recipient"] ?? ConfigurationManager.AppSettings["Recipient"]; }}
		public static string Sender { get { return ConfigurationManager.AppSettings["UI_Sender"] ?? ConfigurationManager.AppSettings["Sender"]; }}
		public static string Password { get { return ConfigurationManager.AppSettings["UI_Password"] ?? ConfigurationManager.AppSettings["Password"]; }}
		public static int XmlReadEncoding { get { return int.Parse(ConfigurationManager.AppSettings["XmlReadEncoding"]); }}
		public static int XmlWriteEncoding { get { return int.Parse(ConfigurationManager.AppSettings["XmlWriteEncoding"]); }}
		public static string SubjectTemplateSuccess { get { return ConfigurationManager.AppSettings["UI_SubjectTemplateSuccess"] ?? ConfigurationManager.AppSettings["SubjectTemplateSuccess"]; }}
		public static string SubjectTemplateFailed { get { return ConfigurationManager.AppSettings["UI_SubjectTemplateFailed"] ?? ConfigurationManager.AppSettings["SubjectTemplateFailed"]; }}
		public static string BodyTemplate { get { return ConfigurationManager.AppSettings["UI_BodyTemplate"] ?? ConfigurationManager.AppSettings["BodyTemplate"]; }}
		public static string ErrorItemTemplate { get { return ConfigurationManager.AppSettings["UI_ErrorItemTemplate"] ?? ConfigurationManager.AppSettings["ErrorItemTemplate"]; }}
		public static string LogItemTemplate { get { return ConfigurationManager.AppSettings["UI_LogItemTemplate"] ?? ConfigurationManager.AppSettings["LogItemTemplate"]; }}
		public static string MissedElementsTemplate { get { return ConfigurationManager.AppSettings["UI_MissedElementsTemplate"] ?? ConfigurationManager.AppSettings["MissedElementsTemplate"]; }}
        public static IEnumerable<string> XmlFormats { get { return ConfigurationManager.AppSettings["XmlFormats"].Split(new [] {';'}, StringSplitOptions.RemoveEmptyEntries); }}
        public static IEnumerable<string> TextFormats { get { return ConfigurationManager.AppSettings["TextFormats"].Split(new [] {';'}, StringSplitOptions.RemoveEmptyEntries); }}
		public static string FtpUtilsUrl { get { return ConfigurationManager.AppSettings["UI_FtpUtilsUrl"] ?? ConfigurationManager.AppSettings["FtpUtilsUrl"]; }}
		public static string FtpDataUrl { get { return ConfigurationManager.AppSettings["UI_FtpDataUrl"] ?? ConfigurationManager.AppSettings["FtpDataUrl"]; }}
        public static IEnumerable<string> FtpFiles { get { return ConfigurationManager.AppSettings["FtpFiles"].Split(new [] {';'}, StringSplitOptions.RemoveEmptyEntries); }}
		public static int FtpNumberOfThreads { get { return int.Parse(ConfigurationManager.AppSettings["FtpNumberOfThreads"]); }}
		public static string DefaultStringColumnType { get { return ConfigurationManager.AppSettings["UI_DefaultStringColumnType"] ?? ConfigurationManager.AppSettings["DefaultStringColumnType"]; }}
		public static string FileIdFieldName { get { return ConfigurationManager.AppSettings["UI_FileIdFieldName"] ?? ConfigurationManager.AppSettings["FileIdFieldName"]; }}
		public static string LineNumberFieldName { get { return ConfigurationManager.AppSettings["UI_LineNumberFieldName"] ?? ConfigurationManager.AppSettings["LineNumberFieldName"]; }}
		public static string ParentLineNumberFieldName { get { return ConfigurationManager.AppSettings["UI_ParentLineNumberFieldName"] ?? ConfigurationManager.AppSettings["ParentLineNumberFieldName"]; }}
		public static string ErrorTableName { get { return ConfigurationManager.AppSettings["UI_ErrorTableName"] ?? ConfigurationManager.AppSettings["ErrorTableName"]; }}
		public static string ImportTablesPrefix { get { return ConfigurationManager.AppSettings["UI_ImportTablesPrefix"] ?? ConfigurationManager.AppSettings["ImportTablesPrefix"]; }}
        public static IEnumerable<string> SpansEntitiesConnStrTemplate { get { return ConfigurationManager.AppSettings["SpansEntitiesConnStrTemplate"].Split(new [] {';'}, StringSplitOptions.RemoveEmptyEntries); }}
		public static string SetJobStartTimeTemplate { get { return ConfigurationManager.AppSettings["UI_SetJobStartTimeTemplate"] ?? ConfigurationManager.AppSettings["SetJobStartTimeTemplate"]; }}
		public static string HasConfigTables { get { return ConfigurationManager.AppSettings["UI_HasConfigTables"] ?? ConfigurationManager.AppSettings["HasConfigTables"]; }}
		public static int HasConfigTablesExpectedCount { get { return int.Parse(ConfigurationManager.AppSettings["HasConfigTablesExpectedCount"]); }}
		public static string HasXmlTables { get { return ConfigurationManager.AppSettings["UI_HasXmlTables"] ?? ConfigurationManager.AppSettings["HasXmlTables"]; }}
		public static int HasXmlTablesExpectedCount { get { return int.Parse(ConfigurationManager.AppSettings["HasXmlTablesExpectedCount"]); }}
		public static string TableCreateSqlFormatOpen { get { return ConfigurationManager.AppSettings["UI_TableCreateSqlFormatOpen"] ?? ConfigurationManager.AppSettings["TableCreateSqlFormatOpen"]; }}
		public static string TableDropAndCreateSqlFormatOpen { get { return ConfigurationManager.AppSettings["UI_TableDropAndCreateSqlFormatOpen"] ?? ConfigurationManager.AppSettings["TableDropAndCreateSqlFormatOpen"]; }}
		public static string TableDropOrCreateSqlFormatClose { get { return ConfigurationManager.AppSettings["UI_TableDropOrCreateSqlFormatClose"] ?? ConfigurationManager.AppSettings["TableDropOrCreateSqlFormatClose"]; }}
		public static string FileMappingInsertSqlFormat { get { return ConfigurationManager.AppSettings["UI_FileMappingInsertSqlFormat"] ?? ConfigurationManager.AppSettings["FileMappingInsertSqlFormat"]; }}
		public static string MasterRecordIdSqlFormat { get { return ConfigurationManager.AppSettings["UI_MasterRecordIdSqlFormat"] ?? ConfigurationManager.AppSettings["MasterRecordIdSqlFormat"]; }}
		public static string FileIdForMasterTableSqlFormat { get { return ConfigurationManager.AppSettings["UI_FileIdForMasterTableSqlFormat"] ?? ConfigurationManager.AppSettings["FileIdForMasterTableSqlFormat"]; }}
		public static string ReportComplete { get { return ConfigurationManager.AppSettings["UI_ReportComplete"] ?? ConfigurationManager.AppSettings["ReportComplete"]; }}
		public static string ReportJobSuccess { get { return ConfigurationManager.AppSettings["UI_ReportJobSuccess"] ?? ConfigurationManager.AppSettings["ReportJobSuccess"]; }}
		public static string ReportJobFailure { get { return ConfigurationManager.AppSettings["UI_ReportJobFailure"] ?? ConfigurationManager.AppSettings["ReportJobFailure"]; }}
		public static string ReportFtpListDirectory { get { return ConfigurationManager.AppSettings["UI_ReportFtpListDirectory"] ?? ConfigurationManager.AppSettings["ReportFtpListDirectory"]; }}
		public static string ReportFtpDownloadFile { get { return ConfigurationManager.AppSettings["UI_ReportFtpDownloadFile"] ?? ConfigurationManager.AppSettings["ReportFtpDownloadFile"]; }}
		public static string ReportSkipDownload { get { return ConfigurationManager.AppSettings["UI_ReportSkipDownload"] ?? ConfigurationManager.AppSettings["ReportSkipDownload"]; }}
		public static string ReportCanceled { get { return ConfigurationManager.AppSettings["UI_ReportCanceled"] ?? ConfigurationManager.AppSettings["ReportCanceled"]; }}
		public static string ReportSyncStart { get { return ConfigurationManager.AppSettings["UI_ReportSyncStart"] ?? ConfigurationManager.AppSettings["ReportSyncStart"]; }}
		public static string ReportSyncIgnoreFolders { get { return ConfigurationManager.AppSettings["UI_ReportSyncIgnoreFolders"] ?? ConfigurationManager.AppSettings["ReportSyncIgnoreFolders"]; }}
		public static string ReportSyncIgnoreFiles { get { return ConfigurationManager.AppSettings["UI_ReportSyncIgnoreFiles"] ?? ConfigurationManager.AppSettings["ReportSyncIgnoreFiles"]; }}
		public static string ReportSyncStartTime { get { return ConfigurationManager.AppSettings["UI_ReportSyncStartTime"] ?? ConfigurationManager.AppSettings["ReportSyncStartTime"]; }}
		public static string ReportSyncOverwrite { get { return ConfigurationManager.AppSettings["UI_ReportSyncOverwrite"] ?? ConfigurationManager.AppSettings["ReportSyncOverwrite"]; }}
		public static string ReportSyncFilesToDownloadTemplate { get { return ConfigurationManager.AppSettings["UI_ReportSyncFilesToDownloadTemplate"] ?? ConfigurationManager.AppSettings["ReportSyncFilesToDownloadTemplate"]; }}
		public static string ReportSyncUpToDateTemplate { get { return ConfigurationManager.AppSettings["UI_ReportSyncUpToDateTemplate"] ?? ConfigurationManager.AppSettings["ReportSyncUpToDateTemplate"]; }}
		public static string ReportSyncNoFilesTemplate { get { return ConfigurationManager.AppSettings["UI_ReportSyncNoFilesTemplate"] ?? ConfigurationManager.AppSettings["ReportSyncNoFilesTemplate"]; }}
		public static string ReportDataStart { get { return ConfigurationManager.AppSettings["UI_ReportDataStart"] ?? ConfigurationManager.AppSettings["ReportDataStart"]; }}
		public static string ReportDataFilesFound { get { return ConfigurationManager.AppSettings["UI_ReportDataFilesFound"] ?? ConfigurationManager.AppSettings["ReportDataFilesFound"]; }}
		public static string ReportDataFilesToProcess { get { return ConfigurationManager.AppSettings["UI_ReportDataFilesToProcess"] ?? ConfigurationManager.AppSettings["ReportDataFilesToProcess"]; }}
		public static string ReportDataUploadFile { get { return ConfigurationManager.AppSettings["UI_ReportDataUploadFile"] ?? ConfigurationManager.AppSettings["ReportDataUploadFile"]; }}
		public static string ReportDataUnknownFormat { get { return ConfigurationManager.AppSettings["UI_ReportDataUnknownFormat"] ?? ConfigurationManager.AppSettings["ReportDataUnknownFormat"]; }}
		public static string ReportDataSkipInsertTemplate { get { return ConfigurationManager.AppSettings["UI_ReportDataSkipInsertTemplate"] ?? ConfigurationManager.AppSettings["ReportDataSkipInsertTemplate"]; }}
		public static string ReportDataUnzipFile { get { return ConfigurationManager.AppSettings["UI_ReportDataUnzipFile"] ?? ConfigurationManager.AppSettings["ReportDataUnzipFile"]; }}
		public static string ReportDataErrorPrefix { get { return ConfigurationManager.AppSettings["UI_ReportDataErrorPrefix"] ?? ConfigurationManager.AppSettings["ReportDataErrorPrefix"]; }}
		public static string ReportXmlCheckerInvalidXmlTemplate { get { return ConfigurationManager.AppSettings["UI_ReportXmlCheckerInvalidXmlTemplate"] ?? ConfigurationManager.AppSettings["ReportXmlCheckerInvalidXmlTemplate"]; }}
		public static string ReportXmlCheckerReencodeTemplate { get { return ConfigurationManager.AppSettings["UI_ReportXmlCheckerReencodeTemplate"] ?? ConfigurationManager.AppSettings["ReportXmlCheckerReencodeTemplate"]; }}
		public static string ReportPaUnknownRecord { get { return ConfigurationManager.AppSettings["UI_ReportPaUnknownRecord"] ?? ConfigurationManager.AppSettings["ReportPaUnknownRecord"]; }}
		public static string ReportPaUnknownRecordTemplate { get { return ConfigurationManager.AppSettings["UI_ReportPaUnknownRecordTemplate"] ?? ConfigurationManager.AppSettings["ReportPaUnknownRecordTemplate"]; }}
		public static string ReportPaUnknownFileTemplate { get { return ConfigurationManager.AppSettings["UI_ReportPaUnknownFileTemplate"] ?? ConfigurationManager.AppSettings["ReportPaUnknownFileTemplate"]; }}
		public static string ReportDocsStartTemplate { get { return ConfigurationManager.AppSettings["UI_ReportDocsStartTemplate"] ?? ConfigurationManager.AppSettings["ReportDocsStartTemplate"]; }}
		public static string ReportDocsLocalPathTemplate { get { return ConfigurationManager.AppSettings["UI_ReportDocsLocalPathTemplate"] ?? ConfigurationManager.AppSettings["ReportDocsLocalPathTemplate"]; }}
		public static string ReportDocsDownloadListTemplate { get { return ConfigurationManager.AppSettings["UI_ReportDocsDownloadListTemplate"] ?? ConfigurationManager.AppSettings["ReportDocsDownloadListTemplate"]; }}
		public static string ReportDocsStartDownloadFileTemplate { get { return ConfigurationManager.AppSettings["UI_ReportDocsStartDownloadFileTemplate"] ?? ConfigurationManager.AppSettings["ReportDocsStartDownloadFileTemplate"]; }}
		public static string ReportDocsSqlFileTemplate { get { return ConfigurationManager.AppSettings["UI_ReportDocsSqlFileTemplate"] ?? ConfigurationManager.AppSettings["ReportDocsSqlFileTemplate"]; }}
		public static string ReportDocsXsltFileTemplate { get { return ConfigurationManager.AppSettings["UI_ReportDocsXsltFileTemplate"] ?? ConfigurationManager.AppSettings["ReportDocsXsltFileTemplate"]; }}
		public static string ReportDocsXsdFileTemplate { get { return ConfigurationManager.AppSettings["UI_ReportDocsXsdFileTemplate"] ?? ConfigurationManager.AppSettings["ReportDocsXsdFileTemplate"]; }}
		public static string ReportDocsXmlFileTemplate { get { return ConfigurationManager.AppSettings["UI_ReportDocsXmlFileTemplate"] ?? ConfigurationManager.AppSettings["ReportDocsXmlFileTemplate"]; }}
		public static string ReportDocsXmlTransformedFileTemplate { get { return ConfigurationManager.AppSettings["UI_ReportDocsXmlTransformedFileTemplate"] ?? ConfigurationManager.AppSettings["ReportDocsXmlTransformedFileTemplate"]; }}
		public static string ReportDocsStartTransformation { get { return ConfigurationManager.AppSettings["UI_ReportDocsStartTransformation"] ?? ConfigurationManager.AppSettings["ReportDocsStartTransformation"]; }}
		public static string ReportDocsStartBulkLoad { get { return ConfigurationManager.AppSettings["UI_ReportDocsStartBulkLoad"] ?? ConfigurationManager.AppSettings["ReportDocsStartBulkLoad"]; }}
		public static string ReportDocsErrorForLogTableTemplate { get { return ConfigurationManager.AppSettings["UI_ReportDocsErrorForLogTableTemplate"] ?? ConfigurationManager.AppSettings["ReportDocsErrorForLogTableTemplate"]; }}
		public static string ReportInstallStart { get { return ConfigurationManager.AppSettings["UI_ReportInstallStart"] ?? ConfigurationManager.AppSettings["ReportInstallStart"]; }}
		public static string ReportInstallRunScriptTemplate { get { return ConfigurationManager.AppSettings["UI_ReportInstallRunScriptTemplate"] ?? ConfigurationManager.AppSettings["ReportInstallRunScriptTemplate"]; }}
		public static string ErrorJobFinishedIncorrectly { get { return ConfigurationManager.AppSettings["UI_ErrorJobFinishedIncorrectly"] ?? ConfigurationManager.AppSettings["ErrorJobFinishedIncorrectly"]; }}
    }
}