use backoffice

declare @today datetime = getdate()
declare @results table (
	Newsletter nvarchar(128),
	NewsletterGUID nvarchar(128),
	UserId int,
	UserName nvarchar(max),
	Title nvarchar(max),
	Forenames nvarchar(max),
	Surname nvarchar(max),
	Initials nvarchar(max),
	CompanyId int,
	CompanyName nvarchar(max),
	UserStatus nvarchar(max),
	NewsletterFormat int
)

drop table if exists #groups

select * 
into #groups
from 
( values 
    ('SSA', '1d471490-8942-461d-b110-0499e622fb77', '2827'),
    ('SSA', '1d471490-8942-461d-b110-0499e622fb77', '2828'),
    ('SSA', '1d471490-8942-461d-b110-0499e622fb77', '2829'),
    ('FIG', '31e290ef-ff07-45d4-8bcd-cc3399f7a1ac', '2600'),
    ('FIG', '31e290ef-ff07-45d4-8bcd-cc3399f7a1ac', '2601'),
    ('FIG', '31e290ef-ff07-45d4-8bcd-cc3399f7a1ac','2602'),
    ('FIG','31e290ef-ff07-45d4-8bcd-cc3399f7a1ac', '2603'),
    ('Covered Bonds', 'a01f6417-3233-44df-b8d7-19adf653627b', '2883'),
    ('Covered Bonds', 'a01f6417-3233-44df-b8d7-19adf653627b', '2884'),
    ('Covered Bonds', 'a01f6417-3233-44df-b8d7-19adf653627b', '2885'),
    ('Covered Bonds', 'a01f6417-3233-44df-b8d7-19adf653627b', '2886'),
    ('Corporate Bonds', '4d9183ec-16f9-4dd3-8959-c3b6759a7377', '2604'),
    ('Corporate Bonds', '4d9183ec-16f9-4dd3-8959-c3b6759a7377',  '2605'),
    ('Corporate Bonds', '4d9183ec-16f9-4dd3-8959-c3b6759a7377', '2606'),
    ('Emerging Markets', '526ba446-0666-4671-9eb7-127fc8e6a197', '2607'),
    ('Emerging Markets', '526ba446-0666-4671-9eb7-127fc8e6a197', '2608'),
    ('Emerging Markets', '526ba446-0666-4671-9eb7-127fc8e6a197', '2609'),
    ('Equity', 'dbc39f2d-087d-47e4-b2ff-b16fd7191add',  '2610'),
    ('Equity', 'dbc39f2d-087d-47e4-b2ff-b16fd7191add', '2611'),
    ('Equity', 'dbc39f2d-087d-47e4-b2ff-b16fd7191add', '2612'),
    ('Loans', '6fd7805c-d44b-46aa-a564-44d0c6de3c7c', '2613'),
    ('Loans', '6fd7805c-d44b-46aa-a564-44d0c6de3c7c',  '2614'),
    ('Loans', '6fd7805c-d44b-46aa-a564-44d0c6de3c7c', '2615'),
    ('LevFin', '05d02c73-12c6-4983-9113-698e28830f7e', '2616'),
    ('LevFin', '05d02c73-12c6-4983-9113-698e28830f7e', '2617'),
    ('LevFin', '05d02c73-12c6-4983-9113-698e28830f7e', '2618'),
    ('US Securitization', '1655be27-fe61-4a69-9824-0c3e5c87bdf4', '2879'),
    ('US Securitization', '1655be27-fe61-4a69-9824-0c3e5c87bdf4', '2880'),
    ('Eur Securitization', '2143c71e-52cc-463a-bfcd-62de0ada9244', '2619'),
    ('Eur Securitization', '2143c71e-52cc-463a-bfcd-62de0ada9244', '2620'),
    ('Eur Securitization', '2143c71e-52cc-463a-bfcd-62de0ada9244', '2621'),
    ('Asia', '47eacfef-e202-452a-a428-2c49cd1fe708', '2627'),
    ('Asia', '47eacfef-e202-452a-a428-2c49cd1fe708', '2628'),
    ('Asia', '47eacfef-e202-452a-a428-2c49cd1fe708', '2629'),
    ('China', '581cc0d2-6a8a-479f-b603-d7bb8905d942', '2632'),
    ('China', '581cc0d2-6a8a-479f-b603-d7bb8905d942', '2633'),
    ('SRI/Green', '0036a204-57e1-4f03-a4d3-18e9e209865c', '2888'),
    ('Weekly (Friday)', '9797e041-7ec5-4c49-bd54-3ecb9432b03b', '2640'),
    ('Breaking news special coverage', 'e178ae2e-ba2b-40bf-961a-3f61a2114567', '2640'),
    ('People & Markets weekly (Monday)', 'caaa2a73-0fbe-4b58-a979-dedcb522182c', '2638'),
    ('Primary market monitor (Tuesday)', 'fa3a8a39-92b7-4761-8652-f1118228475e', '2639'),
    ('The View (Wednesday)', '1182c51c-25d8-436f-a3c7-e640f71dfed0', '2634')
) as v (GroupName, NewsletterGUID, NewsletterAlertCategoryId)


declare @group nvarchar(128)
declare @guid nvarchar(128)
declare cur cursor 
	for select distinct GroupName, NewsletterGUID from #groups

open cur
fetch next from cur into @group, @guid

while @@fetch_status = 0
begin

	-- retrieves all User's Choices for given Site and Newsletter	
	;WITH NewsletterUsersChoices AS (
		SELECT
			 ROW_NUMBER() OVER (PARTITION BY BackOfficeUserId, NewsletterAlertCategoryId, ppna.ProductId ORDER BY NewsletterAlertCategoryId, pnacu.Id DESC) AS NewsletterUsersChoicesOrder
			,pnac.NewsletterAlertId
			,pnacu.SelectedFormat
			,NewsletterAlertCategoryId
			,Title
			,BackOfficeUserId AS UserId
			,CASE WHEN pnacu.ActionType = 1 THEN 1 ELSE 0 END AS IsSelected
			,ppna.ProductId
			,ps.SiteId
		FROM dbo.ProductNewsletterAlertCategoriesUser pnacu
		INNER JOIN dbo.ProductNewsletterAlertCategories pnac ON pnac.Id = pnacu.NewsletterAlertCategoryId
		INNER JOIN dbo.ProductProductNewsletterAlerts ppna ON ppna.NewsletterAlertId = pnac.NewsletterAlertId
		INNER JOIN Product.ProductSites ps ON ps.ProductID = ppna.ProductId
		WHERE pnacu.NewsletterAlertCategoryId in (	select NewsletterAlertCategoryId
													from #groups
													where GroupName = @group)
	)
	-- retrieves Newsletter Recipients List based on dates and activity of User's Subscriptions
	,NewsletterRecipientsList AS
	(
		SELECT
			 ROW_NUMBER() OVER (PARTITION BY nuc.UserId ORDER BY SubscriptionTypeId DESC) AS SubscriptionTypePriorityOrder
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
			,nuc.SelectedFormat AS SelectedNewsletterFormat
		FROM NewsletterUsersChoices nuc
		INNER JOIN Orders.Subscription sub ON sub.ProductId = nuc.ProductId
		INNER JOIN Logon.SubscriptionUser su ON su.SubscriptionId = sub.SubscriptionId AND su.UserId = nuc.UserId
		LEFT JOIN Orders.ExcludedSubscription exs ON exs.SubscriptionId = sub.SubscriptionId
		LEFT JOIN Logon.SubscriptionUserExcluded exsu ON exsu.SubscriptionUserId = su.SubscriptionUserId
		WHERE
			(
				(sub.SubscriptionTypeId = 3 AND sub.SubscriptionEndDateTime >= @today)
				OR (sub.SubscriptionTypeId = 2 AND sub.SubscriptionEndDateTime >= @today)
			)
			AND exs.SubscriptionId IS NULL AND exsu.SubscriptionUserId IS NULL
			AND nuc.NewsletterUsersChoicesOrder = 1 AND nuc.IsSelected = 1 -- get the last user's choice and only if newsletter was selected
	)

	insert into @results
	select distinct 
		 @group as Newsletter
		,@guid as NewsletterGUID
		,u.UserId
		,u.UserName
		,case when lower(uinfo.Title) = 'not selected' then '' else uinfo.Title end as Title
		,case when lower(ltrim(rtrim(uinfo.Forenames))) = 'unknown' then '' else uinfo.Forenames end as Forenames
		,case when lower(ltrim(rtrim(uinfo.Surname))) = 'unknown' then '' else uinfo.Surname end as Surname
		,isnull(uinfo.Initials, '') as Initials
		,uinfo.CompanyId
		,uinfo.CompanyName
		,st.SubscriptionType AS UserStatus
		,nrl.SelectedNewsletterFormat
	from NewsletterRecipientsList nrl
	inner join Product.Products prod on prod.ProductID = nrl.ProductId
	inner join Logon.Users u on u.UserId = nrl.UserId
	inner join Orders.SubscriptionType st on st.SubscriptionTypeId = nrl.SubscriptionTypeId 
	cross apply Customer.ufGetDefaultUserContactBasic(u.UserId) uinfo
	where SubscriptionTypePriorityOrder = 1
	order by Newsletter, Surname, Forenames

	fetch next from cur into @group, @guid
end

-- main results
select *
from @results

-- statistics, not necessary 
select newsletter, count(newsletter) as [Number of Recipients]
from @results
group by newsletter


close cur
deallocate cur



