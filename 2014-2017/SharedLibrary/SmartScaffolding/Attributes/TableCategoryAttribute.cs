namespace SharedLibrary.SmartScaffolding.Attributes
{
	using System;

	/// <summary>
	/// Attribute to specify xslt file name for the entity's field of type XML.
	/// Path is not supported, all xslt files should be placed in the predefined folder.
	/// </summary>
	[AttributeUsage(AttributeTargets.Class, AllowMultiple = false)]
	public class TableCategoryAttribute : Attribute
	{
		public string Category { get; private set; }
		public string SubCategory { get; private set; }

		public TableCategoryAttribute() { }

		public TableCategoryAttribute(string name, string subCategory = null)
		{
			this.Category = name;
			this.SubCategory = subCategory;
		}
	}
}
