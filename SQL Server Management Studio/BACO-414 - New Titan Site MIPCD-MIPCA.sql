use [NewCentralUsers]

declare @stID int;

insert into [NewCentralUsers].[dbo].[Statuses]
(stPID, stName, stMask, stCheckSession, stCheckGUID)
values
(5027, 'Subscription', 4 ,0 ,0)

select @stID = scope_identity()
print 'StatusId: ' + cast(@stID as char(100));

