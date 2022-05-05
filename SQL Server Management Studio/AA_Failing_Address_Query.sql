use backoffice
begin tran

set IDENTITY_INSERT NewCentralUsers.dbo.Addresses on 
insert into NewCentralUsers.dbo.Addresses
(aid, auid)
--original query
/*SELECT DISTINCT [aID],[aUID]
FROM [Interim].[Addresses_ReplTest] A
JOIN Interim.[UserContactAddress_Stage] U 
ON A.auid = U.UserId and A.aid = U.AddressId*/
--fixed query
SELECT DISTINCT a.[aID],a.[aUID]
  FROM [Interim].[Addresses_ReplTest] A
JOIN Interim.[UserContactAddress_Stage] U 
ON A.auid = U.UserId and A.aid = U.AddressId
join NewCentralUsers.dbo.UserDetails ud on u.userid = ud.uID
left join NewCentralUsers.dbo.Addresses adr on U.AddressId = adr.aID
where adr.aid is null 
set IDENTITY_INSERT NewCentralUsers.dbo.Addresses off

rollback
