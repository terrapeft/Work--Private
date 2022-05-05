using System;

namespace SharedLibrary.SmartScaffolding.Attributes
{
    /// <summary>
    /// Property metadata attribute, defines links between entites an provides parameters for html anchor element parameters.
    /// </summary>
    [AttributeUsage(AttributeTargets.Property, AllowMultiple = false)]
    public class LinkAttribute : Attribute
    {
        /// <summary>
        /// The type of the entity to link to.
        /// </summary>
        public Type Path;

        /// <summary>
        /// The property, which value is used as a filter.
        /// </summary>
        public string [] Filter;

        /// <summary>
        /// Anchor text.
        /// </summary>
        public string Display = "View";

        /// <summary>
        /// The boolean property which defines whether the link is enabled.
        /// Link is enabled if EnableIf is null or empty.
        /// </summary>
        public string EnableIf;

        /// <summary>
        /// Static title of the pop-up.
        /// </summary>
        public string Title;

        /// <summary>
        /// The filed to take value for the second level title.
        /// </summary>
        public string Title2Field;

        /// <summary>
        /// The dialog width, 630 pixels by default.
        /// </summary>
        public string DialogWidth = "630";

        /// <summary>
        /// The dialog height, 520 pixels by default.
        /// </summary>
        public string DialogHeight = "520";

        /// <summary>
        /// The link action, "popup" by default.
        /// </summary>
        public string Action = "popup";

        /// <summary>
        /// The property to take the text for anchor from.
        /// </summary>
        public string DisplayField;
    }
}
