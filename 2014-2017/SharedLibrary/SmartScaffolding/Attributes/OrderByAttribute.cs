using System;

namespace SharedLibrary.SmartScaffolding.Attributes
{
    /// <summary>
    /// Property metadata attribute, marks the OrderBy column of the entity.
    /// </summary>
    [AttributeUsage(AttributeTargets.Property, AllowMultiple = false)]
	public class OrderByAttribute : Attribute
	{
        /// <summary>
        /// Gets the order, use values "ASC" or "DESC".
        /// </summary>
        /// <value>
        /// The order.
        /// </value>
		public string Order { get; private set; }

        /// <summary>
        /// Initializes a new instance of the <see cref="OrderByAttribute"/> class.
        /// </summary>
		public OrderByAttribute() { }

        /// <summary>
        /// Initializes a new instance of the <see cref="OrderByAttribute"/> class.
        /// </summary>
        /// <param name="order">The order.</param>
		public OrderByAttribute(string order)
		{
			this.Order = order;
		}
	}
}
