use Backoffice

drop table if exists #broken

select userid 
into #Broken
from (values 
	(622914),(1926738),(2507494),(3598149),(5036409),(5036827),(876818),(2996844),(3467936),(3598210),(5087726),(2149786),(1836183),(2963564),(3598006),(5074402),(5112163),(5099852),(5132124),(2015574),(2962815),(3598012),(3598237),(3598296),(5088721)
) v (userid)


select *
from logon.usersummary uca
join logon.users u on uca.userid = u.userid
left join Customer.UserContactAddress ca on uca.UserId = ca.UserId
join #broken b on uca.userid = b.userid
 
  
begin try
	begin tran
		insert into customer.activeusercontactaddress (usercontactaddressid)
		select usercontactaddressid from (
			select uca.userid, max(uca.usercontactaddressid) as usercontactaddressid
			from customer.usercontactaddress uca
			left join customer.activeusercontactaddress auca on uca.UserContactAddressId = auca.UserContactAddressId
			join #broken b on uca.userid = b.userid
			where auca.ActiveUserContactAddressId is null
			group by uca.userid
		) f

		insert into logon.userdefaultcommunication (userid, activeusercontactaddressid, contactid)
		select uca.userid, max(auca.activeusercontactaddressid), max(uca.contactid)
		from customer.usercontactaddress uca
		join customer.activeusercontactaddress auca on uca.usercontactaddressid = auca.usercontactaddressid
		left join logon.UserDefaultCommunication udc on uca.UserId = udc.UserId
		join #broken b on uca.userid = b.userid
		where udc.activeusercontactaddressid is null
		group by uca.userid
	commit tran
end try
begin catch
	if @@trancount <> 0
		rollback
	;throw
end catch