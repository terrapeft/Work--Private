using System;

namespace SharedLibrary.SmartScaffolding.Attributes
{
    public class WhereAttribute : Attribute
    {
        public string Where { get; private set; }

        public WhereAttribute(string whereClause)
        {
            Where = whereClause;
        }
    }
}
