using System;

namespace Db
{
    [AttributeUsage(AttributeTargets.Property, AllowMultiple = false)]
    public class LinkAttribute : Attribute
    {

        /// <summary>
        /// The type of the entity to link to.
        /// </summary>
        public Type Path;

        /// <summary>
        /// The property, the value of which is to use as a filter.
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
    }
}
