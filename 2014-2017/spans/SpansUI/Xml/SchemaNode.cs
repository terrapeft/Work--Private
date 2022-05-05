using System;
using System.Collections.Generic;
using System.Linq;

namespace SpansUI.Xml
{
    public class SchemaNode
    {
        private Func<SchemaNode, IEnumerable<SchemaNode>> _flattener = null;
        private string _dbName;

        public string DbName
        {
            get { return string.IsNullOrEmpty(_dbName) ? Name : _dbName; }
            set { _dbName = value; }
        }

        public string Name;
        public string DataType;

        public bool IsConstant;
        public bool Nullable;
        public bool IsTable;
        public bool IsColumn;
        public bool IsPrimaryKey;
        public bool IsForeignKey;
        public bool IsIdentity;

        public SchemaNode Parent;
        public int Level;

        public List<string> Relationships = new List<string>();

        public List<SchemaNode> Children = new List<SchemaNode>();

        public bool HasChildren
        {
            get { return Children.Count > 0; }
        }

        public Annotation Annotation { get; set; }

        public List<SchemaNode> Columns
        {
            get
            {
                return Children.Where(c => c.IsColumn && !c.IsConstant).ToList();
            }
        }

        /// <summary>
        /// A distinct flatten (all children and children of children to the end of the tree) 
        /// list of elements which are expected to be tables on SQL Server,
        /// like complex types which are not marked as constant 
        /// and simple types with defined relationship.
        /// Ordered by level with a relationship taken into account, so that first table in list 
        /// should be first in the SQL drop script.
        /// </summary>
        /// <value>
        /// The flatten tables.
        /// </value>
        public List<SchemaNode> FlattenTables
        {
            get
            {
                _flattener = t => new[] { t }.Concat(t.Children.SelectMany(c => _flattener(c)));

                var list = _flattener(this)
                    .Where(c => c.IsTable && !c.IsConstant)
                    .Distinct(new SchemaNodeComparer())
                    .OrderByDescending(n => n.Level)
                    .ToList();

                if (Annotation != null)
                {
                    var children = Annotation.Relationships.Select(r => r.Child);
                    var parents = Annotation.Relationships.Select(r => r.Parent);

                    // put tables with FKs to the top, so that they will be first in delete statements
                    parents
                        .Intersect(children)
                        .Select(t2 => list.FirstOrDefault(t => t.DbName == t2))
                        .Where(n => n != null)
                        .ToList()
                        .ForEach(n =>
                        {
                            list.Remove(n);
                            list.Insert(0, n);
                        });

                    children
                        .Except(parents)
                        .Select(t1 => list.FirstOrDefault(t => t.DbName == t1))
                        .Where(n => n != null).ToList()
                        .ForEach(n =>
                        {
                            list.Remove(n);
                            list.Insert(0, n);
                        });
                }

                return list;

            }
        }

        public string XPath
        {
            get
            {
                var node = this;
                var xp = new List<string>();
                while (node != null)
                {
                    xp.Add(node.DbName);
                    node = node.Parent;
                }
                xp.Reverse();
                return "/" + string.Join("/", xp);
            }
        }

        public override string ToString()
        {
            return DbName;
        }
    }

    public class SchemaNodeComparer : IEqualityComparer<SchemaNode>
    {
        public bool Equals(SchemaNode x, SchemaNode y)
        {
            return x.DbName == y.DbName;
        }

        public int GetHashCode(SchemaNode obj)
        {
            return obj.DbName.GetHashCode();
        }
    }
}
