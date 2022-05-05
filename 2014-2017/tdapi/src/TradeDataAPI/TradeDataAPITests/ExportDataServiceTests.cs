using System;
using System.Collections.Generic;
using System.Net;
using System.ServiceModel.Web;
using Microsoft.VisualStudio.TestTools.UnitTesting;

namespace ExportDataServiceTests
{
	using TradeDataAPI;

	using UsersDb.Helpers;

	/// <summary>
	/// High level tests, consider valid if no exceptions.
	/// </summary>
	[TestClass]
	public class SvcTests
	{
        [TestMethod]
	    public void UriTemplate_WhereClause_Test()
	    {
            var baseAddress = "https://local.tradedataservice.com";
            var host = new WebServiceHost(typeof(ExportDataService), new Uri(baseAddress));
            host.Open();

            var c = new WebClient();
            var d = c.DownloadString(baseAddress + "GetCFTCDataByExchangeCodeAndContractNumber/csv?ContractNumber=&u=vchupaev&p=123");
	    }
	}
}
