using System;

namespace SharedLibrary.SmartScaffolding.Attributes
{
    /// <summary>
    /// Entity meatadata attribute, specifies that the advanced search control should be available for the corresponding entity.
    /// </summary>
    [AttributeUsage(AttributeTargets.Class, AllowMultiple = false)]
    public class AdvancedSearchAttribute : Attribute
    {
        /// <summary>
        /// The exclude list, which contains the Themes names
        /// </summary>
        public string[] ExcludeIn = {};
    }
}
