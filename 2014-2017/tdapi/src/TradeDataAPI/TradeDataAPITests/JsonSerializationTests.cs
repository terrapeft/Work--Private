using System;
using System.Collections.Generic;
using System.Diagnostics;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using UsersDb;
using UsersDb.Code;
using UsersDb.DataContext;

namespace ExportDataServiceTests
{
    [TestClass]
    public class JsonSerializationTests
    {
        [TestMethod]
        public void Serialize()
        {
            var sp = new SearchParametersJson();

            sp.Keyword = "keyword";
            sp.Filter.Add("filter1", new List<string> { "f1_1", "f1_2" });
            sp.Filter.Add("filter2", null);
            sp.SearchGroups.AddRange(new[] { "search group1", "search group2" });
            sp.VisibleRootColumns.AddRange(new[] { "visibleCols1", "2" });
            sp.ComparisonOperatorSetter = "3";

            var query = new UserSearchQuery { DeserializedParameters = sp };
            Debug.WriteLine(query.QueryParameters);
        }
    }
}
