using System;
using System.Data;
using System.Linq;
using HtmlAgilityPack;

namespace Scraper
{
    public static class TableConverter
    {
        public static DataTable ToDataTable(this HtmlDocument document, string tableId)
        {
            var dt = new DataTable();
            var hdt = document.DocumentNode.SelectSingleNode($"//table[@id='{tableId}']");

            // select th and create columns
            hdt.SelectNodes(".//tr/th/a")
                .ToList()
                .ForEach(a =>
                {
                    dt.Columns.Add(a.InnerText);
                });

            // select those tr, which have td as a child
            foreach (var row in hdt.SelectNodes(".//tr[.//td]"))
            {
                var dtRow = dt.NewRow();
                var cells = row.SelectNodes(".//td");
                
                for (var k = 0; k < cells.Count; k++)
                {
                    var cell = cells[k];
                    dtRow[k] = Stringify(cell.InnerText);
                }

                dt.Rows.Add(dtRow);
            }

            return dt;
        }

        private static object Stringify(string innerText)
        {
            var val = HtmlEntity.DeEntitize(innerText).Trim();
            return string.IsNullOrWhiteSpace(val) ? (object) DBNull.Value : val;
        }
    }
}
