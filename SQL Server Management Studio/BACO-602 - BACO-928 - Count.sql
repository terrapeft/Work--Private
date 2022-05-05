use BackOffice

select count(*)
from Interim.[UserContactAddress_Stage]

SELECT count(*)
  FROM [Interim].[Addresses_ReplTest] A
JOIN Interim.[UserContactAddress_Stage] U
ON A.auid = U.UserId and A.aid = U.AddressId
join NewCentralUsers.dbo.UserDetails ud on u.userid = ud.uID
join Interim.AddressUCAMap uca on uca.addressid = a.aid and uca.userid = u.UserId
left join NewCentralUsers.dbo.Addresses adr on U.AddressId = adr.aID
where adr.aid is null












