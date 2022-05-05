drop table if exists AutoArchiving_Errors;

create table [NewCentralUsers].[dbo].[AutoArchiving_Errors] (
	[aeId] int identity(1,1) not null,
	[aeAlId] int not null,
	[aeErrorLine] int,
	[aeErrorMessage] nvarchar(4000),
	[aeUserIds] nvarchar(max),
	[aeDate] datetime default getdate()
	constraint FK_AutoArchivingErrors_AutoArchivingLog foreign key ([aeAlId]) references [NewCentralUsers].[dbo].[AutoArchiving_Log] ([alId])
) on [primary];
