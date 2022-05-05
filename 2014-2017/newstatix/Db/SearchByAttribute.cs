using System;

namespace Db
{
    [AttributeUsage(AttributeTargets.Property, AllowMultiple = false)]
    public class SearchByAttribute : Attribute
    {
    }
}
