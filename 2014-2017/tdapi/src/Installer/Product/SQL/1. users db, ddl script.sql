USE [master]
GO

IF db_id('{DB_NAME}') IS NOT NULL
BEGIN
	ALTER DATABASE [{DB_NAME}] SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
	DROP DATABASE [{DB_NAME}];
END;
GO

/****** Object:  Database [{DB_NAME}]    Script Date: 03/05/2015 16:52:18 ******/
CREATE DATABASE [{DB_NAME}] ON  PRIMARY 
( NAME = N'{DB_NAME}', FILENAME = N'{DB_FILENAME}' , SIZE = 5120KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'{DB_NAME}_log', FILENAME = N'{DB_LOGNAME}' , SIZE = 26816KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [{DB_NAME}] SET COMPATIBILITY_LEVEL = 100
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [{DB_NAME}].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [{DB_NAME}] SET ANSI_NULL_DEFAULT OFF
GO
ALTER DATABASE [{DB_NAME}] SET ANSI_NULLS OFF
GO
ALTER DATABASE [{DB_NAME}] SET ANSI_PADDING OFF
GO
ALTER DATABASE [{DB_NAME}] SET ANSI_WARNINGS OFF
GO
ALTER DATABASE [{DB_NAME}] SET ARITHABORT OFF
GO
ALTER DATABASE [{DB_NAME}] SET AUTO_CLOSE OFF
GO
ALTER DATABASE [{DB_NAME}] SET AUTO_CREATE_STATISTICS ON
GO
ALTER DATABASE [{DB_NAME}] SET AUTO_SHRINK OFF
GO
ALTER DATABASE [{DB_NAME}] SET AUTO_UPDATE_STATISTICS ON
GO
ALTER DATABASE [{DB_NAME}] SET CURSOR_CLOSE_ON_COMMIT OFF
GO
ALTER DATABASE [{DB_NAME}] SET CURSOR_DEFAULT  GLOBAL
GO
ALTER DATABASE [{DB_NAME}] SET CONCAT_NULL_YIELDS_NULL OFF
GO
ALTER DATABASE [{DB_NAME}] SET NUMERIC_ROUNDABORT OFF
GO
ALTER DATABASE [{DB_NAME}] SET QUOTED_IDENTIFIER OFF
GO
ALTER DATABASE [{DB_NAME}] SET RECURSIVE_TRIGGERS OFF
GO
ALTER DATABASE [{DB_NAME}] SET  DISABLE_BROKER
GO
ALTER DATABASE [{DB_NAME}] SET AUTO_UPDATE_STATISTICS_ASYNC OFF
GO
ALTER DATABASE [{DB_NAME}] SET DATE_CORRELATION_OPTIMIZATION OFF
GO
ALTER DATABASE [{DB_NAME}] SET TRUSTWORTHY OFF
GO
ALTER DATABASE [{DB_NAME}] SET ALLOW_SNAPSHOT_ISOLATION OFF
GO
ALTER DATABASE [{DB_NAME}] SET PARAMETERIZATION SIMPLE
GO
ALTER DATABASE [{DB_NAME}] SET READ_COMMITTED_SNAPSHOT OFF
GO
ALTER DATABASE [{DB_NAME}] SET HONOR_BROKER_PRIORITY OFF
GO
ALTER DATABASE [{DB_NAME}] SET  READ_WRITE
GO
ALTER DATABASE [{DB_NAME}] SET RECOVERY FULL
GO
ALTER DATABASE [{DB_NAME}] SET  MULTI_USER
GO
ALTER DATABASE [{DB_NAME}] SET PAGE_VERIFY CHECKSUM
GO
ALTER DATABASE [{DB_NAME}] SET DB_CHAINING OFF
GO

USE [{DB_NAME}]
GO
/****** Object:  Table [dbo].[ELMAH_Error]    Script Date: 09/26/2016 14:08:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ELMAH_Error](
	[ErrorId] [uniqueidentifier] NOT NULL,
	[Application] [nvarchar](60) NOT NULL,
	[Host] [nvarchar](50) NOT NULL,
	[Type] [nvarchar](250) NOT NULL,
	[Source] [nvarchar](60) NOT NULL,
	[Message] [nvarchar](500) NOT NULL,
	[User] [nvarchar](50) NOT NULL,
	[StatusCode] [int] NOT NULL,
	[TimeUtc] [datetime] NOT NULL,
	[Sequence] [int] IDENTITY(1,1) NOT NULL,
	[AllXml] [ntext] NOT NULL,
 CONSTRAINT [PK_ELMAH_Error] PRIMARY KEY NONCLUSTERED 
(
	[ErrorId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_ELMAH_Error_App_Time_Seq] ON [dbo].[ELMAH_Error] 
(
	[Application] ASC,
	[TimeUtc] DESC,
	[Sequence] DESC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
/****** Object:  UserDefinedTableType [dbo].[ECCT]    Script Date: 09/26/2016 14:08:10 ******/
CREATE TYPE [dbo].[ECCT] AS TABLE(
	[exchangeCode] [varchar](12) NULL,
	[contractNumber] [int] NULL
)
GO
/****** Object:  UserDefinedTableType [dbo].[DeletedIDs]    Script Date: 09/26/2016 14:08:10 ******/
CREATE TYPE [dbo].[DeletedIDs] AS TABLE(
	[Id] [nvarchar](36) NULL
)
GO
/****** Object:  UserDefinedTableType [dbo].[StringList]    Script Date: 09/26/2016 14:08:10 ******/
CREATE TYPE [dbo].[StringList] AS TABLE(
	[string] [nvarchar](max) NULL
)
GO
/****** Object:  UserDefinedFunction [dbo].[fnIPtoBigInt]    Script Date: 09/26/2016 14:08:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[fnIPtoBigInt]
(
    @Ipaddress NVARCHAR(15) -- should be in the form '123.123.123.123'
)
RETURNS BIGINT
AS
BEGIN
 DECLARE @part1 AS NVARCHAR(3) 
 DECLARE @part2 AS NVARCHAR(3) 
 DECLARE @part3 AS NVARCHAR(3)
 DECLARE @part4 AS NVARCHAR(3)

 SELECT @part1 = LEFT(@Ipaddress, CHARINDEX('.',@Ipaddress) - 1)
 SELECT @Ipaddress = SUBSTRING(@Ipaddress, LEN(@part1) + 2, 15)
 SELECT @part2 = LEFT(@Ipaddress, CHARINDEX('.',@Ipaddress) - 1)
 SELECT @Ipaddress = SUBSTRING(@Ipaddress, LEN(@part2) + 2, 15)
 SELECT @part3 = LEFT(@Ipaddress, CHARINDEX('.',@Ipaddress) - 1)
 SELECT @part4 = SUBSTRING(@Ipaddress, LEN(@part3) + 2, 15)

 DECLARE @ipAsBigInt AS BIGINT
 SELECT @ipAsBigInt =
    (16777216 * (CAST(@part1 AS BIGINT)))
    + (65536 * (CAST(@part2 AS BIGINT)))
    + (256 * (CAST(@part3 AS BIGINT)))
    + (CAST(@part4 AS BIGINT))

 RETURN @ipAsBigInt

END
GO
/****** Object:  Table [dbo].[FailedAttemptsUsers]    Script Date: 09/26/2016 14:08:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FailedAttemptsUsers](
	[Username] [nvarchar](50) NOT NULL,
	[IpAddress] [nvarchar](18) NOT NULL,
	[FailedLoginAttemptsCnt] [int] NULL,
	[LastFailedAttempt] [datetime] NULL,
 CONSTRAINT [PK_FailedAttemptsUsers] PRIMARY KEY CLUSTERED 
(
	[Username] ASC,
	[IpAddress] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  UserDefinedFunction [dbo].[fnSubnetBitstoBigInt]    Script Date: 09/26/2016 14:08:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[fnSubnetBitstoBigInt]
(
    @SubnetBits TINYINT -- max = 32
)
RETURNS BIGINT
AS
BEGIN

 DECLARE @multiplier AS BIGINT = 2147483648
 DECLARE @ipAsBigInt AS BIGINT = 0
 DECLARE @bitIndex TINYINT = 1
 WHILE @bitIndex <= @SubnetBits
 BEGIN
    SELECT @ipAsBigInt = @ipAsBigInt + @multiplier
    SELECT @multiplier = @multiplier / 2
    SELECT @bitIndex = @bitIndex + 1
 END

 RETURN @ipAsBigInt

END
GO
/****** Object:  Table [dbo].[ResourceType]    Script Date: 09/26/2016 14:08:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ResourceType](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NULL,
	[Description] [nvarchar](250) NULL,
 CONSTRAINT [PK_ResourceType] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY],
 CONSTRAINT [UK_ResourceType_Name] UNIQUE NONCLUSTERED 
(
	[Name] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  UserDefinedFunction [dbo].[spUtil_SpaceBeforeCap]    Script Date: 09/26/2016 14:08:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[spUtil_SpaceBeforeCap] (
    @InputString NVARCHAR(MAX),
    @PreserveAdjacentCaps BIT
)
RETURNS NVARCHAR(MAX)
AS
BEGIN

DECLARE
    @i INT, @j INT,
        @previous NCHAR, @current NCHAR, @next NCHAR,
        @result NVARCHAR(MAX)

SELECT
    @i = 1,
        @j = LEN(@InputString),
        @result = ''

WHILE @i <= @j
BEGIN
    SELECT
        @previous = SUBSTRING(@InputString,@i-1,1),
                @current = SUBSTRING(@InputString,@i+0,1),
                @next = SUBSTRING(@InputString,@i+1,1)

    IF @current = UPPER(@current) COLLATE Latin1_General_CS_AI
    BEGIN
        -- Add space if Current is UPPER 
        -- and either Previous or Next is lower or user chose not to preserve adjacent caps
        -- and Previous or Current is not already a space
        IF @current = UPPER(@current) COLLATE Latin1_General_CS_AI
        AND (
                            @previous <> UPPER(@previous) collate Latin1_General_CS_AI
                            OR  @next <> UPPER(@next) collate Latin1_General_CS_AI
                            OR  @PreserveAdjacentCaps = 0
        )
        AND @previous <> ' '
        AND @current <> ' '
            SET @result = @result + ' '
    END 

    SET @result = @result + @current
    SET @i = @i + 1
END 

RETURN @result
END
GO
/****** Object:  UserDefinedFunction [dbo].[spUtil_EscapeXml]    Script Date: 09/26/2016 14:08:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create FUNCTION [dbo].[spUtil_EscapeXml] 
(@xml nvarchar(4000))
RETURNS nvarchar(4000)
AS
BEGIN
    declare @return nvarchar(4000)
    select @return = 
    REPLACE(
        REPLACE(
            REPLACE(
                REPLACE(
                    REPLACE(@xml,'&', '&amp;')
                ,'<', '&lt;')
            ,'>', '&gt;')
        ,'"', '&quot;')
    ,'''', '&#39;')

return @return
end
GO
/****** Object:  StoredProcedure [dbo].[spSelectTableColumns]    Script Date: 09/26/2016 14:08:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[spSelectTableColumns]
@tableName varchar(128)
AS
SELECT column_name
FROM TRADEdataAPI.INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = @tableName
ORDER BY column_name
GO
/****** Object:  StoredProcedure [dbo].[spInsteadOfDeleteTrigger]    Script Date: 09/26/2016 14:08:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[spInsteadOfDeleteTrigger] (@ids DeletedIDs readonly, @tableName nvarchar(128))
as
declare @sql nvarchar(max)

begin
	set @sql = 'update ' + @tableName + ' set IsDeleted = 1 where Id in (';
	
	-- concatenate ids of deleted entities
	select @sql += left(Id, len(Id) - 1)
		from (
			select '''' + cast(Id as nvarchar(10)) + ''', '
			from @ids
			for xml path ('')
		  ) c (Id)
	set @sql += ')'
		    
	exec sp_executesql @sql;
end
GO
/****** Object:  StoredProcedure [dbo].[spJobExpireUsers]    Script Date: 09/26/2016 14:08:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[spJobExpireUsers]
as
begin
	update	users 
	set		IsActive = 0
	where	IsActive = 1
	and		cast (AccountExpirationDate as date) < cast (getdate() as date) 
end
GO
/****** Object:  StoredProcedure [dbo].[spInformerNumberOfExpiredUsers]    Script Date: 09/26/2016 14:08:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[spInformerNumberOfExpiredUsers]
AS
BEGIN
	select count(1) as [Count]
	from Users
	where	IsDeleted = 0
	and		IsActive = 0
END
GO
/****** Object:  StoredProcedure [dbo].[spInformerNumberOfActiveUsers]    Script Date: 09/26/2016 14:08:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[spInformerNumberOfActiveUsers]
AS
begin
	select	count(1) as [Count]
	from	Users
	where	IsDeleted = 0
	and		IsActive = 1
end
GO
/****** Object:  StoredProcedure [dbo].[spInformerCUIErrors]    Script Date: 09/26/2016 14:08:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[spInformerCUIErrors]
as
begin
	select count(*)
	from ELMAH_Error
	where cast (timeUtc as date) = cast (GETUTCDATE() as date)
	and application = 'CustomersUI'
end
GO
/****** Object:  StoredProcedure [dbo].[spCUIGetXymRootLevelGLOBAL]    Script Date: 09/26/2016 14:08:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[spCUIGetXymRootLevelGLOBAL]
AS
SELECT * FROM [TRADEdataAPI].[dbo].[XymRootLevelGLOBALDetailedView]
GO
/****** Object:  UserDefinedFunction [dbo].[spCUIGetSeriesWhereClause]    Script Date: 09/26/2016 14:08:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE function [dbo].[spCUIGetSeriesWhereClause] (@list ECCT readonly)
 returns nvarchar(max)
as
begin
 declare @whereClause nvarchar(max);
 select @whereClause = coalesce(@whereClause + ' or ', '') 
 	+ '(ExchangeCode = ''' + exchangeCode + ''' and ' + 'ContractNumber = ' + cast(contractNumber as varchar) + ')'
 from @list;
 
 return ' where (' + @whereClause + ') ';
end
GO
/****** Object:  StoredProcedure [dbo].[spInformerAUIErrors]    Script Date: 09/26/2016 14:08:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[spInformerAUIErrors]
as
begin
	select count(*)
	from ELMAH_Error
	where cast (timeUtc as date) = cast (GETUTCDATE() as date)
	and application = 'AdministrativeUI'
end
GO
/****** Object:  StoredProcedure [dbo].[spInformerAPIFailedCalls]    Script Date: 09/26/2016 14:08:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[spInformerAPIFailedCalls]
as
begin
	select count(*)
	from ELMAH_Error
	where cast (timeUtc as date) = cast (GETUTCDATE() as date)
	and application = 'WebAPI'
	and type like 'System.ServiceModel.Web.WebFaultException%' 
end
/****** Object:  UserDefinedFunction [dbo].[spCUIGetSeriesWhereClause]    Script Date: 03/11/2015 16:55:48 ******/
SET ANSI_NULLS ON
GO
/****** Object:  StoredProcedure [dbo].[spInformerAPIErrors]    Script Date: 09/26/2016 14:08:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[spInformerAPIErrors]
as
begin
	select count(*)
	from ELMAH_Error
	where cast (timeUtc as date) = cast (GETUTCDATE() as date)
	and application = 'WebAPI'
	and type not like 'System.ServiceModel.Web.WebFaultException%' 
end
GO
/****** Object:  StoredProcedure [dbo].[spSelectSeries]    Script Date: 09/26/2016 14:08:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[spSelectSeries]
	@words StringList readonly,
	@pn int = 0, -- page number
	@ps int = 10, -- page size
	@fa bit = 0 -- find all
AS
begin
	-- look for all words or for any
	declare 
		@query nvarchar(4000),
		@count int,
		@condition varchar(5) = case when @fa = 1 then ' and ' else ' or ' end;

	-- create a query, enclose each word or phrase into double quotes
	select
		@query = case
			when @query is null
			then '"' + w.string + '"'
			else @query + @condition + '"' + w.string + '"'
		end
	from
		@words w
    
    -- do search using full-text indicies
    select * from (
		select 	tbl.*, row_number() over (order by id) as rowId
		from containstable([TRADEdataAPI].[dbo].[XymREUTERSTradedSeriesGLOBAL_Joint], SearchText, @query) vw
		join [TRADEdataAPI].[dbo].[XymREUTERSTradedSeriesGLOBALView] tbl on vw.[KEY] = tbl.ID ) t
	where rowId between (@pn * @ps + 1) and ((@pn * @ps) + @ps)
	
	-- get count 
	select @count = count(*)
		from [TRADEdataAPI].[dbo].[XymREUTERSTradedSeriesGLOBAL_Joint]
		where contains(SearchText, @query)
	
	return @count;
end
GO
/****** Object:  StoredProcedure [dbo].[spTrialCheckUsername]    Script Date: 09/26/2016 14:08:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[spTrialCheckUsername]
	@username nvarchar(100),
	@hasUser bit out
as
begin
	set @hasUser = (select count(*) from users where Username = @username or Email = @username);
end
GO
/****** Object:  UserDefinedFunction [dbo].[fnIsIpaddressInSubnet]    Script Date: 09/26/2016 14:08:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[fnIsIpaddressInSubnet]
(
    @networkAddress NVARCHAR(15), -- 'eg: '192.168.0.0'
    @subnetMask NVARCHAR(15), -- 'eg: '255.255.255.0' for '/24'
    @testAddress NVARCHAR(15) -- 'eg: '192.168.0.1'
)
RETURNS BIT AS
BEGIN
    RETURN CASE WHEN (dbo.fnIPtoBigInt(@networkAddress) & dbo.fnIPtoBigInt(@subnetMask)) 
        = (dbo.fnIPtoBigInt(@testAddress) & dbo.fnIPtoBigInt(@subnetMask)) 
    THEN 1 ELSE 0 END
END
GO
/****** Object:  StoredProcedure [dbo].[ELMAH_LogError]    Script Date: 09/26/2016 14:08:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ELMAH_LogError]
(
    @ErrorId UNIQUEIDENTIFIER,
    @Application NVARCHAR(60),
    @Host NVARCHAR(30),
    @Type NVARCHAR(100),
    @Source NVARCHAR(60),
    @Message NVARCHAR(500),
    @User NVARCHAR(50),
    @AllXml NTEXT,
    @StatusCode INT,
    @TimeUtc DATETIME
)
AS

    SET NOCOUNT ON

    INSERT
    INTO
        [ELMAH_Error]
        (
            [ErrorId],
            [Application],
            [Host],
            [Type],
            [Source],
            [Message],
            [User],
            [AllXml],
            [StatusCode],
            [TimeUtc]
        )
    VALUES
        (
            @ErrorId,
            @Application,
            @Host,
            @Type,
            @Source,
            @Message,
            @User,
            @AllXml,
            @StatusCode,
            @TimeUtc
        )
GO
/****** Object:  StoredProcedure [dbo].[ELMAH_GetErrorXml]    Script Date: 09/26/2016 14:08:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ELMAH_GetErrorXml]
(
    @Application NVARCHAR(60),
    @ErrorId UNIQUEIDENTIFIER
)
AS

    SET NOCOUNT ON

    SELECT 
        [AllXml]
    FROM 
        [ELMAH_Error]
    WHERE
        [ErrorId] = @ErrorId
    --AND
        --[Application] = @Application
GO
/****** Object:  StoredProcedure [dbo].[ELMAH_GetErrorsXml]    Script Date: 09/26/2016 14:08:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ELMAH_GetErrorsXml]
(
    @Application NVARCHAR(60),
    @ExceptionType NVARCHAR(100) = NULL,
    @IncludeExceptionByType BIT = 1,
    @PageIndex INT = 0,
    @PageSize INT = 15,
    @TotalCount INT OUTPUT
)
AS 

    SET NOCOUNT ON

    DECLARE @FirstTimeUTC DATETIME
    DECLARE @FirstSequence INT
    DECLARE @StartRow INT
    DECLARE @StartRowIndex INT
	
	DECLARE @showException BIT = 0, @hideException BIT = 0, @goFurther BIT = 0
	
	IF (@ExceptionType IS NOT NULL AND @ExceptionType <> '') AND @IncludeExceptionByType = 1
	BEGIN
		SET @showException = 1;
		SET @hideException = 0;
	END
	ELSE IF (@ExceptionType IS NOT NULL AND @ExceptionType <> '') AND @IncludeExceptionByType = 0
	BEGIN
		SET @showException = 0;
		SET @hideException = 1;
	END

	IF @showException <> 0 OR @hideException <> 0
		SET @goFurther = 1;

    SELECT 
        @TotalCount = COUNT(1) 
    FROM 
        [ELMAH_Error]
    WHERE 
        [Application] = @Application
        AND (@goFurther = 0 OR ((@showException = 1 AND [Type] LIKE @ExceptionType + '%') OR (@hideException = 1 AND [Type] NOT LIKE @ExceptionType + '%')))

    -- Get the ID of the first error for the requested page

    SET @StartRowIndex = @PageIndex * @PageSize + 1

    IF @StartRowIndex <= @TotalCount
    BEGIN

        SET ROWCOUNT @StartRowIndex

        SELECT  
            @FirstTimeUTC = [TimeUtc],
            @FirstSequence = [Sequence]
        FROM 
            [ELMAH_Error]
        WHERE   
            [Application] = @Application
		AND 
			(@goFurther = 0 OR ((@showException = 1 AND [Type] LIKE @ExceptionType + '%') OR (@hideException = 1 AND [Type] NOT LIKE @ExceptionType + '%')))
        ORDER BY 
            [TimeUtc] DESC, 
            [Sequence] DESC

    END
    ELSE
    BEGIN

        SET @PageSize = 0

    END

    -- Now set the row count to the requested page size and get
    -- all records below it for the pertaining application.

    SET ROWCOUNT @PageSize

    SELECT 
        errorId     = [ErrorId], 
        application = [Application],
        host        = [Host], 
        type        = [Type],
        source      = [Source],
        message     = [Message],
        [user]      = [User],
        statusCode  = [StatusCode], 
        time        = CONVERT(VARCHAR(50), [TimeUtc], 126) + 'Z'
    FROM 
        [ELMAH_Error] error
    WHERE
        [Application] = @Application
	AND 
		(@goFurther = 0 OR ((@showException = 1 AND [Type] LIKE @ExceptionType + '%') OR (@hideException = 1 AND [Type] NOT LIKE @ExceptionType + '%')))
    AND
        [TimeUtc] <= @FirstTimeUTC
    AND 
        [Sequence] <= @FirstSequence
    ORDER BY
        [TimeUtc] DESC, 
        [Sequence] DESC
    FOR
        XML AUTO
GO
/****** Object:  Table [dbo].[DataFormats]    Script Date: 09/26/2016 14:08:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DataFormats](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](10) NOT NULL,
	[IsDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_DataFormats] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DatabaseConfiguration]    Script Date: 09/26/2016 14:08:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DatabaseConfiguration](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Alias] [nvarchar](50) NOT NULL,
	[ConnectionString] [nvarchar](2048) NOT NULL,
	[StoredProcPrefix] [nvarchar](50) NOT NULL,
	[StoredProcParamPrefix] [nvarchar](50) NOT NULL,
	[StoredProcMethodPrefix] [nvarchar](50) NOT NULL,
	[StoredProcOwner] [nvarchar](50) NOT NULL,
	[StoredProcInformerPrefix] [nvarchar](50) NOT NULL,
	[IsDefault] [bit] NULL,
	[IsDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_DatabaseConfiguration] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Countries]    Script Date: 09/26/2016 14:08:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Countries](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](64) NOT NULL,
	[Code] [nvarchar](2) NOT NULL,
	[IsDeleted] [bit] NOT NULL,
 CONSTRAINT [PK__Countrie__3214EC072645B050] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ServiceConfiguration]    Script Date: 09/26/2016 14:08:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ServiceConfiguration](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](100) NULL,
	[Value] [nvarchar](max) NULL,
	[Description] [nvarchar](1500) NULL,
	[IsDeleted] [bit] NOT NULL,
	[ResourceTypeId] [int] NOT NULL,
	[GroupName] [nvarchar](100) NULL,
 CONSTRAINT [PK_ServiceConfiguration] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY],
 CONSTRAINT [UK_ServiceConfiguration_Name] UNIQUE NONCLUSTERED 
(
	[Name] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SearchTables]    Script Date: 09/26/2016 14:08:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SearchTables](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](120) NOT NULL,
	[IsDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_SearchTables] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Roles]    Script Date: 09/26/2016 14:08:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Roles](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[IsDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_Roles] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY],
 CONSTRAINT [UK_Roles_Name] UNIQUE NONCLUSTERED 
(
	[Name] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  UserDefinedFunction [dbo].[fnIsIpaddressInSubnetShortHand]    Script Date: 09/26/2016 14:08:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[fnIsIpaddressInSubnetShortHand]
(
    @network NVARCHAR(18), -- 'eg: '192.168.0.0/24'
    @testAddress NVARCHAR(15) -- 'eg: '192.168.0.1'
)
RETURNS BIT AS
BEGIN
	IF CHARINDEX('/', @network) = 0
	BEGIN
		RETURN CASE WHEN @network = @testAddress THEN 1 ELSE 0 END
	END
	
    DECLARE @networkAddress NVARCHAR(15)
    DECLARE @subnetBits TINYINT

    SELECT @networkAddress = LEFT(@network, CHARINDEX('/', @network) - 1)
    SELECT @subnetBits = CAST(SUBSTRING(@network, LEN(@networkAddress) + 2, 2) AS TINYINT)

    RETURN CASE WHEN (dbo.fnIPtoBigInt(@networkAddress) & dbo.fnSubnetBitstoBigInt(@subnetBits)) 
        = (dbo.fnIPtoBigInt(@testAddress) & dbo.fnSubnetBitstoBigInt(@subnetBits)) 
    THEN 1 ELSE 0 END
END
GO
/****** Object:  Table [dbo].[Resources]    Script Date: 09/26/2016 14:08:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Resources](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](100) NULL,
	[Value] [nvarchar](max) NULL,
	[Description] [nvarchar](1500) NULL,
	[IsDeleted] [bit] NOT NULL,
	[ResourceTypeId] [int] NOT NULL,
	[GroupName] [nvarchar](100) NULL,
 CONSTRAINT [PK_Resources] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY],
 CONSTRAINT [UK_Resources_Name] UNIQUE NONCLUSTERED 
(
	[Name] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PermissionType]    Script Date: 09/26/2016 14:08:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PermissionType](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[IsDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_PermissionType] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MethodGroups]    Script Date: 09/26/2016 14:08:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MethodGroups](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[Shared] [bit] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[IsTrial] [bit] NOT NULL,
 CONSTRAINT [PK_MethodGroups] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY],
 CONSTRAINT [UK_MethodGroups_Name] UNIQUE NONCLUSTERED 
(
	[Name] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MethodTypes]    Script Date: 09/26/2016 14:08:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MethodTypes](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[IsDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_MethodType] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY],
 CONSTRAINT [UK_MethodTypes_Name] UNIQUE NONCLUSTERED 
(
	[Name] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EmailTemplates]    Script Date: 09/26/2016 14:08:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EmailTemplates](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[Description] [nvarchar](2048) NULL,
	[Subject] [nvarchar](100) NULL,
	[Body] [nvarchar](max) NULL,
	[IsDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_EmailTemplates] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Actions]    Script Date: 09/26/2016 14:08:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Actions](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[IsDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_AuditActions] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY],
 CONSTRAINT [UK_AuditActions_Name] UNIQUE NONCLUSTERED 
(
	[Name] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Statuses]    Script Date: 09/26/2016 14:08:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Statuses](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[IsDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_Statuses] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY],
 CONSTRAINT [UK_Statuses_Name] UNIQUE NONCLUSTERED 
(
	[Name] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  StoredProcedure [dbo].[spCUIHasSeries]    Script Date: 09/26/2016 14:08:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[spCUIHasSeries]
	@ecct [ECCT] readonly
AS
declare @sql nvarchar(max) 
	= 'SELECT distinct (ExchangeCode + cast (ContractNumber as varchar(10)))  as [Value]  FROM [TRADEdataAPI].[dbo].[XymREUTERSTradedSeriesGLOBAL] '
	+ dbo.spCUIGetSeriesWhereClause(@ecct);
	
exec (@sql);
GO
/****** Object:  StoredProcedure [dbo].[spCUIGetSeries]    Script Date: 09/26/2016 14:08:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[spCUIGetSeries] 
@columns StringList readonly,
@ecct ECCT readonly,
@page int,
@pageSize int

AS
declare @whereClause nvarchar(max);
declare @cols nvarchar(max);

set @whereClause = dbo.spCUIGetSeriesWhereClause(@ecct);
select @cols = coalesce(@cols + ', ', '') + [string] from @columns;

-- count total items for pager
declare @countSql nvarchar(max) = 'set @count = (select count(*) from [TRADEdataAPI].[dbo].[XymREUTERSTradedSeriesGLOBALView]' + @whereClause + ')';
declare @count int = 0;
execute sp_executesql @countSql, N'@count int OUTPUT', @count OUTPUT;

-- select specified page
declare @sql nvarchar(max);
set @sql = 'SELECT ' + @cols + ' FROM '
	+ '(SELECT ' + @cols + ', ROW_NUMBER() OVER (ORDER BY ExchangeCode, ContractNumber) as row_number '
	+ 'FROM [TRADEdataAPI].[dbo].[XymREUTERSTradedSeriesGLOBALView]' + @whereClause + ') t0'
	+ @whereClause;

if @pageSize > 0
	set @sql = @sql + ' and t0.row_number BETWEEN ' + (cast((@page * @pageSize + 1) as varchar(1000)) + ' and ' + cast((@page * @pageSize) + @pageSize as varchar(1000)));

exec (@sql);
return @count;
GO
/****** Object:  Table [dbo].[SubscriptionRequestType]    Script Date: 09/26/2016 14:08:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SubscriptionRequestType](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NULL,
	[IsDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_SubscriptionRequestType] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TimeZones]    Script Date: 09/26/2016 14:08:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TimeZones](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](200) NOT NULL,
	[Code] [nvarchar](200) NOT NULL,
	[IsDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_TimeZones] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ThresholdPeriods]    Script Date: 09/26/2016 14:08:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ThresholdPeriods](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[HowLong] [int] NOT NULL,
	[DatePart] [nvarchar](2) NOT NULL,
	[IsDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_ThresholdPeriods] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY],
 CONSTRAINT [UK_ThresholdPeriods_Name] UNIQUE NONCLUSTERED 
(
	[Name] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Trigger [tr_iod_Actions]    Script Date: 09/26/2016 14:08:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create trigger [dbo].[tr_iod_Actions] on [dbo].[Actions]
instead of delete
as
begin
    set nocount on;
    declare @Ids DeletedIDs;
    insert into @Ids(Id) select distinct Id from deleted;
    exec spInsteadOfDeleteTrigger @ids = @ids, @tablename = 'Actions'
end
GO
/****** Object:  StoredProcedure [dbo].[spInformerRecentExpirations]    Script Date: 09/26/2016 14:08:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[spInformerRecentExpirations]
as
declare 
	@email_subject nvarchar(500),
	@email_body nvarchar(max)
begin
	set @email_subject = (select value from Resources where id = 24)
	set @email_body = (select value from Resources where id = 25)
	select	Id as UserId, 
			isnull(FirstName, '') + ' ' + isnull(LastName, '') as FullName, accountExpirationDate,
			Email,
			@email_subject as [Subject],
			@email_body as Body
	from	Users
	where	IsDeleted = 0
	and		datediff(day, getdate(), accountExpirationDate) > -31 
	and		datediff(day, getdate(), accountExpirationDate) < 0
	order by accountExpirationDate desc
end
GO
/****** Object:  Trigger [tr_iod_MethodGroups]    Script Date: 09/26/2016 14:08:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create trigger [dbo].[tr_iod_MethodGroups] on [dbo].[MethodGroups]
instead of delete
as
begin
    set nocount on;
    declare @Ids DeletedIDs;
    insert into @Ids(Id) select distinct Id from deleted;
    exec spInsteadOfDeleteTrigger @ids = @ids, @tablename = 'MethodGroups'
end
GO
/****** Object:  Trigger [tr_iod_EmailTemplates]    Script Date: 09/26/2016 14:08:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE trigger [dbo].[tr_iod_EmailTemplates] on [dbo].[EmailTemplates]
instead of delete
as
begin
    set nocount on;
    declare @Ids DeletedIDs;
    insert into @Ids(Id) 
    select distinct Id from deleted;
    exec spInsteadOfDeleteTrigger @ids = @ids, @tablename = 'EmailTemplates'
end
GO
/****** Object:  Trigger [tr_iod_DataFormats]    Script Date: 09/26/2016 14:08:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create trigger [dbo].[tr_iod_DataFormats] on [dbo].[DataFormats]
instead of delete
as
begin
    set nocount on;
    declare @Ids DeletedIDs;
    insert into @Ids(Id) select distinct Id from deleted;
    exec spInsteadOfDeleteTrigger @ids = @ids, @tablename = 'DataFormats'
end
GO
/****** Object:  Trigger [tr_iod_DatabaseConfiguration]    Script Date: 09/26/2016 14:08:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE trigger [dbo].[tr_iod_DatabaseConfiguration] on [dbo].[DatabaseConfiguration]
instead of delete
as
begin
    set nocount on;
    declare @Ids DeletedIDs;
    insert into @Ids(Id) 
    select distinct Id from deleted;
    exec spInsteadOfDeleteTrigger @ids = @ids, @tablename = 'DatabaseConfiguration'
end
GO
/****** Object:  Trigger [tr_iod_Countries]    Script Date: 09/26/2016 14:08:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create trigger [dbo].[tr_iod_Countries] on [dbo].[Countries]
instead of delete
as
begin
    set nocount on;
    declare @Ids DeletedIDs;
    insert into @Ids(Id) select distinct Id from deleted;
    exec spInsteadOfDeleteTrigger @ids = @ids, @tablename = 'Countries'
end
GO
/****** Object:  Trigger [tr_iod_Roles]    Script Date: 09/26/2016 14:08:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create trigger [dbo].[tr_iod_Roles] on [dbo].[Roles]
instead of delete
as
begin
    set nocount on;
    declare @Ids DeletedIDs;
    insert into @Ids(Id) select distinct Id from deleted;
    exec spInsteadOfDeleteTrigger @ids = @ids, @tablename = 'Roles'
end
GO
/****** Object:  Trigger [tr_iod_Resources]    Script Date: 09/26/2016 14:08:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create trigger [dbo].[tr_iod_Resources] on [dbo].[Resources]
instead of delete
as
begin
    set nocount on;
    declare @Ids DeletedIDs;
    insert into @Ids(Id) select distinct Id from deleted;
    exec spInsteadOfDeleteTrigger @ids = @ids, @tablename = 'Resources'
end
GO
/****** Object:  Trigger [tr_iod_PermissionType]    Script Date: 09/26/2016 14:08:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create trigger [dbo].[tr_iod_PermissionType] on [dbo].[PermissionType]
instead of delete
as
begin
    set nocount on;
    declare @Ids DeletedIDs;
    insert into @Ids(Id) select distinct Id from deleted;
    exec spInsteadOfDeleteTrigger @ids = @ids, @tablename = 'PermissionType'
end
GO
/****** Object:  Trigger [tr_iod_Statuses]    Script Date: 09/26/2016 14:08:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create trigger [dbo].[tr_iod_Statuses] on [dbo].[Statuses]
instead of delete
as
begin
    set nocount on;
    declare @Ids DeletedIDs;
    insert into @Ids(Id) select distinct Id from deleted;
    exec spInsteadOfDeleteTrigger @ids = @ids, @tablename = 'Statuses'
end
GO
/****** Object:  Trigger [tr_iod_ServiceConfiguration]    Script Date: 09/26/2016 14:08:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create trigger [dbo].[tr_iod_ServiceConfiguration] on [dbo].[ServiceConfiguration]
instead of delete
as
begin
    set nocount on;
    declare @Ids DeletedIDs;
    insert into @Ids(Id) select distinct Id from deleted;
    exec spInsteadOfDeleteTrigger @ids = @ids, @tablename = 'ServiceConfiguration'
end
GO
/****** Object:  Trigger [tr_iod_SearchTables]    Script Date: 09/26/2016 14:08:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create trigger [dbo].[tr_iod_SearchTables] on [dbo].[SearchTables]
instead of delete
as
begin
    set nocount on;
    declare @Ids DeletedIDs;
    insert into @Ids(Id) select distinct Id from deleted;
    exec spInsteadOfDeleteTrigger @ids = @ids, @tablename = 'SearchTables'
end
GO
/****** Object:  StoredProcedure [dbo].[spInformerComingExpirations]    Script Date: 09/26/2016 14:08:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[spInformerComingExpirations]
as
declare 
	@email_subject nvarchar(500),
	@email_body nvarchar(max)
begin
	set @email_subject = (select value from Resources where id = 26)
	set @email_body = (select value from Resources where id = 27)
	select	Id as UserId, 
			isnull(FirstName, '') + ' ' + isnull(LastName, '') as FullName, accountExpirationDate,
			Email,
			@email_subject as [Subject],
			@email_body as Body
	from	Users
	where	IsDeleted = 0
	and		datediff(day, getdate(), accountExpirationDate) >= 0 
	and		datediff(day, getdate(), accountExpirationDate) < 31
	order by accountExpirationDate asc
end
GO
/****** Object:  StoredProcedure [dbo].[spJobZeroCounters]    Script Date: 09/26/2016 14:08:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[spJobZeroCounters]
as
begin
	-- do regular update
	update	u 
	set		Hits = 0,
			ThresholdPeriodEnd = 
				case t.[DatePart]
					when 'yy' then dateadd(yy, t.HowLong, ThresholdPeriodEnd)
					when 'ww' then dateadd(ww, t.HowLong, ThresholdPeriodEnd)
					when 'dd' then dateadd(dd, t.HowLong, ThresholdPeriodEnd)
					when 'mm' then dateadd(mm, t.HowLong, ThresholdPeriodEnd)
				end
	from	users u 
	join	thresholdperiods t on u.thresholdperiodid = t.id
	where 	cast (ThresholdPeriodEnd as date) < cast (getdate() as date)
	
	-- now fix old dates
	update	u 
	set		Hits = 0,
			ThresholdPeriodEnd = 
				case t.[DatePart]
					when 'yy' then dateadd(yy, t.HowLong, cast (getdate() as date))
					when 'ww' then dateadd(ww, t.HowLong, cast (getdate() as date))
					when 'dd' then dateadd(dd, t.HowLong, cast (getdate() as date))
					when 'mm' then dateadd(mm, t.HowLong, cast (getdate() as date))
				end
	from	users u 
	join	thresholdperiods t on u.thresholdperiodid = t.id
	where 	cast (ThresholdPeriodEnd as date) < cast (getdate() as date)
end
GO
/****** Object:  StoredProcedure [dbo].[spJobSendTrialEmail]    Script Date: 09/26/2016 14:08:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[spJobSendTrialEmail]
	@templateName nvarchar(50),
	@username nvarchar(100),
	@password nvarchar(128)
	
as
begin
	declare @template nvarchar(max)
	set @template = (select Body from EmailTemplates where Name = @templateName)
end
GO
/****** Object:  StoredProcedure [dbo].[spSendTrialEmail]    Script Date: 09/26/2016 14:08:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[spSendTrialEmail]
	@name nvarchar(100),
	@baseUrl nvarchar(512),
    @methodName nvarchar(150),
	@username nvarchar(100),
	@password nvarchar(128),
	@email varchar(100),
	@verificationLink nvarchar(2048),
	@templateName nvarchar(50),
	@format varchar(4),
	@mailProfile varchar(100),
	@logoFullPath varchar(2048) = null
as
begin
	declare @template nvarchar(max)
	declare @subj nvarchar(250)

	set @subj = (select top 1 [Subject] from EmailTemplates where Name = @templateName)
	
	set @template = 
	(
		select top 1 
		replace(
			replace(
				replace(
					replace(
						replace(
                            replace(
    							replace(Body, '{email}', @email),
                            '{methodName}', @methodName),
						'{ServiceUrl}', @baseUrl),
					'{link}', @verificationLink), 
				'{name}', @name), 
			'{username}', @username), 
		'{password}', @password)
		
		from EmailTemplates where Name = @templateName
	)		

	exec msdb.dbo.sp_send_dbmail 
	@profile_name=N'Default_Mail',
	@recipients=@email,
	@subject=@subj,
	@body=@template,
	@body_format=@format,
	@file_attachments=@logoFullPath
end
GO
/****** Object:  Table [dbo].[Companies]    Script Date: 09/26/2016 14:08:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Companies](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
	[Address] [nvarchar](500) NULL,
	[Phone] [nvarchar](50) NULL,
	[Fax] [nvarchar](50) NULL,
	[CountryId] [int] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_Companies] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Methods]    Script Date: 09/26/2016 14:08:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Methods](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](150) NOT NULL,
	[DisplayName] [nvarchar](200) NULL,
	[TypeId] [int] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[DatabaseId] [int] NOT NULL,
 CONSTRAINT [PK_Methods_1] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY],
 CONSTRAINT [UK_Methods_Name] UNIQUE NONCLUSTERED 
(
	[Name] ASC,
	[DatabaseId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Permissions]    Script Date: 09/26/2016 14:08:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Permissions](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[PermissionTypeId] [int] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_Permissions] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SearchColumns]    Script Date: 09/26/2016 14:08:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SearchColumns](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](120) NOT NULL,
	[Alias] [nvarchar](150) NOT NULL,
	[TableId] [int] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_SearchColumns] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SearchGroups]    Script Date: 09/26/2016 14:08:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SearchGroups](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](120) NOT NULL,
	[TableId] [int] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_SearchGroups] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Users]    Script Date: 09/26/2016 14:08:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Users](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CompanyId] [int] NOT NULL,
	[TimeZoneId] [int] NOT NULL,
	[Firstname] [nvarchar](100) NULL,
	[Middlename] [nvarchar](100) NULL,
	[Lastname] [nvarchar](100) NULL,
	[Email] [nvarchar](100) NOT NULL,
	[Phone] [nvarchar](50) NULL,
	[PhoneExt] [nvarchar](10) NULL,
	[Username] [varchar](100) NOT NULL,
	[Password] [nvarchar](128) NOT NULL,
	[Salt] [nvarchar](128) NOT NULL,
	[IsActive] [bit] NOT NULL,
	[FailedLoginAttemptsCnt] [int] NULL,
	[LastFailedAttempt] [datetime] NULL,
	[AccountExpirationDate] [datetime] NOT NULL,
	[ThresholdPeriodId] [int] NOT NULL,
	[ThresholdPeriodEnd] [date] NOT NULL,
	[Hits] [int] NOT NULL,
	[HitsLimit] [int] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[SessionId] [uniqueidentifier] NULL,
	[AllowSync] [bit] NULL,
	[SyncPassword] [nvarchar](128) NULL,
 CONSTRAINT [PK_Users] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY],
 CONSTRAINT [UK_Users_Username] UNIQUE NONCLUSTERED 
(
	[Username] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Trigger [tr_iod_SubscriptionRequestType]    Script Date: 09/26/2016 14:08:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create trigger [dbo].[tr_iod_SubscriptionRequestType] on [dbo].[SubscriptionRequestType]
instead of delete
as
begin
    set nocount on;
    declare @Ids DeletedIDs;
    insert into @Ids(Id) select distinct Id from deleted;
    exec spInsteadOfDeleteTrigger @ids = @ids, @tablename = 'SubscriptionRequestType'
end
GO
/****** Object:  Trigger [tr_iod_MethodTypes]    Script Date: 09/26/2016 14:08:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create trigger [dbo].[tr_iod_MethodTypes] on [dbo].[MethodTypes]
instead of delete
as
begin
    set nocount on;
    declare @Ids DeletedIDs;
    insert into @Ids(Id) select distinct Id from deleted;
    exec spInsteadOfDeleteTrigger @ids = @ids, @tablename = 'MethodTypes'
end
GO
/****** Object:  Trigger [tr_iod_TimeZones]    Script Date: 09/26/2016 14:08:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create trigger [dbo].[tr_iod_TimeZones] on [dbo].[TimeZones]
instead of delete
as
begin
    set nocount on;
    declare @Ids DeletedIDs;
    insert into @Ids(Id) select distinct Id from deleted;
    exec spInsteadOfDeleteTrigger @ids = @ids, @tablename = 'TimeZones'
end
GO
/****** Object:  Trigger [tr_iod_ThresholdPeriods]    Script Date: 09/26/2016 14:08:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create trigger [dbo].[tr_iod_ThresholdPeriods] on [dbo].[ThresholdPeriods]
instead of delete
as
begin
    set nocount on;
    declare @Ids DeletedIDs;
    insert into @Ids(Id) select distinct Id from deleted;
    exec spInsteadOfDeleteTrigger @ids = @ids, @tablename = 'ThresholdPeriods'
end
GO
/****** Object:  Table [dbo].[UserSearchQueries]    Script Date: 09/26/2016 14:08:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserSearchQueries](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](150) NOT NULL,
	[QueryParameters] [nvarchar](max) NOT NULL,
	[UserId] [int] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_UserSearchQueries] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY],
 CONSTRAINT [UK_UserSearchQueries] UNIQUE NONCLUSTERED 
(
	[Name] ASC,
	[UserId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Trigger [tr_iod_Users]    Script Date: 09/26/2016 14:08:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create trigger [dbo].[tr_iod_Users] on [dbo].[Users]
instead of delete
as
begin
    set nocount on;
    declare @Ids DeletedIDs;
    insert into @Ids(Id) select distinct Id from deleted;
    exec spInsteadOfDeleteTrigger @ids = @ids, @tablename = 'Users'
end
GO
/****** Object:  Trigger [tr_iod_Methods]    Script Date: 09/26/2016 14:08:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create trigger [dbo].[tr_iod_Methods] on [dbo].[Methods]
instead of delete
as
begin
    set nocount on;
    declare @Ids DeletedIDs;
    insert into @Ids(Id) select distinct Id from deleted;
    exec spInsteadOfDeleteTrigger @ids = @ids, @tablename = 'Methods'
end
GO
/****** Object:  Table [dbo].[UserRole]    Script Date: 09/26/2016 14:08:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserRole](
	[RoleId] [int] NOT NULL,
	[UserId] [int] NOT NULL,
 CONSTRAINT [PK_UserRole] PRIMARY KEY CLUSTERED 
(
	[RoleId] ASC,
	[UserId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SearchGroupColumns]    Script Date: 09/26/2016 14:08:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SearchGroupColumns](
	[SearchGroupId] [int] NOT NULL,
	[SearchColumnId] [int] NOT NULL,
 CONSTRAINT [PK_SearchGroupColumns] PRIMARY KEY CLUSTERED 
(
	[SearchGroupId] ASC,
	[SearchColumnId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RolePermission]    Script Date: 09/26/2016 14:08:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RolePermission](
	[RoleId] [int] NOT NULL,
	[PermissionId] [int] NOT NULL,
 CONSTRAINT [PK_RolePermission] PRIMARY KEY CLUSTERED 
(
	[RoleId] ASC,
	[PermissionId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PermissionSearchGroup]    Script Date: 09/26/2016 14:08:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PermissionSearchGroup](
	[PermissionId] [int] NOT NULL,
	[SearchGroupId] [int] NOT NULL,
 CONSTRAINT [PK_PermissionSearchGroup] PRIMARY KEY CLUSTERED 
(
	[PermissionId] ASC,
	[SearchGroupId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MethodGroupMethod]    Script Date: 09/26/2016 14:08:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MethodGroupMethod](
	[MethodId] [int] NOT NULL,
	[MethodGroupId] [int] NOT NULL,
 CONSTRAINT [PK_MethodGroupMethod] PRIMARY KEY CLUSTERED 
(
	[MethodId] ASC,
	[MethodGroupId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[IPs]    Script Date: 09/26/2016 14:08:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[IPs](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[IP] [nvarchar](45) NOT NULL,
	[GeoLocationCountryId] [int] NULL,
	[IsAllowed] [bit] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[CompanyId] [int] NULL,
 CONSTRAINT [PK_IPs] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY],
 CONSTRAINT [UK_IPs] UNIQUE NONCLUSTERED 
(
	[IP] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Informers]    Script Date: 09/26/2016 14:08:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Informers](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Title] [nvarchar](240) NOT NULL,
	[HeaderColor] [nvarchar](30) NULL,
	[ContentColor] [nvarchar](30) NULL,
	[FooterColor] [nvarchar](30) NULL,
	[InformerStyle] [nvarchar](700) NULL,
	[ContentStyle] [nvarchar](700) NULL,
	[TitleStyle] [nvarchar](700) NULL,
	[FooterStyle] [nvarchar](700) NULL,
	[ContentProviderId] [int] NOT NULL,
	[UserId] [int] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[Xslt] [nvarchar](120) NOT NULL,
	[XsltParameters] [nvarchar](1500) NULL,
	[ShowFooter] [bit] NOT NULL,
 CONSTRAINT [PK_Informers] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Audits]    Script Date: 09/26/2016 14:08:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Audits](
	[Id] [uniqueidentifier] NOT NULL,
	[IpAddr] [nvarchar](45) NULL,
	[TableName] [nvarchar](100) NULL,
	[Values] [nvarchar](max) NULL,
	[ActionId] [int] NOT NULL,
	[RecordDate] [datetime] NOT NULL,
	[UserId] [int] NULL,
	[IsDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_Audit] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  StoredProcedure [dbo].[spSetSessionExpired]    Script Date: 09/26/2016 14:08:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[spSetSessionExpired]
	@username varchar(100)
as
begin
	update [Users].dbo.Users set sessionId = null where Username = @username;
	update [TRADEdataUsers].dbo.Users set sessionId = null where Username = @username;
end
GO
/****** Object:  StoredProcedure [dbo].[spSelectSearchGroups]    Script Date: 09/26/2016 14:08:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[spSelectSearchGroups]
as 
begin
	select Id, Name from SearchGroups
	where TableId = 1 /* XymRootLevelGLOBAL */
	and IsDeleted = 0
end
GO
/****** Object:  StoredProcedure [dbo].[spResetSessionId]    Script Date: 09/26/2016 14:08:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[spResetSessionId]
	@username varchar(100)
as
begin
	declare @guid uniqueidentifier = newid();
	--select @guid = isnull(SessionId, @guid) from Users where Username = @username;
	
	update [Users].dbo.users set sessionId = @guid where Username = @username;
	update [TRADEdataUsers].dbo.Users set SessionId = @guid where Username = @username;
	
	select @guid;
end
GO
/****** Object:  Table [dbo].[Subscriptions]    Script Date: 09/26/2016 14:08:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Subscriptions](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[MethodGroupId] [int] NOT NULL,
	[UserId] [int] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_Subscriptions] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SubscriptionRequests]    Script Date: 09/26/2016 14:08:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SubscriptionRequests](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Accepted] [bit] NOT NULL,
	[AcceptedBy] [int] NULL,
	[Notify] [bit] NULL,
	[UserId] [int] NOT NULL,
	[LastUpdate] [datetime] NOT NULL,
	[IsFulfilled] [bit] NOT NULL,
	[RequestTypeId] [int] NOT NULL,
	[Comment] [nvarchar](1500) NULL,
	[IsDeleted] [bit] NOT NULL,
	[EmailSent] [datetime] NULL,
 CONSTRAINT [PK_SubscriptionRequest] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Trigger [tr_iod_SearchGroups]    Script Date: 09/26/2016 14:08:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create trigger [dbo].[tr_iod_SearchGroups] on [dbo].[SearchGroups]
instead of delete
as
begin
    set nocount on;
    declare @Ids DeletedIDs;
    insert into @Ids(Id) select distinct Id from deleted;
    exec spInsteadOfDeleteTrigger @ids = @ids, @tablename = 'SearchGroups'
end
GO
/****** Object:  Trigger [tr_iod_SearchColumns]    Script Date: 09/26/2016 14:08:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create trigger [dbo].[tr_iod_SearchColumns] on [dbo].[SearchColumns]
instead of delete
as
begin
    set nocount on;
    declare @Ids DeletedIDs;
    insert into @Ids(Id) select distinct Id from deleted;
    exec spInsteadOfDeleteTrigger @ids = @ids, @tablename = 'SearchColumns'
end
GO
/****** Object:  Trigger [tr_iod_Permissions]    Script Date: 09/26/2016 14:08:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create trigger [dbo].[tr_iod_Permissions] on [dbo].[Permissions]
instead of delete
as
begin
    set nocount on;
    declare @Ids DeletedIDs;
    insert into @Ids(Id) select distinct Id from deleted;
    exec spInsteadOfDeleteTrigger @ids = @ids, @tablename = 'Permissions'
end
GO
/****** Object:  Trigger [tr_iod_Companies]    Script Date: 09/26/2016 14:08:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create trigger [dbo].[tr_iod_Companies] on [dbo].[Companies]
instead of delete
as
begin
    set nocount on;
    declare @Ids DeletedIDs;
    insert into @Ids(Id) select distinct Id from deleted;
    exec spInsteadOfDeleteTrigger @ids = @ids, @tablename = 'Companies'
end
GO
/****** Object:  StoredProcedure [dbo].[spInsertOrUpdateUserSearchQuery]    Script Date: 09/26/2016 14:08:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[spInsertOrUpdateUserSearchQuery]
	@userId int,
	@name nvarchar (150),
	@parameters nvarchar(max) = null,
	@isDeleted bit = 0
as 
begin
	declare @id int; 
	set @id = (select top 1 id from UserSearchQueries where UserId = @userId and Name = @name)
	
	if (@id is null)
	begin
		insert into UserSearchQueries (Name, QueryParameters, UserId, IsDeleted)
		values (@name, @parameters, @userId, @isDeleted) 
	end
	else
	begin
		update UserSearchQueries set
			QueryParameters = ISNULL(@parameters,QueryParameters),
			IsDeleted = ISNULL(@isDeleted,IsDeleted)
		where Id = @id
	end
end
GO
/****** Object:  Trigger [tr_iod_IPs]    Script Date: 09/26/2016 14:08:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create trigger [dbo].[tr_iod_IPs] on [dbo].[IPs]
instead of delete
as
begin
    set nocount on;
    declare @Ids DeletedIDs;
    insert into @Ids(Id) select distinct Id from deleted;
    exec spInsteadOfDeleteTrigger @ids = @ids, @tablename = 'IPs'
end
GO
/****** Object:  Trigger [tr_iod_Informers]    Script Date: 09/26/2016 14:08:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create trigger [dbo].[tr_iod_Informers] on [dbo].[Informers]
instead of delete
as
begin
    set nocount on;
    declare @Ids DeletedIDs;
    insert into @Ids(Id) select distinct Id from deleted;
    exec spInsteadOfDeleteTrigger @ids = @ids, @tablename = 'Informers'
end
GO
/****** Object:  Trigger [tr_iod_Audits]    Script Date: 09/26/2016 14:08:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create trigger [dbo].[tr_iod_Audits] on [dbo].[Audits]
instead of delete
as
begin
    set nocount on;
    declare @Ids DeletedIDs;
    insert into @Ids(Id) select distinct Id from deleted;
    exec spInsteadOfDeleteTrigger @ids = @ids, @tablename = 'Audits'
end
GO
/****** Object:  Table [dbo].[SubscriptionRequestMethodGroup]    Script Date: 09/26/2016 14:08:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SubscriptionRequestMethodGroup](
	[MethodGroupId] [int] NOT NULL,
	[SubscriptionRequestId] [int] NOT NULL,
 CONSTRAINT [PK_SubscriptionRequestMethods] PRIMARY KEY CLUSTERED 
(
	[MethodGroupId] ASC,
	[SubscriptionRequestId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  StoredProcedure [dbo].[spSelectUserSearchQuery]    Script Date: 09/26/2016 14:08:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[spSelectUserSearchQuery]
	@userId int,
	@name nvarchar (150) = null
as 
begin
	select QueryParameters
	from UserSearchQueries
	where UserId = @userId and Name = @name
	and IsDeleted = 0
end
GO
/****** Object:  StoredProcedure [dbo].[spSelectUserSearchQueries]    Script Date: 09/26/2016 14:08:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[spSelectUserSearchQueries]
	@userId int
as 
begin
	select Name, QueryParameters
	from UserSearchQueries
	where UserId = @userId
	and IsDeleted = 0
end
GO
/****** Object:  StoredProcedure [dbo].[spIsAllowedIpAddress]    Script Date: 09/26/2016 14:08:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[spIsAllowedIpAddress]
(
	@ipAddress varchar(45),
	@isValid bit OUT
)
as
begin
	if (select count (*)
		from IPs a
		where a.IsDeleted = 0 and IsAllowed = 1
		and dbo.fnIsIpaddressInSubnetShortHand(IP, @ipAddress) = 1) > 0

		set @isValid = 1
	else 
		set @isValid = 0
end
GO
/****** Object:  StoredProcedure [dbo].[spInformerSubscriptionRequests]    Script Date: 09/26/2016 14:08:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[spInformerSubscriptionRequests]
as
begin
	select sr.id as RequestId, LastUpdate, u.Id as UserId, isnull(FirstName, '') + ' ' + isnull(LastName, '') as FullName, t.Name as [RequestType]
	from SubscriptionRequests sr 
		join Users u on sr.UserId = u.Id
		join SubscriptionRequestType t on sr.RequestTypeId = t.Id
	where sr.isdeleted = 0
        and sr.RequestTypeId <> 3
		and isfulfilled = 0
end
GO
/****** Object:  StoredProcedure [dbo].[spInformerRecentTrialRequests]    Script Date: 09/26/2016 14:08:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[spInformerRecentTrialRequests]
as
begin
	select sr.id as RequestId, LastUpdate, u.Id as UserId, isnull(FirstName, '') + ' ' + isnull(LastName, '') as FullName, 
	t.Name as [RequestType]
	from SubscriptionRequests sr 
		join Users u on sr.UserId = u.Id
		join SubscriptionRequestType t on sr.RequestTypeId = t.Id
	where sr.IsDeleted = 0
	and sr.RequestTypeId = 3
	and		datediff(day, getdate(), LastUpdate) > -31 
	and		datediff(day, getdate(), LastUpdate) < 1
    and isFulfilled = 0

end
GO
/****** Object:  Table [dbo].[UsageStats]    Script Date: 09/26/2016 14:08:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UsageStats](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[UserId] [int] NULL,
	[IpId] [int] NULL,
	[RequestDate] [datetime] NOT NULL,
	[HttpStatusCode] [int] NULL,
	[MethodId] [int] NULL,
	[MethodArgs] [nvarchar](max) NULL,
	[DataFormatId] [int] NOT NULL,
	[ErrorMessage] [nvarchar](max) NULL,
	[RequestDuration] [bigint] NULL,
	[StatusId] [int] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_UsageStats] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Trial]    Script Date: 09/26/2016 14:08:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Trial](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [int] NOT NULL,
	[VerificationCode] [varchar](50) NULL,
	[RequestId] [int] NOT NULL,
	[TrialStart] [datetime] NULL,
	[TrialEnd] [datetime] NULL,
	[IsDeleted] [bit] NOT NULL,
 CONSTRAINT [PK_Trial] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Trigger [tr_iod_UserSearchQueries]    Script Date: 09/26/2016 14:08:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create trigger [dbo].[tr_iod_UserSearchQueries] on [dbo].[UserSearchQueries]
instead of delete
as
begin
    set nocount on;
    declare @Ids DeletedIDs;
    insert into @Ids(Id) select distinct Id from deleted;
    exec spInsteadOfDeleteTrigger @ids = @ids, @tablename = 'UserSearchQueries'
end
GO
/****** Object:  Trigger [tr_iod_SubscriptionRequests]    Script Date: 09/26/2016 14:08:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create trigger [dbo].[tr_iod_SubscriptionRequests] on [dbo].[SubscriptionRequests]
instead of delete
as
begin
    set nocount on;
    declare @Ids DeletedIDs;
    insert into @Ids(Id) select distinct Id from deleted;
    exec spInsteadOfDeleteTrigger @ids = @ids, @tablename = 'SubscriptionRequests'
end
GO
/****** Object:  Trigger [tr_iod_Subscriptions]    Script Date: 09/26/2016 14:08:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create trigger [dbo].[tr_iod_Subscriptions] on [dbo].[Subscriptions]
instead of delete
as
begin
    set nocount on;
    declare @Ids DeletedIDs;
    insert into @Ids(Id) select distinct Id from deleted;
    exec spInsteadOfDeleteTrigger @ids = @ids, @tablename = 'Subscriptions'
end
GO
/****** Object:  Trigger [tr_iod_UsageStats]    Script Date: 09/26/2016 14:08:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create trigger [dbo].[tr_iod_UsageStats] on [dbo].[UsageStats]
instead of delete
as
begin
    set nocount on;
    declare @Ids DeletedIDs;
    insert into @Ids(Id) select distinct Id from deleted;
    exec spInsteadOfDeleteTrigger @ids = @ids, @tablename = 'UsageStats'
end
GO
/****** Object:  Trigger [tr_iod_Trial]    Script Date: 09/26/2016 14:08:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create trigger [dbo].[tr_iod_Trial] on [dbo].[Trial]
instead of delete
as
begin
    set nocount on;
    declare @Ids DeletedIDs;
    insert into @Ids(Id) select distinct Id from deleted;
    exec spInsteadOfDeleteTrigger @ids = @ids, @tablename = 'Trial'
end
GO
/****** Object:  StoredProcedure [dbo].[spInformerListOfCountries]    Script Date: 09/26/2016 14:08:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[spInformerListOfCountries]
as
begin
	select distinct name as [Country], COUNT(Name) as [Count]
	from UsageStats s join 
		IPs i on s.IpId = i.Id join
		Countries c on i.GeoLocationCountryId = c.id
	where s.IsDeleted = 0 and i.IsDeleted = 0 and c.IsDeleted = 0
	group by Name
	order by count (Name) desc
end
GO
/****** Object:  StoredProcedure [dbo].[spInformerUnregisteredIPs]    Script Date: 09/26/2016 14:08:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[spInformerUnregisteredIPs]

as

select	distinct u.Id as UserId, 
		IP,
		Username as Username, 
		isnull(FirstName, '') + ' ' + isnull(LastName, '') as FullName,
		u.CompanyId
from 	usagestats us left outer join 
		users u on u.Id = us.UserId left outer join
		ips i on us.IpId = i.Id
where	IP is not null
		and datediff(day, getdate(), RequestDate) > -31 and datediff(day, getdate(), RequestDate) <= 0
		and IP not in (select IP from IPs where IsDeleted = 0 and IsAllowed = 1)
GO
/****** Object:  StoredProcedure [dbo].[spInformerTodaysRequests]    Script Date: 09/26/2016 14:08:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spInformerTodaysRequests]
AS
BEGIN
	select top 100	u.id as [UserId],
			cm.name as [CompanyName],
			u.firstname + ' ' + u.lastname as [FullName],
			m.DisplayName as [Method], 
			RequestDate as [RequestDate],
			df.Name as [RequestType],
			RequestDuration as [Duration],
			HttpStatusCode,
			us.Id as rid,
			st.Name as [StatusName]
	from usagestats us 
		join users u on us.userid = u.id
		join companies cm on u.companyid = cm.id
		join dataformats df on dataformatid = df.id
		join methods m on us.MethodId = m.Id
		join statuses st on us.StatusId = st.Id
	where	u.IsDeleted = 0 
	and m.TypeId in (1, 3) -- Data and Virtual methods
	and		cast(requestdate as date) = cast(getdate() as date)
	order by requestdate desc
END
GO
/****** Object:  Default [DF_Actions_IsDeleted]    Script Date: 09/26/2016 14:08:07 ******/
ALTER TABLE [dbo].[Actions] ADD  CONSTRAINT [DF_Actions_IsDeleted]  DEFAULT ((0)) FOR [IsDeleted]
GO
/****** Object:  Default [DF_Logs_Id]    Script Date: 09/26/2016 14:08:07 ******/
ALTER TABLE [dbo].[Audits] ADD  CONSTRAINT [DF_Logs_Id]  DEFAULT (newid()) FOR [Id]
GO
/****** Object:  Default [DF_Audits_IsDeleted]    Script Date: 09/26/2016 14:08:07 ******/
ALTER TABLE [dbo].[Audits] ADD  CONSTRAINT [DF_Audits_IsDeleted]  DEFAULT ((1)) FOR [IsDeleted]
GO
/****** Object:  Default [DF_Companies_IsDeleted]    Script Date: 09/26/2016 14:08:07 ******/
ALTER TABLE [dbo].[Companies] ADD  CONSTRAINT [DF_Companies_IsDeleted]  DEFAULT ((0)) FOR [IsDeleted]
GO
/****** Object:  Default [DF_Countries_IsDeleted]    Script Date: 09/26/2016 14:08:07 ******/
ALTER TABLE [dbo].[Countries] ADD  CONSTRAINT [DF_Countries_IsDeleted]  DEFAULT ((0)) FOR [IsDeleted]
GO
/****** Object:  Default [DF_DatabaseConfiguration_IsDeleted]    Script Date: 09/26/2016 14:08:07 ******/
ALTER TABLE [dbo].[DatabaseConfiguration] ADD  CONSTRAINT [DF_DatabaseConfiguration_IsDeleted]  DEFAULT ((0)) FOR [IsDeleted]
GO
/****** Object:  Default [DF_DataFormats_IsDeleted]    Script Date: 09/26/2016 14:08:07 ******/
ALTER TABLE [dbo].[DataFormats] ADD  CONSTRAINT [DF_DataFormats_IsDeleted]  DEFAULT ((0)) FOR [IsDeleted]
GO
/****** Object:  Default [DF_ELMAH_Error_ErrorId]    Script Date: 09/26/2016 14:08:07 ******/
ALTER TABLE [dbo].[ELMAH_Error] ADD  CONSTRAINT [DF_ELMAH_Error_ErrorId]  DEFAULT (newid()) FOR [ErrorId]
GO
/****** Object:  Default [DF_EmailTemplates_IsDeleted]    Script Date: 09/26/2016 14:08:07 ******/
ALTER TABLE [dbo].[EmailTemplates] ADD  CONSTRAINT [DF_EmailTemplates_IsDeleted]  DEFAULT ((0)) FOR [IsDeleted]
GO
/****** Object:  Default [DF_Informers_IsDeleted]    Script Date: 09/26/2016 14:08:07 ******/
ALTER TABLE [dbo].[Informers] ADD  CONSTRAINT [DF_Informers_IsDeleted]  DEFAULT ((0)) FOR [IsDeleted]
GO
/****** Object:  Default [DF_Informers_ShowFooter]    Script Date: 09/26/2016 14:08:07 ******/
ALTER TABLE [dbo].[Informers] ADD  CONSTRAINT [DF_Informers_ShowFooter]  DEFAULT ((0)) FOR [ShowFooter]
GO
/****** Object:  Default [DF_IPs_IsAllowed]    Script Date: 09/26/2016 14:08:07 ******/
ALTER TABLE [dbo].[IPs] ADD  CONSTRAINT [DF_IPs_IsAllowed]  DEFAULT ((0)) FOR [IsAllowed]
GO
/****** Object:  Default [DF_IPs_IsDeleted]    Script Date: 09/26/2016 14:08:07 ******/
ALTER TABLE [dbo].[IPs] ADD  CONSTRAINT [DF_IPs_IsDeleted]  DEFAULT ((0)) FOR [IsDeleted]
GO
/****** Object:  Default [DF_MethodGroups_Shared]    Script Date: 09/26/2016 14:08:07 ******/
ALTER TABLE [dbo].[MethodGroups] ADD  CONSTRAINT [DF_MethodGroups_Shared]  DEFAULT ((0)) FOR [Shared]
GO
/****** Object:  Default [DF_MethodGroups_IsDeleted]    Script Date: 09/26/2016 14:08:07 ******/
ALTER TABLE [dbo].[MethodGroups] ADD  CONSTRAINT [DF_MethodGroups_IsDeleted]  DEFAULT ((0)) FOR [IsDeleted]
GO
/****** Object:  Default [DF_MethodGroups_Trial]    Script Date: 09/26/2016 14:08:07 ******/
ALTER TABLE [dbo].[MethodGroups] ADD  CONSTRAINT [DF_MethodGroups_Trial]  DEFAULT ((0)) FOR [IsTrial]
GO
/****** Object:  Default [DF_Methods_TypeId]    Script Date: 09/26/2016 14:08:07 ******/
ALTER TABLE [dbo].[Methods] ADD  CONSTRAINT [DF_Methods_TypeId]  DEFAULT ((1)) FOR [TypeId]
GO
/****** Object:  Default [DF_Methods_IsDeleted]    Script Date: 09/26/2016 14:08:07 ******/
ALTER TABLE [dbo].[Methods] ADD  CONSTRAINT [DF_Methods_IsDeleted]  DEFAULT ((0)) FOR [IsDeleted]
GO
/****** Object:  Default [DF_Permissions_IsDeleted]    Script Date: 09/26/2016 14:08:07 ******/
ALTER TABLE [dbo].[Permissions] ADD  CONSTRAINT [DF_Permissions_IsDeleted]  DEFAULT ((0)) FOR [IsDeleted]
GO
/****** Object:  Default [DF_PermissionType_IsDeleted]    Script Date: 09/26/2016 14:08:07 ******/
ALTER TABLE [dbo].[PermissionType] ADD  CONSTRAINT [DF_PermissionType_IsDeleted]  DEFAULT ((0)) FOR [IsDeleted]
GO
/****** Object:  Default [DF_Resources_IsDeleted]    Script Date: 09/26/2016 14:08:07 ******/
ALTER TABLE [dbo].[Resources] ADD  CONSTRAINT [DF_Resources_IsDeleted]  DEFAULT ((0)) FOR [IsDeleted]
GO
/****** Object:  Default [DF_Roles_IsDeleted]    Script Date: 09/26/2016 14:08:07 ******/
ALTER TABLE [dbo].[Roles] ADD  CONSTRAINT [DF_Roles_IsDeleted]  DEFAULT ((0)) FOR [IsDeleted]
GO
/****** Object:  Default [DF_SearchColumns_IsDeleted]    Script Date: 09/26/2016 14:08:07 ******/
ALTER TABLE [dbo].[SearchColumns] ADD  CONSTRAINT [DF_SearchColumns_IsDeleted]  DEFAULT ((0)) FOR [IsDeleted]
GO
/****** Object:  Default [DF_SearchGroups_IsDeleted]    Script Date: 09/26/2016 14:08:07 ******/
ALTER TABLE [dbo].[SearchGroups] ADD  CONSTRAINT [DF_SearchGroups_IsDeleted]  DEFAULT ((0)) FOR [IsDeleted]
GO
/****** Object:  Default [DF_SearchTables_IsDeleted]    Script Date: 09/26/2016 14:08:07 ******/
ALTER TABLE [dbo].[SearchTables] ADD  CONSTRAINT [DF_SearchTables_IsDeleted]  DEFAULT ((0)) FOR [IsDeleted]
GO
/****** Object:  Default [DF_ServiceConfiguration_IsDeleted]    Script Date: 09/26/2016 14:08:07 ******/
ALTER TABLE [dbo].[ServiceConfiguration] ADD  CONSTRAINT [DF_ServiceConfiguration_IsDeleted]  DEFAULT ((0)) FOR [IsDeleted]
GO
/****** Object:  Default [DF_SubscriptionRequests_Accepted]    Script Date: 09/26/2016 14:08:07 ******/
ALTER TABLE [dbo].[SubscriptionRequests] ADD  CONSTRAINT [DF_SubscriptionRequests_Accepted]  DEFAULT ((0)) FOR [Accepted]
GO
/****** Object:  Default [DF_SubscriptionRequest_LastUpdate]    Script Date: 09/26/2016 14:08:07 ******/
ALTER TABLE [dbo].[SubscriptionRequests] ADD  CONSTRAINT [DF_SubscriptionRequest_LastUpdate]  DEFAULT (getdate()) FOR [LastUpdate]
GO
/****** Object:  Default [DF_SubscriptionRequest_IsProcessed]    Script Date: 09/26/2016 14:08:07 ******/
ALTER TABLE [dbo].[SubscriptionRequests] ADD  CONSTRAINT [DF_SubscriptionRequest_IsProcessed]  DEFAULT ((0)) FOR [IsFulfilled]
GO
/****** Object:  Default [DF_SubscriptionRequest_IsDeleted]    Script Date: 09/26/2016 14:08:07 ******/
ALTER TABLE [dbo].[SubscriptionRequests] ADD  CONSTRAINT [DF_SubscriptionRequest_IsDeleted]  DEFAULT ((0)) FOR [IsDeleted]
GO
/****** Object:  Default [DF_SubscriptionRequestType_IsDeleted]    Script Date: 09/26/2016 14:08:07 ******/
ALTER TABLE [dbo].[SubscriptionRequestType] ADD  CONSTRAINT [DF_SubscriptionRequestType_IsDeleted]  DEFAULT ((0)) FOR [IsDeleted]
GO
/****** Object:  Default [DF_Subscriptions_IsDeleted]    Script Date: 09/26/2016 14:08:07 ******/
ALTER TABLE [dbo].[Subscriptions] ADD  CONSTRAINT [DF_Subscriptions_IsDeleted]  DEFAULT ((0)) FOR [IsDeleted]
GO
/****** Object:  Default [DF_TimeZones_IsDeleted]    Script Date: 09/26/2016 14:08:07 ******/
ALTER TABLE [dbo].[TimeZones] ADD  CONSTRAINT [DF_TimeZones_IsDeleted]  DEFAULT ((0)) FOR [IsDeleted]
GO
/****** Object:  Default [DF_Trial_IsDeleted]    Script Date: 09/26/2016 14:08:07 ******/
ALTER TABLE [dbo].[Trial] ADD  CONSTRAINT [DF_Trial_IsDeleted]  DEFAULT ((0)) FOR [IsDeleted]
GO
/****** Object:  Default [DF_UsageStats_RequestDate]    Script Date: 09/26/2016 14:08:07 ******/
ALTER TABLE [dbo].[UsageStats] ADD  CONSTRAINT [DF_UsageStats_RequestDate]  DEFAULT (getutcdate()) FOR [RequestDate]
GO
/****** Object:  Default [DF_UsageStats_DataFormatId]    Script Date: 09/26/2016 14:08:07 ******/
ALTER TABLE [dbo].[UsageStats] ADD  CONSTRAINT [DF_UsageStats_DataFormatId]  DEFAULT ((0)) FOR [DataFormatId]
GO
/****** Object:  Default [DF_UsageStats_IsDeleted]    Script Date: 09/26/2016 14:08:07 ******/
ALTER TABLE [dbo].[UsageStats] ADD  CONSTRAINT [DF_UsageStats_IsDeleted]  DEFAULT ((0)) FOR [IsDeleted]
GO
/****** Object:  Default [DF_Users_CompanyId]    Script Date: 09/26/2016 14:08:07 ******/
ALTER TABLE [dbo].[Users] ADD  CONSTRAINT [DF_Users_CompanyId]  DEFAULT ((1)) FOR [CompanyId]
GO
/****** Object:  Default [DF_Users_IsActive]    Script Date: 09/26/2016 14:08:07 ******/
ALTER TABLE [dbo].[Users] ADD  CONSTRAINT [DF_Users_IsActive]  DEFAULT ((1)) FOR [IsActive]
GO
/****** Object:  Default [DF_Users_FailedLoginAttemptsCnt]    Script Date: 09/26/2016 14:08:07 ******/
ALTER TABLE [dbo].[Users] ADD  CONSTRAINT [DF_Users_FailedLoginAttemptsCnt]  DEFAULT ((0)) FOR [FailedLoginAttemptsCnt]
GO
/****** Object:  Default [DF_Users_IsDeleted]    Script Date: 09/26/2016 14:08:07 ******/
ALTER TABLE [dbo].[Users] ADD  CONSTRAINT [DF_Users_IsDeleted]  DEFAULT ((0)) FOR [IsDeleted]
GO
/****** Object:  Default [DF_UserSearchQueries_IsDeleted]    Script Date: 09/26/2016 14:08:07 ******/
ALTER TABLE [dbo].[UserSearchQueries] ADD  CONSTRAINT [DF_UserSearchQueries_IsDeleted]  DEFAULT ((0)) FOR [IsDeleted]
GO
/****** Object:  ForeignKey [FK_Audit_AuditActions]    Script Date: 09/26/2016 14:08:07 ******/
ALTER TABLE [dbo].[Audits]  WITH CHECK ADD  CONSTRAINT [FK_Audit_AuditActions] FOREIGN KEY([ActionId])
REFERENCES [dbo].[Actions] ([Id])
GO
ALTER TABLE [dbo].[Audits] CHECK CONSTRAINT [FK_Audit_AuditActions]
GO
/****** Object:  ForeignKey [FK_Audit_Users]    Script Date: 09/26/2016 14:08:07 ******/
ALTER TABLE [dbo].[Audits]  WITH CHECK ADD  CONSTRAINT [FK_Audit_Users] FOREIGN KEY([UserId])
REFERENCES [dbo].[Users] ([Id])
GO
ALTER TABLE [dbo].[Audits] CHECK CONSTRAINT [FK_Audit_Users]
GO
/****** Object:  ForeignKey [FK_Companies_Countries]    Script Date: 09/26/2016 14:08:07 ******/
ALTER TABLE [dbo].[Companies]  WITH CHECK ADD  CONSTRAINT [FK_Companies_Countries] FOREIGN KEY([CountryId])
REFERENCES [dbo].[Countries] ([Id])
GO
ALTER TABLE [dbo].[Companies] CHECK CONSTRAINT [FK_Companies_Countries]
GO
/****** Object:  ForeignKey [FK_Informers_Users]    Script Date: 09/26/2016 14:08:07 ******/
ALTER TABLE [dbo].[Informers]  WITH CHECK ADD  CONSTRAINT [FK_Informers_Users] FOREIGN KEY([UserId])
REFERENCES [dbo].[Users] ([Id])
GO
ALTER TABLE [dbo].[Informers] CHECK CONSTRAINT [FK_Informers_Users]
GO
/****** Object:  ForeignKey [FK_IPs_Companies]    Script Date: 09/26/2016 14:08:07 ******/
ALTER TABLE [dbo].[IPs]  WITH CHECK ADD  CONSTRAINT [FK_IPs_Companies] FOREIGN KEY([CompanyId])
REFERENCES [dbo].[Companies] ([Id])
GO
ALTER TABLE [dbo].[IPs] CHECK CONSTRAINT [FK_IPs_Companies]
GO
/****** Object:  ForeignKey [FK_IPs_Countries]    Script Date: 09/26/2016 14:08:07 ******/
ALTER TABLE [dbo].[IPs]  WITH CHECK ADD  CONSTRAINT [FK_IPs_Countries] FOREIGN KEY([GeoLocationCountryId])
REFERENCES [dbo].[Countries] ([Id])
GO
ALTER TABLE [dbo].[IPs] CHECK CONSTRAINT [FK_IPs_Countries]
GO
/****** Object:  ForeignKey [FK_MethodGroupMethod_Methods]    Script Date: 09/26/2016 14:08:07 ******/
ALTER TABLE [dbo].[MethodGroupMethod]  WITH CHECK ADD  CONSTRAINT [FK_MethodGroupMethod_Methods] FOREIGN KEY([MethodId])
REFERENCES [dbo].[Methods] ([Id])
GO
ALTER TABLE [dbo].[MethodGroupMethod] CHECK CONSTRAINT [FK_MethodGroupMethod_Methods]
GO
/****** Object:  ForeignKey [FK_StoredProcedureListStoredProcedure_StoredProceduresLists]    Script Date: 09/26/2016 14:08:07 ******/
ALTER TABLE [dbo].[MethodGroupMethod]  WITH CHECK ADD  CONSTRAINT [FK_StoredProcedureListStoredProcedure_StoredProceduresLists] FOREIGN KEY([MethodGroupId])
REFERENCES [dbo].[MethodGroups] ([Id])
GO
ALTER TABLE [dbo].[MethodGroupMethod] CHECK CONSTRAINT [FK_StoredProcedureListStoredProcedure_StoredProceduresLists]
GO
/****** Object:  ForeignKey [FK_Methods_DatabaseConfiguration]    Script Date: 09/26/2016 14:08:07 ******/
ALTER TABLE [dbo].[Methods]  WITH CHECK ADD  CONSTRAINT [FK_Methods_DatabaseConfiguration] FOREIGN KEY([DatabaseId])
REFERENCES [dbo].[DatabaseConfiguration] ([Id])
GO
ALTER TABLE [dbo].[Methods] CHECK CONSTRAINT [FK_Methods_DatabaseConfiguration]
GO
/****** Object:  ForeignKey [FK_Methods_MethodTypes]    Script Date: 09/26/2016 14:08:07 ******/
ALTER TABLE [dbo].[Methods]  WITH CHECK ADD  CONSTRAINT [FK_Methods_MethodTypes] FOREIGN KEY([TypeId])
REFERENCES [dbo].[MethodTypes] ([Id])
GO
ALTER TABLE [dbo].[Methods] CHECK CONSTRAINT [FK_Methods_MethodTypes]
GO
/****** Object:  ForeignKey [FK_Permissions_PermissionType]    Script Date: 09/26/2016 14:08:07 ******/
ALTER TABLE [dbo].[Permissions]  WITH CHECK ADD  CONSTRAINT [FK_Permissions_PermissionType] FOREIGN KEY([PermissionTypeId])
REFERENCES [dbo].[PermissionType] ([Id])
GO
ALTER TABLE [dbo].[Permissions] CHECK CONSTRAINT [FK_Permissions_PermissionType]
GO
/****** Object:  ForeignKey [FK_PermissionSearchGroup_Permissions]    Script Date: 09/26/2016 14:08:07 ******/
ALTER TABLE [dbo].[PermissionSearchGroup]  WITH CHECK ADD  CONSTRAINT [FK_PermissionSearchGroup_Permissions] FOREIGN KEY([PermissionId])
REFERENCES [dbo].[Permissions] ([Id])
GO
ALTER TABLE [dbo].[PermissionSearchGroup] CHECK CONSTRAINT [FK_PermissionSearchGroup_Permissions]
GO
/****** Object:  ForeignKey [FK_PermissionSearchGroup_SearchGroups]    Script Date: 09/26/2016 14:08:07 ******/
ALTER TABLE [dbo].[PermissionSearchGroup]  WITH CHECK ADD  CONSTRAINT [FK_PermissionSearchGroup_SearchGroups] FOREIGN KEY([SearchGroupId])
REFERENCES [dbo].[SearchGroups] ([Id])
GO
ALTER TABLE [dbo].[PermissionSearchGroup] CHECK CONSTRAINT [FK_PermissionSearchGroup_SearchGroups]
GO
/****** Object:  ForeignKey [FK_Resources_ResourceType]    Script Date: 09/26/2016 14:08:07 ******/
ALTER TABLE [dbo].[Resources]  WITH CHECK ADD  CONSTRAINT [FK_Resources_ResourceType] FOREIGN KEY([ResourceTypeId])
REFERENCES [dbo].[ResourceType] ([Id])
GO
ALTER TABLE [dbo].[Resources] CHECK CONSTRAINT [FK_Resources_ResourceType]
GO
/****** Object:  ForeignKey [FK_RolePermission_Permissions]    Script Date: 09/26/2016 14:08:07 ******/
ALTER TABLE [dbo].[RolePermission]  WITH CHECK ADD  CONSTRAINT [FK_RolePermission_Permissions] FOREIGN KEY([PermissionId])
REFERENCES [dbo].[Permissions] ([Id])
GO
ALTER TABLE [dbo].[RolePermission] CHECK CONSTRAINT [FK_RolePermission_Permissions]
GO
/****** Object:  ForeignKey [FK_RolePermission_Roles]    Script Date: 09/26/2016 14:08:07 ******/
ALTER TABLE [dbo].[RolePermission]  WITH CHECK ADD  CONSTRAINT [FK_RolePermission_Roles] FOREIGN KEY([RoleId])
REFERENCES [dbo].[Roles] ([Id])
GO
ALTER TABLE [dbo].[RolePermission] CHECK CONSTRAINT [FK_RolePermission_Roles]
GO
/****** Object:  ForeignKey [FK_SearchColumns_SearchTables]    Script Date: 09/26/2016 14:08:07 ******/
ALTER TABLE [dbo].[SearchColumns]  WITH CHECK ADD  CONSTRAINT [FK_SearchColumns_SearchTables] FOREIGN KEY([TableId])
REFERENCES [dbo].[SearchTables] ([Id])
GO
ALTER TABLE [dbo].[SearchColumns] CHECK CONSTRAINT [FK_SearchColumns_SearchTables]
GO
/****** Object:  ForeignKey [FK_SearchGroupColumns_SearchColumns]    Script Date: 09/26/2016 14:08:07 ******/
ALTER TABLE [dbo].[SearchGroupColumns]  WITH CHECK ADD  CONSTRAINT [FK_SearchGroupColumns_SearchColumns] FOREIGN KEY([SearchColumnId])
REFERENCES [dbo].[SearchColumns] ([Id])
GO
ALTER TABLE [dbo].[SearchGroupColumns] CHECK CONSTRAINT [FK_SearchGroupColumns_SearchColumns]
GO
/****** Object:  ForeignKey [FK_SearchGroupColumns_SearchGroups]    Script Date: 09/26/2016 14:08:07 ******/
ALTER TABLE [dbo].[SearchGroupColumns]  WITH CHECK ADD  CONSTRAINT [FK_SearchGroupColumns_SearchGroups] FOREIGN KEY([SearchGroupId])
REFERENCES [dbo].[SearchGroups] ([Id])
GO
ALTER TABLE [dbo].[SearchGroupColumns] CHECK CONSTRAINT [FK_SearchGroupColumns_SearchGroups]
GO
/****** Object:  ForeignKey [FK_SearchGroups_SearchTables]    Script Date: 09/26/2016 14:08:07 ******/
ALTER TABLE [dbo].[SearchGroups]  WITH CHECK ADD  CONSTRAINT [FK_SearchGroups_SearchTables] FOREIGN KEY([TableId])
REFERENCES [dbo].[SearchTables] ([Id])
GO
ALTER TABLE [dbo].[SearchGroups] CHECK CONSTRAINT [FK_SearchGroups_SearchTables]
GO
/****** Object:  ForeignKey [FK_ServiceConfiguration_ResourceType]    Script Date: 09/26/2016 14:08:07 ******/
ALTER TABLE [dbo].[ServiceConfiguration]  WITH CHECK ADD  CONSTRAINT [FK_ServiceConfiguration_ResourceType] FOREIGN KEY([ResourceTypeId])
REFERENCES [dbo].[ResourceType] ([Id])
GO
ALTER TABLE [dbo].[ServiceConfiguration] CHECK CONSTRAINT [FK_ServiceConfiguration_ResourceType]
GO
/****** Object:  ForeignKey [FK_SubscriptionRequestMethodGroup_MethodGroups]    Script Date: 09/26/2016 14:08:07 ******/
ALTER TABLE [dbo].[SubscriptionRequestMethodGroup]  WITH CHECK ADD  CONSTRAINT [FK_SubscriptionRequestMethodGroup_MethodGroups] FOREIGN KEY([MethodGroupId])
REFERENCES [dbo].[MethodGroups] ([Id])
GO
ALTER TABLE [dbo].[SubscriptionRequestMethodGroup] CHECK CONSTRAINT [FK_SubscriptionRequestMethodGroup_MethodGroups]
GO
/****** Object:  ForeignKey [FK_SubscriptionRequestMethodGroup_SubscriptionRequests]    Script Date: 09/26/2016 14:08:07 ******/
ALTER TABLE [dbo].[SubscriptionRequestMethodGroup]  WITH CHECK ADD  CONSTRAINT [FK_SubscriptionRequestMethodGroup_SubscriptionRequests] FOREIGN KEY([SubscriptionRequestId])
REFERENCES [dbo].[SubscriptionRequests] ([Id])
GO
ALTER TABLE [dbo].[SubscriptionRequestMethodGroup] CHECK CONSTRAINT [FK_SubscriptionRequestMethodGroup_SubscriptionRequests]
GO
/****** Object:  ForeignKey [FK_SubscriptionRequest_Users]    Script Date: 09/26/2016 14:08:07 ******/
ALTER TABLE [dbo].[SubscriptionRequests]  WITH CHECK ADD  CONSTRAINT [FK_SubscriptionRequest_Users] FOREIGN KEY([UserId])
REFERENCES [dbo].[Users] ([Id])
GO
ALTER TABLE [dbo].[SubscriptionRequests] CHECK CONSTRAINT [FK_SubscriptionRequest_Users]
GO
/****** Object:  ForeignKey [FK_SubscriptionRequest_Users_AcceptedBy]    Script Date: 09/26/2016 14:08:07 ******/
ALTER TABLE [dbo].[SubscriptionRequests]  WITH CHECK ADD  CONSTRAINT [FK_SubscriptionRequest_Users_AcceptedBy] FOREIGN KEY([AcceptedBy])
REFERENCES [dbo].[Users] ([Id])
GO
ALTER TABLE [dbo].[SubscriptionRequests] CHECK CONSTRAINT [FK_SubscriptionRequest_Users_AcceptedBy]
GO
/****** Object:  ForeignKey [FK_SubscriptionRequests_SubscriptionRequestType]    Script Date: 09/26/2016 14:08:07 ******/
ALTER TABLE [dbo].[SubscriptionRequests]  WITH CHECK ADD  CONSTRAINT [FK_SubscriptionRequests_SubscriptionRequestType] FOREIGN KEY([RequestTypeId])
REFERENCES [dbo].[SubscriptionRequestType] ([Id])
GO
ALTER TABLE [dbo].[SubscriptionRequests] CHECK CONSTRAINT [FK_SubscriptionRequests_SubscriptionRequestType]
GO
/****** Object:  ForeignKey [FK_Subscriptions_MethodGroups]    Script Date: 09/26/2016 14:08:07 ******/
ALTER TABLE [dbo].[Subscriptions]  WITH CHECK ADD  CONSTRAINT [FK_Subscriptions_MethodGroups] FOREIGN KEY([MethodGroupId])
REFERENCES [dbo].[MethodGroups] ([Id])
GO
ALTER TABLE [dbo].[Subscriptions] CHECK CONSTRAINT [FK_Subscriptions_MethodGroups]
GO
/****** Object:  ForeignKey [FK_Subscriptions_Users]    Script Date: 09/26/2016 14:08:07 ******/
ALTER TABLE [dbo].[Subscriptions]  WITH CHECK ADD  CONSTRAINT [FK_Subscriptions_Users] FOREIGN KEY([UserId])
REFERENCES [dbo].[Users] ([Id])
GO
ALTER TABLE [dbo].[Subscriptions] CHECK CONSTRAINT [FK_Subscriptions_Users]
GO
/****** Object:  ForeignKey [FK_Trial_SubscriptionRequests]    Script Date: 09/26/2016 14:08:07 ******/
ALTER TABLE [dbo].[Trial]  WITH CHECK ADD  CONSTRAINT [FK_Trial_SubscriptionRequests] FOREIGN KEY([RequestId])
REFERENCES [dbo].[SubscriptionRequests] ([Id])
GO
ALTER TABLE [dbo].[Trial] CHECK CONSTRAINT [FK_Trial_SubscriptionRequests]
GO
/****** Object:  ForeignKey [FK_Trial_Users]    Script Date: 09/26/2016 14:08:07 ******/
ALTER TABLE [dbo].[Trial]  WITH CHECK ADD  CONSTRAINT [FK_Trial_Users] FOREIGN KEY([UserId])
REFERENCES [dbo].[Users] ([Id])
GO
ALTER TABLE [dbo].[Trial] CHECK CONSTRAINT [FK_Trial_Users]
GO
/****** Object:  ForeignKey [FK_UsageStats_DataFormats]    Script Date: 09/26/2016 14:08:07 ******/
ALTER TABLE [dbo].[UsageStats]  WITH CHECK ADD  CONSTRAINT [FK_UsageStats_DataFormats] FOREIGN KEY([DataFormatId])
REFERENCES [dbo].[DataFormats] ([Id])
GO
ALTER TABLE [dbo].[UsageStats] CHECK CONSTRAINT [FK_UsageStats_DataFormats]
GO
/****** Object:  ForeignKey [FK_UsageStats_IPs]    Script Date: 09/26/2016 14:08:07 ******/
ALTER TABLE [dbo].[UsageStats]  WITH CHECK ADD  CONSTRAINT [FK_UsageStats_IPs] FOREIGN KEY([IpId])
REFERENCES [dbo].[IPs] ([Id])
GO
ALTER TABLE [dbo].[UsageStats] CHECK CONSTRAINT [FK_UsageStats_IPs]
GO
/****** Object:  ForeignKey [FK_UsageStats_Methods]    Script Date: 09/26/2016 14:08:07 ******/
ALTER TABLE [dbo].[UsageStats]  WITH CHECK ADD  CONSTRAINT [FK_UsageStats_Methods] FOREIGN KEY([MethodId])
REFERENCES [dbo].[Methods] ([Id])
GO
ALTER TABLE [dbo].[UsageStats] CHECK CONSTRAINT [FK_UsageStats_Methods]
GO
/****** Object:  ForeignKey [FK_UsageStats_Statuses]    Script Date: 09/26/2016 14:08:07 ******/
ALTER TABLE [dbo].[UsageStats]  WITH CHECK ADD  CONSTRAINT [FK_UsageStats_Statuses] FOREIGN KEY([StatusId])
REFERENCES [dbo].[Statuses] ([Id])
GO
ALTER TABLE [dbo].[UsageStats] CHECK CONSTRAINT [FK_UsageStats_Statuses]
GO
/****** Object:  ForeignKey [FK_UsageStats_Users]    Script Date: 09/26/2016 14:08:07 ******/
ALTER TABLE [dbo].[UsageStats]  WITH CHECK ADD  CONSTRAINT [FK_UsageStats_Users] FOREIGN KEY([UserId])
REFERENCES [dbo].[Users] ([Id])
GO
ALTER TABLE [dbo].[UsageStats] CHECK CONSTRAINT [FK_UsageStats_Users]
GO
/****** Object:  ForeignKey [FK_UserRole_Roles]    Script Date: 09/26/2016 14:08:07 ******/
ALTER TABLE [dbo].[UserRole]  WITH CHECK ADD  CONSTRAINT [FK_UserRole_Roles] FOREIGN KEY([RoleId])
REFERENCES [dbo].[Roles] ([Id])
GO
ALTER TABLE [dbo].[UserRole] CHECK CONSTRAINT [FK_UserRole_Roles]
GO
/****** Object:  ForeignKey [FK_UserRole_Users]    Script Date: 09/26/2016 14:08:07 ******/
ALTER TABLE [dbo].[UserRole]  WITH CHECK ADD  CONSTRAINT [FK_UserRole_Users] FOREIGN KEY([UserId])
REFERENCES [dbo].[Users] ([Id])
GO
ALTER TABLE [dbo].[UserRole] CHECK CONSTRAINT [FK_UserRole_Users]
GO
/****** Object:  ForeignKey [FK_Users_ThresholdPeriods]    Script Date: 09/26/2016 14:08:07 ******/
ALTER TABLE [dbo].[Users]  WITH CHECK ADD  CONSTRAINT [FK_Users_ThresholdPeriods] FOREIGN KEY([ThresholdPeriodId])
REFERENCES [dbo].[ThresholdPeriods] ([Id])
GO
ALTER TABLE [dbo].[Users] CHECK CONSTRAINT [FK_Users_ThresholdPeriods]
GO
/****** Object:  ForeignKey [FK_UserSearchQueries_Users]    Script Date: 09/26/2016 14:08:07 ******/
ALTER TABLE [dbo].[UserSearchQueries]  WITH CHECK ADD  CONSTRAINT [FK_UserSearchQueries_Users] FOREIGN KEY([UserId])
REFERENCES [dbo].[Users] ([Id])
GO
ALTER TABLE [dbo].[UserSearchQueries] CHECK CONSTRAINT [FK_UserSearchQueries_Users]
GO