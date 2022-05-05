using System;
using Microsoft.VisualStudio.TestTools.UnitTesting;

namespace ExportDataServiceTests
{
    using System.Collections.Generic;

    using UsersDb;
    using UsersDb.Helpers;

    [TestClass]
    public class DbHelperTests
    {

        [TestMethod]
        public void WhereClause_Test()
        {
            var dict = new Dictionary<string, List<string>> {
				{"ExchangeCode", new List<string>{"ACE", "ADEX"}},
				{"ContractType", new List<string>{"E"}}
			};
            var expected = "(ExchangeCode='ACE' or ExchangeCode='ADEX') and (ContractType='E')";
            Assert.AreEqual(expected, QueryBuilder.Filter(dict));
        }

        [TestMethod]
        public void BuildCommand_Test()
        {
            var dict = new Dictionary<string, string> {
				{"param1", "12"},
				{"param2", "13"}
			};
            var query = "select * from Table";

            var expected = query + " where param1 like @param1 Or param2 like @param2";
            Assert.AreEqual(expected, QueryBuilder.Select(query, dict, SearchOptions.Contains, JoinWith.Or));
        }

        [TestMethod]
        public void BuildCommand_Empty_Params_Test()
        {
            var sut = new DbHelper(string.Empty);
            var dict = new Dictionary<string, string>();
            var query = "select * from Table";
            var expected = "select top 100 * from Table";

            Assert.AreEqual(expected, QueryBuilder.Select(query, dict, SearchOptions.Contains, JoinWith.Or, 100));
        }

        [TestMethod]
        public void BuildCommand_Empty_Params_IgnoreCase_Test()
        {
            var sut = new DbHelper(string.Empty);
            var dict = new Dictionary<string, string>();
            var query = "SELECT * from Table";
            var expected = "SELECT top 1010 * from Table";

            Assert.AreEqual(expected, QueryBuilder.Select(query, dict, SearchOptions.Contains, JoinWith.Or, 1010));
        }

    }
}
