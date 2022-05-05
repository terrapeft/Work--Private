use newcentralusers
go

drop table if exists AutoArchiving_Errors;
drop table if exists AutoArchiving_Log;
go

create table [NewCentralUsers].[dbo].[AutoArchiving_Log] (
	[alId] int identity(1,1) not null primary key,
	[alStartedAtUtc] datetime not null default getutcdate(),
	[alFinishedAtUtc] datetime,
	[alLastUpdatedAtUtc] datetime not null,
	[alUsersCount] int,
	[alProgressPercent] int,
	[alDatabaseName] varchar(15) default 'NewCentralUsers',
	[alHasErrors] bit
) on [primary]

go

create table [NewCentralUsers].[dbo].[AutoArchiving_Errors] (
	[aeId] int identity(1,1) not null,
	[aeAlId] int not null,
	[aeErrorLine] int,
	[aeErrorMessage] nvarchar(4000),
	constraint FK_AutoArchivingErrors_AutoArchivingLog foreign key ([aeAlId]) references [NewCentralUsers].[dbo].[AutoArchiving_Log] ([alId])
) on [primary]

go

/*
alter table [NewCentralUsers].[dbo].[AutoArchiving_Log]
drop column [alDatabaseName]

alter table [NewCentralUsers].[dbo].[AutoArchiving_Log]
add [alDatabaseName] varchar(15) default 'NewCentralUsers'

update [NewCentralUsers].[dbo].[AutoArchiving_Log]
set [alDatabaseName] = 'NewCentralUsers'

select l.*, n.adname
from AutoArchiving_Log l join AutoArchiving_DbNames n on aldatabaseid = adid
--where aldatabaseid = 2
order by [alStartedAtUtc] desc


select * from [AutoArchiving_Errors]
where aealid = 37

*/



select sum(alUsersCount)
from AutoArchiving_Log
where aldatabasename <> 'backoffice'
group by cast (alStartedAtUtc as date)


