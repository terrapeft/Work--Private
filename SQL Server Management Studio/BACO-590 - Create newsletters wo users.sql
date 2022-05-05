/*********************************************
*
*   BACO-590: ManagingIP - Free Content Email Weekly (622)
*
**********************************************/
use newcentralusers

declare @newsletterId int

set @newsletterId = (select max(nNewsletterID) + 1 from Newsletters)
print 'ManagingIP - Free Content Email Weekly nNewsletterId: ' + cast(@newsletterId as varchar(12))

insert into NewsletterNames (nlnNewsletterId, nlnName, nlnPubId, nlnAvailableToTrialImport, nlnRank, nlnIsBreakingNews)
values (@newsletterId, 'ManagingIP - Free Content Email Weekly', 5027, 1, 1, 0)


