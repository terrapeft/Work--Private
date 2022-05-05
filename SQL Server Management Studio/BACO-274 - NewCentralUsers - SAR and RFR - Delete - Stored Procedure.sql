use newcentralusers
go

create or alter procedure [dbo].[AutoArchiving]
	@selectByN int = 500,
	@deleteForYears int = 7
as

set nocount on

declare @startedAt datetime = getutcdate()
declare @deleteBefore datetime = dateadd(yy, -@deleteForYears, getutcdate())
declare @logRecordId int

drop table if exists #UsersToCheck;
create table #UsersToCheck
(
	UserID int not null primary key,
	Username varchar(100) not null
);

drop table if exists #OldUsers;
create table #OldUsers
(
	UserID int not null primary key,
	Username varchar(100) not null
);

insert into #OldUsers
select U.[uID], U.[uUsername]
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
	and U.[uCreationDate] < @deleteBefore
	and U.[uUsername] not like ('%@euromoneyplc.com') and U.[uUsername] not like ('%@arcadia.spb.ru')


insert #UsersToCheck 
select top(@selectByN) userid, username 
from #OldUsers

/*

	Start deletion from here

*/

declare @usersCount int, @thereAreSomeMoreUsers int, @step int = 0, @steps int, @progress int, @stepValue int
set @usersCount = (select count(*) from #OldUsers)
set @steps = ceiling(cast(@usersCount as float)/@selectByN)
set @stepValue = iif(@steps = 0, 0, ceiling(100/@steps)) 

set @thereAreSomeMoreUsers = @usersCount

-- Add parent log record
insert into [NewCentralUsers].[dbo].[AutoArchiving_Log] (alStartedAtUtc, alUsersCount, alLastUpdatedAtUtc) 
values (@startedAt, @usersCount, getutcdate())
set @logRecordId = @@identity

while @thereAreSomeMoreUsers > 0
begin /* MAIN */
	
	declare @deleteCount int

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'next >>')

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, MPUserCategories - EventNCUUsers')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[MPUserCategories] T1 join [dbo].[EventNcuUsers] T2 on T1.[EventNcuUserId] = T2.[euID] join #UsersToCheck U on T2.[euUserId] = U.[UserID]
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch
	end	

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, MPUserCategories - EventNCUUsers, Orders, deletes information about person of interest and also about event participants from the order belonging to the person of interest.')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[MPUserCategories] T1 
			join [dbo].[EventNcuUsers] T2 on T1.[EventNcuUserId] = T2.[euID] 
			join [dbo].[Orders] o on [t2].[euOrderID] = o.oID
			join #UsersToCheck U on o.[ouid] = U.[UserID]
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, MPEventUserDetails - EventNcuUsers')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[MPEventUserDetails] T1 join [dbo].[EventNcuUsers] T2 on T1.[EventNcuUserId] = T2.[euID] join #UsersToCheck U on T2.[euUserId] = U.[UserID]
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch
	end	

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, MPEventUserDetails  - EventNcuUsers - Orders, deletes information about person of interest and also about event participants from the order belonging to the person of interest.')
	set @deleteCount = 4500 --rollback
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[MPEventUserDetails] T1 
			join [dbo].[EventNcuUsers] T2 on T1.[EventNcuUserId] = T2.[euID] 
			join [dbo].[Orders] o on [t2].[euOrderID] = o.oID
			join #UsersToCheck U on o.[ouid] = U.[UserID]
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, MPUserBlocks - BlockerId')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[MPUserBlocks] T1 
			join [dbo].[EventNcuUsers] T2 on T1.[BlockerId] = T2.[euID] 
			join #UsersToCheck U on T2.[euUserId] = U.[UserID]
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, MPUserBlocks - BlockedId')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[MPUserBlocks] T1 
			join [dbo].[EventNcuUsers] T2 on T1.[BlockedId] = T2.[euID] 
			join #UsersToCheck U on T2.[euUserId] = U.[UserID]
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, MPUserFavourites - Order users by FavouriteEventNcuUserId')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction

			delete top (4500) f
			from [dbo].[MPUserFavourites] f
			join eventncuusers eu on eu.euid = f.FavouriteEventNcuUserId
			join (
				select euId from eventncuusers t0 
				join [dbo].[Orders] T1 on t0.euOrderID = t1.oid
				join [dbo].[Addresses] T2 on T1.[oDeliveryAddress] = T2.[aID] 
				join #UsersToCheck U on t2.[auid] = U.[UserID]
			) fav on eu.euid = fav.euid

			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	


	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, MPUserFavourites - Order users by EventNcuUserId')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction

			delete top (4500) f
			from [dbo].[MPUserFavourites] f
			join eventncuusers eu on eu.euid = f.EventNcuUserId
			join (
				select euId from eventncuusers t0 
				join [dbo].[Orders] T1 on t0.euOrderID = t1.oid
				join [dbo].[Addresses] T2 on T1.[oDeliveryAddress] = T2.[aID] 
				join #UsersToCheck U on t2.[auid] = U.[UserID]
			) fav on eu.euid = fav.euid

			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	


	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, MPUserFavourites - Order users by FavouriteEventNcuUserId')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction

			delete top (4500) f
			from [dbo].[MPUserFavourites] f
			join eventncuusers eu on eu.euid = f.FavouriteEventNcuUserId
			join (
				select euId from eventncuusers t0 
				join [dbo].[Orders] T1 on t0.euOrderID = t1.oid
				join [dbo].[Addresses] T2 on T1.[oBillAddress] = T2.[aID] 
				join #UsersToCheck U on t2.[auid] = U.[UserID]
			) fav on eu.euid = fav.euid

			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	


	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, MPUserFavourites - Order users by EventNcuUserId')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction

			delete top (4500) f
			from [dbo].[MPUserFavourites] f
			join eventncuusers eu on eu.euid = f.EventNcuUserId
			join (
				select euId from eventncuusers t0 
				join [dbo].[Orders] T1 on t0.euOrderID = t1.oid
				join [dbo].[Addresses] T2 on T1.[oBillAddress] = T2.[aID] 
				join #UsersToCheck U on t2.[auid] = U.[UserID]
			) fav on eu.euid = fav.euid

			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	


	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, MPUserFavourites')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction

			delete top (4500) t1 from [dbo].[MPUserFavourites] T1 
			join [dbo].[EventNcuUsers] T2 on T1.[EventNcuUserId] = T2.[euID] 
			join #UsersToCheck U on T2.[euUserId] = U.[UserID]
			
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, MPUserFavourites')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[MPUserFavourites] T1 join [dbo].[EventNcuUsers] T2 on T1.[FavouriteEventNcuUserId] = T2.[euID] join #UsersToCheck U on T2.[euUserId] = U.[UserID]
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, MPUserSessions')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[MPUserSessions] T1 join [dbo].[EventNcuUsers] T2 on T1.[EventNcuUserId] = T2.[euID] join #UsersToCheck U on T2.[euUserId] = U.[UserID]
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, EventNcuUsers - Orders by user')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[EventNcuUsers] T1 join [dbo].[Orders] T2 on T1.[euOrderID] = T2.[oId] join #UsersToCheck U on T1.[euUserID] = U.[UserID]
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch
	end	


	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, EventNcuUsers - Orders by delivery address user, deletes information about person of interest and also about event participants from the order belonging to the person of interest.')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction

			delete top (4500) t0 from eventncuusers t0 
			join [dbo].[Orders] T1 on t0.euOrderID = t1.oid
			join [dbo].[Addresses] T2 on T1.[oDeliveryAddress] = T2.[aID] 
			join #UsersToCheck U on t2.[auid] = U.[UserID]

			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch
	end	

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, EventNcuUsers - Orders by billing address user, deletes information about person of interest and also about event participants from the order belonging to the person of interest.')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top(4500) t0	from eventncuusers t0 
			join [dbo].[Orders] T1 on t0.euOrderID = t1.oid
			join [dbo].[Addresses] T2 on T1.[oBillAddress] = T2.[aID] 
			join #UsersToCheck U on t2.[auid] = U.[UserID]
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch
	end	

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, EventNcuUsers - GroupBooking')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 
			from [dbo].[EventNcuUsers] T1 
			join [dbo].[GroupBooking] T2 on T1.[euGroupBookingId] = T2.[Id] 
			join #UsersToCheck U on T1.[euUserId] = U.[UserID]

			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch
	end	

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, EventNcuUsers - GroupBooking, Orders')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
	
			delete top (4500) t1
			from EventNcuUsers t1
			join GroupBooking t2 on t1.eugroupbookingid = t2.Id
			join Orders t3 on t2.OrderId = t3.oid
			join #UsersToCheck U on t3.[ouid] = U.[UserID]
			
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch
	end	

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, EventNcuUsers - GroupBooking by PocUserId')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
	
			delete top (4500) t1
			from EventNcuUsers t1
			join GroupBooking t2 on t1.eugroupbookingid = t2.Id
			join #UsersToCheck U on t2.[pocuserid] = U.[UserID]
			
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch
	end	

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, MPCommunicationFlags')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[MPCommunicationFlags] T1 join #UsersToCheck U on T1.[UserId] = U.[UserID]
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	


	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'Communication chain')
	drop table if exists #comm_temp

	;with comm_to as
	(
		select c.Id, c.ParentCommunicationId
		from mpcommunication c join mpattendee a on c.toattendeeid = a.id
		join #UsersToCheck U on a.[UserId] = U.[UserID]
		union all
		select c.Id, c.ParentCommunicationId
		from mpcommunication c join mpattendee a on c.toattendeeid = a.id
		join comm_to cm on c.id = cm.ParentCommunicationId
	)
	select * into #comm_temp from comm_to order by id desc
	
	;with comm_from as
	(
		select c.Id, c.ParentCommunicationId
		from mpcommunication c 
		join mpattendee a on c.fromattendeeid = a.id
		join #UsersToCheck U on a.[UserId] = U.[UserID]
		union all
		select c.Id, c.ParentCommunicationId
		from mpcommunication c 
		join mpattendee a on c.fromattendeeid = a.id
		join comm_from cm on c.id = cm.ParentCommunicationId
	)
	insert into #comm_temp 
	select * from comm_from order by id desc

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, MPCommunicationFlags 2')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) c
			from [dbo].[MPCommunicationFlags] c
			join #comm_temp t on c.CommunicationId = t.Id

			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, MPCommunication')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) c
			from mpcommunication c
			join #comm_temp t on c.Id = t.Id
			
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	







	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, MPAction')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[MPAction] T1 join [dbo].[MPAttendee] T2 on T1.[AttendeeId] = T2.[Id] join #UsersToCheck U on T2.[UserId] = U.[UserID]
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, MPAttendee')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[MPAttendee] T1 join [dbo].[MPMeeting] T2 on T1.[MeetingId] = T2.[Id] join #UsersToCheck U on T2.[OrganiserUserId] = U.[UserID]
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, SalesContactLink')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[SalesContactLink] T1 join [dbo].[Subscriptions] T2 on T1.[sID] = T2.[sID] join #UsersToCheck U on T2.[sUID] = U.[UserID]
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, GroupBooking')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[GroupBooking] T1 join [dbo].[Orders] T2 on T1.[OrderId] = T2.[oId] join #UsersToCheck U on T2.[oUID] = U.[UserID]
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, OrderDetails')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[OrderDetails] T1 join [dbo].[Orders] T2 on T1.[odOrderID] = T2.[oId] join #UsersToCheck U on T2.[oUID] = U.[UserID]
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, OrderDetails')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[OrderDetails] T1 join [dbo].[Orders] T2 on T1.[odOrderID] = T2.[oId] join [dbo].[Addresses] T3 on T2.[oDeliveryAddress] = T3.[aID] join #UsersToCheck U on T3.[aUID] = U.[UserID]
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, OrderDetails')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[OrderDetails] T1 join [dbo].[Orders] T2 on T1.[odOrderID] = T2.[oId] join [dbo].[Addresses] T3 on T2.[oBillAddress] = T3.[aID] join #UsersToCheck U on T3.[aUID] = U.[UserID]
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, Orders')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[Orders] T1 join [dbo].[Addresses] T2 on T1.[oDeliveryAddress] = T2.[aID] join #UsersToCheck U on T2.[aUID] = U.[UserID]
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, Orders')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[Orders] T1 join [dbo].[Addresses] T2 on T1.[oBillAddress] = T2.[aID] join #UsersToCheck U on T2.[aUID] = U.[UserID]
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, _DeletionAddressesTemp')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[_DeletionAddressesTemp] T1 join #UsersToCheck U on T1.[aUID] = U.[UserID]
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, OrderDetails')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[OrderDetails] T1 join [dbo].[Orders] T2 on T1.[odOrderID] = T2.[oId] join [dbo].[Addresses] T3 on T2.[oBillAddress] = T3.[aID] join #UsersToCheck U on T3.[aUID] = U.[UserID]
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, _DeletionCAPMasterDonorTemp')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[_DeletionCAPMasterDonorTemp] T1 join [dbo].[Subscriptions] T2 on T1.[cmdDonorSubID] = T2.[sID] join #UsersToCheck U on T2.[sUID] = U.[UserID]
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, _DeletionCAPMasterDonorTemp')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[_DeletionCAPMasterDonorTemp] T1 join [dbo].[Subscriptions] T2 on T1.[cmdMasterSubID] = T2.[sID] join #UsersToCheck U on T2.[sUID] = U.[UserID]
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, _DeletionCAPMasterTemp')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[_DeletionCAPMasterDonorTemp] T1 join [dbo].[Subscriptions] T2 on T1.[cmdMasterSubID] = T2.[sID] join #UsersToCheck U on T2.[sUID] = U.[UserID]
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, _DeletionEdenDUsersTemp')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[_DeletionEdenDUsersTemp] T1 join #UsersToCheck U on T1.[EdenDUserID] = U.[UserID]
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, _DeletionEdenDUsersTemp')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[_DeletionEdenDUsersTemp] T1 join #UsersToCheck U on T1.[uID] = U.[UserID]
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, _DeletionEdenUserTemp')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[_DeletionEdenUserTemp] T1 join #UsersToCheck U on T1.[eduID] = U.[UserID]
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, _DeletionEdenUserTemp')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[_DeletionEdenUserTemp] T1 join #UsersToCheck U on T1.[eduUserID] = U.[UserID]
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, _DeletionGUIDValuesTemp')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[_DeletionGUIDValuesTemp] T1 join [dbo].[Subscriptions] T2 on T1.[gSID] = T2.[sID] join #UsersToCheck U on T2.[sUID] = U.[UserID]
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, _DeletionIpRangesTemp')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[_DeletionIpRangesTemp] T1 join [dbo].[Subscriptions] T2 on T1.[iprSubscriptionID] = T2.[sID] join #UsersToCheck U on T2.[sUID] = U.[UserID]
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, _DeletionLF_AgendaRegistrationTemp')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[_DeletionLF_AgendaRegistrationTemp] T1 join #UsersToCheck U on T1.[aUserId] = U.[UserID]
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, _DeletionOrderDetailsTemp')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[_DeletionOrderDetailsTemp] T1 join [dbo].[Orders] T2 on T1.[odOrderID] = T2.[oID] join #UsersToCheck U on T2.[oUID] = U.[UserID]
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, _DeletionOrderDetailsTemp')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[_DeletionOrderDetailsTemp] T1 join [dbo].[Orders] T2 on T1.[odOrderID] = T2.[oID] join [dbo].[Addresses] T3 on T2.oDeliveryAddress = T3.aID join #UsersToCheck U on T3.[aUID] = U.[UserID]
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, _DeletionOrderDetailsTemp')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[_DeletionOrderDetailsTemp] T1 join [dbo].[Orders] T2 on T1.[odOrderID] = T2.[oID] join [dbo].[Addresses] T3 on T2.oBillAddress = T3.aID join #UsersToCheck U on T3.[aUID] = U.[UserID]
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, _DeletionOrderDetailsTemp1')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[_DeletionOrderDetailsTemp1] T1 join [dbo].[Orders] T2 on T1.[odOrderID] = T2.[oID] join #UsersToCheck U on T2.[oUID] = U.[UserID]
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, _DeletionOrderDetailsTemp1')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[_DeletionOrderDetailsTemp1] T1 join [dbo].[Orders] T2 on T1.[odOrderID] = T2.[oID] join [dbo].[Addresses] T3 on T2.oDeliveryAddress = T3.aID join #UsersToCheck U on T3.[aUID] = U.[UserID]
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, _DeletionOrderDetailsTemp1')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[_DeletionOrderDetailsTemp1] T1 join [dbo].[Orders] T2 on T1.[odOrderID] = T2.[oID] join [dbo].[Addresses] T3 on T2.oBillAddress = T3.aID join #UsersToCheck U on T3.[aUID] = U.[UserID]
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, _DeletionOrdersTemp')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[_DeletionOrdersTemp] T1 join #UsersToCheck U on T1.[oUID] = U.[UserID]
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, _DeletionOrdersTemp1')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[_DeletionOrdersTemp1] T1 join #UsersToCheck U on T1.[oUID] = U.[UserID]
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, _DeletionOrdersTemp2')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[_DeletionOrdersTemp2] T1 join #UsersToCheck U on T1.[oUID] = U.[UserID]
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, _DeletionSubscriptionsTemp')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[_DeletionSubscriptionsTemp] T1 join #UsersToCheck U on T1.[sUID] = U.[UserID]
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, _DeletionUserDetailsTemp')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[_DeletionUserDetailsTemp] T1 join #UsersToCheck U on T1.[uID] = U.[UserID]
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, _DeletionUserDetailsTemp')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[_DeletionUserDetailsTemp] T1 join #UsersToCheck U on T1.[userid] = U.[UserID]
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, _DeletionUserEmailAlertsAuditTemp')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[_DeletionUserEmailAlertsAuditTemp] T1 join #UsersToCheck U on T1.[UserID] = U.[UserID]
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, _DeletionUserPreferencesTemp')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[_DeletionUserPreferencesTemp] T1 join #UsersToCheck U on T1.[UserID] = U.[UserID]
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, _UL_Access')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[_UL_Access] T1 join #UsersToCheck U on T1.[userid] = U.[UserID]
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	
 

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, _UL_Users')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[_UL_Users] T1 join #UsersToCheck U on T1.[userid] = U.[UserID]
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, a$')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[a$] T1 join #UsersToCheck U on T1.[uid] = U.[UserID]
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, address_dup')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[address_dup] T1 join #UsersToCheck U on T1.[aUID] = U.[UserID]
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, Addresses_dup_log')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[Addresses_dup_log] T1 join #UsersToCheck U on T1.[aUID] = U.[UserID]
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, Addresses_Insert_Stage')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[Addresses_Insert_Stage] T1 join #UsersToCheck U on T1.[aUID] = U.[UserID]
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, Admin_UserPub')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[Admin_UserPub] T1 join [dbo].[Admin_Users] T2 on T1.[aupUID] = T2.[auID] join #UsersToCheck U on LOWER(T2.[auUSERNAME]) COLLATE SQL_Latin1_General_CP1_CI_AS = LOWER(U.[Username]) COLLATE SQL_Latin1_General_CP1_CI_AS
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, Admin_UserSites')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[Admin_UserSites] T1 join [dbo].[Admin_Users] T2 on T1.[ausAdmin_UserID] = T2.[auID] join #UsersToCheck U on LOWER(T2.[auUSERNAME]) COLLATE SQL_Latin1_General_CP1_CI_AS = LOWER(U.[Username]) COLLATE SQL_Latin1_General_CP1_CI_AS
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, Admin_Users')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[Admin_Users] T1 join #UsersToCheck U on LOWER(T1.[auUSERNAME]) COLLATE SQL_Latin1_General_CP1_CI_AS = LOWER(U.[Username]) COLLATE SQL_Latin1_General_CP1_CI_AS
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, AffiliateRequests')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[AffiliateRequests] T1 join [dbo].[Orders] T2 on T1.[OrderId] = T2.[oID] join #UsersToCheck U on T2.[oUID] = U.[UserID]
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, AffiliateRequests')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[AffiliateRequests] T1 join #UsersToCheck U on LOWER(T1.[EmailAddress]) COLLATE SQL_Latin1_General_CP1_CI_AS = LOWER(U.[Username]) COLLATE SQL_Latin1_General_CP1_CI_AS
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, Affiliates')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[Affiliates] T1 join #UsersToCheck U on LOWER(T1.[Email]) COLLATE SQL_Latin1_General_CP1_CI_AS = LOWER(U.[Username]) COLLATE SQL_Latin1_General_CP1_CI_AS
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	
 
 

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, AIN_Sunbelt_Import')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[AIN_Sunbelt_Import] T1 join #UsersToCheck U on T1.[calc_userid] = U.[UserID]
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, airfive')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[airfive] T1 join #UsersToCheck U on LOWER(T1.[Expr1]) COLLATE SQL_Latin1_General_CP1_CI_AS = LOWER(U.[Username]) COLLATE SQL_Latin1_General_CP1_CI_AS
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, airfive_eden')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[airfive_eden] T1 join #UsersToCheck U on LOWER(T1.[EmailAddress]) COLLATE SQL_Latin1_General_CP1_CI_AS = LOWER(U.[Username]) COLLATE SQL_Latin1_General_CP1_CI_AS
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, AirFive_email06')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[AirFive_email06] T1 join #UsersToCheck U on LOWER(T1.[EmailAddress]) COLLATE SQL_Latin1_General_CP1_CI_AS = LOWER(U.[Username]) COLLATE SQL_Latin1_General_CP1_CI_AS
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, AirFiveEmailAddresses06')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[AirFiveEmailAddresses06] T1 join #UsersToCheck U on LOWER(T1.[EmailAddress]) COLLATE SQL_Latin1_General_CP1_CI_AS = LOWER(U.[Username]) COLLATE SQL_Latin1_General_CP1_CI_AS
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, AlertUsersLoginInfo')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[AlertUsersLoginInfo] T1 join #UsersToCheck U on T1.[auUID] = U.[UserID]
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	
 

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, alpusers')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[alpusers] T1 join #UsersToCheck U on T1.[newuserid] = U.[UserID]
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	
 

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, amm_dload$')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[amm_dload$] T1 join #UsersToCheck U on LOWER(T1.[Email]) COLLATE SQL_Latin1_General_CP1_CI_AS = LOWER(U.[Username]) COLLATE SQL_Latin1_General_CP1_CI_AS
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, AlphaControlTemp')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[AlphaControlTemp] T1 join #UsersToCheck U on LOWER(T1.[EmailAddress]) COLLATE SQL_Latin1_General_CP1_CI_AS = LOWER(U.[Username]) COLLATE SQL_Latin1_General_CP1_CI_AS
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, amm_reconcile_names')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[amm_reconcile_names] T1 join #UsersToCheck U on LOWER(T1.[Email]) COLLATE SQL_Latin1_General_CP1_CI_AS = LOWER(U.[Username]) COLLATE SQL_Latin1_General_CP1_CI_AS
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, amm_reconcile_names')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[amm_reconcile_names] T1 join [dbo].[Subscriptions] T2 on T1.[subid] = T2.[sID] join #UsersToCheck U on T2.[sUID] = U.[UserID]
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, Amps_Table')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[Amps_Table] T1 join #UsersToCheck U on T1.[uid] = U.[UserID]
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, AOI_NEW')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[AOI_NEW] T1 join #UsersToCheck U on T1.[aUID] = U.[UserID]
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	
 

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, AR_SUNBELT_IMPORT')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[AR_SUNBELT_IMPORT] T1 join #UsersToCheck U on T1.[calc_userid] = U.[UserID]
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	
 

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, ARAIIMAG_SUNBELT_IMPORT')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[ARAIIMAG_SUNBELT_IMPORT] T1 join #UsersToCheck U on T1.[calc_userid] = U.[UserID]
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	
 

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, argi_subs_suid')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[argi_subs_suid] T1 join #UsersToCheck U on T1.[sUID] = U.[UserID]
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, AsiaLaw_Temp_Registrants')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[AsiaLaw_Temp_Registrants] T1 join #UsersToCheck U on T1.[rUserID] = U.[UserID]
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	
 

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, Authors')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[Authors] T1 join #UsersToCheck U on LOWER(T1.[aEmail]) COLLATE SQL_Latin1_General_CP1_CI_AS = LOWER(U.[Username]) COLLATE SQL_Latin1_General_CP1_CI_AS
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, b$')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[b$] T1 join #UsersToCheck U on T1.[uid] = U.[UserID]
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, backofficeimport')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[backofficeimport] T1 join #UsersToCheck U on T1.[userid] = U.[UserID]
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	
 

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, BEB1')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[BEB1] T1 join #UsersToCheck U on T1.[userid] = U.[UserID]
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	
 
 

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, BlockEmailAddress')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[BlockEmailAddress] T1 join #UsersToCheck U on LOWER(T1.[EmailAddress]) COLLATE SQL_Latin1_General_CP1_CI_AS = LOWER(U.[Username]) COLLATE SQL_Latin1_General_CP1_CI_AS
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, bo')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[bo] T1 join #UsersToCheck U on LOWER(T1.[Email address]) COLLATE SQL_Latin1_General_CP1_CI_AS = LOWER(U.[Username]) COLLATE SQL_Latin1_General_CP1_CI_AS
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	
 
 

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, BOAT_Logging')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[BOAT_Logging] T1 join [dbo].[Subscriptions] T2 on T1.[subid] = T2.[sID] join #UsersToCheck U on T2.[sUID] = U.[UserID]
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	
 
 
 
 
 

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, both$')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[both$] T1 join #UsersToCheck U on T1.[UID] = U.[UserID]
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, bt_competitions')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[bt_competitions] T1 join #UsersToCheck U on LOWER(T1.[EMailAddress]) COLLATE SQL_Latin1_General_CP1_CI_AS = LOWER(U.[Username]) COLLATE SQL_Latin1_General_CP1_CI_AS
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, BURT_AgentLog')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[BURT_AgentLog] T1 join #UsersToCheck U on T1.[UserID] = U.[UserID]
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, BURT_Agents')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[BURT_Agents] T1 join #UsersToCheck U on T1.[UserID] = U.[UserID]
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, BURT_Audit')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[BURT_Audit] T1 join #UsersToCheck U on T1.[UserID] = U.[UserID]
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	
 

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, BURT_Search')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[BURT_Search] T1 join #UsersToCheck U on T1.[UserID] = U.[UserID]
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	
 
 
 

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, DEBETA_2008')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[DEBETA_2008] T1 join #UsersToCheck U on LOWER(T1.[EMAIL]) COLLATE SQL_Latin1_General_CP1_CI_AS = LOWER(U.[Username]) COLLATE SQL_Latin1_General_CP1_CI_AS
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, C_MailinglistTest')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[C_MailinglistTest] T1 join #UsersToCheck U on LOWER(T1.[EmailAddress]) COLLATE SQL_Latin1_General_CP1_CI_AS = LOWER(U.[Username]) COLLATE SQL_Latin1_General_CP1_CI_AS
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, CAPMasterDetachedDonorsLog')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[CAPMasterDetachedDonorsLog] T1 join [dbo].[Subscriptions] T2 on T1.[cmdLDonorSubID] = T2.[sID] join #UsersToCheck U on T2.[sUID] = U.[UserID]
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, CAPMasterDetachedDonorsLog')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[CAPMasterDetachedDonorsLog] T1 join [dbo].[Subscriptions] T2 on T1.[cmdLMasterSubID] = T2.[sID] join #UsersToCheck U on T2.[sUID] = U.[UserID]
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, CAPMasterRelationship')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[CAPMasterRelationship] T1 join [dbo].CAPMaster T2 on T1.CAPMasterParentId = T2.cmID join [dbo].[Subscriptions] T3 on T2.[cmMasterSubID] = T3.[sID] join #UsersToCheck U on T3.[sUID] = U.[UserID]
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, CAPMasterRelationship')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[CAPMasterRelationship] T1 join [dbo].CAPMaster T2 on T1.CAPMasterChildId = T2.cmID join [dbo].[Subscriptions] T3 on T2.[cmMasterSubID] = T3.[sID] join #UsersToCheck U on T3.[sUID] = U.[UserID]
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, CAPMasterDonor')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[CAPMasterDonor] T1 join [dbo].[Subscriptions] T2 on T1.[cmdDonorSubID] = T2.[sID] join #UsersToCheck U on T2.[sUID] = U.[UserID]
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, CAPMasterDonor')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[CAPMasterDonor] T1 join [dbo].[Subscriptions] T2 on T1.[cmdMasterSubID] = T2.[sID] join #UsersToCheck U on T2.[sUID] = U.[UserID]
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, CAPMaster')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[CAPMaster] T1 join [dbo].[Subscriptions] T2 on T1.[cmMasterSubID] = T2.[sID] join #UsersToCheck U on T2.[sUID] = U.[UserID]
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, Cart_Carts')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[Cart_Carts] T1 join #UsersToCheck U on T1.[ccUID] = U.[UserID]
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, Cart_Items')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[Cart_Items] T1 join #UsersToCheck U on T1.[ciUserID] = U.[UserID]
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	
 

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, CategoryEmail')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[CategoryEmail] T1 join #UsersToCheck U on T1.[cUID] = U.[UserID]
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	
 
 

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, cats$')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[cats$] T1 join #UsersToCheck U on LOWER(T1.[Email]) COLLATE SQL_Latin1_General_CP1_CI_AS = LOWER(U.[Username]) COLLATE SQL_Latin1_General_CP1_CI_AS
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	
 

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, ConcurrentSessions')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[ConcurrentSessions] T1 join [dbo].[Subscriptions] T2 on T1.[SubscriptionID] = T2.[sID] join #UsersToCheck U on T2.[sUID] = U.[UserID]
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	
 
 
 
 

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, Cover1')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[Cover1] T1 join #UsersToCheck U on LOWER(T1.[Email Address]) COLLATE SQL_Latin1_General_CP1_CI_AS = LOWER(U.[Username]) COLLATE SQL_Latin1_General_CP1_CI_AS
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	
 

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, CW_Records')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[CW_Records] T1 join [dbo].[Subscriptions] T2 on T1.[SubscriptionID] = T2.[sID] join #UsersToCheck U on T2.[sUID] = U.[UserID]
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	
 

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, DataCashAudit')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[DataCashAudit] T1 join #UsersToCheck U on T1.[DCA_UserID] = U.[UserID]
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, DataCashAudit_BasketDetails')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[DataCashAudit_BasketDetails] T1 join #UsersToCheck U on T1.[dcaUserID] = U.[UserID]
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	
 

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, DatacashOrderRef')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[DatacashOrderRef] T1 join [dbo].[Orders] T2 on T1.[dcOrderID] = T2.[oID] join #UsersToCheck U on T2.[oUID] = U.[UserID]
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, DataCashTransaction')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[DataCashTransaction] T1 join #UsersToCheck U on T1.[dctUserID] = U.[UserID]
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	
 
 

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, DatacashReport')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[DatacashReport] T1 join [dbo].[DatacashOrderRef] T2 on T1.[OurReference] = T2.[dcIndex] join [dbo].[Orders] T3 on T2.dcOrderID = T3.oID join #UsersToCheck U on T3.[oUID] = U.[UserID]
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	
 

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, DelegateMessengerInformation')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[DelegateMessengerInformation] T1 join #UsersToCheck U on T1.[UserId] = U.[UserID]
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, DelegateMessengerOptouts')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[DelegateMessengerOptouts] T1 join #UsersToCheck U on T1.[UserId] = U.[UserID]
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, DeltetionEventNCUUsersTemp')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[DeltetionEventNCUUsersTemp] T1 join #UsersToCheck U on T1.[euID] = U.[UserID]
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, DeltetionEventNCUUsersTemp')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[DeltetionEventNCUUsersTemp] T1 join #UsersToCheck U on T1.[euUserID] = U.[UserID]
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, DeltetionEventNCUUsersTemp1')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[DeltetionEventNCUUsersTemp1] T1 join #UsersToCheck U on T1.[euID] = U.[UserID]
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, DeltetionEventNCUUsersTemp1')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[DeltetionEventNCUUsersTemp1] T1 join #UsersToCheck U on T1.[euUserID] = U.[UserID]
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, DeltetionUserPreferencesTemp')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[DeltetionUserPreferencesTemp] T1 join #UsersToCheck U on T1.[UserId] = U.[UserID]
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, DIN_Sunbelt_Import')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[DIN_Sunbelt_Import] T1 join #UsersToCheck U on T1.[calc_userid] = U.[UserID]
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	
 

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, dto6')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[dto6] T1 join #UsersToCheck U on LOWER(T1.[EmailAddress]) COLLATE SQL_Latin1_General_CP1_CI_AS = LOWER(U.[Username]) COLLATE SQL_Latin1_General_CP1_CI_AS
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, dtp')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[dtp] T1 join #UsersToCheck U on LOWER(T1.[EmailAddress]) COLLATE SQL_Latin1_General_CP1_CI_AS = LOWER(U.[Username]) COLLATE SQL_Latin1_General_CP1_CI_AS
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	
 

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, DuplicateUserIDs')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[DuplicateUserIDs] T1 join #UsersToCheck U on T1.[UserID] = U.[UserID]
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	
 

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, DW_Sunbelt_Import')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[DW_Sunbelt_Import] T1 join #UsersToCheck U on T1.[calc_userid] = U.[UserID]
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, dwbeta_2008')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[dwbeta_2008] T1 join #UsersToCheck U on LOWER(T1.[EMAIL]) COLLATE SQL_Latin1_General_CP1_CI_AS = LOWER(U.[Username]) COLLATE SQL_Latin1_General_CP1_CI_AS
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, DWC_ICFR_Cards_temp3')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[DWC_ICFR_Cards_temp3] T1 join #UsersToCheck U on LOWER(T1.[Email]) COLLATE SQL_Latin1_General_CP1_CI_AS = LOWER(U.[Username]) COLLATE SQL_Latin1_General_CP1_CI_AS
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	
 
 
 
 
 
 
 
 

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, EdenDUsers')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[EdenDUsers] T1 join #UsersToCheck U on T1.[EdenDUserID] = U.[UserID]
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, EdenDUsers')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[EdenDUsers] T1 join #UsersToCheck U on T1.[uID] = U.[UserID]
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, EdenDUsersTEMP')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[EdenDUsersTEMP] T1 join #UsersToCheck U on T1.[OrigEUserID] = U.[UserID]
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, EdenDUsersTEMP')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[EdenDUsersTEMP] T1 join #UsersToCheck U on T1.[uID] = U.[UserID]
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, EdenDUsersTMP')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[EdenDUsersTMP] T1 join #UsersToCheck U on T1.[OrigEUserID] = U.[UserID]
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, EdenDUsersTMP')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[EdenDUsersTMP] T1 join #UsersToCheck U on T1.[uID] = U.[UserID]
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, EdenUser')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[EdenUser] T1 join #UsersToCheck U on T1.[eduUserID] = U.[UserID]
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, edwin')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[edwin] T1 join #UsersToCheck U on LOWER(T1.[qEmailAddress]) COLLATE SQL_Latin1_General_CP1_CI_AS = LOWER(U.[Username]) COLLATE SQL_Latin1_General_CP1_CI_AS
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	
 
 

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, EIVS0708')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[EIVS0708] T1 join #UsersToCheck U on LOWER(T1.[Col029]) COLLATE SQL_Latin1_General_CP1_CI_AS = LOWER(U.[Username]) COLLATE SQL_Latin1_General_CP1_CI_AS
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	
 
 
 
 
 

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, em_activesub')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[em_activesub] T1 join #UsersToCheck U on T1.[userID] = U.[UserID]
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, em_address_temp')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[em_address_temp] T1 join #UsersToCheck U on T1.[aUID] = U.[UserID]
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, em_restoreblank')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[em_restoreblank] T1 join #UsersToCheck U on LOWER(T1.[uEmailAddress]) COLLATE SQL_Latin1_General_CP1_CI_AS = LOWER(U.[Username]) COLLATE SQL_Latin1_General_CP1_CI_AS
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, em_temp')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[em_temp] T1 join #UsersToCheck U on T1.[uID] = U.[UserID]
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, em_temp2')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[em_temp2] T1 join #UsersToCheck U on T1.[uID] = U.[UserID]
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	
 

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, email_100')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[email_100] T1 join #UsersToCheck U on LOWER(T1.[EmailAddress]) COLLATE SQL_Latin1_General_CP1_CI_AS = LOWER(U.[Username]) COLLATE SQL_Latin1_General_CP1_CI_AS
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, email_125')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[email_125] T1 join #UsersToCheck U on LOWER(T1.[EmailAddress]) COLLATE SQL_Latin1_General_CP1_CI_AS = LOWER(U.[Username]) COLLATE SQL_Latin1_General_CP1_CI_AS
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, email_50')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[email_50] T1 join #UsersToCheck U on LOWER(T1.[EmailAddress]) COLLATE SQL_Latin1_General_CP1_CI_AS = LOWER(U.[Username]) COLLATE SQL_Latin1_General_CP1_CI_AS
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, email_75')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[email_75] T1 join #UsersToCheck U on LOWER(T1.[EmailAddress]) COLLATE SQL_Latin1_General_CP1_CI_AS = LOWER(U.[Username]) COLLATE SQL_Latin1_General_CP1_CI_AS
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, EmailLogging')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[EmailLogging] T1 join #UsersToCheck U on LOWER(T1.[eUsername]) COLLATE SQL_Latin1_General_CP1_CI_AS = LOWER(U.[Username]) COLLATE SQL_Latin1_General_CP1_CI_AS
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, EmailNewsletter')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[EmailNewsletter] T1 join #UsersToCheck U on LOWER(T1.[EMailAddress]) COLLATE SQL_Latin1_General_CP1_CI_AS = LOWER(U.[Username]) COLLATE SQL_Latin1_General_CP1_CI_AS
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, EmailStory')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[EmailStory] T1 join #UsersToCheck U on T1.[sUID] = U.[UserID]
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, EMBL_BOAT_Logging')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[EMBL_BOAT_Logging] T1 join #UsersToCheck U on T1.[nl_uid] = U.[UserID]
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	
 
 
 

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, ems_supp_apr_06')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[ems_supp_apr_06] T1 join #UsersToCheck U on LOWER(T1.[uEmail]) COLLATE SQL_Latin1_General_CP1_CI_AS = LOWER(U.[Username]) COLLATE SQL_Latin1_General_CP1_CI_AS
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, EMTraining_Requests')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[EMTraining_Requests] T1 join #UsersToCheck U on LOWER(T1.[EmailAddress]) COLLATE SQL_Latin1_General_CP1_CI_AS = LOWER(U.[Username]) COLLATE SQL_Latin1_General_CP1_CI_AS
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, EMTraining_Requests')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[EMTraining_Requests] T1 join [dbo].[Orders] T2 on T1.[orderid] = T2.[oID] join #UsersToCheck U on T2.[oUID] = U.[UserID]
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, enews_temp2')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[enews_temp2] T1 join #UsersToCheck U on LOWER(T1.[EmailAddress]) COLLATE SQL_Latin1_General_CP1_CI_AS = LOWER(U.[Username]) COLLATE SQL_Latin1_General_CP1_CI_AS
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, ErrorRows')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[ErrorRows] T1 join #UsersToCheck U on T1.[uid] = U.[UserID]
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, ESCS2006_Survey')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[ESCS2006_Survey] T1 join #UsersToCheck U on LOWER(T1.[Email]) COLLATE SQL_Latin1_General_CP1_CI_AS = LOWER(U.[Username]) COLLATE SQL_Latin1_General_CP1_CI_AS
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, enews_emails')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[enews_emails] T1 join #UsersToCheck U on LOWER(T1.[EmailAddress]) COLLATE SQL_Latin1_General_CP1_CI_AS = LOWER(U.[Username]) COLLATE SQL_Latin1_General_CP1_CI_AS
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, ET_SiteUploadPaths')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[ET_SiteUploadPaths] T1 join #UsersToCheck U on T1.[uID] = U.[UserID]
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, ET_SiteUploadPaths')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[ET_SiteUploadPaths] T1 join #UsersToCheck U on T1.[uUserid] = U.[UserID]
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, ET_Users')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[ET_Users] T1 join #UsersToCheck U on T1.[UserID] = U.[UserID]
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, euromoney_import')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[euromoney_import] T1 join #UsersToCheck U on T1.[UID] = U.[UserID]
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, EuromoneyBksDoc')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[EuromoneyBksDoc] T1 join #UsersToCheck U on T1.[UserID] = U.[UserID]
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, EuromoneyBooks_catdownload')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[EuromoneyBooks_catdownload] T1 join #UsersToCheck U on LOWER(T1.[Email]) COLLATE SQL_Latin1_General_CP1_CI_AS = LOWER(U.[Username]) COLLATE SQL_Latin1_General_CP1_CI_AS
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, EuromoneyTrialistEmailAlert')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[EuromoneyTrialistEmailAlert] T1 join #UsersToCheck U on T1.[eUID] = U.[UserID]
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	
 

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, EventNCUUserAudit')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[EventNCUUserAudit] T1 join #UsersToCheck U on T1.[euID] = U.[UserID]
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, EventNcuUsers')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[EventNcuUsers] T1 join #UsersToCheck U on T1.[euUserID] = U.[UserID]
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	


	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, EventNcuUsers - lost users')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) n
			from eventncuusers n 
			left join UserDetails u on n.euuserid = u.uid
			where uid is null
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	


	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, EW_LoanPoll2006')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[EW_LoanPoll2006] T1 join #UsersToCheck U on LOWER(T1.[email]) COLLATE SQL_Latin1_General_CP1_CI_AS = LOWER(U.[Username]) COLLATE SQL_Latin1_General_CP1_CI_AS
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, EW_logins')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[EW_logins] T1 join [dbo].[Subscriptions] T2 on T1.[Subid] = T2.[sID] join #UsersToCheck U on T2.[sUID] = U.[UserID]
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	
 

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, ew_subinfo')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[ew_subinfo] T1 join #UsersToCheck U on T1.[userid] = U.[UserID]
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, ew_temp_noemail')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[ew_temp_noemail] T1 join #UsersToCheck U on LOWER(T1.[Email]) COLLATE SQL_Latin1_General_CP1_CI_AS = LOWER(U.[Username]) COLLATE SQL_Latin1_General_CP1_CI_AS
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, ExpiredTrialists')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[ExpiredTrialists] T1 join #UsersToCheck U on T1.[eUserid] = U.[UserID]
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, ExtraTrials_TEMP')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[ExtraTrials_TEMP] T1 join #UsersToCheck U on T1.[UserID] = U.[UserID]
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, ExtraTSUsers$')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[ExtraTSUsers$] T1 join #UsersToCheck U on LOWER(T1.[email]) COLLATE SQL_Latin1_General_CP1_CI_AS = LOWER(U.[Username]) COLLATE SQL_Latin1_General_CP1_CI_AS
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, F_DirectoryNames')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[F_DirectoryNames] T1 join #UsersToCheck U on LOWER(T1.[EmailAddress]) COLLATE SQL_Latin1_General_CP1_CI_AS = LOWER(U.[Username]) COLLATE SQL_Latin1_General_CP1_CI_AS
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, F_DirectoryNames_VinceWork')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[F_DirectoryNames_VinceWork] T1 join #UsersToCheck U on T1.[v_uid] = U.[UserID]
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, F_DirectoryNameUserIDs')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[F_DirectoryNameUserIDs] T1 join #UsersToCheck U on T1.[fduid] = U.[UserID]
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, F_DirectoryNameUserIDs')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[F_DirectoryNameUserIDs] T1 join #UsersToCheck U on T1.[uid] = U.[UserID]
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, F_DirectoryNameUserSubscriptionIDs')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[F_DirectoryNameUserSubscriptionIDs] T1 join #UsersToCheck U on T1.[fduid] = U.[UserID]
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, F_DirectoryNameUserSubscriptionIDs')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[F_DirectoryNameUserSubscriptionIDs] T1 join [dbo].[Subscriptions] T2 on T1.[sid] = T2.[sID] join #UsersToCheck U on T2.[sUID] = U.[UserID]
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, FailedOrders')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[FailedOrders] T1 join [dbo].[Orders] T2 on T1.[FailedOrderId] = T2.[oID] join #UsersToCheck U on T2.[oUID] = U.[UserID]
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, foi_temp')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[foi_temp] T1 join #UsersToCheck U on T1.[uID] = U.[UserID]
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, fow_220c07')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[fow_220c07] T1 join #UsersToCheck U on T1.[uid] = U.[UserID]
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, FOWsubs')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[FOWsubs] T1 join #UsersToCheck U on T1.[uid] = U.[UserID]
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, fowtrials')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[fowtrials] T1 join #UsersToCheck U on T1.[uid] = U.[UserID]
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	
 

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, FreeSignUp_Survey_Answers')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[FreeSignUp_Survey_Answers] T1 join #UsersToCheck U on T1.[saUserId] = U.[UserID]
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	
 

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, Freetrial_list')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[Freetrial_list] T1 join #UsersToCheck U on T1.[userid] = U.[UserID]
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, FreeTrialRequests')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[FreeTrialRequests] T1 join #UsersToCheck U on T1.[ActionUserId] = U.[UserID]
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	
 
 
 

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, gi_distinct101')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[gi_distinct101] T1 join #UsersToCheck U on T1.[uID] = U.[UserID]
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, GI_eventsdata')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[GI_eventsdata] T1 join #UsersToCheck U on LOWER(T1.[Email]) COLLATE SQL_Latin1_General_CP1_CI_AS = LOWER(U.[Username]) COLLATE SQL_Latin1_General_CP1_CI_AS
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, GroupBooking')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[GroupBooking] T1 join #UsersToCheck U on T1.[PocUserId] = U.[UserID]
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	
 
 

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, GUIDAccess')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[GUIDAccess] T1 join [dbo].[Subscriptions] T2 on T1.[SubscriptionID] = T2.[sID] join #UsersToCheck U on T2.[sUID] = U.[UserID]
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, GUIDValues')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[GUIDValues] T1 join [dbo].[Subscriptions] T2 on T1.[gSID] = T2.[sID] join #UsersToCheck U on T2.[sUID] = U.[UserID]
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	
 
 
 
 

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, hp_subs')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[hp_subs] T1 join #UsersToCheck U on T1.[user_id] = U.[UserID]
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	
 
 

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, IdmPoll')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[IdmPoll] T1 join #UsersToCheck U on LOWER(T1.[Username]) COLLATE SQL_Latin1_General_CP1_CI_AS = LOWER(U.[Username]) COLLATE SQL_Latin1_General_CP1_CI_AS
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	
 

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, ii_BPA')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[ii_BPA] T1 join #UsersToCheck U on T1.[iUID] = U.[UserID]
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, II_export')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[II_export] T1 join #UsersToCheck U on T1.[uid] = U.[UserID]
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, II_export_temp')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[II_export_temp] T1 join #UsersToCheck U on T1.[uid] = U.[UserID]
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, ii_export2')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[ii_export2] T1 join #UsersToCheck U on LOWER(T1.[EmailAddress]) COLLATE SQL_Latin1_General_CP1_CI_AS = LOWER(U.[Username]) COLLATE SQL_Latin1_General_CP1_CI_AS
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, II_HF_T')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[II_HF_T] T1 join #UsersToCheck U on LOWER(T1.[Email]) COLLATE SQL_Latin1_General_CP1_CI_AS = LOWER(U.[Username]) COLLATE SQL_Latin1_General_CP1_CI_AS
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, II_Name_Change')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[II_Name_Change] T1 join #UsersToCheck U on LOWER(T1.[OLD]) COLLATE SQL_Latin1_General_CP1_CI_AS = LOWER(U.[Username]) COLLATE SQL_Latin1_General_CP1_CI_AS
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, II_Name_Change')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[II_Name_Change] T1 join #UsersToCheck U on LOWER(T1.[NEW]) COLLATE SQL_Latin1_General_CP1_CI_AS = LOWER(U.[Username]) COLLATE SQL_Latin1_General_CP1_CI_AS
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, ii_RenewalCode')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[ii_RenewalCode] T1 join [dbo].[Subscriptions] T2 on T1.[rSID] = T2.[sID] join #UsersToCheck U on T2.[sUID] = U.[UserID]
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, IIControlTemp')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[IIControlTemp] T1 join #UsersToCheck U on LOWER(T1.[EmailAddress]) COLLATE SQL_Latin1_General_CP1_CI_AS = LOWER(U.[Username]) COLLATE SQL_Latin1_General_CP1_CI_AS
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, III_BCA')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[III_BCA] T1 join #UsersToCheck U on LOWER(T1.[bEmail]) COLLATE SQL_Latin1_General_CP1_CI_AS = LOWER(U.[Username]) COLLATE SQL_Latin1_General_CP1_CI_AS
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	
 

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, IIJ_Agents')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[IIJ_Agents] T1 join #UsersToCheck U on T1.[aUID] = U.[UserID]
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, IIJ_DownloadSecurityLog')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[IIJ_DownloadSecurityLog] T1 join [dbo].[Subscriptions] T2 on T1.[SubscriptionID] = T2.[sID] join #UsersToCheck U on T2.[sUID] = U.[UserID]
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, IIExamPrepUserInfo')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[IIExamPrepUserInfo] T1 join #UsersToCheck U on LOWER(T1.[eEmail]) COLLATE SQL_Latin1_General_CP1_CI_AS = LOWER(U.[Username]) COLLATE SQL_Latin1_General_CP1_CI_AS
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, IIJ_DownloadDisabledSubscriptions')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[IIJ_DownloadDisabledSubscriptions] T1 join [dbo].[Subscriptions] T2 on T1.[SubscriptionID] = T2.[sID] join #UsersToCheck U on T2.[sUID] = U.[UserID]
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	
 
 

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, IIJ_JP_EXTRA')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[IIJ_JP_EXTRA] T1 join #UsersToCheck U on LOWER(T1.[EMail]) COLLATE SQL_Latin1_General_CP1_CI_AS = LOWER(U.[Username]) COLLATE SQL_Latin1_General_CP1_CI_AS
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	
 
 

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, IIMAG_SUNBELT_IMPORT')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[IIMAG_SUNBELT_IMPORT] T1 join #UsersToCheck U on T1.[calc_userid] = U.[UserID]
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, IIMAG2011_SUNBELT_IMPORT')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[IIMAG2011_SUNBELT_IMPORT] T1 join #UsersToCheck U on T1.[calc_userid] = U.[UserID]
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, IIMAG2011_SUNBELT_IMPORT_DUMMY')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[IIMAG2011_SUNBELT_IMPORT_DUMMY] T1 join #UsersToCheck U on T1.[calc_userid] = U.[UserID]
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, iiMagBloombergSymbologyUsers')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[iiMagBloombergSymbologyUsers] T1 join #UsersToCheck U on LOWER(T1.[bsuEmail]) COLLATE SQL_Latin1_General_CP1_CI_AS = LOWER(U.[Username]) COLLATE SQL_Latin1_General_CP1_CI_AS
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, iiMagBValUsers')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[iiMagBValUsers] T1 join #UsersToCheck U on LOWER(T1.[bvEmail]) COLLATE SQL_Latin1_General_CP1_CI_AS = LOWER(U.[Username]) COLLATE SQL_Latin1_General_CP1_CI_AS
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, iiMagIntraLinksUsers')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[iiMagIntraLinksUsers] T1 join #UsersToCheck U on LOWER(T1.[iluEmail]) COLLATE SQL_Latin1_General_CP1_CI_AS = LOWER(U.[Username]) COLLATE SQL_Latin1_General_CP1_CI_AS
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, IIMagPodcastData')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[IIMagPodcastData] T1 join #UsersToCheck U on LOWER(T1.[Email]) COLLATE SQL_Latin1_General_CP1_CI_AS = LOWER(U.[Username]) COLLATE SQL_Latin1_General_CP1_CI_AS
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	
 

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, IIMAGProductCatalogueReport$')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[IIMAGProductCatalogueReport$] T1 join #UsersToCheck U on T1.[User ID] = U.[UserID]
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, iiMagRegFormsUsers')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[iiMagRegFormsUsers] T1 join #UsersToCheck U on LOWER(T1.[rfuEmail]) COLLATE SQL_Latin1_General_CP1_CI_AS = LOWER(U.[Username]) COLLATE SQL_Latin1_General_CP1_CI_AS
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, iiMagRSInvestmentUsers')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[iiMagRSInvestmentUsers] T1 join #UsersToCheck U on LOWER(T1.[rsiEmail]) COLLATE SQL_Latin1_General_CP1_CI_AS = LOWER(U.[Username]) COLLATE SQL_Latin1_General_CP1_CI_AS
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, iiMagTempNoEmail')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[iiMagTempNoEmail] T1 join #UsersToCheck U on LOWER(T1.[EmailAddress]) COLLATE SQL_Latin1_General_CP1_CI_AS = LOWER(U.[Username]) COLLATE SQL_Latin1_General_CP1_CI_AS
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	
 

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, IINews_PDFForm')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[IINews_PDFForm] T1 join #UsersToCheck U on T1.[pUID] = U.[UserID]
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	
 
 

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, IINewsFeeds')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[IINewsFeeds] T1 join #UsersToCheck U on T1.[UserID] = U.[UserID]
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, IINUserReport')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[IINUserReport] T1 join #UsersToCheck U on T1.[userid] = U.[UserID]
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, IINUserReport_old')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[IINUserReport_old] T1 join #UsersToCheck U on T1.[userid] = U.[UserID]
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, IINUserReport1')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[IINUserReport1] T1 join #UsersToCheck U on T1.[userid] = U.[UserID]
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, IISearchesGroupNoXref')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[IISearchesGroupNoXref] T1 join #UsersToCheck U on T1.[NCUUserId] = U.[UserID]
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, iisFFT1')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[iisFFT1] T1 join #UsersToCheck U on LOWER(T1.[uEmailAddress]) COLLATE SQL_Latin1_General_CP1_CI_AS = LOWER(U.[Username]) COLLATE SQL_Latin1_General_CP1_CI_AS
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, import_dup')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[import_dup] T1 join #UsersToCheck U on LOWER(T1.[Emailaddress]) COLLATE SQL_Latin1_General_CP1_CI_AS = LOWER(U.[Username]) COLLATE SQL_Latin1_General_CP1_CI_AS
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, import_poll')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[import_poll] T1 join #UsersToCheck U on LOWER(T1.[EmailAddress]) COLLATE SQL_Latin1_General_CP1_CI_AS = LOWER(U.[Username]) COLLATE SQL_Latin1_General_CP1_CI_AS
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, import147')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[import147] T1 join #UsersToCheck U on T1.[userid] = U.[UserID]
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, IncompleteOrderDetails')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[IncompleteOrderDetails] T1 join [dbo].[Orders] T2 on T1.[odOrderID] = T2.[oID] join #UsersToCheck U on T2.[oUID] = U.[UserID]
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, IncompleteOrders')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[IncompleteOrders] T1 join #UsersToCheck U on T1.[oUID] = U.[UserID]
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	
 
 
 

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, IPRanges')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[IPRanges] T1 join [dbo].[Subscriptions] T2 on T1.[iprSubscriptionID] = T2.[sID] join #UsersToCheck U on T2.[sUID] = U.[UserID]
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	
 
 
 
 
 
 
 

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, JPM_Survey_Dump')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[JPM_Survey_Dump] T1 join #UsersToCheck U on T1.[uid] = U.[UserID]
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, jrnls_export')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[jrnls_export] T1 join #UsersToCheck U on T1.[uid] = U.[UserID]
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, JRNLS_Import_argi')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[JRNLS_Import_argi] T1 join #UsersToCheck U on T1.[UID] = U.[UserID]
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, JRNLS_Import_argi')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[JRNLS_Import_argi] T1 join #UsersToCheck U on T1.[USERID] = U.[UserID]
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, JRNLS_Import_First')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[JRNLS_Import_First] T1 join #UsersToCheck U on T1.[UID] = U.[UserID]
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, Jul_cap_raising_rep')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[Jul_cap_raising_rep] T1 join #UsersToCheck U on T1.[uid] = U.[UserID]
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, jul_gov_rep')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[jul_gov_rep] T1 join #UsersToCheck U on T1.[uid] = U.[UserID]
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, jul_risk_rep')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[jul_risk_rep] T1 join #UsersToCheck U on T1.[uid] = U.[UserID]
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, KeywordEmail')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[KeywordEmail] T1 join #UsersToCheck U on T1.[kUID] = U.[UserID]
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	
 

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, KeywordEmailLog')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[KeywordEmailLog] T1 join #UsersToCheck U on T1.[kcUID] = U.[UserID]
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	
 
 
 

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, LF_a$')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[LF_a$] T1 join #UsersToCheck U on T1.[UserID] = U.[UserID]
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, LF_AgendaRegistration')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[LF_AgendaRegistration] T1 join #UsersToCheck U on T1.[aUserId] = U.[UserID]
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, LF_b$')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[LF_b$] T1 join #UsersToCheck U on T1.[userid] = U.[UserID]
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	
 
 
 

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, LF_NewUsersEmail')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[LF_NewUsersEmail] T1 join #UsersToCheck U on T1.[NCUUserID] = U.[UserID]
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, LF_Sunbelt_Import')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[LF_Sunbelt_Import] T1 join #UsersToCheck U on T1.[uid] = U.[UserID]
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, LF_SUNBELT_IMPORT_2011')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[LF_SUNBELT_IMPORT_2011] T1 join #UsersToCheck U on T1.[calc_userid] = U.[UserID]
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	
 
 
 
 

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, LFSubscriptionBackup')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[LFSubscriptionBackup] T1 join #UsersToCheck U on T1.[sUID] = U.[UserID]
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	
 

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, LibrarySubs')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[LibrarySubs] T1 join #UsersToCheck U on T1.[lUId] = U.[UserID]
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	
 
 
 
 
 
 
 
 

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, LZ_2010')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[LZ_2010] T1 join #UsersToCheck U on T1.[UserID] = U.[UserID]
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	
 

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, ManualLoad')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[ManualLoad] T1 join #UsersToCheck U on T1.[uid] = U.[UserID]
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	
 
 
 
 
 
 
 
 
 
 
 

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, MPAttendee')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[MPAttendee] T1 join #UsersToCheck U on T1.[UserId] = U.[UserID]
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	
 

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, MPAttendeeUnavailability')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[MPAttendeeUnavailability] T1 join #UsersToCheck U on T1.[UserId] = U.[UserID]
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	
 
 
 
 
 

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, MPCommunicationFlags')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[MPCommunicationFlags] T1 join #UsersToCheck U on T1.[UserId] = U.[UserID]
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	
 
 
 

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, MPEventUserDetails')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[MPEventUserDetails] T1 join EventNcuUsers T2 on T1.EventNcuUserId = T2.euID join #UsersToCheck U on T2.[euUserId] = U.[UserID]
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, MPMails')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[MPMails] T1 join #UsersToCheck U on T1.[mpmUserID] = U.[UserID]
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	
 

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, MPMeeting')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[MPMeeting] T1 join #UsersToCheck U on T1.[OrganiserUserId] = U.[UserID]
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	
 
 
 
 
 

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, MPUserAttachments')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[MPUserAttachments] T1 join EventNcuUsers T2 on T1.EventNcuUserId = T2.euID join #UsersToCheck U on T2.[euUserId] = U.[UserID]
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	
 
	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, MPUserDetails')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[MPUserDetails] T1 join #UsersToCheck U on T1.[UserId] = U.[UserID]
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, MPUserLinks')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[MPUserLinks] T1 join EventNcuUsers T2 on T1.EventNcuUserId = T2.euID join #UsersToCheck U on T2.[euUserId] = U.[UserID]
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, MPUserSessions')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[MPUserSessions] T1 join EventNcuUsers T2 on T1.EventNcuUserId = T2.euID join #UsersToCheck U on T2.[euUserId] = U.[UserID]
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, MPWithdrawnDelegateActionData')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[MPWithdrawnDelegateActionData] T1 join #UsersToCheck U on T1.[mpwdActionEventUserId] = U.[UserID]
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, MPWithdrawnDelegateActionData')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[MPWithdrawnDelegateActionData] T1 join #UsersToCheck U on T1.[mpwdEventUserId] = U.[UserID]
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	
 
 
 
 
 
 
 
 
 
 
 
 
 
 

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, NewsletterUserCategories')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[NewsletterUserCategories] T1 join #UsersToCheck U on T1.[UserId] = U.[UserID]
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, newuserdetails')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[newuserdetails] T1 join #UsersToCheck U on T1.[newuserid] = U.[UserID]
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, newuserdetails')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[newuserdetails] T1 join #UsersToCheck U on T1.[userid] = U.[UserID]
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, newuserdetails_lmg')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[newuserdetails_lmg] T1 join #UsersToCheck U on T1.[newuserid] = U.[UserID]
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, newuserdetails_lmg')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[newuserdetails_lmg] T1 join #UsersToCheck U on T1.[userid] = U.[UserID]
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, newuserdetails_mip')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[newuserdetails_mip] T1 join #UsersToCheck U on T1.[newuserid] = U.[UserID]
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, newuserdetails_mip')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[newuserdetails_mip] T1 join #UsersToCheck U on T1.[userid] = U.[UserID]
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	
 
 
 
 
 
 

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, Old_UserDetails')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[Old_UserDetails] T1 join #UsersToCheck U on T1.[UserID] = U.[UserID]
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	
 
 

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, OnlineSalesStateTaxesLogs')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[OnlineSalesStateTaxesLogs] T1 join #UsersToCheck U on LOWER(T1.[UserEmail]) COLLATE SQL_Latin1_General_CP1_CI_AS = LOWER(U.[Username]) COLLATE SQL_Latin1_General_CP1_CI_AS
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	
 
 
 
 
 
 
 
 
 
 
 

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, OPI_New_CC_SUB')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[OPI_New_CC_SUB] T1 join #UsersToCheck U on T1.[uID] = U.[UserID]
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	
 
 
 
 
 
 
 
 

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, OrderRecords')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[OrderRecords] T1 join #UsersToCheck U on T1.[userID] = U.[UserID]
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	
 
 
 

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, Orders')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[Orders] T1 join #UsersToCheck U on T1.[oUID] = U.[UserID]
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, Orders_Stage')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[Orders_Stage] T1 join #UsersToCheck U on T1.[oUID] = U.[UserID]
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, Orders_Test')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[Orders_Test] T1 join #UsersToCheck U on T1.[oUID] = U.[UserID]
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	
 
 
 
 
 
 
 

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, pfnews')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[pfnews] T1 join #UsersToCheck U on T1.[uid] = U.[UserID]
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	
 
 
 
 

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, PM_PrivateMessages')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[PM_PrivateMessages] T1 join #UsersToCheck U on T1.[UserID] = U.[UserID]
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, ProductViewsHosted')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[ProductViewsHosted] T1 join #UsersToCheck U on T1.[pUID] = U.[UserID]
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, ProductVisitors')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[ProductVisitors] T1 join #UsersToCheck U on T1.[pvUID] = U.[UserID]
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	
 
 
 

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, PublicationPreferenceURLs')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[PublicationPreferenceURLs] T1 join #UsersToCheck U on T1.[ppuID] = U.[UserID]
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	
 
 
 
 
 
 
 
 
 
 

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, qss_table')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[qss_table] T1 join #UsersToCheck U on T1.[uid] = U.[UserID]
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, qss_table_141017')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[qss_table_141017] T1 join #UsersToCheck U on T1.[uid] = U.[UserID]
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, QSS_Table_Dev')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[QSS_Table_Dev] T1 join #UsersToCheck U on T1.[uid] = U.[UserID]
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	
 
 

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, ravennews')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[ravennews] T1 join #UsersToCheck U on T1.[euid] = U.[UserID]
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, Reaction0')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[Reaction0] T1 join #UsersToCheck U on T1.[userid] = U.[UserID]
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, reactions')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[reactions] T1 join #UsersToCheck U on T1.[userid] = U.[UserID]
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, SavedSearches')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[SavedSearches] T1 join #UsersToCheck U on T1.[ssUserID] = U.[UserID]
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	
 

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, SearchLogs')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[SearchLogs] T1 join #UsersToCheck U on T1.[SearchUserID] = U.[UserID]
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	
 
 
 
 
 
 
 

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, sf')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[sf] T1 join #UsersToCheck U on T1.[newuid] = U.[UserID]
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	
 

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, Sheet1')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[Sheet1] T1 join #UsersToCheck U on T1.[UserID] = U.[UserID]
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	
 
 
 
 
 
 
 
 
 
 
 
 

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, Subscription_History_Logs')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[Subscription_History_Logs] T1 join #UsersToCheck U on T1.[sUID] = U.[UserID]
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, SubscriptionChanges')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[SubscriptionChanges] T1 join #UsersToCheck U on T1.[sUID] = U.[UserID]
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, subscriptionMagOBU')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[subscriptionMagOBU] T1 join #UsersToCheck U on T1.[oUID] = U.[UserID]
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	
 

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, Subscriptions')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[Subscriptions] T1 join #UsersToCheck U on T1.[sUID] = U.[UserID]
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, Subscriptions_Del_Stage')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[Subscriptions_Del_Stage] T1 join #UsersToCheck U on T1.[sUID] = U.[UserID]
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, Subscriptions_NPAS_2226')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[Subscriptions_NPAS_2226] T1 join #UsersToCheck U on T1.[sUID] = U.[UserID]
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, Subscriptions_Stage')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[Subscriptions_Stage] T1 join #UsersToCheck U on T1.[sUID] = U.[UserID]
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, subscriptions_tpka')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[subscriptions_tpka] T1 join #UsersToCheck U on T1.[sUID] = U.[UserID]
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, Subscriptions1')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[Subscriptions1] T1 join #UsersToCheck U on T1.[sUID] = U.[UserID]
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, subscriptionsMagNulls')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[subscriptionsMagNulls] T1 join #UsersToCheck U on T1.[sUID] = U.[UserID]
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	
 
 
 

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, SunbeltConversionLog')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[SunbeltConversionLog] T1 join #UsersToCheck U on LOWER(T1.[BOUserID]) COLLATE SQL_Latin1_General_CP1_CI_AS = LOWER(U.[Username]) COLLATE SQL_Latin1_General_CP1_CI_AS
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, SunbeltFeedWelcomeEmail')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[SunbeltFeedWelcomeEmail] T1 join #UsersToCheck U on LOWER(T1.[UserId]) COLLATE SQL_Latin1_General_CP1_CI_AS = LOWER(U.[Username]) COLLATE SQL_Latin1_General_CP1_CI_AS
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, SunbeltFeedWelcomeEmail')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[SunbeltFeedWelcomeEmail] T1 join [dbo].[Subscriptions] T2 on T1.[SubId] = T2.[sID] join #UsersToCheck U on T2.[sUID] = U.[UserID]
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, SunbeltPrefix')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[SunbeltPrefix] T1 join #UsersToCheck U on LOWER(T1.[UserID]) COLLATE SQL_Latin1_General_CP1_CI_AS = LOWER(U.[Username]) COLLATE SQL_Latin1_General_CP1_CI_AS
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	
 
 
 
 
 
 

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, tb_amm_user')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[tb_amm_user] T1 join #UsersToCheck U on T1.[bo_uid] = U.[UserID]
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	
 
 

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, tbFurloughSubscriptionLog')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[tbFurloughSubscriptionLog] T1 join #UsersToCheck U on T1.[fslSuid] = U.[UserID]
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, SunbeltUsersActiveList')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[SunbeltUsersActiveList] T1 join #UsersToCheck U on LOWER(T1.[alEmail]) COLLATE SQL_Latin1_General_CP1_CI_AS = LOWER(U.[Username]) COLLATE SQL_Latin1_General_CP1_CI_AS
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, SunbeltUsersWBadEmail')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[SunbeltUsersWBadEmail] T1 join #UsersToCheck U on LOWER(T1.[UserID]) COLLATE SQL_Latin1_General_CP1_CI_AS = LOWER(U.[Username]) COLLATE SQL_Latin1_General_CP1_CI_AS
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, tblARGIExport')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[tblARGIExport] T1 join #UsersToCheck U on T1.[UID] = U.[UserID]
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, tblARGIImport')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[tblARGIImport] T1 join #UsersToCheck U on T1.[UserID] = U.[UserID]
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, tblARGIImportArchive')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[tblARGIImportArchive] T1 join #UsersToCheck U on T1.[UserID] = U.[UserID]
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, tblARGIImportHeld')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[tblARGIImportHeld] T1 join #UsersToCheck U on T1.[UserID] = U.[UserID]
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, tblARGIImportTest')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[tblARGIImportTest] T1 join #UsersToCheck U on T1.[UserID] = U.[UserID]
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, tblCustomerEmails')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[tblCustomerEmails] T1 join #UsersToCheck U on T1.[UserID] = U.[UserID]
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, tblCustomers')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[tblCustomers] T1 join #UsersToCheck U on T1.[OldUserID] = U.[UserID]
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, tblCustomers')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[tblCustomers] T1 join #UsersToCheck U on T1.[UserID] = U.[UserID]
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, tblIPUsers')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[tblIPUsers] T1 join #UsersToCheck U on T1.[IPUserID] = U.[UserID]
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, tblIPUsers')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[tblIPUsers] T1 join #UsersToCheck U on T1.[userid] = U.[UserID]
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, tblIPUsers_ClassB')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[tblIPUsers_ClassB] T1 join #UsersToCheck U on T1.[IPUserID] = U.[UserID]
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, tblNewIPUsers')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[tblNewIPUsers] T1 join #UsersToCheck U on T1.[userid] = U.[UserID]
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, tblNullStatus')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[tblNullStatus] T1 join #UsersToCheck U on T1.[OldUserID] = U.[UserID]
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, tblNullStatus')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[tblNullStatus] T1 join #UsersToCheck U on T1.[UserID] = U.[UserID]
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, tblRejectEmails')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[tblRejectEmails] T1 join #UsersToCheck U on T1.[UserID] = U.[UserID]
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, tblTandCAcceptance')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[tblTandCAcceptance] T1 join #UsersToCheck U on T1.[userid] = U.[UserID]
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, tblTracking')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[tblTracking] T1 join #UsersToCheck U on T1.[userid] = U.[UserID]
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, tblTrialsToInsert')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[tblTrialsToInsert] T1 join #UsersToCheck U on T1.[UserID] = U.[UserID]
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, tblUsersAdmin')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[tblUsersAdmin] T1 join #UsersToCheck U on T1.[uid] = U.[UserID]
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, tblUsersContent')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[tblUsersContent] T1 join #UsersToCheck U on T1.[uid] = U.[UserID]
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, tbPubWizUserRegistration')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[tbPubWizUserRegistration] T1 join #UsersToCheck U on T1.[UserID] = U.[UserID]
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	
 

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, telemagic')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[telemagic] T1 join #UsersToCheck U on T1.[uid] = U.[UserID]
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	
 

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, temp_JPM_JACOBS_LEVY')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[temp_JPM_JACOBS_LEVY] T1 join #UsersToCheck U on T1.[sUID] = U.[UserID]
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, TEMP_NewIISearchesUsers')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[TEMP_NewIISearchesUsers] T1 join #UsersToCheck U on T1.[NCUuID] = U.[UserID]
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	
 

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, TEMP_Reaction54497')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[TEMP_Reaction54497] T1 join #UsersToCheck U on T1.[TheUserID] = U.[UserID]
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, temp1')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[temp1] T1 join #UsersToCheck U on T1.[uid] = U.[UserID]
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, temp10')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[temp10] T1 join #UsersToCheck U on T1.[uid] = U.[UserID]
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	
 

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, temp47')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[temp47] T1 join #UsersToCheck U on T1.[uid] = U.[UserID]
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	
 

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, temp7')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[temp7] T1 join #UsersToCheck U on T1.[uid] = U.[UserID]
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	
 
 
 

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, TempReactionsImport2')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[TempReactionsImport2] T1 join #UsersToCheck U on T1.[UDuID] = U.[UserID]
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, TempRectionsUsers')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[TempRectionsUsers] T1 join #UsersToCheck U on T1.[UDuID] = U.[UserID]
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	
 
 
 

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, testARGIImport')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[testARGIImport] T1 join #UsersToCheck U on T1.[UserID] = U.[UserID]
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, testCustomers')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[testCustomers] T1 join #UsersToCheck U on T1.[OldUserID] = U.[UserID]
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, testCustomers')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[testCustomers] T1 join #UsersToCheck U on T1.[UserID] = U.[UserID]
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	
 

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, testup')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[testup] T1 join #UsersToCheck U on T1.[uID] = U.[UserID]
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	
 
 
 
 
 
 
 
 

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, tmpARAImport')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[tmpARAImport] T1 join #UsersToCheck U on T1.[NCUUserID] = U.[UserID]
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, tmpCleanNcu')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[tmpCleanNcu] T1 join #UsersToCheck U on T1.[UserID] = U.[UserID]
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	
 
 
 

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, tmpSunbeltTest')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[tmpSunbeltTest] T1 join #UsersToCheck U on T1.[uID] = U.[UserID]
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, tmpSunbeltTest2')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[tmpSunbeltTest2] T1 join #UsersToCheck U on T1.[uID] = U.[UserID]
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, tmpSunbeltTest3')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[tmpSunbeltTest3] T1 join #UsersToCheck U on T1.[tUID] = U.[UserID]
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	
 

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, tmpSunbeltTest5')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[tmpSunbeltTest5] T1 join #UsersToCheck U on T1.[uID] = U.[UserID]
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	
 

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, TriggerErrorLogTable')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[TriggerErrorLogTable] T1 join #UsersToCheck U on T1.[sUID] = U.[UserID]
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, TS_Actives')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[TS_Actives] T1 join #UsersToCheck U on T1.[BackofficeUserID] = U.[UserID]
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	
 
 
 
 

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, ts_Import_Results')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[ts_Import_Results] T1 join #UsersToCheck U on T1.[calc_userid] = U.[UserID]
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	
 

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, TS_Sunbelt_Import')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[TS_Sunbelt_Import] T1 join #UsersToCheck U on T1.[calc_userid] = U.[UserID]
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, TS_TermsAndConditions_Log')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[TS_TermsAndConditions_Log] T1 join #UsersToCheck U on T1.[TCuID] = U.[UserID]
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	
 
 
 

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, TSPrefsToNBO')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[TSPrefsToNBO] T1 join #UsersToCheck U on T1.[BackofficeUserID] = U.[UserID]
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	
 
 
 

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, UpdatedAddressList')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[UpdatedAddressList] T1 join #UsersToCheck U on T1.[auid] = U.[UserID]
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, UpdatedItemsTemp')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[UpdatedItemsTemp] T1 join #UsersToCheck U on T1.[UserID] = U.[UserID]
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, UpdatedUserList')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[UpdatedUserList] T1 join #UsersToCheck U on T1.[userid] = U.[UserID]
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	
 

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, us_insurer_supps_orders')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[us_insurer_supps_orders] T1 join #UsersToCheck U on T1.[oUID] = U.[UserID]
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, US_TS$')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[US_TS$] T1 join #UsersToCheck U on T1.[UID] = U.[UserID]
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, userActivity')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[userActivity] T1 join #UsersToCheck U on T1.[userid] = U.[UserID]
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, Userdata')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[Userdata] T1 join #UsersToCheck U on T1.[newuserid] = U.[UserID]
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, UserDetailChanges')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[UserDetailChanges] T1 join #UsersToCheck U on T1.[uID] = U.[UserID]
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, UserDetailChanges')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[UserDetailChanges] T1 join #UsersToCheck U on T1.[userid] = U.[UserID]
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, UserDetails_InstantASP_Users')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[UserDetails_InstantASP_Users] T1 join #UsersToCheck U on T1.[InstantASP_Users_UserID] = U.[UserID]
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, UserDetails_InstantASP_Users')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[UserDetails_InstantASP_Users] T1 join #UsersToCheck U on T1.[UserDetails_uID] = U.[UserID]
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, UserDetails_Stage')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[UserDetails_Stage] T1 join #UsersToCheck U on T1.[uID] = U.[UserID]
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, UserDetails_Stage')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[UserDetails_Stage] T1 join #UsersToCheck U on T1.[userid] = U.[UserID]
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, UserEmailAlertsAudit')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[UserEmailAlertsAudit] T1 join #UsersToCheck U on T1.[UserID] = U.[UserID]
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	
 
 	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, UserNewsletterCriteria')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[UserNewsletterCriteria] T1 join [dbo].[UserNewsletter] T2 on T1.UserNewsLetterId = T2.UserNewsLetterId join #UsersToCheck U on T2.[UserId] = U.[UserID]
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, UserNewsletter')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[UserNewsletter] T1 join #UsersToCheck U on T1.[UserId] = U.[UserID]
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	
 

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, UserPreferences')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[UserPreferences] T1 join #UsersToCheck U on T1.[UserId] = U.[UserID]
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, Users_NPAS_1643_Backup')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[Users_NPAS_1643_Backup] T1 join #UsersToCheck U on T1.[uID] = U.[UserID]
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, userTracking')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[userTracking] T1 join #UsersToCheck U on T1.[userid] = U.[UserID]
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	
 
 
 
 
 
 

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, Addresses')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'disabling trigger...')
			;disable trigger dbo.DELETE_Repl_Adresses_Tr2 on dbo.Addresses
			begin transaction
			delete top (4500) t1 from [dbo].[Addresses] T1 join [dbo].[UserDetails] T2 on T1.[aUID] = T2.[uID] join #UsersToCheck U on T2.[uID] = U.[UserID]
			select @deleteCount = @@rowcount
			commit
			-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'disabling trigger...')
			;enable trigger dbo.DELETE_Repl_Adresses_Tr2 on dbo.Addresses
		end try
		begin catch
			if @@trancount > 0
				rollback
			;enable trigger dbo.DELETE_Repl_Adresses_Tr2 on dbo.Addresses
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, Addresses')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'disabling trigger 2 ...')
			;disable trigger dbo.DELETE_Repl_Adresses_Tr2 on dbo.Addresses
			begin transaction
			delete top (4500) t1 from [dbo].[Addresses] T1 join #UsersToCheck U on T1.[aUID] = U.[UserID]
			select @deleteCount = @@rowcount
			commit
			-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'disabling trigger 2 ...')
			;enable trigger dbo.DELETE_Repl_Adresses_Tr2 on dbo.Addresses
		end try
		begin catch
			if @@trancount > 0
				rollback
			;enable trigger dbo.DELETE_Repl_Adresses_Tr2 on dbo.Addresses
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	

	-- insert into AutoArchiving_Debug (alid, message) values (@logRecordId, 'dbo, UserDetails')
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete top (4500) t1 from [dbo].[UserDetails] T1 join #UsersToCheck U on T1.[uID] = U.[UserID]
			select @deleteCount = @@rowcount
			commit
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage], [aeUserIds])
			select @logRecordId, error_line(), error_message(), string_agg(userid, ',')
			from #UsersToCheck
			goto WAYOUT
		end catch 
	end	

	WAYOUT:

	delete tu from #OldUsers tu join #UsersToCheck ch on tu.UserID = ch.UserID
	delete from #UsersToCheck

	insert #UsersToCheck select top(@selectByN) userid, username from #OldUsers
	set @thereAreSomeMoreUsers = @@rowcount

	-- current step
	set @step = @step + 1
	set @progress = ceiling((@step*100)/@steps) - @stepValue

	declare @hasErrors bit
	set @hasErrors = (select top 1 1 from [NewCentralUsers].[dbo].[AutoArchiving_Errors] where aeAlId = @logRecordId)

	update [NewCentralUsers].[dbo].[AutoArchiving_Log]
	set [alProgressPercent] = @progress,
		[alLastUpdatedAtUtc] = getutcdate(),
		[alhasErrors] = @hasErrors
	where alId = @logRecordId

end /* MAIN */

update [NewCentralUsers].[dbo].[AutoArchiving_Log]
set [alFinishedAtUtc] = getutcdate(),
	[alLastUpdatedAtUtc] = getutcdate(),
	[alProgressPercent] = 100
where alId = @logRecordId

drop table if exists #UsersToCheck;
drop table if exists #OldUsers;

