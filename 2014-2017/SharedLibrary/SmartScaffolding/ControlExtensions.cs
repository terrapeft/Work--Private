using System;
using System.Web.UI;

namespace SharedLibrary.SmartScaffolding
{
    /// <summary>
    /// A set of methods to work with PageTemplates.
    /// </summary>
	public static class ControlExtensionMethods
	{
		/// <summary>
		/// Gets the page template from the page.
		/// </summary>
		/// <param name="page">The page.</param>
		/// <returns></returns>
		public static PageTemplate GetPageTemplate(this Page page)
		{
			try
			{
                if (page.RouteData.Values["action"] == null)
                    return PageTemplate.Unknown;

				return (PageTemplate)Enum.Parse(typeof(PageTemplate), page.RouteData.Values["action"].ToString());
			}
			catch (ArgumentException)
			{
				return PageTemplate.Unknown;
			}
		}

        /// <summary>
        /// Gets the page table from the registered routes.
        /// </summary>
        /// <param name="page">The page.</param>
        /// <returns></returns>
		public static string GetPageTable(this Page page)
		{
			if (page.RouteData.Values.ContainsKey("table"))
			{
				return page.RouteData.Values["table"].ToString();
			}
			return null;
		}
	}
}
