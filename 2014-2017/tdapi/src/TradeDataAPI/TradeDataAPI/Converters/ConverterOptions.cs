using System;

namespace TradeDataAPI.Converters
{
    [Flags]
    public enum ConverterOptions
    {
        None = 0,
        IncludeNamedProperty = 1,
        SetTablesIndicies = 2
    }
}