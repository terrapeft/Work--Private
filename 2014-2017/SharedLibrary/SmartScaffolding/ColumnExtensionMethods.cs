using System.ComponentModel.DataAnnotations;
using System.Web.DynamicData;

namespace SharedLibrary.SmartScaffolding
{
    /// <summary>
    /// MetaColumn methods.
    /// </summary>
    public static class ColumnExtensionMethods
    {
        /// <summary>
        /// Gets the column order.
        /// </summary>
        /// <param name="column">The MetaColumn.</param>
        /// <returns></returns>
        public static int GetColumnOrder(this MetaColumn column)
        {
            var display = column.GetAttribute<DisplayAttribute>();
            return (display != null) ? display.GetOrder() ?? 0 : 0;
        }
    }
}
