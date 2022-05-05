use backoffice

--+ users (trigger INSERT_Repl_LogonUsers_Tr2)
/*
insert into Interim.[LogonUsers_Stage] ([UserId],[UserName],[EncryptPassword],[IsLockedOut],[UserTypeId],[ActionCode],[ProcessNum])
select userid, username, right(newid(),10), islockedout, UserTypeId, 'I', 0 
from logon.Users
where userid in (
	1080455,
	1237813,
	1428196,
	1471247,
	1622198,
	1704597,
	2066089,
	2263870,
	2362120,
	5057161,
	536134
)
*/

/*
-- subscription users (trigger SubscriptionUser_Repl_AI) - already in Stage
SELECT *
	FROM [Interim].[SubscriptionUser_Stage] AS I 
	where userid in (
		1080455,
		1237813,
		1428196,
		1471247,
		1622198,
		1704597,
		2066089,
		2263870,
		2362120,
		5057161,
		536134
	)
*/

/*
-- [Logon].[UserGroupSubscription] (UserGroupSubscription_Repl_AI) - nothing to add:

SELECT * 
FROM [Logon].[UserGroupSubscription] AS I
JOIN Orders.Subscription AS S ON I.[SubscriptionId] = S.[SubscriptionId] 
join [Logon].[SubscriptionUser] sui on i.SubscriptionId = sui.SubscriptionId
WHERE ProductId in (Select ProductId from INTERIM.[Repl_NCUNBOProductMap]) and   
userid in (
		1080455,
		1237813,
		1428196,
		1471247,
		1622198,
		1704597,
		2066089,
		2263870,
		2362120,
		5057161,
		536134
	)
*/


/*
-- UserGroupSubscriptionIpRange_Repl_AI - nothing there

SELECT 
	i.[UserGroupSubscriptionId]
    ,[IpRangeId]
	,[ActiveStartDate]
	,ActiveEndDate
    ,'I'
FROM [logon].[UserGroupSubscriptionIpRange] AS I 
join [Logon].[UserGroupSubscription] as II on i.usergroupsubscriptionid = ii.usergroupsubscriptionid
JOIN Orders.Subscription AS S ON II.[SubscriptionId] = S.[SubscriptionId] 
join [Logon].[SubscriptionUser] sui on ii.SubscriptionId = sui.SubscriptionId
where userid in (
		1080455,
		1237813,
		1428196,
		1471247,
		1622198,
		1704597,
		2066089,
		2263870,
		2362120,
		5057161,
		536134
	)

*/

/*
-- [Logon].[LandingPage_Repl_AI] - nothing there, as it joins via [UserGroupSubscriptionId]

	SELECT
           [UserGroupSubscriptionId]
           ,[LandingpageGuid]
           ,'I'
	 FROM logon.LandingPage AS I 

*/



--+ [Customer].[Insert_Repl_ContactPref_Tr2]
/*
INSERT INTO Interim.[ContactPref_Stage] ([UserId],[UserContactPermissionTypeId],[SubscriptionAllowed],[EditorialAllowed],[MarketingAllowed],[ActionCode])
select [UserId],[UserContactPermissionTypeId],[SubscriptionAllowed],[EditorialAllowed],[MarketingAllowed], 'I' FROM Customer.UserContactPreferences
where userid in (
		1080455,
		1237813,
		1428196,
		1471247,
		1622198,
		1704597,
		2066089,
		2263870,
		2362120,
		5057161,
		536134
	)

except

select [UserId],[UserContactPermissionTypeId],[SubscriptionAllowed],[EditorialAllowed],[MarketingAllowed], 'I' FROM Interim.[ContactPref_Stage]

where userid in (
		1080455,
		1237813,
		1428196,
		1471247,
		1622198,
		1704597,
		2066089,
		2263870,
		2362120,
		5057161,
		536134
	)
	*/


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
	where ud.uid is null and u.addressid != 0 and auid in (
		1080455,
		1237813,
		1428196,
		1471247,
		1622198,
		1704597,
		2066089,
		2263870,
		2362120,
		5057161,
		536134)

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


--

FROM [logon].[UserGroupSubscriptionIpRange] AS I 
join [Logon].[UserGroupSubscription] as II on i.usergroupsubscriptionid = ii.usergroupsubscriptionid
JOIN Orders.Subscription AS S ON II.[SubscriptionId] = S.[SubscriptionId] 
join [Logon].[SubscriptionUser] sui on ii.SubscriptionId = sui.SubscriptionId
where userid in (
		1080455,
		1237813,
		1428196,
		1471247,
		1622198,
		1704597,
		2066089,
		2263870,
		2362120,
		5057161,
		536134
	)
