/*********************************************
*
*   BACO-591: Patent Strategy Newsletter
*
**********************************************/
use newcentralusers

declare @newsletterId int

set @newsletterId = (select max(nNewsletterID) + 1 from Newsletters)
print 'Patent Strategy nNewsletterId: ' + cast(@newsletterId as varchar(12))

insert into NewsletterNames (nlnNewsletterId, nlnName, nlnPubId, nlnAvailableToTrialImport, nlnRank, nlnIsBreakingNews)
values (@newsletterId, 'Patent Strategy', 5027, 1, 1, 0)

