USE [NewCentralUsers]
GO


/*

Required things for migration:

 1. Decide if we need to include or exclude registrants: @includeRegistrants
 2. Choose category for migration, if need both then run twice, otherwise there will be issues with multiple rows: @newsletterAlertCategoryId
 3. For the NCU side - verify existed or create new publications for TP week and ITR: @itrPubId, @tpWeekPubId
 4. For the Backoffice side verify sites: @itrSiteId, @tpweekSiteId, 
	currently they are "TP Week UNIFIED ID" and "International Tax Review (UNIFIED ID)"
    => select * from [BackOffice].[Product].[Site] where siteid in (1002693, 1001647)
 5. For the NCU side - specify correct newsletterId, currently it's a random value: @newsletterId
 6. Should the dbo.Newsletters record be always new, or it shuld be updated
 7. More values for the dbo.Subscriptions?

*/



declare @IDs table(Id int)

-- 0 - include trial and subscriptions
-- 1 - include subscription of all types: registration, trial, subscription, book, cap donor
declare @includeRegistrants bit = 0

-- 1 - non-breaking news
-- 2 - breaking news
declare @newsletterAlertCategoryId int = 1 

declare @itrPubId int = 49 -- ITR in NCU
declare @itrSiteId int = 1002693

declare @tpWeekPubId int = 242 -- TPWeek in NCU
declare @tpweekSiteId int = 1001647

-- for real migration it will be set inside of the loop
declare @userId int = 25494 -- hbanck@citco.com, tpweek recipient

-- this is not a correct value, should be verified before running
-- the emailPreferenceId in the service's code, where it should come from?
declare @newsletterId int = 17771 


drop table if exists ##NewsletterUsersChoices
drop table if exists ##NewsletterUsersList

-- users' choices, part of the [Backoffice].[Customer].[uspGetListEmailRecipientsForSiteIdAndNewsletterAlertCategoryId]
-- we need an email format from it
select
	 row_number() over (partition by BackOfficeUserId, NewsletterAlertCategoryId, ppna.ProductId order by NewsletterAlertCategoryId, pnacu.Id desc) as NewsletterUsersChoicesOrder
	,pnac.NewsletterAlertId
	,pnacu.SelectedFormat
	,NewsletterAlertCategoryId
	,Title
	,BackOfficeUserId as UserId
	,case when pnacu.ActionType = 1 then 1 else 0 end as IsSelected
	,ppna.ProductId
	,ps.SiteId
into ##NewsletterUsersChoices
from [Backoffice].dbo.ProductNewsletterAlertCategoriesUser pnacu
inner join [Backoffice].dbo.ProductNewsletterAlertCategories pnac on pnac.Id = pnacu.NewsletterAlertCategoryId
inner join [Backoffice].dbo.ProductProductNewsletterAlerts ppna on ppna.NewsletterAlertId = pnac.NewsletterAlertId
inner join [Backoffice].Product.ProductSites ps on ps.ProductID = ppna.ProductId
where pnacu.NewsletterAlertCategoryId = 1 AND ps.SiteId = @tpweekSiteId -- NewsletterAlertCategoryId = 1 for non-breaking news


-- users list, part of the [Backoffice].[Customer].[uspGetListEmailRecipientsForSiteIdAndNewsletterAlertCategoryId]
-- we need start and expiration dates here
select
	row_number() over (partition by nuc.UserId order by SubscriptionTypeId desc) as SubscriptionTypePriorityOrder
	,sub.SubscriptionStartDateTime
	,sub.SubscriptionEndDateTime
	,sub.SubscriptionTypeId
	,su.SubscriptionId
	,nuc.UserId
	,nuc.SiteId
	,nuc.ProductId
	,nuc.NewsletterAlertId
	,nuc.NewsletterAlertCategoryId
	,nuc.Title
	,nuc.SelectedFormat as SelectedNewsletterFormat
into ##NewsletterUsersList
from ##NewsletterUsersChoices nuc
	inner join [Backoffice].Orders.Subscription sub on sub.ProductId = nuc.ProductId
	inner join [Backoffice].Logon.SubscriptionUser su on su.SubscriptionId = sub.SubscriptionId AND su.UserId = nuc.UserId
	left join [Backoffice].Orders.ExcludedSubscription exs on exs.SubscriptionId = sub.SubscriptionId
	left join [Backoffice].Logon.SubscriptionUserExcluded exsu on exsu.SubscriptionUserId = su.SubscriptionUserId
where sub.SubscriptionEndDateTime >= getdate()
	AND exs.SubscriptionId IS NULL AND exsu.SubscriptionUserId IS NULL
	AND nuc.NewsletterUsersChoicesOrder = 1 AND nuc.IsSelected = 1 -- get the last user's choice and only if newsletter was selected

declare @nlPlain bit
declare @nlHtml bit

set @nlPlain = (
	select 
		case when SelectedNewsletterFormat = 2 
			then 1 
			else 0
		end 
	from ##NewsletterUsersList 
	where userid = @userId)

set @nlHtml = (
	select 
		case when SelectedNewsletterFormat = 1 
			then 1 
			else 0
		end 
	from ##NewsletterUsersList 
	where userid = @userId)


-- there are already existed records for some users
/*
select distinct nuid, npublication,nnewsletterid, nplain, nhtml,nCreationDate, nUpdated
from [dbo].[Newsletters] n join ##NewsletterUsersChoices c on n.nUID = c.UserId
where nPublication = 242
*/


-- as there is no UpdateDate column, does it mean there always should be a new record?
/*
if exists (select 1 from newsletters where nuid = @userId and nPublication = @tpWeekPubId and nNewsletterId = @newsletterId)
	update newsletters set 
		nPlain = @nlPlain,
		nHtml = @nlHtml
	where 
		nuid = @userId 
		and nPublication = @tpWeekPubId 
		and nNewsletterId = @newsletterId
else
*/
	-- insert newsletter, we will need the format from here
	insert into newsletters
			   ([nPublication]
			   ,[nUID]
			   ,[nNewsletterID]
			   ,[nPlain]
			   ,[nHTML]
			   ,[nCreationDate]
			   ,[nUpdated])
	output inserted.nIndex INTO @IDs(Id)
	values
			   (@tpweekPubId 
			   ,@userId 
			   ,@newsletterId -- what is it?
			   ,@nlPlain 
			   ,@nlHtml 
			   ,getdate() 
			   ,0) -- should it be 1?

--declare @nlId int
--set @nlId = (select top 1 Id from @IDs)


-- subscriptions

declare @start datetime
declare @end datetime
declare @trialEnd datetime


set @start = (select SubscriptionStartDateTime from ##NewsletterUsersList where userid = @userId)
set @trialEnd = (select 
				case when SubscriptionTypeId = 2
					then SubscriptionStartDateTime 
					else null
				end 
			from ##NewsletterUsersList 
			where userid = @userId)

set @end = (select 
				case when SubscriptionTypeId != 2 
					then SubscriptionStartDateTime 
					else null
				end 
			from ##NewsletterUsersList 
			where userid = @userId)

if exists (select 1 from subscriptions where suid = @userId and spid = @tpWeekPubId)
	update subscriptions set 
		[sStartDate] = @start,
		[sExpiryDate] = @end,
		[sTrialExpiryDate] = @trialEnd,
		[sUpdateDate] = getdate(),
		[sUpdatedBy] = current_user
	where suid = @userId and spid = @tpWeekPubId
else
	insert into subscriptions
        ([sUID]
        ,[sPID]
        ,[sStartDate]
        ,[sExpiryDate]
        ,[sTrialExpiryDate]/*
        ,[sSubscriptionNumber]
        ,[sMasterRecord]
        ,[sAllowedSessions]
        ,[sNumberOfLogons]
        ,[sNumberOfGUIDs]
        ,[sStatus]
        ,[sCreationDate]
        ,[sCreatedBy]
        ,[sUpdateDate]
        ,[sUpdatedBy]
        ,[sAreasOfInterest]
        ,[sFirstLoggedOn]
        ,[sComments]
        ,[sQuestion]
        ,[sPendingPayment]
        ,[sIPOnly]
        ,[sAdditionalQuestions]
        ,[sCopyPaste]
        ,[sGUID]
        ,[sIPLogOnCheck]
        ,[sTrialTerminatedDate]*/)
     VALUES 
        (@userId
        ,@tpWeekPubId
        ,@start
        ,@end
        ,@trialEnd/*
        ,<sSubscriptionNumber, nvarchar(20),>
        ,<sMasterRecord, bit,>
        ,<sAllowedSessions, smallint,>
        ,<sNumberOfLogons, smallint,>
        ,<sNumberOfGUIDs, smallint,>
        ,<sStatus, int,>
        ,<sCreationDate, datetime,>
        ,<sCreatedBy, varchar(150),>
        ,<sUpdateDate, datetime,>
        ,<sUpdatedBy, varchar(50),>
        ,<sAreasOfInterest, nvarchar(1000),>
        ,<sFirstLoggedOn, datetime,>
        ,<sComments, nvarchar(200),>
        ,<sQuestion, nvarchar(50),>
        ,<sPendingPayment, bit,>
        ,<sIPOnly, bit,>
        ,<sAdditionalQuestions, nvarchar(1000),>
        ,<sCopyPaste, bit,>
        ,<sGUID, uniqueidentifier,>
        ,<sIPLogOnCheck, bit,>
        ,<sTrialTerminatedDate, datetime,>*/
	   )


