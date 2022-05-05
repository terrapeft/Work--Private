namespace Db.AuditTrail
{
    /// <summary>
    /// Represents the [Users].[Actions] table
    /// </summary>
    public enum AuditAction
    {
        Create = 1,
        Update = 2,
        Delete = 3,
        LogIn = 4,
        ConcurrentLogOff = 5,
        ForbiddenIpAddress = 6
    }
}
