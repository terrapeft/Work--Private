using System;
using System.Collections.Generic;
using System.Linq;
using System.Xml.Linq;

namespace SpansUI.Xml
{
    public class XDocumentReader
    {
        private string _path;
        private XDocument _schemaDocument;

        public XDocumentReader(string schemaPath)
        {
            _schemaDocument = XDocument.Load(schemaPath);
            _path = schemaPath;
        }

        #region Public methods

        public SchemaNode BuildTree()
        {
            var schemaNode = _schemaDocument.Root.FirstElement();
            var annotations = _schemaDocument.Root.RootAnnotationElement();

            var schema = AnalyseNode(schemaNode);
            schema.Annotation = ReadRelationships(annotations);

            InferElementsFromAnnotations(schema.Annotation, schema.FlattenTables);
            AddMissingPrimaryKeys(schema.FlattenTables);

            return schema;
        }

        private void AddMissingPrimaryKeys(IEnumerable<SchemaNode> flattenTables)
        {
            foreach (var table in flattenTables)
            {
                if (table.Children.All(c => !c.IsPrimaryKey && !c.DbName.Equals("Id", StringComparison.OrdinalIgnoreCase)))
                {
                    table.Children.Insert(0, new SchemaNode
                    {
                        Name = "Id",
                        DataType = "integer",
                        IsColumn = true,
                        Parent = table,
                        IsIdentity = true,
                        IsPrimaryKey = true
                    });
                }
            }
        }

        #endregion

        private void InferElementsFromAnnotations(Annotation annotation, List<SchemaNode> tables)
        {
            // FKs - add the foreign keys, specified in annotation if it was not added inline in xsd
            foreach (var r in annotation.Relationships)
            {
                // same node can be defined several times in XML
                var parent = tables.FirstOrDefault(t => t.DbName.Equals(r.Parent));
                var child = tables.FirstOrDefault(t => t.DbName.Equals(r.Child));

                if (parent != null)
                {
                    var pkNode = parent.Columns.FirstOrDefault(c => c.Name == r.ParentKey);
                    if (pkNode == null)
                    {
                        // add node which is defined in annotations, but not in XSD element (this is allowed)
                        parent.Children.Insert(0, new SchemaNode
                        {
                            Name = r.ParentKey,
                            DataType = "integer",
                            Parent = parent,
                            IsIdentity = true,
                            IsPrimaryKey = true,
                            IsColumn = true
                        });
                    }
                    else
                    {
                        // if node already defined, just mark it as a key
                        pkNode.IsPrimaryKey = true;
                        /*
                                                if (pkNode.DataType.Equals("integer", StringComparison.OrdinalIgnoreCase)
                                                    || pkNode.DataType.Equals("int", StringComparison.OrdinalIgnoreCase))
                                                {
                                                    pkNode.IsIdentity = true;
                                                }
                        */
                    }
                }

                if (child != null)
                {
                    var fkNode = child.Children.FirstOrDefault(c => c.Name == r.ChildKey);
                    if (fkNode == null)
                    {
                        child.Children.Insert(0, new SchemaNode
                        {
                            Name = r.ChildKey,
                            DataType = "integer",
                            Parent = child,
                            IsForeignKey = true,
                            IsColumn = true
                        });
                    }
                    else
                    {
                        fkNode.IsForeignKey = true;
                    }
                }
            }
        }

        private SchemaNode AnalyseNode(XElement xlm, SchemaNode parentNode = null)
        {
            if (xlm == null)
                return null;

            // analyse current xsd element and create a node from it
            var node = new SchemaNode
            {
                Level = parentNode == null ? 0 : parentNode.Level + 1,
                Name = xlm.GetAttribute("name") ?? xlm.GetAttribute("ref"),
                IsConstant = xlm.IsSqlConstant(),
                Nullable = xlm.AttributeEquals("minOccurs", new[] { "0" }) || xlm.AttributeEquals("nillable", new[] { bool.TrueString }),
                Relationships = xlm.GetAttribute("relationship", string.Empty)
                    .Split(new[] { ' ' }, StringSplitOptions.RemoveEmptyEntries)
                    .ToList(),
                DataType = xlm.HasAttribute("type") ? xlm.GetAttribute("type").StripNamespace() : "string",
                IsColumn = xlm.IsSimpleType(),
                Parent = parentNode
            };

            node.DbName = (xlm.HasAttribute("relation") ? xlm.GetAttribute("relation") : xlm.GetAttribute("field")) ??
                          node.Name;

            node.IsTable = xlm.IsComplexType() || node.Relationships.Any();

            // the overflow filed, defined in xsd, contains all extra xml nodes which were skipped during bulk insert process
            // see SqlXml 4.0 annotations documentation for more details 
            var overFlowField = xlm.GetAttribute("overflow-field");
            if (!string.IsNullOrWhiteSpace(overFlowField))
            {
                node.Children.Add(new SchemaNode
                {
                    Level = node.Level,
                    Name = overFlowField,
                    DbName = overFlowField,
                    IsColumn = true,
                    DataType = "xml",
                    Nullable = true
                });
            }

            if (parentNode != null)
            {
                parentNode.Children.Add(node);
            }

            // child elements of xsd node
            foreach (XElement element in xlm.SqlRelatedElements())
            {
                AnalyseNode(element, node);
            }

            return node;
        }

        private Annotation ReadRelationships(IEnumerable<XElement> annNodes)
        {
            var ann = new Annotation();

            foreach (var elem in annNodes)
            {
                ann.Relationships.Add(new RelationshipNode
                {
                    Name = elem.GetAttribute("name"),
                    Parent = elem.GetAttribute("parent"),
                    ParentKey = elem.GetAttribute("parent-key"),
                    Child = elem.GetAttribute("child"),
                    ChildKey = elem.GetAttribute("child-key")
                });
            }

            return ann;
        }
    }

    #region Extensions

    public static class XElementExtensions
    {
        private static string _namespaceDivider = ":";

        public static string StripNamespace(this string str)
        {
            if (str.IndexOf(_namespaceDivider) < 0)
                return str;

            return str.Substring(str.IndexOf(_namespaceDivider) + 1, str.Length - str.IndexOf(_namespaceDivider) - 1);
        }

        public static bool IsComplexType(this XElement node)
        {
            var elements = node.Nodes().OfType<XElement>();
            return elements.Any()
                && (elements.First().Name.LocalName.Equals("complexType", StringComparison.OrdinalIgnoreCase)
                || node.HasAttribute("relationship"));
        }

        public static bool IsSqlConstant(this XElement node)
        {
            return node.AttributeEquals("is-constant", new[] { "true", "1" });
        }

        public static bool IsSimpleType(this XElement node)
        {
            return !node.Nodes().Any(); /*
                || (((XElement)node.Nodes().First()).Name.LocalName.Equals("element", StringComparison.OrdinalIgnoreCase)
                || ((XElement)node.Nodes().First()).Name.LocalName.Equals("attribute", StringComparison.OrdinalIgnoreCase));*/
        }

        public static XElement FirstElement(this XElement node)
        {
            return node.Nodes()
                .OfType<XElement>()
                .FirstOrDefault(e => e.Name.LocalName.Equals("element", StringComparison.OrdinalIgnoreCase));
        }

        public static IEnumerable<XElement> RootAnnotationElement(this XElement node)
        {
            var annotations = node.GetElementsByName("annotation").FirstOrDefault();

            if (annotations != null)
            {
                var appInfo = annotations.GetElementsByName("appinfo").FirstOrDefault();
                if (appInfo != null)
                    return appInfo.Nodes().OfType<XElement>();
            }

            return new List<XElement>();
        }

        public static bool HasAttribute(this XElement element, string attrName)
        {
            return element.GetAttribute(attrName) != null;
        }

        public static string GetAttribute(this XElement element, string attrName, string defaultValue = null)
        {
            var val = element.Attributes().FirstOrDefault(a => a.Name.LocalName.Equals(attrName, StringComparison.OrdinalIgnoreCase));
            return val == null ? defaultValue : val.Value;
        }

        public static bool AttributeEquals(this XElement element, string attrName, string[] values)
        {
            var val = element.GetAttribute(attrName);
            return val != null && values.Contains(val, StringComparer.OrdinalIgnoreCase);
        }

        public static IEnumerable<XElement> GetElementsByName(this XElement element, string name)
        {
            return element.Nodes()
                .OfType<XElement>()
                .Where(n => n.Name.LocalName.Equals(name, StringComparison.OrdinalIgnoreCase))
                .ToList();
        }

        public static IEnumerable<XElement> SqlRelatedElements(this XElement element)
        {
            if (!element.HasElements)
                return new List<XElement>();

            var ct = element.GetElementsByName("complexType").FirstOrDefault();
            var results = new List<XElement>();

            if (ct != null)
            {
                results.AddRange(ct.GetElementsByName("attribute"));

                var sq = ct.GetElementsByName("sequence").FirstOrDefault();
                if (sq != null)
                {
                    results.AddRange(sq.Nodes().OfType<XElement>());
                }
            }

            return results;
        }
    }

    #endregion
}
