use backoffice

/* euromoneyadmin */

/*

	Active GC users 
	with active subscriptions of type Subcription (type id: 3) or Trial (type id: 2),
	that are not in the Logon.SubscriptionUserExcluded (deactivated end users) 
	and not in the Orders.SubscriptionExcluded (deactivated subscriptions or trials)
	with one default address (there could be several active addresses),
	with phones aggregated in one field

*/

drop table if exists #results_1310

;with Phones as (
	select uph.UserContactAddressId, string_agg(pnt.PhoneNumberType + ': ' + pn.PhoneNumber, ', ') as Phones
	from Customer.UserContactAddressPhoneNumber uph
	left join Customer.PhoneNumber pn on uph.PhoneNumberId = pn.PhoneNumberId
	left join Customer.PhoneNumberExtension pne on uph.PhoneNumberExtensionId = pne.PhoneNumberExtensionId
	left join Customer.PhoneNumberType pnt on uph.PhoneNumberTypeId = pnt.PhoneNumberTypeId
	group by uph.UserContactAddressId
),

UserContact as (
	select 	
		 uca.UserId as ucUserId
		,a.*
		,p.Phones
		,c.*, g.Gender, g.GenderCode, t.Title
		,cm.*
		,convert(bit, case when auca.ActiveUserContactAddressId = udc.ActiveUserContactAddressId then 1 else 0 end) as IsDefaultUserContactAddress
		,convert(bit, case when uca.ContactId = udc.ContactId then 1 else 0 end ) as IsDefaultContact
	from Customer.UserContactAddress uca
	join Customer.Address a on uca.AddressId = a.AddressId
	join Customer.Contact c on uca.ContactId = c.ContactId
	join Customer.Company cm on uca.CompanyId = cm.CompanyId
	join Customer.Gender g on c.GenderId = g.GenderId
	join Customer.Title t on c.TitleId = t.TitleId
	join Customer.ActiveUserContactAddress auca on uca.UserContactAddressId = auca.UserContactAddressId
	left join Phones p on auca.UserContactAddressId = p.UserContactAddressId
	left join Logon.UserDefaultCommunication udc on uca.UserId = udc.UserId
)

select distinct
	 u.UserId
	,u.UserName
	,u.IsLockedOut
	,u.UserTypeId
	,ut.UserType
	,s.SubscriptionId as sSubscriptionId
	,s.SubscriptionTypeId
	,st.SubscriptionType
	,s.SubscriptionCodeId
	,s.ParentSubscriptionId
	,s.SubscriptionUserLimit
	,s.SubscriptionStartDateTime
	,s.SubscriptionEndDateTime
	,s.RenewalCount
	,s.ConcurrencyLimit
	  ,p.ProductID
      ,p.Name
      ,p.BriefDescription
      ,p.FullDescription
      ,p.ProfitCentreID
      ,p.PrimaryProductOwnerID
      ,p.SecondaryProductOwnerID
      ,p.PrimaryFinanceOwnerID
      ,p.SecondaryFinanceOwnerID
      ,p.TypeID
      ,p.FulfillmentHouseID
      ,p.QssDemographic
      ,p.IsPhysicallyFulfilled
      ,p.IsElectronicDelivered
      ,p.IsActive as pIsActive
      ,p.IsHidden
      ,p.CreatedDate
      ,p.CreatorID
      ,p.SubTypeID
      ,p.CompletedStepsFlag
      ,p.OverallTypeID
      ,p.DescriptivePdfID
      ,p.LockingFlags
      ,p.NotifyOnViewUserID
      ,p.PrimaryURL
      ,p.ShopShortLink
      ,p.SiteSpecificCentreID
      ,p.IsTrialsAvailable
      ,p.NCUPublicationID
      ,p.ProductFamilyID
      ,p.UpdateDate
      ,p.CodesID
      ,p.LegalEntityID
      ,p.LegalMasterId
      ,p.VariantParentID
      ,p.SiteDisplayName
      ,p.CMSSourceID
	,pt.Name as [Product Type]
	,od.OrderDetailId
	,od.ApplicationId
	,od.PriceID
	,od.Quantity
	,od.UnitPrice
	,od.NetValue
	,od.TaxPaid
	,od.PostagePackageFee
	,od.DispatchCode
	,o.OrderId
	,o.OrderTypeId
	,o.CreatorUserId
	,o.OrderDateTime
	,o.BillingUserContactAddressId
	,o.UserContactAddressId
	,o.CustomerReference
	,o.LeadSourceId
	,o.ClientVatNumber
	,o.CurrencyId
	,o.NetTotalValue
	,o.TotalVatPaid
	,o.TotalPostagePackageFee
	,o.IntServerIpAddress
	,o.ParentOrderId
	,o.CreatorCultUserId
	,o.LineItemCount
	,o.TaxCalculationId
	,o.PaymentProviderId
	,o.PaymentStatusId
	,o.MCOrderId
	,o.SiteId
	,o.PaymentReference
	,o.CreditCardLastFourDigits
	,addr.*
	,ugs.*
into #results_1310
from Logon.Users u
join Logon.UserType ut on u.UserTypeId = ut.UserTypeId
join Logon.SubscriptionUser su on u.UserId = su.UserId
join Orders.Subscription s on su.SubscriptionId = s.SubscriptionId
join Orders.SubscriptionType st on s.SubscriptionTypeId = st.SubscriptionTypeId
join Orders.OrderDetail od on s.OrderDetailId = od.OrderDetailId
join Orders.Orders o on od.OrderId = o.OrderId
join Product.Products p on s.ProductId = p.ProductId
join Product.ProductTypes pt on p.TypeID = pt.ProductTypeID
left join UserContact addr on u.UserId = addr.ucUserId
left join Logon.UserGroupSubscription ugs on s.SubscriptionId = ugs.SubscriptionId
left join Logon.SubscriptionUserExcluded sue on su.SubscriptionUserId = sue.SubscriptionUserId
left join Orders.ExcludedSubscription es on su.SubscriptionId = es.SubscriptionId
where 
	sue.SubscriptionUserId is null
and es.SubscriptionId is null
and s.SubscriptionEndDateTime > getdate()
and p.ProductID in (
	select ProductID
	from Product.Products
	where name like 'power finance%'
)
and u.UserTypeId <> 11
and s.SubscriptionTypeId <> 1 
and addr.IsDefaultUserContactAddress = 1
order by UserName


-- Main results
select * from #results_1310


-- DPA information from the LegalCompliance database on AZ01-SQL-PRD-01

select R.UserID, R.Title, R.IsAccepted from
(
  select row_number() over (partition by a.UserID, c.Title order by a.LatestUpdate desc) as rownum, a.UserID, c.Title, a.IsAccepted
  from [UK-SQL-01].[LegalCompliance].[dbo].[Acceptance] a
  join [UK-SQL-01].[LegalCompliance].[dbo].[User] u on a.UserID = u.UserID
  join [UK-SQL-01].[LegalCompliance].[dbo].[ContractVersion] cv on a.ContractVersionID = cv.ContractVersionID
  join [UK-SQL-01].[LegalCompliance].[dbo].[Contract] c on cv.ContractID = c.ContractID
  where u.Email in (select username from #results_1310)
) r
where r.rownum = 1

