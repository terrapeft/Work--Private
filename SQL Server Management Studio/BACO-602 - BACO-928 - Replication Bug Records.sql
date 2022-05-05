use backoffice

drop table if exists #testerim

-- Collect Replication Bug Records
;with addr as 
(
	select A.addressid , A.UserId 
	from INTERIM.UserContactaddress_Stage A
	where A.PArentUSerContactaddressid IS NULL AND A.addressid !=0
	AND A.USERID NOT IN (5005748 , 5005785)
	UNION
	select B.addressid , B.UserId 
	from INTERIM.UserContactaddress_Stage B
	JOIN Customer.UserContactAddress C WITH(NOLOCK) 
	ON C.UserId = B.UserId AND 
	C.UserContactAddressId = B.ParentUserContactAddressId AND
	C.AddressId = 0
	where B.USERID NOT IN (5005748 , 5005785) AND B.addressid !=0
),
max_addr as (
	select uca.userid, uca.AddressId, max(usercontactaddressid) as usercontactaddressid
	from addr a
	join customer.UserContactaddress uca on uca.AddressId = a.AddressId and uca.UserId = a.UserId
	where uca.userid is not null
	group by uca.userid, uca.AddressId
),
missed as (
	select userid, AddressId, null as usercontactaddressid
	from addr
	except
	select userid, AddressId, null as usercontactaddressid
	from max_addr
),
uca_map as (
	select a.UserId, a.AddressId, usercontactaddressid
	from Interim.AddressUCAMap map
	join addr a on map.addressid = a.AddressId and map.userid = a.UserId
)/*,
all_counted as (
	select userid, AddressId, usercontactaddressid
	from missed
	union
	select userid, AddressId, usercontactaddressid
	from max_addr
)
*/

select ac.UserId, ac.AddressId, ac.usercontactaddressid as maxucid, m.usercontactaddressid as Interimucid
from missed ac
left join uca_map m on ac.userid = m.UserId and ac.AddressId = m.AddressId
order by userid



-- NewAddress Set
/*
with addr as 
(
	select A.addressid , A.UserId, A.TrGUID as AGUID 
	from INTERIM.UserContactaddress_Stage A
	where A.PArentUSerContactaddressid IS NULL AND A.addressid !=0
	AND A.USERID NOT IN (5005748 , 5005785)
	UNION
	select B.addressid , B.UserId, B.TrGUID as AGUID 
	from INTERIM.UserContactaddress_Stage B
	JOIN Customer.UserContactAddress C WITH(NOLOCK) 
	ON C.UserId = B.UserId AND 
	C.UserContactAddressId = B.ParentUserContactAddressId AND
	C.AddressId = 0
	where B.USERID NOT IN (5005748 , 5005785) AND B.addressid !=0 and NOT EXISTS 
	(SELECT 1 FROM NewCentralUsers.dbo.Addresses A
	 WHERE A.aID = B.AddressId)
),
max_addr as (
	select uca.userid, uca.AddressId, A.AGUID, max(usercontactaddressid) as usercontactaddressid
	from addr a
	join customer.UserContactaddress uca on uca.AddressId = a.AddressId and uca.UserId = a.UserId
	where uca.userid is not null
	group by uca.userid, uca.AddressId, AGUID
)

select AddressId, userid, AGUID
from max_addr
*/

--Select @ucid = max(usercontactaddressid) from customer.UserContactaddress where 
--addressid = ? and userid = ?;

--select addressid as aid1 from Interim.AddressUCAMap where 
--usercontactaddressid = @ucid;




/*

select ac.UserId, ac.AddressId, ac.usercontactaddressid as maxucid, m.usercontactaddressid as Interimucid
from all_counted ac
left join uca_map m on ac.userid = m.UserId and ac.AddressId = m.AddressId
--where ac.usercontactaddressid != m.usercontactaddressid
where ac.usercontactaddressid is null or m.usercontactaddressid is null
order by ac.UserId

*/



--select distinct * 
--from ##NoInterim
--order by userid

