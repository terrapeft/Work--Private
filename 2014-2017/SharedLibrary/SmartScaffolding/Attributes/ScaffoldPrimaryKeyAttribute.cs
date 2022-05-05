using System;

namespace SharedLibrary.SmartScaffolding.Attributes
{
    [AttributeUsage(AttributeTargets.Property, AllowMultiple = false)]
    public class ScaffoldPrimaryKeyAttribute : Attribute
    {
        public bool Scaffold { get; set; }

        public ScaffoldPrimaryKeyAttribute(bool scaffold)
        {
            Scaffold = scaffold;
        }
    }
}
