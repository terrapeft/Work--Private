using System;

namespace Statix.Controls.Search.Classes
{
    interface IFilterValue : IValue
    {
        TypeCode Type { get; set; }
    }
}
