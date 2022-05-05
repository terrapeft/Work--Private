using System;

namespace SharedLibrary.SmartScaffolding.Attributes
{
    /// <summary>
    /// Property metadata attribute, specifies the css class for the property and thus a html table column on the page.
    /// </summary>
    public class CssClassAttribute : Attribute
    {
        private readonly string _cssClass;

        /// <summary>
        /// Initializes a new instance of the <see cref="CssClassAttribute"/> class.
        /// </summary>
        /// <param name="cssClass">The CSS class.</param>
        public CssClassAttribute(string cssClass)
        {
            _cssClass = cssClass;
        }

        /// <summary>
        /// Gets the CSS class.
        /// </summary>
        /// <value>
        /// The CSS class.
        /// </value>
        public string CssClass
        {
            get { return _cssClass; }
        }
    }
}