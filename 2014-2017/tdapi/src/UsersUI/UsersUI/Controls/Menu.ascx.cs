using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using SharedLibrary.SmartScaffolding;
using SharedLibrary.SmartScaffolding.Attributes;

namespace UsersUI.Controls
{
	using System.ComponentModel.DataAnnotations;
	using System.Web.DynamicData;
	using System.Web.Security;

	public partial class Menu : UserControl
	{
		public string CurrentTable
		{
			get
			{
				return ((Page)HttpContext.Current.CurrentHandler).GetPageTable();
			}
		}

		public IEnumerable<MetaTable> UngroupedTables
		{
			get
			{
				var tt = Global.DefaultModel.Tables
					.Where(t => t.Attributes.GetAttribute<ScaffoldTableAttribute>() == null || t.Attributes.GetAttribute<ScaffoldTableAttribute>().Scaffold)
					.Where(t => t.Attributes.GetAttribute<TableCategoryAttribute>() == null);

				return tt;
			}
		}

		public IEnumerable<IGrouping<string, MetaTable>> TablesGroups
		{
			get
			{
				var f = Global.DefaultModel.Tables
					.Where(t => t.Attributes.GetAttribute<ScaffoldTableAttribute>() == null || t.Attributes.GetAttribute<ScaffoldTableAttribute>().Scaffold)
					.Where(t => t.Attributes.GetAttribute<TableCategoryAttribute>() != null && t.Attributes.GetAttribute<TableCategoryAttribute>().Category != "Account")
					.GroupBy(t => t.Attributes.GetAttribute<TableCategoryAttribute>().Category)
					.ToList();

				return f;
			}
		}

		public IEnumerable<MetaTable> AccountTables
		{
			get
			{
				return Global.DefaultModel.Tables
					.Where(t => t.Attributes.GetAttribute<ScaffoldTableAttribute>() == null || t.Attributes.GetAttribute<ScaffoldTableAttribute>().Scaffold)
					.Where(t => t.Attributes.GetAttribute<TableCategoryAttribute>() != null && t.Attributes.GetAttribute<TableCategoryAttribute>().Category == "Account");
			}
		}

		protected void logout_ServerClick(object sender, EventArgs e)
		{
			FormsAuthentication.SignOut();
			FormsAuthentication.RedirectToLoginPage();
		}
	}
}