use backoffice

declare @uids table (uid int)

insert into @uids
select distinct auid
from Interim.Addresses_ReplTest a
join Interim.UserContactAddress_Stage u on a.auid = u.UserId and a.aid = u.AddressId
full outer join Interim.LogonUsers_Stage ut on a.auid = ut.userid
full outer join NewCentralUsers.dbo.UserDetails d on a.auid = d.uid
where ut.userid is null and d.uid is null

-- users (trigger INSERT_Repl_LogonUsers_Tr2)

insert into Interim.[LogonUsers_Stage] ([UserId],[UserName],[EncryptPassword],[IsLockedOut],[UserTypeId],[ActionCode],[ProcessNum])
select userid, username, right(newid(),10), islockedout, UserTypeId, 'I', 0 
from logon.Users
where userid in (select uid from @uids)


-- [Customer].[Insert_Repl_ContactPref_Tr2]

INSERT INTO Interim.[ContactPref_Stage] ([UserId],[UserContactPermissionTypeId],[SubscriptionAllowed],[EditorialAllowed],[MarketingAllowed],[ActionCode])
SELECT [UserId],[UserContactPermissionTypeId],[SubscriptionAllowed],[EditorialAllowed],[MarketingAllowed], 'I' 
FROM Customer.UserContactPreferences
where userid in (select uid from @uids)

except -- those who are already there

SELECT [UserId],[UserContactPermissionTypeId],[SubscriptionAllowed],[EditorialAllowed],[MarketingAllowed], 'I' 
FROM Interim.[ContactPref_Stage]

where userid in (select uid from @uids)
	
-- [Customer].[Repl_Insert_UCA_Tr2]

declare @addrId int
declare @userId int
declare @pId int
DECLARE @UCAId as INT

declare mycursor cursor 
for 
	select U.addressid as aid, [aUID], usa.ParentusercontactaddressID as pid, usa.usercontactaddressid
	from [Interim].[Addresses_ReplTest] A
	join Interim.[UserContactAddress_Stage] U 
	on A.auid = U.UserId --and A.aid = U.AddressId
	join Customer.USerContactAddress USA ON USA.UserContactaddressId = U.ParentUserContactaddressId and USA.userid = U.UserID and USA.addressid = 0 
	full outer join [newcentralusers].[dbo].[userdetails] ud on auid = ud.uid
	where ud.uid is null 
	and u.addressid != 0 
	and auid in (select uid from @uids)

open mycursor
fetch next from mycursor into @addrId, @userId, @pId, @UCAId
while @@fetch_status = 0
begin
	-- from trigger:
	IF  EXISTS (SELECT 1 FROM INTERIM.AddressUCAMap where userid = @userId AND usercontactaddressID = @pid)
		BEGIN -- BEgin For IF EXISTS

			UPDATE INTERIM.AddressUCAMap
			SET usercontactaddressID = @UCAId
			WHERE usercontactaddressID = @pid AND  userid = @userId

		END -- END For IF EXISTS

	ELSE
	--IF NOT EXISTS (SELECT 1 FROM INTERIM.AddressUCAMap where userid = @uid AND usercontactaddressID = @pid)
	BEGIN

		INSERT INTO INTERIM.AddressUCAMap 
		SELECT @userId, @addrid, @ucaid

	END

	fetch next from mycursor into @addrId, @userId, @pId, @UCAId


end
close mycursor
deallocate mycursor


