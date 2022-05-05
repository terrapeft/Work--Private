use NewCentralUsers

SET NOCOUNT on

declare @selectByN int = 10000
declare @deleteBefore datetime = dateadd(yy, -7, getutcdate())

drop table if exists #UsersToCheck;
create table #UsersToCheck
(
	UserID int not null primary key,
	Username varchar(100) not null
);

drop table if exists #UsersChunk;
create table #UsersChunk
(
	UserID int not null primary key,
	Username varchar(100) not null
);

insert into #UsersToCheck
select top 100000 U.[uID], U.[uUsername]
from [dbo].[UserDetails] U
	left join (
		select [S].[sUID], max([uvLastAccess]) as LastUserVisit
		from [dbo].[UserVisits] UV
		join [dbo].[Subscriptions] S
		on [UV].[uvSID] = [S].[sID]
		group by S.[sUID]
	) [UV] on [UV].[sUID] = U.[uID]
	left join (
		select UL.ulSID, max([ulDateTime]) as LastLoggedIn
		from [dbo].[UserLogin] UL
		group by UL.ulSID
	) [IUL] on [IUL].[ulSID] = U.[uID]
	left join (
		select [sUID], max(sExpiryDate) as LastSubscriptionExpiryDate
		from [dbo].[Subscriptions]
		group by [sUID]
	) [IS] on [IS].[sUID] = U.[uID]
	left join (
		select [sUID], max(sTrialExpiryDate) as LastTrialExpiryDate
		from [dbo].[Subscriptions]
		group by [sUID]
	) [IT] on [IT].[sUID] = U.[uID]
	left join
	(
		select O.oUID, max(O.oOrderDate) as LastOrderDate
		from [dbo].[Orders] O
		group by O.oUID
	) [IO] on [IO].oUID = U.[uID]
where
	(
		[IUL].LastLoggedIn is null -- No logins recorded
		or
		[IUL].LastLoggedIn < @deleteBefore -- Last login is more than 7 years ago
	)
	and
	(
		[UV].LastUserVisit is null -- No user visits recorded
		or
		[UV].LastUserVisit < @deleteBefore -- Last user visit is more than 7 years ago
	)
	and
	(
		[IS].LastSubscriptionExpiryDate is null -- No subscriptions with expiry date recorded
		or
		[IS].LastSubscriptionExpiryDate < @deleteBefore -- Last subscription expired more than 7 years ago
	)
	and
	(
		[IT].LastTrialExpiryDate is null -- No trials with expiry date recorded
		or
		[IT].LastTrialExpiryDate < @deleteBefore -- Last trial expired more than 7 years ago
	)
	and
	(
		[IO].LastOrderDate is null -- No orders recorded
		or
		[IO].LastOrderDate < @deleteBefore -- Last order is more than 7 years ago
	)
	and coalesce
	(
		[IUL].LastLoggedIn,
		[UV].LastUserVisit,
		[IS].LastSubscriptionExpiryDate,
		[IT].LastTrialExpiryDate,
		[IO].LastOrderDate
	) IS not null
	and U.[uUsername] IS not null

insert #UsersChunk 
select userid, username 
from #UsersToCheck

/*

	Start deletion from here

*/

begin transaction

	declare @userId int, @deleteCount int
	declare @userName varchar(256)
	declare taskCursor cursor for  

	select userid, username
	from #UsersChunk

	open taskCursor
   
	fetch next from taskCursor into @userId, @userName
  
	while @@fetch_status = 0  
	begin
		print cast(@userid as varchar(128)) + ' ' + @userName 



		
			delete t1 from [dbo].[EventNcuUsers] T1 join #UsersChunk U on T1.[euUserID] = U.[UserID]
		
			delete t1 from [dbo].[MPUserCategories] T1 
			join [dbo].[EventNcuUsers] T2 on T1.[EventNcuUserId] = T2.[euID] 
			join [dbo].[Orders] o on [t2].[euOrderID] = o.oID
			join #UsersChunk U on o.[ouid] = U.[UserID]
		
			delete top (4500) t1 from [dbo].[EventNcuUsers] T1 join #UsersChunk U on T1.[euUserID] = U.[UserID]
		



		fetch next from taskCursor into @userId, @userName
	end

	close taskCursor
    deallocate taskCursor


rollback transaction


