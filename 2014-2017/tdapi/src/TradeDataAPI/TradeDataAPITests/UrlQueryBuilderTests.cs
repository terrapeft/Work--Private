using System;
using System.Collections.Generic;
using System.Data;
using System.Diagnostics;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;
using System.Threading.Tasks;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using TradeDataAPI.Helpers;

namespace ExportDataServiceTests
{
    [TestClass]
    public class UrlQueryBuilderTests
    {
        [TestMethod]
        public void RegEx_Test()
        {
            var input = "or-t10.column-lt=12\n" +
                        "t2.descr-gt=100";

            foreach (Match m in Regex.Matches(input, UrlQueryParser.UrlRegExpr, RegexOptions.Multiline))
            {
                Trace.WriteLine(string.Format("'{0}' found at index {1}.", m.Value, m.Index));
            }
        }

        [TestMethod]
        public void WhereClauses_Test()
        {
            var input = new[] {
                "col1-lt=12", 
                "and-col2-gt=100",
                "or-col3-in=1,2",
                "col4-sort=desc"
            };

            var sut = new UrlQueryParser();
            sut.BuildQuery(input);
            //var dict = sut.WhereClauses();

        }

        [TestMethod]
        public void DataTable_Test()
        {
            var dt = new DataTable();
            dt.Columns.Add("c1", typeof (string));
            dt.Columns.Add("c2", typeof(string));

            var r = dt.NewRow();
            r[0] = "b";
            r[1] = "1";
            dt.Rows.Add(r);

            r = dt.NewRow();
            r[0] = "a";
            r[1] = "3";
            dt.Rows.Add(r);

            r = dt.NewRow();
            r[0] = "a";
            r[1] = "2";
            dt.Rows.Add(r);

            r = dt.NewRow();
            r[0] = "car";
            r[1] = "12";
            dt.Rows.Add(r);

            r = dt.NewRow();
            r[0] = "boat";
            r[1] = "122";
            dt.Rows.Add(r);

            var t1 = dt.Select(string.Empty, "");
            var t2 = dt.Select(string.Empty, "c1 ASC");
            var t3 = dt.Select(string.Empty, "c1 ASC, c2 ASC");
            var t4 = dt.Select(string.Empty, "c1 ASC, c2 DESC");

            var t5 = dt.Select("c1 like '%at'");
        }

        [TestMethod]
        public void Aggregate_Test()
        {
            var value = "1,2,3";
            var sstr = value.Split(',').Select(v => string.Format("'{0}'", v)).Aggregate((str, v) => str + "," + v);
        }
    }
}
