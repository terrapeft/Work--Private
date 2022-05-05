using System;

namespace SharedLibrary.SmartScaffolding.Attributes
{
    /// <summary>
	/// Property metadata attribute, defines the type of data to use in serialization.
	/// </summary>
	[AttributeUsage(AttributeTargets.Property, AllowMultiple = false)]
	public class JsonTypeAttribute : Attribute
	{
        /// <summary>
        /// Gets the type.
        /// </summary>
        /// <value>
        /// The type.
        /// </value>
		public Type Type { get; private set; }

        /// <summary>
        /// Initializes a new instance of the <see cref="JsonTypeAttribute"/> class.
        /// </summary>
		public JsonTypeAttribute() { }

        /// <summary>
        /// Initializes a new instance of the <see cref="JsonTypeAttribute"/> class.
        /// </summary>
        /// <param name="type">The type.</param>
        public JsonTypeAttribute(Type type)
		{
            this.Type = type;
		}
	}
}
