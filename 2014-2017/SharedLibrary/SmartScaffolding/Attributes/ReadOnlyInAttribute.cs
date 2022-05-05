namespace SharedLibrary.SmartScaffolding.Attributes
{
	using System;

	[AttributeUsage(AttributeTargets.Property, AllowMultiple = false)]
	public class ReadOnlyInAttribute : Attribute
	{
		public PageTemplate PageTemplate { get; private set; }

		public ReadOnlyInAttribute() { }

		public ReadOnlyInAttribute(PageTemplate lookupTable)
		{
			this.PageTemplate = lookupTable;
		}
	}
}