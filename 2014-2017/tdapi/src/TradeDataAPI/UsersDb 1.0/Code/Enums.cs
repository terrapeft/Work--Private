using System;

namespace UsersDb
{
    /// <summary>
    /// Represents the [Users].[Roles] table
    /// </summary>
    public enum UserRoles
    {
        Administrator = 1,
        Customer = 2,
        TrialUser = 3
    }

    public enum UiPermission
    {
        AccessAdminUI = 1,
        AccessCustomerUI = 2,
        ResourcesAdmin = 5
    }

    public enum PermissionTypes
    {
        BuiltIn = 1,
        SearchGroups = 2,
        SuperAdmin = 3
    }

    public enum SubscriptionRequestTypes
    {
        Add = 1,
        Remove = 2,
        Trial = 3
    }

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

    /// <summary>
    /// Represents the [Users].[MethodTypes] table
    /// </summary>
    public enum MethodTypes
    {
        Data = 1,
        Informer = 2,
        Virtual = 3
    }

    /// <summary>
    /// Represents the [Users].[Statuses] table
    /// </summary>
    public enum ActionStatus
    {
        Succeeded = 1,
        Fialed = 2
    }

    /// <summary>
    /// Defines the way to search in the string
    /// </summary>
    public enum SearchOptions
    {
        StartsWith = 1,
        EndsWith = 2,
        Contains = 3,
        Equals = 4
    }

    /// <summary>
    /// Defines the way to join the where clause conditions
    /// </summary>
    public enum JoinWith
    {
        And,
        Or
    }

    public enum SearchTables
    {
        XymRootLevelGLOBAL = 1,
        XymREUTERSTradedSeriesGLOBAL = 2
    }

}