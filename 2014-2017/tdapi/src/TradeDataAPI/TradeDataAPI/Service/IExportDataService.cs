using System.IO;
using System.ServiceModel;
using System.ServiceModel.Web;

namespace TradeDataAPI
{
	using System.ServiceModel.Channels;

	[ServiceContract]
	public interface IExportDataService
	{
        [OperationContract]
        [WebGet(UriTemplate = "clearCache?u={username}&p={password}", BodyStyle = WebMessageBodyStyle.Bare)]
        Message ClearCache(string username, string password);

        [OperationContract]
        [WebGet(UriTemplate = "{dbAlias}/{storedProcId}/search/{format}?s={words}&ps={pageSize}&pn={pageNum}&u={username}&p={password}&fa={findAll}", BodyStyle = WebMessageBodyStyle.Bare)]
        Message FullTextSearch(string dbAlias, string storedProcId, string format, string words, string pageSize, string pageNum, string username, string password, string findAll);

        [OperationContract]
        [WebGet(UriTemplate = "{dbAlias}/GetSeries/{format}?ec={exchangeCode}&cn={contractNum}&ps={pageSize}&pn={pageNum}&u={username}&p={password}", BodyStyle = WebMessageBodyStyle.Bare)]
        Message GetSeries(string dbAlias, string format, string exchangeCode, string contractNum, string pageSize, string pageNum, string username, string password);

        [OperationContract]
        [WebGet(UriTemplate = "{dbAlias}/{storedProcId}/{format}?u={username}&p={password}&ps={pageSize}&pn={pageNumber}&cn={csvColNames}&q={csvForceQuotes}&ij={indentJSON}&d={csvDelimiter}", BodyStyle = WebMessageBodyStyle.Bare)]
        Message GetData(string dbAlias, string storedProcId, string format, string username, string password, string pageSize, string pageNumber, string csvColNames, string csvForceQuotes, string indentJson, string csvDelimiter);

        [OperationContract]
        [WebGet(UriTemplate = "site/{dbAlias}/{storedProcId}/json?u={username}&p={password}&pageSize={pageSize}&pageNumber={pageNumber}&sortColumn={sortColumn}&sortOrder={sortOrder}&source={source}", BodyStyle = WebMessageBodyStyle.Bare)]
        Message GetSiteData(string dbAlias, string storedProcId, string username, string password, string pageSize, string pageNumber, string sortColumn, string sortOrder, string source);

		[OperationContract]
        [WebGet(UriTemplate = "{dbAlias}/{storedProcId}/help?u={username}&p={password}", BodyStyle = WebMessageBodyStyle.Bare)]
        Message GetHelp(string dbAlias, string storedProcId, string username, string password);

		[OperationContract]
        [WebGet(UriTemplate = "{dbAlias}/GetBySymbol/{format}?s={keyword}&se={includeSeries}&sc={columnGroupIds}&so={searchOption}&ec={exchangeCodes}&ct={contractTypes}&u={username}&p={password}&ps={pageSize}&pn={pageNumber}&re={includeRoot}&cn={csvColNames}&q={csvForceQuotes}&ij={indentJson}&d={csvDelimiter}&sa={availability}&zip={compress}", BodyStyle = WebMessageBodyStyle.Bare)]
        Message GetSearchResults(string dbAlias, string format, string keyword, string includeSeries, string columnGroupIds, string searchOption, string exchangeCodes, string contractTypes, string username, string password, string pageSize, string pageNumber, string availability, string includeRoot, string csvColNames, string csvForceQuotes, string indentJson, string csvDelimiter, string compress);

        [OperationContract]
        [WebGet(UriTemplate = "{dbAlias}/GetSuggestions/json?s={keyword}&sc={columnGroupIds}&so={searchOption}&ec={exchangeCodes}&ct={contractTypes}&u={username}&p={password}", BodyStyle = WebMessageBodyStyle.Bare)]
        Message GetSuggestions(string dbAlias, string keyword, string columnGroupIds, string searchOption, string exchangeCodes, string contractTypes, string username, string password);

        [OperationContract]
        [WebGet(UriTemplate = "{dbAlias}/list?u={username}&p={password}", BodyStyle = WebMessageBodyStyle.Bare)]
        Message GetList(string dbAlias, string username, string password);
	}
}
