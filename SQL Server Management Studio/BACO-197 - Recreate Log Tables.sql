use newcentralusers;

drop table if exists AutoArchiving_Errors;
drop table if exists AutoArchiving_Log;
drop table if exists AutoArchiving_DbNames;

go

create table [NewCentralUsers].[dbo].[AutoArchiving_DbNames] (
	[adId] int not null primary key,
	[adName] varchar(15)
);

go

insert into [NewCentralUsers].[dbo].[AutoArchiving_DbNames] values
(1, 'NewCentralUsers'),
(2, 'BackOffice')

go

create table [NewCentralUsers].[dbo].[AutoArchiving_Log] (
	[alId] int identity(1,1) not null primary key,
	[alStartedAtUtc] datetime not null default getutcdate(),
	[alFinishedAtUtc] datetime,
	[alLastUpdatedAtUtc] datetime not null,
	[alUsersCount] int,
	[alProgressPercent] int,
	[alDatabaseId] int default 1,
	[alHasErrors] bit,
	constraint FK_AutoArchivingLog_AutoArchivingDbNames foreign key ([alDatabaseId]) references [NewCentralUsers].[dbo].[AutoArchiving_DbNames] ([adId])
) on [primary];

go

create table [NewCentralUsers].[dbo].[AutoArchiving_Errors] (
	[aeId] int identity(1,1) not null,
	[aeAlId] int not null,
	[aeErrorLine] int,
	[aeErrorMessage] nvarchar(4000),
	[aeUserIds] nvarchar(max),
	[aeDate] datetime default getdate()
	constraint FK_AutoArchivingErrors_AutoArchivingLog foreign key ([aeAlId]) references [NewCentralUsers].[dbo].[AutoArchiving_Log] ([alId])
) on [primary];

go

