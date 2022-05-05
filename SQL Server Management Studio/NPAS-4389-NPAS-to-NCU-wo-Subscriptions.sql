USE [NewCentralUsers]
GO


drop table if exists ##NewsletterUsersChoices
drop table if exists ##NewsletterUsersList

declare @itrPubId int = 49 -- ITR in NCU
declare @itrSiteId int = 1002693

declare @tpWeekPubId int = 242 -- TPWeek in NCU
declare @tpweekSiteId int = 1001647

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
	--AND UserName in ('77754@H8fQ.random.euromoney.com', '150382@AH91.random.euromoney.com')


select @userId = min(UserId) from ##NewsletterUsersList

--select * from ##NewsletterUsersList where username = 'Deactivated_pdawson@euromoneyplc.com'


while @userId is not null
begin
	declare @nlPlain bit
	declare @nlHtml bit
	declare @nacId int
	declare @newsletterId int

	select @nacId = (select top 1 NewsletterAlertCategoryId from ##NewsletterUsersList where userid = @userId)
	
	-- taken from [NewCentralUsers].[dbo].[NewsletterNames]
	select @newsletterId = (
		select
			case 
				when @nacId in (1, 451) then 80
				when @nacId = 449 then 637
				when @nacId in (171, 448, 817) then 644
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

	-- there are already existed records for some users
	/*
	select distinct nuid, npublication,nnewsletterid, nplain, nhtml,nCreationDate, nUpdated
	from [dbo].[Newsletters] n join ##NewsletterUsersChoices c on n.nUID = c.UserId
	where nPublication = 242
	*/


	if not exists (select 1 from newsletters where nuid = @userId and nPublication = @tpWeekPubId and nNewsletterId = @newsletterId)
	begin
		select @tpweekPubId [nPublication]
					   ,@userId [nUID]
					   ,UserName
					   ,@newsletterId [nNewsletterID]
					   ,@nlPlain [nPlain]
					   ,@nlHtml [nHTML]
					   ,getdate() [nCreationDate]
					   ,0 [nUpdated]
		from ##NewsletterUsersList
		where userid = @userId
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
		--output inserted.nIndex INTO @IDs(Id)
		values
					(@tpweekPubId 
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
		select 'Update for user ' + cast(@userId as varchar(10)) + ', publication: ' + cast(@tpWeekPubId as varchar(10)) + ', newsletter: ' + cast(@newsletterId as varchar(10))
		/*
		if exists (select 1 from newsletters where nuid = @userId and nPublication = @tpWeekPubId and nNewsletterId = @newsletterId)
		update newsletters set 
			nPlain = @nlPlain,
			nHtml = @nlHtml
		where 
			nuid = @userId 
			and nPublication = @tpWeekPubId 
			and nNewsletterId = @newsletterId
		*/
	end

	select @userId = min(UserId) from ##NewsletterUsersList where UserId > @userId
end
