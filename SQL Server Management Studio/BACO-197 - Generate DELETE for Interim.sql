declare @sql nvarchar(max)

set @sql = N'
	set @startTime = getdate()
	set @deleteCount = 4500
	while @deleteCount = 4500
	begin
		begin try
			begin transaction
			delete	top (4500) {table}
			from	{table} t
			join	#UsersToCheck utc on t.{column} = utc.userid
			select @deleteCount = @@rowcount
			print ''{table}: '' + cast (@deleteCount as varchar(10))
			commit transaction with (delayed_durability = on)
		end try
		begin catch
			if @@trancount > 0
				rollback
			set @deleteCount = 0
			print ''Error on line '' + cast(error_line() as varchar(10)) + '', '' + error_message()
			insert into [NewCentralUsers].[dbo].[AutoArchiving_Errors] ([aeAlId], [aeErrorLine], [aeErrorMessage])
			values (@logRecordId, error_line(), error_message())
		end catch
	end
	print ''Took '' + cast(datediff(ss, @startTime, getdate()) as varchar(10)) + '' seconds.'''

declare @cursor as cursor
declare @table as varchar(1024)
declare @column as varchar(1024)

set @cursor = cursor for
	select 'Backoffice.' + schema_name(t.schema_id) + '.' + t.name as TableName--, c.Name
	from sys.tables t
	--join sys.columns c on c.object_id = t.object_id
	where schema_name(t.schema_id) = 'Interim' 
		  and t.name in ('ContactPref_Stage',
'LogonUsers_Stage',
'RejectedContactPref',
'RejectedUserAddress',
'RejectedUsers',
'Repl_Add_Sub_With_Order',
'Repl_NCUNBOProductMap',
'Subscription_Stage',
'SubscriptionUser_Stage',
'SubscriptionUserExcluded_Stage',
'SubsNotinNCU',
'UserDefaultCommunication_Stage',
'UserGroupSubscription_Stage',
'UserGroupSubscriptionIpRange_Stage',
'ActiveUserContacAddress_Stage',
'Addresses',
'AddressUCAMap',
'LandingPage_Stage',
'Orders',
'Orders_Stage',
'Repl_NCUNBOProductMap',
'Subscription_Stage',
'SubscriptionUser_Stage',
'SubscriptionUserExcluded_Stage',
'SubsNotinNCU',
'UserContactAddress_Stage',
'UserDefaultCommunication_Stage',
'UserDetails')
	order by T.name

open @cursor
fetch next from @cursor into @table--, @column
while @@fetch_status = 0
begin
	--print replace(replace(@sql, '{table}', @table), '{column}', @column)
	print replace(@sql, '{table}', @table)
	fetch next from @cursor into @table--, @column
end

close @cursor
deallocate @cursor
