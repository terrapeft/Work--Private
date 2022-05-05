using System.IO;
using System.Linq;
using System.Xml;
using System.Xml.Linq;
using System.Xml.Schema;

namespace SpansUI.Xml
{
    /// <summary>
    /// 
    /// </summary>
    public class XsdSchemaReader
    {
        private string _path;
        private XmlSchemaSet _schemaSet;
        private XDocument _schemaDocument;

        public XsdSchemaReader()
        {
        }

        public XsdSchemaReader(string schemaPath)
        {
            _schemaSet = new XmlSchemaSet();
            _schemaSet.Add(null, schemaPath);
            _schemaSet.Compile();

            _schemaDocument = XDocument.Load(schemaPath);

            _path = schemaPath;
        }

        #region Public methods

        public string GenerateXsd(string xmlPath)
        {
            _schemaSet = CreateXmlSchema(xmlPath);

            var name = string.Empty;
            var s = _schemaSet.Schemas().Cast<XmlSchema>().FirstOrDefault();
            if (s != null)
            {
                int k = 0;
                var fileInfo = new FileInfo(xmlPath);
                name = Path.Combine(fileInfo.DirectoryName, fileInfo.Name.Substring(0, fileInfo.Name.LastIndexOf('.')) + ".xsd");
                while (File.Exists(name))
                {
                    name = Path.Combine(fileInfo.DirectoryName, fileInfo.Name.Substring(0, fileInfo.Name.LastIndexOf('.')) + "[" + k++ + "]" + ".xsd");
                }
                using (var writer = XmlWriter.Create(name))
                {
                    s.Write(writer);
                }
            }

            return name;
        }

        #endregion


        private XmlSchemaSet CreateXmlSchema(string path)
        {
            var reader = XmlReader.Create(path);
            var schema = new XmlSchemaInference();
            var schemaSet = schema.InferSchema(reader);
            schemaSet.Compile();

            return schemaSet;
        }
    }
}
