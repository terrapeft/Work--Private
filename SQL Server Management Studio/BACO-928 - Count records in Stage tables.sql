use backoffice
/*
SELECT name AS [Name], 
       SCHEMA_NAME(schema_id) AS schema_name, 
       type_desc, 
       create_date, 
       modify_date
FROM sys.objects
WHERE type ='u'
and SCHEMA_NAME(schema_id) = 'Interim'
and (name like '%_Stage' and name not like 'InitialLoad_%' and name not like 'report_%')
*/


/*

use backoffice

drop table if exists #tbls
drop table if exists #tbl

declare @sql nvarchar(1024), @table nvarchar(256)
create table #tbl (name nvarchar(256), count int)

SELECT 'Interim.' + name AS [Name]
into #tbls       
FROM sys.objects
WHERE type ='u'
and SCHEMA_NAME(schema_id) = 'Interim'
and (name like '%_Stage' and name not like 'InitialLoad_%' and name not like 'report_%')

while (select count(*) from #tbls) > 0
begin
	set @table = (select top 1 name from #tbls)
	set @sql = N'insert into #tbl select ''' + @table + ''', count(*) from ' + @table
	exec sp_executesql @sql

	delete top (1) 
	from #tbls
end

select * from #tbl
order by count

*/


-- .
select *
from Interim.LogonUsers_Stage s
join Logon.Users u on s.UserId = u.UserId
join Logon.UserSummary us on u.UserId = us.UserId
order by s.username

-- no mapping
select  us.*
from Interim.SubscriptionUser_Stage as us
join Orders.Subscription as s on s.SubscriptionId = us.SubscriptionId 
join [Product].[Products] as p on p.ProductID = s.ProductID
left join interim.[Repl_NCUNBOProductMap] pm on pm.ProductId = s.ProductId
where pm.productid is null

-- outdated
select  count(*)
-- delete from us
from Interim.SubscriptionUser_Stage as us
join Orders.Subscription as s on s.SubscriptionId = us.SubscriptionId 
join [Product].[Products] as p on p.ProductID = s.ProductID
where subscriptionenddatetime < getdate() 

select count(*) -- s.SubscriptionEndDateTime, us.SubscriptionEndDateTime
-- delete from us
from Interim.Subscription_Stage as us
join Orders.Subscription as s on s.SubscriptionId = us.SubscriptionId 
join [Product].[Products] as p on p.ProductID = s.ProductID
where s.subscriptionenddatetime < getdate() 
--and s.SubscriptionEndDateTime != us.SubscriptionEndDateTime



/*


select count(*)
from Interim.[LogonUsers_Stage]   U
where u.UserTypeId = 11

select count(*)
from Interim.ActiveUserContacAddress_Stage i
join Customer.UserContactAddress uca on i.usercontactaddressid = uca.usercontactaddressid
join Logon.Users u on uca.userid = u.userid
where u.usertypeid = 11

select count(*)
from Interim.SubscriptionUser_Stage st
join Logon.Users u on st.userid = u.userid
where u.usertypeid = 11

select count(*)
from Interim.ContactPref_Stage cp
join Logon.Users u on cp.userid = u.userid
where u.usertypeid = 11

select count(*)
from Interim.UserContactAddress_Stage ua
join Logon.Users u on ua.userid = u.userid
where u.usertypeid = 11


select count(*)
from Interim.UserDefaultCommunication_Stage dc
join Logon.Users u on dc.userid = u.userid
where u.usertypeid = 11


select count (*)
from Logon.Users

*/
/*

delete s
from Interim.LogonUsers_Stage s
join Logon.Users u on s.UserId = u.UserId
where u.UserTypeId = 11

delete i
from Interim.ActiveUserContacAddress_Stage i
join Customer.UserContactAddress uca on i.usercontactaddressid = uca.usercontactaddressid
join Logon.Users u on uca.userid = u.userid
where u.usertypeid = 11

delete st
from Interim.SubscriptionUser_Stage st
join Logon.Users u on st.userid = u.userid
where u.usertypeid = 11

delete cp
from Interim.ContactPref_Stage cp
join Logon.Users u on cp.userid = u.userid
where u.usertypeid = 11

delete ua
from Interim.UserContactAddress_Stage ua
join Logon.Users u on ua.userid = u.userid
where u.usertypeid = 11

delete dc
from Interim.UserDefaultCommunication_Stage dc
join Logon.Users u on dc.userid = u.userid
where u.usertypeid  = 11

delete ud
from Interim.UserDetails_Stage ud
join Logon.Users u on ud.userid = u.userid
where u.usertypeid  = 11

delete x
from Interim.SubscriptionUserExcluded_Stage x
join Interim.SubscriptionUser_Stage st on x.SubscriptionUserId = st.SubscriptionUserId
join Logon.Users u on st.userid = u.userid
where u.usertypeid = 11

delete ai
from Interim.Addresses_Insert_Stage ai
join Logon.Users u on ai.auid = u.userid
where u.usertypeid  = 11


*/


/*


SELECT count(*)
  FROM [Interim].[Addresses_ReplTest] A
JOIN Interim.[UserContactAddress_Stage] U 
ON A.auid = U.UserId and A.aid = U.AddressId
join NewCentralUsers.dbo.UserDetails ud on u.userid = ud.uID
--join Interim.AddressUCAMap uca on uca.addressid = a.aid and uca.userid = u.UserId
left join NewCentralUsers.dbo.Addresses adr on U.AddressId = adr.aID


SELECT DISTINCT TOP 1 a.[aID],a.[aUID],a.[aAncestorID],a.[aParentID],a.[aEclipseCode],a.[aJobTitle],a.[aCompany],a.[aAddress1]
      ,a.[aAddress2],a.[aAddress3],a.[aCity],a.[aCounty],case WHEN LTRIM(RTRIM(a.[aState])) = 'Not Applicable' THEN '' ELSE a.aState END as aState
	  ,a.[aPostCode],dbo.[fn_NBO_NCU_Country_Mapping](a.[aCID]) as acid,a.[aTel],a.[aFax]
      ,a.[aMobTel],isnull(a.[aCreationDate], '1753-1-1') as aCreationDate,a.[aCreatedBy],a.[aUpdatedDate],a.[aUpdatedBy],a.[aActive]
      ,a.[aDefault],a.[aSessionId],a.[aUpdateReason]
  FROM [Interim].[Addresses_ReplTest] A
JOIN Interim.[UserContactAddress_Stage] U 
ON A.auid = U.UserId and A.aid = U.AddressId
join NewCentralUsers.dbo.UserDetails ud on u.userid = ud.uID
left join NewCentralUsers.dbo.Addresses adr on U.AddressId = adr.aID

ORDER BY isnull(a.[aCreationDate], '1753-1-1') DESC
*/




