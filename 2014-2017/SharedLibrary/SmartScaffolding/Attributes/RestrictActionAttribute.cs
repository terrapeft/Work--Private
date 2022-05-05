namespace SharedLibrary.SmartScaffolding.Attributes
{
	using System;

	[AttributeUsage(AttributeTargets.Class, AllowMultiple = false)]
	public class RestrictActionAttribute : Attribute
	{
		public PageTemplate Action { get; set; }
	}
}
