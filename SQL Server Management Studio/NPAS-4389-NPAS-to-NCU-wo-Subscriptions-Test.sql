USE [NewCentralUsers]
GO


/* 
Products and Sites

productid   name																	siteid	name
1061279	    International Tax Review - ITR - Level 2 Online Only (UNIFIED ID)		4		Euromoney PLC
1061279	    International Tax Review - ITR - Level 2 Online Only (UNIFIED ID)		1002693	International Tax Review (UNIFIED ID)         
1059674	    International Tax Review Basic Online - ITR- Level 1 (UNIFIED ID)		4		Euromoney PLC
1059674	    International Tax Review Basic Online - ITR- Level 1 (UNIFIED ID)		1002693	International Tax Review (UNIFIED ID)
1059673	    International Tax Review Magazine - ITR - Level 1 (UNIFIED ID)			4		Euromoney PLC
1059673	    International Tax Review Magazine - ITR - Level 1 (UNIFIED ID)			1002693	International Tax Review (UNIFIED ID)
1059672	    International Tax Review Online Premium - ITR - Level 3 (UNIFIED ID)	4		Euromoney PLC
1059672	    International Tax Review Online Premium - ITR - Level 3 (UNIFIED ID)	1002693	International Tax Review (UNIFIED ID)
1058050	    International Tax Review Premium										4		Euromoney PLC
1058050	    International Tax Review Premium										1002693	International Tax Review (UNIFIED ID)
1032689	    TP Week Basic Subscription (UNIFIED ID)									4		Euromoney PLC
1032689	    TP Week Basic Subscription (UNIFIED ID)									1001647	TP Week UNIFIED ID


*/

drop table if exists ##NewsletterUsersChoices
drop table if exists ##NewsletterUsersList


declare @itrSiteId int = 1002693
declare @tpweekSiteId int = 1001647
declare @euromoneySiteId int = 4

declare @itrPubId int = 49 -- ITR in NCU

declare @tpWeekPubId int = 242 -- TPWeek in NCU

declare @userId int

-- users' choices, part of the [Backoffice].[Customer].[uspGetListEmailRecipientsForSiteIdAndNewsletterAlertCategoryId]
-- we need an email format from it
select
	 row_number() over (partition by BackOfficeUserId, NewsletterAlertCategoryId, ppna.ProductId order by NewsletterAlertCategoryId, pnacu.Id desc) as NewsletterUsersChoicesOrder
	,pnac.NewsletterAlertId
	,pnacu.SelectedFormat
	,NewsletterAlertCategoryId
	,pnac.Title
	,BackOfficeUserId as UserId
	,case when pnacu.ActionType = 1 then 1 else 0 end as IsSelected
	,ppna.ProductId
	,ps.SiteId
into ##NewsletterUsersChoices
from [Backoffice].dbo.ProductNewsletterAlertCategoriesUser pnacu
inner join [Backoffice].dbo.ProductNewsletterAlertCategories pnac on pnac.Id = pnacu.NewsletterAlertCategoryId
left join [Backoffice].dbo.ProductProductNewsletterAlerts ppna on ppna.NewsletterAlertId = pnac.NewsletterAlertId
left join [Backoffice].Product.ProductSites ps on ps.ProductID = ppna.ProductId
where pnacu.NewsletterAlertCategoryId in (1,2, 861, 862, 863)
and ps.SiteId in (@tpweekSiteId, @itrSiteId, @euromoneySiteId)


-- users list, part of the [Backoffice].[Customer].[uspGetListEmailRecipientsForSiteIdAndNewsletterAlertCategoryId]
-- we need start and expiration dates here
select
	--row_number() over (partition by nuc.UserId order by SubscriptionTypeId desc) as SubscriptionTypePriorityOrder
	sub.SubscriptionStartDateTime
	,sub.SubscriptionEndDateTime
	,sub.SubscriptionTypeId
	,su.SubscriptionId
	,nuc.UserId
	,u.UserName
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
	join [BackOffice].[Logon].[Users] u on u.UserId = nuc.UserId
where sub.SubscriptionEndDateTime >= getdate()
	AND exs.SubscriptionId IS NULL AND exsu.SubscriptionUserId IS NULL
	AND nuc.NewsletterUsersChoicesOrder = 1 AND nuc.IsSelected = 1 -- get the last user's choice and only if newsletter was selected
	--AND UserName in ('2278205@29zW.random.euromoney.com')


select @userId = min(UserId) from ##NewsletterUsersList

drop table if exists ##test_output
create table ##test_output (
	operation varchar(6),
	pubId int,
	userId int,
	UserName nvarchar(1024),
	newsletterId int,
    nlPlain bit,
	nlHtml bit,
	nCreationDate datetime,
	nUpdated bit
)

while @userId is not null
begin
	declare @nlPlain bit
	declare @nlHtml bit
	declare @nacId int
	declare @newsletterId int
	declare @pubId int

	select @nacId = (select top 1 NewsletterAlertCategoryId from ##NewsletterUsersList where userid = @userId)
	
	-- taken from [NewCentralUsers].[dbo].[NewsletterNames]
	select @newsletterId = (
		select
			case 
				when @nacId in (1, 2) then 80
				else 637
			end
	)

	select @pubId = (
		select
			case 
				when @nacId in (1, 2) then @tpWeekPubId
				else @itrPubId
			end
	)

	set @nlPlain = (
		select top 1
			case when SelectedNewsletterFormat = 2 
				then 1 
				else 0
			end 
		from ##NewsletterUsersList 
		where userid = @userId)

	set @nlHtml = (
		select top 1
			case when SelectedNewsletterFormat = 1 
				then 1 
				else 0
			end 
		from ##NewsletterUsersList 
		where userid = @userId)

	--if not exists (select 1 from newsletters where nuid = @userId and nPublication = @pubId and nNewsletterId = @newsletterId)
	if not exists (select 1 from ##test_output where userid = @userId and pubid = @pubId and newsletterId = @newsletterId)
	begin
  
		insert into ##test_output
		select 'Insert' as Opertion
			,@pubId [nPublication]
			,@userId [nUID]
			,UserName
			,@newsletterId [nNewsletterID]
			,@nlPlain [nPlain]
			,@nlHtml [nHTML]
			,getdate() [nCreationDate]
			,0 [nUpdated]
		from ##NewsletterUsersList
		where userid = @userId
		and newsletteralertcategoryid = @nacId

		/*
		-- insert newsletter, we will need the format from here
		insert into newsletters
			([nPublication]
			,[nUID]
			,[nNewsletterID]
			,[nPlain]
			,[nHTML]
			,[nCreationDate]
			,[nUpdated])
		values
			(@pubId 
			,@userId 
			,@newsletterId
			,@nlPlain 
			,@nlHtml 
			,getdate() 
			,0) -- should it be 1?
		*/
	end
	else 
	begin
		insert into ##test_output
		select 'Update' as Opertion
			,@pubId [nPublication]
			,@userId [nUID]
			,UserName
			,@newsletterId [nNewsletterID]
			,@nlPlain [nPlain]
			,@nlHtml [nHTML]
			,getdate() [nCreationDate]
			,0 [nUpdated]
		from ##NewsletterUsersList
		where userid = @userId
		and newsletteralertcategoryid = @nacId
		/*
		if exists (select 1 from newsletters where nuid = @userId and nPublication = @pubId and nNewsletterId = @newsletterId)
		update newsletters set 
			nPlain = @nlPlain,
			nHtml = @nlHtml
		where 
			nuid = @userId 
			and nPublication = @pubId 
			and nNewsletterId = @newsletterId
		*/
	end

	select @userId = min(UserId) from ##NewsletterUsersList where UserId > @userId
end

select * from ##test_output