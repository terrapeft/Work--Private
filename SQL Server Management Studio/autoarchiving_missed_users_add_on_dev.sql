/*
delete from NewCentralUsers.dbo.userdetails
where uemailaddress = 'bademail@ssis.fix'
*/


set identity_insert userdetails  on
--insert into NewCentralUsers.dbo.userdetails (uid, uEmailAddress) values (5168885, 'bademail@ssis.fix')
--insert into NewCentralUsers.dbo.userdetails (uid, uEmailAddress) values (5212038, 'bademail2@ssis.fix')
--insert into NewCentralUsers.dbo.userdetails (uid, uEmailAddress) values (1471247, 'bademail2@ssis.fix')
insert into NewCentralUsers.dbo.userdetails (uid, uEmailAddress) values (5160168, 'bademail2@ssis.fix')
insert into NewCentralUsers.dbo.userdetails (uid, uEmailAddress) values (5153133, 'bademail2@ssis.fix')
insert into NewCentralUsers.dbo.userdetails (uid, uEmailAddress) values (5057161, 'bademail2@ssis.fix')
insert into NewCentralUsers.dbo.userdetails (uid, uEmailAddress) values (1622198, 'bademail2@ssis.fix')
insert into NewCentralUsers.dbo.userdetails (uid, uEmailAddress) values (1428196, 'bademail2@ssis.fix')

set identity_insert userdetails  off


select * from NewCentralUsers.dbo.userdetails
where uid in (5168885, 5212038, 1471247,5057161,
5160168,
5153133,
5057161,
1622198,
1428196
)

