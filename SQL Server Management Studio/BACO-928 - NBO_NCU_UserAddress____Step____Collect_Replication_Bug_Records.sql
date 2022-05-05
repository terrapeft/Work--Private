use backoffice

drop table if exists #nn

;with addr as (
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
uca_map as (
	select a.UserId, a.AddressId, usercontactaddressid
	from Interim.AddressUCAMap map
	join addr a on map.addressid = a.AddressId and map.userid = a.UserId
)

select x.userid, x.addressid, x.usercontactaddressid as maxucid, m.usercontactaddressid as Interimucid
into ##NoInterim
from max_addr x 
join uca_map m on x.UserId = m.UserId and x.AddressId = m.AddressId
where x.usercontactaddressid != m.usercontactaddressid
and x.usercontactaddressid not in (select usercontactaddressid from uca_map)
