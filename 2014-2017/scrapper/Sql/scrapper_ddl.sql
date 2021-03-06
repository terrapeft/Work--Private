/*
Generated in MSSMS by Vitaly Chupaev.

Checks the object existance, drops it, if found, then creates.
List of items:

*** Types:
 [ForeignOrganizationProducts] - used to pass DataTable to stored procedure


*** Tables:
 [FOP] - keeps scraped data
 [FOPAuidit] - keeps changes, has no reference on FOP to support delete without deletion of audit, stores original values
 [FOPAction] - Insert/Update/Delete
 [FOPBatch] - used to generate BatchId and keep consistancy


*** Triggers:
 [trFOPDelete] - inserts audit trail with time and user
 [trFOPUpdate] - inserts audit trail with time and user
 [trFOPInsert] - inserts audit trail with time and user
 

*** Views:
 [FOPHistory] - shows all actions on data


*** Stored procedures

 [spFOPCompareAndInsertRecord] - expects data table of type [ForeignOrganizationProducts] and user name, 
								 compares table with the most recent row set, stores new data only if changes were found, 
								 otherwise logs an attempt (action CHECK)
								 
 [spFOPSelectChangesByDate] - expects two dates, compares ONLY date part, without time, returns 3 sets: added, deleted and differences.
							  for original columns Status, Date and Remarks it returns set like 'Status1' and 'Status2', etc., 
							  the value in this columns is displayed only if it had changed, 
							  if no changes, there will be null, thus you do not need to compare fields for changes,
							  Organization + ProductName are always shown as a KEY

 [spFOPSelectChangesByBatchId] - Behaves mostly the same as [spFOPSelectChangesByDate], but expects batch ids, this is useful, when batches were created in one day.
							  Also have two additional parameters - @quote bit and @quoteWith nvarchar(1) - they used to quote all fields, when @quote is 1, 
							  defaults - zero and single quote respectively, useful for email report, where the ability to separate fields in attachemnt is absent.

*/

/****** Object:  ForeignKey [FK_FOP_Batch]    Script Date: 11/03/2015 20:11:38 ******/
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_FOP_Batch]') AND parent_object_id = OBJECT_ID(N'[dbo].[FOP]'))
ALTER TABLE [dbo].[FOP] DROP CONSTRAINT [FK_FOP_Batch]
GO
/****** Object:  ForeignKey [FK_FOPAudit_FOPAction]    Script Date: 11/03/2015 20:11:38 ******/
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_FOPAudit_FOPAction]') AND parent_object_id = OBJECT_ID(N'[dbo].[FOPAudit]'))
ALTER TABLE [dbo].[FOPAudit] DROP CONSTRAINT [FK_FOPAudit_FOPAction]
GO
/****** Object:  StoredProcedure [dbo].[spFOPSelectChangesByDate]    Script Date: 11/03/2015 20:11:38 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spFOPSelectChangesByDate]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spFOPSelectChangesByDate]
GO
/****** Object:  View [dbo].[FOPHistory]    Script Date: 11/03/2015 20:11:38 ******/
IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[FOPHistory]'))
DROP VIEW [dbo].[FOPHistory]
GO
/****** Object:  StoredProcedure [dbo].[spFOPCompareAndInsertRecord]    Script Date: 11/03/2015 20:11:38 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spFOPCompareAndInsertRecord]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spFOPCompareAndInsertRecord]
GO
/****** Object:  StoredProcedure [dbo].[spFOPSelectChangesByBatchId]    Script Date: 11/03/2015 20:11:38 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spFOPSelectChangesByBatchId]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spFOPSelectChangesByBatchId]
GO
/****** Object:  Table [dbo].[FOP]    Script Date: 11/03/2015 20:11:38 ******/
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_FOP_Batch]') AND parent_object_id = OBJECT_ID(N'[dbo].[FOP]'))
ALTER TABLE [dbo].[FOP] DROP CONSTRAINT [FK_FOP_Batch]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FOP]') AND type in (N'U'))
DROP TABLE [dbo].[FOP]
GO
/****** Object:  Table [dbo].[FOPAudit]    Script Date: 11/03/2015 20:11:38 ******/
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_FOPAudit_FOPAction]') AND parent_object_id = OBJECT_ID(N'[dbo].[FOPAudit]'))
ALTER TABLE [dbo].[FOPAudit] DROP CONSTRAINT [FK_FOPAudit_FOPAction]
GO
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_FOPAudit_Timestamp]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[FOPAudit] DROP CONSTRAINT [DF_FOPAudit_Timestamp]
END
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FOPAudit]') AND type in (N'U'))
DROP TABLE [dbo].[FOPAudit]
GO
/****** Object:  Table [dbo].[FOPBatch]    Script Date: 11/03/2015 20:11:38 ******/
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_Batch_Timestamp]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[FOPBatch] DROP CONSTRAINT [DF_Batch_Timestamp]
END
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FOPBatch]') AND type in (N'U'))
DROP TABLE [dbo].[FOPBatch]
GO
/****** Object:  Table [dbo].[FOPAction]    Script Date: 11/03/2015 20:11:38 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FOPAction]') AND type in (N'U'))
DROP TABLE [dbo].[FOPAction]
GO
/****** Object:  UserDefinedTableType [dbo].[ForeignOrganizationProducts]    Script Date: 11/03/2015 20:11:39 ******/
IF  EXISTS (SELECT * FROM sys.types st JOIN sys.schemas ss ON st.schema_id = ss.schema_id WHERE st.name = N'ForeignOrganizationProducts' AND ss.name = N'dbo')
DROP TYPE [dbo].[ForeignOrganizationProducts]
GO
/****** Object:  UserDefinedTableType [dbo].[ForeignOrganizationProducts]    Script Date: 11/03/2015 20:11:39 ******/
IF NOT EXISTS (SELECT * FROM sys.types st JOIN sys.schemas ss ON st.schema_id = ss.schema_id WHERE st.name = N'ForeignOrganizationProducts' AND ss.name = N'dbo')
CREATE TYPE [dbo].[ForeignOrganizationProducts] AS TABLE(
	[Organization] [nvarchar](250) NULL,
	[ProductName] [nvarchar](500) NULL,
	[Status] [nvarchar](100) NULL,
	[Date] [nvarchar](10) NULL,
	[Remarks] [nvarchar](max) NULL
)
GO
/****** Object:  Table [dbo].[FOPAction]    Script Date: 11/03/2015 20:11:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FOPAction]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[FOPAction](
	[FOPActionId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[Description] [nvarchar](100) NULL,
 CONSTRAINT [PK_FOPAction] PRIMARY KEY CLUSTERED 
(
	[FOPActionId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET IDENTITY_INSERT [dbo].[FOPAction] ON
INSERT [dbo].[FOPAction] ([FOPActionId], [Name], [Description]) VALUES (1, N'INSERT    ', NULL)
INSERT [dbo].[FOPAction] ([FOPActionId], [Name], [Description]) VALUES (2, N'UPDATE    ', NULL)
INSERT [dbo].[FOPAction] ([FOPActionId], [Name], [Description]) VALUES (3, N'DELETE    ', NULL)
INSERT [dbo].[FOPAction] ([FOPActionId], [Name], [Description]) VALUES (4, N'CHECK     ', N'Means the provided data was not inserted, because it matched previous record.')
SET IDENTITY_INSERT [dbo].[FOPAction] OFF
/****** Object:  Table [dbo].[FOPBatch]    Script Date: 11/03/2015 20:11:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FOPBatch]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[FOPBatch](
	[FOPBatchId] [int] IDENTITY(1,1) NOT NULL,
	[Timestamp] [datetime] NOT NULL CONSTRAINT [DF_Batch_Timestamp]  DEFAULT (getdate()),
 CONSTRAINT [PK_Batch] PRIMARY KEY CLUSTERED 
(
	[FOPBatchId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[FOPAudit]    Script Date: 11/03/2015 20:11:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FOPAudit]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[FOPAudit](
	[FOPAuditId] [int] IDENTITY(1,1) NOT NULL,
	[FOPId] [int] NOT NULL,
	[FOPActionId] [int] NOT NULL,
	[Timestamp] [datetime] NOT NULL CONSTRAINT [DF_FOPAudit_Timestamp]  DEFAULT (getdate()),
	[User] [nvarchar](50) NULL,
 CONSTRAINT [PK_FOPAudit] PRIMARY KEY CLUSTERED 
(
	[FOPAuditId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[FOP]    Script Date: 11/03/2015 20:11:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FOP]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[FOP](
	[FOPId] [int] IDENTITY(1,1) NOT NULL,
	[FOPBatchId] [int] NOT NULL,
	[Organization] [nvarchar](250) NULL,
	[ProductName] [nvarchar](500) NULL,
	[Status] [nvarchar](100) NULL,
	[Date] [nvarchar](50) NULL,
	[Remarks] [nvarchar](max) NULL,
 CONSTRAINT [PK_FOP] PRIMARY KEY CLUSTERED 
(
	[FOPId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  StoredProcedure [dbo].[spFOPSelectChangesByBatchId]    Script Date: 11/03/2015 20:11:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spFOPSelectChangesByBatchId]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'/*

First set contains products which appear in the second day, but do not present in the first
Second set contains products which only present in the first day
Third set contains differences in columns other then Organization and ProductName

*/
CREATE procedure [dbo].[spFOPSelectChangesByBatchId]
@firstBatchId int,
@secondBatchId int,
@quote bit = 0,
@quotWith varchar(1) = ''''''''
AS
BEGIN

	-- Organization + ProductName treated as a KEY.
	-- All comparisons are done on this assumption.

	-- added records, those which are present in second day but not in the first, compared by KEY
	with FirstDay (Organization, ProductName, [Status], [Date], Remarks) as
	(	select Organization, ProductName, [Status], [Date], Remarks
		from fopbatch b join fop f on b.fopbatchid = f.fopbatchid
		where b.fopbatchId = @firstBatchId),
	SecondDay (Organization, ProductName, [Status], [Date], Remarks) as
	(	select Organization, ProductName, [Status], [Date], Remarks
		from fopbatch b join fop f on b.fopbatchid = f.fopbatchid
		where b.fopbatchId = @secondBatchId)
	select 
		case @quote when 0 then SecondDay.Organization else @quotWith + SecondDay.Organization + @quotWith end as [Organization], 
		case @quote when 0 then SecondDay.ProductName else @quotWith + SecondDay.ProductName + @quotWith end as [ProductName], 
		case @quote when 0 then SecondDay.[Status] else @quotWith + SecondDay.[Status] + @quotWith end as [Status], 
		case @quote when 0 then SecondDay.[Date] else @quotWith + cast(SecondDay.[Date] as nvarchar(30)) + @quotWith end as [Date], 
		case @quote when 0 then SecondDay.Remarks else @quotWith + SecondDay.Remarks + @quotWith end as [Remarks]
	from FirstDay right outer join SecondDay on FirstDay.Organization = SecondDay.Organization and FirstDay.ProductName = SecondDay.ProductName
	where FirstDay.Organization is null or FirstDay.ProductName is null;

	-- deleted records, the ones that only present in the first day set
	with FirstDay (Organization, ProductName, [Status], [Date], Remarks) as
	(	select Organization, ProductName, [Status], [Date], Remarks
		from fopbatch b join fop f on b.fopbatchid = f.fopbatchid
		where b.fopbatchId = @firstBatchId),
	SecondDay (Organization, ProductName, [Status], [Date], Remarks) as
	(	select Organization, ProductName, [Status], [Date], Remarks
		from fopbatch b join fop f on b.fopbatchid = f.fopbatchid
		where b.fopbatchId = @secondBatchId)
	select 
		case @quote when 0 then FirstDay.Organization else @quotWith + FirstDay.Organization + @quotWith end as [Organization], 
		case @quote when 0 then FirstDay.ProductName else @quotWith + FirstDay.ProductName + @quotWith end as [ProductName], 
		case @quote when 0 then FirstDay.[Status] else @quotWith + FirstDay.[Status] + @quotWith end as [Status], 
		case @quote when 0 then FirstDay.[Date] else @quotWith + cast(FirstDay.[Date] as nvarchar(30)) + @quotWith end as [Date], 
		case @quote when 0 then FirstDay.Remarks else @quotWith + FirstDay.Remarks + @quotWith end as [Remarks]
	from FirstDay left outer join SecondDay on FirstDay.Organization = SecondDay.Organization and FirstDay.ProductName = SecondDay.ProductName
	where SecondDay.Organization is null or SecondDay.ProductName is null;

	-- records with differences, 
	-- for all the columns in the CASE clause, the value is displayed only if it had changed, 
	-- if no changes to this column, there will be null, thus you do not need to compare fields for changes,
	-- Organization + ProductName are always shown as a KEY
	with FirstDay (Organization, ProductName, [status], [date], remarks) as
	(	select organization, productname, [status], [date], remarks
		from fopbatch b join fop f on b.fopbatchid = f.fopbatchid
		where b.fopbatchId = @firstBatchId),
	SecondDay (Organization, ProductName, [status], [date], remarks) as
	(	select organization, productname, [status], [date], remarks
		from fopbatch b join fop f on b.fopbatchid = f.fopbatchid
		where b.fopbatchId = @secondBatchId)
	select 
		case @quote when 0 then Organization else @quotWith + Organization + @quotWith end as [Organization], 
		case @quote when 0 then ProductName else @quotWith + ProductName + @quotWith end as [ProductName], 
		case @quote when 0 then [Status1] else @quotWith + [Status1] + @quotWith end as [Status1], 
		case @quote when 0 then [Status2] else @quotWith + [Status2] + @quotWith end as [Status2], 
		case @quote when 0 then [Date1] else @quotWith + cast([Date1] as nvarchar(30)) + @quotWith end as [Date1], 
		case @quote when 0 then [Date2] else @quotWith + cast([Date2] as nvarchar(30)) + @quotWith end as [Date2], 
		case @quote when 0 then Remarks1 else @quotWith + Remarks1 + @quotWith end as [Remarks1],
		case @quote when 0 then Remarks2 else @quotWith + Remarks2 + @quotWith end as [Remarks2]
	from (
		select d.Organization, d.ProductName,
			case when (isnull(f.[status], '''') != isnull(d.[status], '''')) then f.[status] else null end as Status1,
			case when (isnull(f.[status], '''') != isnull(d.[status], '''')) then d.[status] else null end as Status2,
			case when (isnull(f.[date], '''') != isnull(d.[date], '''')) then f.[date] else null end as Date1,
			case when (isnull(f.[date], '''') != isnull(d.[date], '''')) then d.[date] else null end as Date2,
			case when (isnull(f.remarks, '''') != isnull(d.remarks, '''')) then f.remarks else null end as Remarks1,
			case when (isnull(f.remarks, '''') != isnull(d.remarks, '''')) then d.remarks else null end as Remarks2
		from FirstDay f, SecondDay d
		where (f.Organization = d.Organization and f.ProductName = d.ProductName)) as t2
	-- remove empty rows
	where ([status1] is not null or [date1] is not null or [remarks1] is not null or [status2] is not null or [date2] is not null or [remarks2] is not null);

END' 
END
GO
/****** Object:  StoredProcedure [dbo].[spFOPCompareAndInsertRecord]    Script Date: 11/03/2015 20:11:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spFOPCompareAndInsertRecord]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[spFOPCompareAndInsertRecord]
	@data ForeignOrganizationProducts readonly,
	@recipients varchar(max),
	@mail_profile sysname,
	@user nvarchar (50) = null,
	@subject_text nvarchar(100) = NULL
AS
BEGIN

SET XACT_ABORT ON;
begin transaction;

if (@subject_text is null)
	set @subject_text = ''Sirt page report ['' + cast (getdate() as nvarchar(30)) + '']'';

declare @batchId1 int
declare @batchId2 int
declare @insertTable table (Id int);
declare @id int;
declare @lastSet ForeignOrganizationProducts;
declare @changesCounter int = 0;
declare @result int = 0;

declare @added int = 0, @deleted int = 0, @updated int = 0, @firstRun int = 0;

-- get the most recent set
set @batchId1 = (select MAX(FOPBatchId) from FOPBatch);

if (@batchId1 is null)
begin
	set @changesCounter = 1
	set @firstRun = 1
end
else begin
	insert into @lastSet
	select Organization, ProductName, [status], [Date], Remarks 
	from FOP
	where FOPBatchId = @batchId1;
end

-- compare with proposed and insert if any changes found

if (@firstRun = 0)
begin

-- any new?
	set @added = (select COUNT(*) from (
		select Organization, ProductName
		from @data
		except
		select Organization, ProductName
		from @lastSet) as t1);

-- smth was deleted?	
	set @deleted = (select COUNT(*) from (
		select Organization, ProductName
		from @lastSet
		except
		select Organization, ProductName
		from @data) as t1);

-- finally - any changes to existed?
	with FirstDay (Organization, ProductName, [status], [Date], Remarks) as
	(	select organization, productname, [status], [date], remarks
		from @lastSet),

	SecondDay (Organization, ProductName, [status], [Date], Remarks) as
	(	select organization, 
			productname, 
			[status], 
			CAST([date] as date),
			remarks
		from @data)

	select @updated = COUNT(*)
	from FirstDay f, SecondDay d
	where (f.Organization = d.Organization and f.ProductName = d.ProductName)
	and	  (f.[status] <> d.[status] or f.[date] <> d.[date] or f.[remarks] <> d.[remarks]);
	
	set @changesCounter = @updated + @added + @deleted;
end

IF 	@changesCounter = 0
begin
	-- insert audit record with domain user
	insert into FOPAudit (FOPId, FOPActionId, [User])
	values (-1, 4, @user)

	set @result = 100; -- no changes
	goto FINISH;
end

-- Create batch
insert into FOPBatch default values;
set @batchId2 = (select MAX(FOPBatchId) from FOPBatch);

-- disable trigger to insert a domain user, otherwise a db user will be logged
ALTER TABLE FOP DISABLE TRIGGER trFOPInsert

insert into FOP (FOPBatchId, Organization, ProductName, [Status], [Date], Remarks)
output inserted.FOPId into @insertTable 
select @batchId2, 
	Organization, 
	ProductName, 
	[Status], 
	--CONVERT(date, CASE ISDATE([Date]) WHEN 1 THEN [Date] ELSE NULL END, 103),
	CAST([date] as date),
	Remarks 
from @data;

ALTER TABLE FOP ENABLE TRIGGER trFOPInsert

-- insert audit record with domain user
insert into FOPAudit (FOPId, FOPActionId, [User])
select Id, 1, @user from @insertTable

set @result = 101;

FINISH:

commit transaction;

declare @changes nvarchar(1000);

if (@firstRun = 1)
	set @changes = ''first run''
else
begin
	set @changes = ''<br>New Organizations or Products: '' + cast(@added as nvarchar(10))
	set @changes = @changes + '',<br>Removed Organizations or Products: '' + cast(@deleted as nvarchar(10))
	set @changes = @changes + '',<br>Data changes: '' + cast(@updated as nvarchar(10))
end

declare @query_text nvarchar(1000) = 
	case when @result = 101 and @firstRun = 0 then ''[dbo].[spFOPSelectChangesByBatchId] '' 
		+ ''@firstBatchId = '' + cast(@batchId1 as nvarchar(10)) + '', '' 
		+ ''@secondBatchId = '' + cast(@batchId2 as nvarchar(10)) + '', ''
		+ ''@quote = 1''
	else NULL end;

declare @attach_as_file bit = case when @result = 101 and @firstRun = 0 then 1 else 0 end;
declare @exclude_output bit = case when @result = 101 and @firstRun = 0 then 1 else 0 end;
declare @no_padding bit = case when @result = 101 and @firstRun = 0 then 1 else 0 end;

declare @body_text nvarchar(1000) = ''Result: '' + 
	case @result 
		when 100 then ''no changes found'' 
		when 101 then ''data added, '' + @changes
		else ''unknown result code '' + cast(@result as nvarchar(10)) end;

EXEC msdb.dbo.sp_send_dbmail @profile_name=@mail_profile,
@recipients=@recipients,
@subject=@subject_text,
@body=@body_text,
@body_format=''HTML'',
@query = @query_text,
@execute_query_database = ''_Test_'',
@attach_query_result_as_file = @attach_as_file,
@query_attachment_filename = ''changes.txt'',
@exclude_query_output = @exclude_output,
@query_result_no_padding = @no_padding,
@query_result_separator = ''  ||  ''

return @result;

END' 
END
GO
/****** Object:  View [dbo].[FOPHistory]    Script Date: 11/03/2015 20:11:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[FOPHistory]'))
EXEC dbo.sp_executesql @statement = N'CREATE VIEW [dbo].[FOPHistory]
AS
SELECT     dbo.FOPAudit.FOPId, dbo.FOPAudit.Timestamp, dbo.FOP.Organization, dbo.FOP.ProductName, dbo.FOPAction.Name AS Action, dbo.FOPAudit.[User]
FROM         dbo.FOPBatch INNER JOIN
                      dbo.FOP ON dbo.FOPBatch.FOPBatchId = dbo.FOP.FOPBatchId RIGHT OUTER JOIN
                      dbo.FOPAudit INNER JOIN
                      dbo.FOPAction ON dbo.FOPAudit.FOPActionId = dbo.FOPAction.FOPActionId ON dbo.FOP.FOPId = dbo.FOPAudit.FOPId
GROUP BY dbo.FOPAudit.FOPId, dbo.FOPAudit.Timestamp, dbo.FOP.Organization, dbo.FOP.ProductName, dbo.FOPAction.Name, dbo.FOPAudit.[User]
'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_DiagramPane1' , N'SCHEMA',N'dbo', N'VIEW',N'FOPHistory', NULL,NULL))
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[41] 4[16] 2[15] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "FOPBatch"
            Begin Extent = 
               Top = 32
               Left = 779
               Bottom = 122
               Right = 939
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "FOP"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 208
               Right = 198
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "FOPAudit"
            Begin Extent = 
               Top = 189
               Left = 447
               Bottom = 309
               Right = 607
            End
            DisplayFlags = 280
            TopColumn = 1
         End
         Begin Table = "FOPAction"
            Begin Extent = 
               Top = 178
               Left = 789
               Bottom = 283
               Right = 949
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 4935
         Width = 5070
         Width = 3540
         Width = 3945
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 12
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'FOPHistory'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_DiagramPane2' , N'SCHEMA',N'dbo', N'VIEW',N'FOPHistory', NULL,NULL))
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N'   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'FOPHistory'
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_DiagramPaneCount' , N'SCHEMA',N'dbo', N'VIEW',N'FOPHistory', NULL,NULL))
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'FOPHistory'
GO
/****** Object:  Trigger [trFOPUpdate]    Script Date: 11/03/2015 20:11:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[trFOPUpdate]'))
EXEC dbo.sp_executesql @statement = N'create trigger [dbo].[trFOPUpdate] on [dbo].[FOP]
for update
as
begin
	declare @updates table (
		id int, 
		actionId int,
		usr nvarchar(50));
	
	insert into @updates(Id, actionId, usr) 
	select FOPId, 2, USER_NAME() from deleted;

	insert into FOPAudit (FOPId, FOPActionId, [User])
	select id, actionId, usr from @updates;
end
'
GO
/****** Object:  Trigger [trFOPInsert]    Script Date: 11/03/2015 20:11:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[trFOPInsert]'))
EXEC dbo.sp_executesql @statement = N'create trigger [dbo].[trFOPInsert] on [dbo].[FOP]
for insert
as
begin
    declare @ids table (Id int, ActionId int, Usr nvarchar(50));
    insert into @ids(Id, ActionId, Usr) select distinct FOPId, 1, USER_NAME() from inserted;
	
	insert into FOPAudit (FOPId, FOPActionId, [User])
	select Id, ActionId, Usr from @ids;

end
'
GO
/****** Object:  Trigger [trFOPDelete]    Script Date: 11/03/2015 20:11:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[trFOPDelete]'))
EXEC dbo.sp_executesql @statement = N'CREATE trigger [dbo].[trFOPDelete] on [dbo].[FOP]
for delete
as
begin
    declare @ids table (Id int, ActionId int, Usr nvarchar(50));
    insert into @ids(Id, ActionId, Usr) select distinct FOPId, 3, USER_NAME() from deleted;
	
	insert into FOPAudit (FOPId, FOPActionId, [User])
	select Id, ActionId, Usr from @ids;

end
'
GO
/****** Object:  StoredProcedure [dbo].[spFOPSelectChangesByDate]    Script Date: 11/03/2015 20:11:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spFOPSelectChangesByDate]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'/*

First set contains products which appear in the second day, but do not present in the first
Second set contains products which only present in the first day
Third set contains differences in columns other then Organization and ProductName

*/
CREATE procedure [dbo].[spFOPSelectChangesByDate]
@firstDate date,
@secondDate date
AS
BEGIN

declare @batch1 int = (select top 1 fopbatchid from fopbatch where cast([timestamp] as date) = @firstDate order by [timestamp] DESC);
declare @batch2 int = (select top 1 fopbatchid from fopbatch where cast([timestamp] as date) = @secondDate order by [timestamp] DESC);

exec [dbo].[spFOPSelectChangesByBatchId] @firstBatchId = @batch1, @secondBatchId = @batch2;

END' 
END
GO
/****** Object:  ForeignKey [FK_FOP_Batch]    Script Date: 11/03/2015 20:11:38 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_FOP_Batch]') AND parent_object_id = OBJECT_ID(N'[dbo].[FOP]'))
ALTER TABLE [dbo].[FOP]  WITH CHECK ADD  CONSTRAINT [FK_FOP_Batch] FOREIGN KEY([FOPBatchId])
REFERENCES [dbo].[FOPBatch] ([FOPBatchId])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_FOP_Batch]') AND parent_object_id = OBJECT_ID(N'[dbo].[FOP]'))
ALTER TABLE [dbo].[FOP] CHECK CONSTRAINT [FK_FOP_Batch]
GO
/****** Object:  ForeignKey [FK_FOPAudit_FOPAction]    Script Date: 11/03/2015 20:11:38 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_FOPAudit_FOPAction]') AND parent_object_id = OBJECT_ID(N'[dbo].[FOPAudit]'))
ALTER TABLE [dbo].[FOPAudit]  WITH CHECK ADD  CONSTRAINT [FK_FOPAudit_FOPAction] FOREIGN KEY([FOPActionId])
REFERENCES [dbo].[FOPAction] ([FOPActionId])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_FOPAudit_FOPAction]') AND parent_object_id = OBJECT_ID(N'[dbo].[FOPAudit]'))
ALTER TABLE [dbo].[FOPAudit] CHECK CONSTRAINT [FK_FOPAudit_FOPAction]
GO
