using System.IO;
using System.Threading;
using SQLXMLBULKLOADLib;

namespace SpansLib.Db
{
    public class SqlXmlBulkInsert
    {
        private readonly string _connectionString;

        public SqlXmlBulkInsert(string connectionString)
        {
            _connectionString = connectionString;
        }

        /// <summary>
        /// Bulks the load.
        /// </summary>
        /// <param name="xml">The absolute path to XML file.</param>
        /// <param name="xsd">The absolute path to XSD file.</param>
        /// <param name="logPath">The log path.</param>
        public void BulkLoad(string xml, string xsd, string logPath)
        {
            Directory.CreateDirectory(Path.GetDirectoryName(logPath));

            // XmlSql works only in STA model
            var t = new Thread(() =>
            {
                var objBl = new SQLXMLBulkLoad4
                {
                    ConnectionString = _connectionString,
                    SchemaGen = false,
                    SGDropTables = false,
                    BulkLoad = true,
                    KeepIdentity = false,

                };

                objBl.Execute(xsd, xml);
            });

            t.SetApartmentState(ApartmentState.STA);
            t.Start();
            t.Join();
        }
    }
}
