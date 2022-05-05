using System.Linq;
using System.Text;
using System.Xml;
using System.Xml.Schema;
using System.Xml.Xsl;

namespace SpansLib.Data.XmlFormats
{
    /// <summary>
    /// XSLT related methods
    /// </summary>
    public class XsltProcessing
    {

        /// <summary>
        /// Transforms XML structure by applying provided XSLT file.
        /// </summary>
        /// <param name="originalXmlPath">The original XML path.</param>
        /// <param name="xsltPath">The XSLT path.</param>
        /// <param name="outputPath">The output path.</param>
        public static void Transform(string originalXmlPath, string xsltPath, string outputPath)
        {
            var myXslTrans = new XslCompiledTransform();
            myXslTrans.Load(xsltPath);
            myXslTrans.Transform(originalXmlPath, outputPath); 
        }


        /// <summary>
        /// Returns found nodes.
        /// </summary>
        /// <param name="xpath">The xpath.</param>
        /// <param name="xmlString">The XML string.</param>
        /// <returns></returns>
        public static string GetXPathResults(string xpath, string xmlString)
        {
            var d = new XmlDocument();
            d.LoadXml(xmlString);

            var schema = new XmlSchema();
            schema.Namespaces.Add("xs", "http://www.w3.org/2001/XMLSchema");
            schema.Namespaces.Add("sql", "urn:schemas-microsoft-com:mapping-schema");
            d.Schemas.Add(schema);

            var sb = new StringBuilder();
            var nodes = d.SelectNodes(xpath);

            if (nodes != null)
            {
                foreach (var n in nodes.OfType<XmlElement>())
                {
                    sb.Append(n.OuterXml);
                }
            }

            return sb.ToString();
        }
    }
}
