namespace SharedLibrary.SmartScaffolding.Attributes
{
	using System;

    /// <summary>
    /// Entity meatadata attribute, specifies which actions are available for the entity. 
    /// </summary>
	[AttributeUsage(AttributeTargets.Class, AllowMultiple = false)]
	public class AllowActionAttribute : Attribute
	{
        /// <summary>
        /// Gets or sets the action.
        /// </summary>
        /// <value>
        /// The action.
        /// </value>
		public PageTemplate Action { get; set; }
	}
}
