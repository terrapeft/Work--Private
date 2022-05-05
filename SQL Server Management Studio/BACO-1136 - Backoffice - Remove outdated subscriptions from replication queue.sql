use backoffice


begin try

	begin tran

	/*                       
		outdated subscriptions
	*/

	delete from us
	from Interim.SubscriptionUser_Stage as us
	join Orders.Subscription as s on s.SubscriptionId = us.SubscriptionId 
	join [Product].[Products] as p on p.ProductID = s.ProductID
	where subscriptionenddatetime < getdate() 

	delete from us
	from Interim.Subscription_Stage as us
	join Orders.Subscription as s on s.SubscriptionId = us.SubscriptionId 
	join [Product].[Products] as p on p.ProductID = s.ProductID
	where s.subscriptionenddatetime < getdate() 




	/*                       
	Archived users -> will be processed in the SSIS packages

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

	commit

end try
begin catch
	if (@@trancount > 0)
		rollback
	;throw
end catch