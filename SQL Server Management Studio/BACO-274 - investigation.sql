-- *1* issue on line 186 - caused by users in order, The DELETE statement conflicted with the REFERENCE constraint "FK__MPUserCat__Event__5DD7730A". The conflict occurred in database "NewCentralUsers", table "dbo.MPUserCategories", column 'EventNcuUserId'.
/*
-- 1943562 alex@tg.lv_OLD
select * from mpusercategories where EventNcuUserId = 1943562

select euuserid, euforenames, eusurname, euaddressid, oid, ouid, t3.uusername, t4.uusername
from [dbo].[EventNcuUsers] T1 
join [dbo].[Orders] T2 on T1.[euOrderID] = T2.[oId] 
join userdetails t3 on t1.euuserid = t3.uid
join userdetails t4 on t2.ouid = t4.uid
where T2.[oUID] = 1943562

begin tran
 
--delete from mpusercategories where EventNcuUserId = 1943562

delete c from mpusercategories c join EventNcuUsers eu on c.eventncuuserid = eu.euId join Orders o on eu.euOrderID = o.oID
where oUID = 1943562

delete d from MPEventUserDetails d join EventNcuUsers eu on d.eventncuuserid = eu.euId join Orders o on eu.euOrderID = o.oID
where oUID = 1943562

delete t1 from [dbo].[EventNcuUsers] T1 join [dbo].[Orders] T2 on T1.[euOrderID] = T2.[oId] where T2.[oUID] = 1943562

rollback tran
*/

-- *2* line 244, The DELETE statement conflicted with the SAME TABLE REFERENCE constraint "FK_MPCommunication_MPCommunication". The conflict occurred in database "NewCentralUsers", table "dbo.MPCommunication", column 'ResponseId'.
--1944211 brodriguez@bts-usa.com 


begin tran

drop table if exists #comm_temp

;with comm_to as
(
	select c.Id, c.responseId, a.userId, 0 as Level
	from mpcommunication c join mpattendee a on (c.toattendeeid = a.id or c.fromattendeeid = a.id)
	where a.userid = 1944211
	union all
	select c.Id, c.responseId, a.userId, Level + 1
	from mpcommunication c join mpattendee a on (c.toattendeeid = a.id or c.fromattendeeid = a.id) 
	join comm_to cm on c.id = cm.ResponseId
)
select distinct * from comm_to


;with comm_to as
(
	select c.Id, c.responseId, a.userId, 0 as Level
	from mpcommunication c, mpattendee a
	where (c.toattendeeid = a.id)
	and a.userid = 1944211
	union all
	select c.Id, c.responseId, a.userId, Level + 1
	from mpcommunication c, mpattendee a, comm_to cm
	where (c.toattendeeid = a.id)
	and c.id = cm.ResponseId
)
select * from comm_to

into #comm_temp from comm_to order by id desc

;with comm_from as
(
	select c.Id, c.responseId, a.userId, 0 as Level
	from mpcommunication c join mpattendee a on c.fromattendeeid = a.id
	where a.userid = 1944211
	union all
	select c.Id, c.responseId, a.userId, Level + 1
	from mpcommunication c join mpattendee a on c.fromattendeeid = a.id
	join comm_from cm on c.id = cm.ResponseId
)
select * from comm_from
insert into #comm_temp 
select * from comm_from order by id desc

--select * from #comm_temp
delete c
from [dbo].[MPCommunicationFlags] c
join #comm_temp t on c.Id = t.Id --and c.userid = t.UserId

select *
from [dbo].[MPCommunicationFlags] c
join #comm_temp t on c.Id = t.Id --and c.userid = t.UserId

delete from mpcommunication where Id in (
	select Id 
	from #comm_temp
)

--select * from mpcommunication where Id in (
--	select Id 
--	from #comm_temp
--)


rollback


