using System;

namespace UsersDb.DataContext
{
    public interface ILoginUser
    {
        string Username { get; set; }

        int? FailedLoginAttemptsCnt { get; set; }

        DateTime? LastFailedAttempt { get; set; }
    }
}
