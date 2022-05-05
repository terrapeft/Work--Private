using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SharedLibrary.SmartScaffolding.Attributes
{
    /// <summary>
    /// Entity metadata attribute, specifies the default sorting for the page.
    /// "it" stands for a default "control variable" used in ASP.NET controls like EntityDataSource, which accept expressions.
    /// </summary>
    [AttributeUsage(AttributeTargets.Class, AllowMultiple = false)]
    public class OrderByItAttribute : Attribute
    {
        /// <summary>
        /// Gets the orderby expression.
        /// </summary>
        /// <value>
        /// The order by.
        /// </value>
        public string OrderBy { get; private set; }


        /// <summary>
        /// Initializes a new instance of the <see cref="OrderByItAttribute"/> class.
        /// </summary>
        /// <param name="orderBy">The order by.</param>
        public OrderByItAttribute(string orderBy)
        {
            OrderBy = orderBy;
        }
    }
}
