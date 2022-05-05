use backoffice 


-- 1. Get users (50322 in PRD, 1 Apr 2020)

drop table if exists #User_data
drop table if exists #broken

SELECT 
	 u.UserId
into #user_data
FROM 		
	Logon.Users u
LEFT JOIN
	Logon.UserSummary us ON u.UserId = us.UserId
LEFT JOIN
	Logon.Application app ON us.CreatorApplicationId = app.ApplicationId	
where u.usertypeid <> 11
		
				
select userid
into #broken
from (

	-- take all users
	select u.userid
	from logon.users u
	join logon.usersummary us on u.userid = us.userid
	where u.usertypeid <> 11

	except 

	-- except those who have passed the check (the SELECT below is written based on the Customer.uspGetUserDefaultContact)
	SELECT distinct uca.userid
	FROM
		Customer.UserContactAddress uca
	JOIN
		Customer.ActiveUserContactAddress auca ON uca.UserContactAddressId = auca.UserContactAddressId
	JOIN
		Customer.Contact c ON uca.ContactId = c.ContactId
	JOIN
		Customer.Title t ON c.TitleId = t.TitleId
	JOIN
		#user_data ud ON ud.UserId = uca.UserId
	LEFT JOIN
		Customer.EmailAddress ea ON uca.EmailAddressId = ea.EmailAddressId
	LEFT JOIN
		Customer.Address a ON uca.AddressId = a.AddressId 		
	LEFT JOIN
		Customer.Country c3 ON a.CountryId = c3.CountryId
	INNER JOIN
		Customer.Province p ON a.ProvinceId = p.ProvinceId
	LEFT JOIN
		Customer.Company c2 ON uca.CompanyId = c2.CompanyId
	LEFT OUTER JOIN
		Customer.ContactAddressTag cat ON auca.ContactAddressTagId = cat.ContactAddressTagId
	LEFT JOIN
		Customer.JobTitle jt ON uca.JobTitleId = jt.JobTitleId
	LEFT JOIN
		Logon.UserDefaultCommunication udc ON uca.UserId = udc.UserId

	join Logon.Users u on uca.userid = u.userId

	WHERE  uca.ContactId = udc.ContactId	 
	and u.usertypeid <> 11
) y


/*
	select broken users before fix in order to have an ability to verify the results for these users
*/

select count(distinct b.UserId)
from #broken b
join logon.users u on b.userid = u.userid
where u.usertypeid <> 11

/*

expertise

*/
----1.
--select count(*)
--from logon.users u
--where u.UserTypeId <> 11

--select count(*)
--from logon.userdefaultcommunication udc
--join logon.users u on udc.userid = u.userid
--where u.usertypeid <> 11

----2.
--select u.userid
--from logon.users u
--where u.UserTypeId <> 11

--except

--select u.userid
--from logon.userdefaultcommunication udc
--join logon.users u on udc.userid = u.userid
--where u.usertypeid <> 11

--except 

--select b.UserId
--from #broken b

----3.
--select *
--from logon.users u
--join logon.UserSummary us on u.userid = us.userid
--where u.userid in (1852373, 5004591, 1751562)


-- 2. Fix them
/*
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
*/