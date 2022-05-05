using System;
using System.Collections.Generic;
using System.Text;
using SpansLib.Data;

namespace SpansUI.Xml
{
    public class SqlXmlSchemaGenerator
    {
        #region Constants

        /// <summary>
        /// {0}: table name
        /// </summary>
        private const string DropTableFormat =
            "IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[{0}]') AND type in (N'U')) " +
            "\r\nBEGIN " +
            "\r\nDROP TABLE [dbo].[{0}];" +
            "\r\nEND" +
            "\r\nGO";

        /// <summary>
        /// {0}: child
        /// {1}: parent
        /// {2}: child key
        /// {3}: parent key
        /// </summary>
        private const string ForeignKeyFormat =
            "\r\nALTER TABLE [dbo].[{0}] WITH CHECK ADD CONSTRAINT [FK_{1}_{0}] FOREIGN KEY([{2}]) " +
            "\r\nREFERENCES [dbo].[{1}] ([{3}]) " +
            "\r\nGO";

        private const string ForeignKeyColumnFormat = "[FK_{0}Id] [int] NULL";

        private const string IdentityColumnName = "Id";

        /// <summary>
        /// {0}: Id column
        /// </summary>
        private const string IdentityColumn = "[{0}] [int] IDENTITY(1,1) NOT NULL";

        /// <summary>
        /// {0}: table name
        /// {1}: Id column
        /// </summary>
        private const string PrimaryKeyFormat = ", CONSTRAINT [PK_{0}] PRIMARY KEY CLUSTERED ([{1}] ASC)";

        #endregion

        public string GenerateSql(SchemaNode node)
        {
            var sqlBuilder = new StringBuilder("use [spans];\r\nGO\r\n");

            var tables = node.FlattenTables;

            tables.ForEach(n => sqlBuilder.Append(GetDropTable(n)));
            tables.ForEach(n => sqlBuilder.Append(GetTable(n, node.Annotation)));
            node.Annotation.Relationships.ForEach(a => sqlBuilder.Append(GetForeignKey(a)));

            return sqlBuilder.ToString();
        }


        #region Private methods

        private string GetDropTable(SchemaNode node)
        {
            if (node.IsConstant)
                return string.Empty;

            return string.Format("{0}{1}{1}",
                String.Format(DropTableFormat, node.DbName),
                Environment.NewLine);
        }

        private string GetTable(SchemaNode node, Annotation annotation)
        {
            if (node.IsConstant)
                return string.Empty;

            // id
            var columns = new List<string>();

            // columns
            node.Columns.ForEach(c => columns.Add(c.IsIdentity
                 ? string.Format("[{0}] [int] identity(1, 1) NOT NULL", c.DbName)
                 : string.Format("[{0}] {1} {2}", c.DbName, MapType(c.DataType), c.Nullable ? Constants.Null : Constants.NotNull)));

            // gather together
            return string.Format("{1}CREATE TABLE [dbo].[{0}] ( {1}{2}{1}{3}){1}GO{1}{1}",
                node.DbName,
                Environment.NewLine,
                string.Join(",\r\n", columns),
                string.Format(PrimaryKeyFormat, node.DbName, IdentityColumnName));
        }

        private string GetForeignKey(RelationshipNode c)
        {
            // FKs
            return string.Format(ForeignKeyFormat, c.Child, c.Parent, c.ChildKey, c.ParentKey);
        }

        private string MapType(string dataType)
        {
            dataType = dataType ?? string.Empty;

            switch (dataType.ToLower())
            {
                case "xml":
                    return "[xml]";
                case "string":
                    return "[nvarchar] (1024)";
                case "unsignedbyte":
                    return "[tinyint]";
                case "decimal":
                    return "[numeric] (18, 6)";
                case "int":
                case "integer":
                    return "[int]";
                case "id":
                    return "[nvarchar] (40)";
                default:
                    return "[nvarchar] (1024)";
            }
        }

        #endregion
    }
}
