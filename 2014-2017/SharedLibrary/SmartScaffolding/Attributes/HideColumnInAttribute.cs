using System;

namespace SharedLibrary.SmartScaffolding.Attributes
{
    /// <summary>
    /// Property metadata attribute, specifies that entity property should be hidden for particular page template(s).
    /// </summary>
    [AttributeUsage(AttributeTargets.Property, AllowMultiple = false)]
	public class HideInAttribute : Attribute
	{
        /// <summary>
        /// Gets the page template(s) to hide in.
        /// </summary>
        /// <value>
        /// The page template.
        /// </value>
		public PageTemplate PageTemplate { get; private set; }

        /// <summary>
        /// Initializes a new instance of the <see cref="HideInAttribute"/> class.
        /// </summary>
		public HideInAttribute() { }

        /// <summary>
        /// Initializes a new instance of the <see cref="HideInAttribute"/> class.
        /// </summary>
        /// <param name="lookupTable">The lookup table.</param>
		public HideInAttribute(PageTemplate lookupTable)
		{
			this.PageTemplate = lookupTable;
		}
	}
}