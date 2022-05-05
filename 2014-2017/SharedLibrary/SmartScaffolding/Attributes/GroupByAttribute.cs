using System;

namespace SharedLibrary.SmartScaffolding.Attributes
{
    /// <summary>
    /// Property metadata attribute, marks the GroupBy column of the entity.
    /// </summary>
    [AttributeUsage(AttributeTargets.Property, AllowMultiple = false)]
    public class GroupByAttribute : Attribute
    { }
}
