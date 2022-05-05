use Backoffice

drop table if exists #broken

select userid 
into #Broken
from (values 
	(1130367), (1208808)
) v (userid)


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