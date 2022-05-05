namespace Db
{
    interface ISpecialAction
    {
        bool SkipSavingEvents { get; set; }
        bool SkipAuditTrail { get; set; }
    }
}
