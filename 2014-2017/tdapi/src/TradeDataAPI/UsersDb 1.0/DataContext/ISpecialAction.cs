namespace UsersDb.DataContext
{
    interface ISpecialAction
    {
        bool SkipSavingEvents { get; set; }
        bool SkipAuditTrail { get; set; }
    }
}
