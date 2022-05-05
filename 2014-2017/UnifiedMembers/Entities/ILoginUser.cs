using System;

namespace TradeDataUsers
{
    public interface ILoginUser
    {
        string Username { get; set; }

        int? FailedAttemptsCnt { get; set; }

        DateTime? LastAttempt { get; set; }
    }
}