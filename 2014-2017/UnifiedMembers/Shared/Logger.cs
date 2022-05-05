using System;
using Elmah;

public class Logger
{
    public static void LogError(Exception ex)
    {
        ErrorSignal.FromCurrentContext().Raise(ex);
    }
}