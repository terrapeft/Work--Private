using System.Collections.Generic;
using System.Linq;
using SharedLibrary.SmartScaffolding;
using SharedLibrary.SmartScaffolding.Attributes;
using UsersDb.DataContext;

namespace UsersDb.Helpers
{
	using System.ComponentModel.DataAnnotations;
	using System.Web.DynamicData;

	using UsersDb;

    public static class MetaDataHelper
	{
		public static string GetOrderExpression(this MetaTable table)
		{
			var col = table.Columns.FirstOrDefault(c => c.Attributes.OfType<OrderByAttribute>().Any());

			if (col != null)
			{
				return string.Format("it.{0} {1}", col.Name, col.GetAttribute<OrderByAttribute>().Order);
			}

			return "it.Id";
		}

        public static string GroupByColumn(this MetaTable table)
        {
            var col = table.Columns.FirstOrDefault(c => c.Attributes.OfType<GroupByAttribute>().Any());

            if (col != null)
            {
                return col.Name;
            }

            return null;
        }

		public static bool CanEdit(this MetaColumn column)
		{
			if (column == null) return true;

			var readOnlyIn = column.GetAttribute<ReadOnlyInAttribute>();
            var resAdmin = UsersDataContext.CurrentSessionUser.IsResourcesAdmin;
            return resAdmin || (!column.IsReadOnly && (readOnlyIn == null || !readOnlyIn.PageTemplate.HasFlag(PageTemplate.Edit)));
		}

		public static IEnumerable<MetaColumn> GetCustomerColumns(this MetaTable table)
		{
			return table.Columns
				.Where(c => !c.IsPrimaryKey && !c.IsForeignKeyComponent)
				.Where(c => c.Attributes.GetAttribute<ScaffoldColumnAttribute>() == null || c.Attributes.GetAttribute<ScaffoldColumnAttribute>().Scaffold)
				.Where(c =>
					c.Attributes.GetAttribute<HideInAttribute>() == null ||
					!c.Attributes.GetAttribute<HideInAttribute>().PageTemplate.HasFlag(PageTemplate.CustomerView)
				);
		}

		public static IEnumerable<MetaColumn> GetDisplayColumns(this MetaTable table)
		{
			return table.Columns
				.Where(c => !c.IsPrimaryKey && !c.IsForeignKeyComponent)
				.Where(c => c.Attributes.GetAttribute<ScaffoldColumnAttribute>() == null || c.Attributes.GetAttribute<ScaffoldColumnAttribute>().Scaffold)
				.Where(c =>
					c.Attributes.GetAttribute<HideInAttribute>() == null ||
					!c.Attributes.GetAttribute<HideInAttribute>().PageTemplate.HasFlag(PageTemplate.Details)
				);
		}

		public static IEnumerable<MetaColumn> GetEditColumns(this MetaTable table)
		{
			return table.Columns
				.Where(c => !c.IsPrimaryKey && !c.IsForeignKeyComponent)
				.Where(c => c.Attributes.GetAttribute<ScaffoldColumnAttribute>() == null || c.Attributes.GetAttribute<ScaffoldColumnAttribute>().Scaffold)
				.Where(c =>
					c.Attributes.GetAttribute<HideInAttribute>() == null ||
					!c.Attributes.GetAttribute<HideInAttribute>().PageTemplate.HasFlag(PageTemplate.Edit)
				);
		}

		public static IEnumerable<MetaColumn> GetInsertColumns(this MetaTable table)
		{
			return table.Columns
				.Where(c => !c.IsPrimaryKey && !c.IsForeignKeyComponent)
				.Where(c => c.Attributes.GetAttribute<ScaffoldColumnAttribute>() == null || c.Attributes.GetAttribute<ScaffoldColumnAttribute>().Scaffold)
				.Where(c =>
					c.Attributes.GetAttribute<HideInAttribute>() == null ||
					!c.Attributes.GetAttribute<HideInAttribute>().PageTemplate.HasFlag(PageTemplate.Insert)
				);
		}
	}
}