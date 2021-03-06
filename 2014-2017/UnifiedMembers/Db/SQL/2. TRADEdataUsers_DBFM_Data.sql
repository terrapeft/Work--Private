USE [{DB_NAME}]
GO

disable trigger dbo.TRG_Applications on dbo.Applications;
disable trigger dbo.TRG_Permissions on dbo.[Permissions];
disable trigger dbo.TRG_Roles on dbo.Roles;
disable trigger dbo.TRG_Sites on dbo.Sites;

declare @outputTbl table (ID int);
declare @permissionId int, @roleId int, @siteId int, @userId int;
declare @appId int = (select ApplicationId from Applications where Code = 'dbfm');

if @appId is not null
begin
    delete from History where ApplicationId = @appId;

    delete from RolePermission where RoleId in (select RoleId from Roles where ApplicationId = @appId);
    delete from RolePermission where PermissionId in (select PermissionId from Permissions where [PermissionName] = 'DeutscheBankFM');

    delete from UserRole where RoleId in (select RoleId from Roles where ApplicationId = @appId);
    delete from Roles where ApplicationId = @appId;
    delete from [Permissions] where [PermissionName] = 'DeutscheBankFM';

    delete from SiteIPAddress where SiteId in (select SiteId from Sites where ApplicationId = @appId);
    delete from Sites where ApplicationId = @appId;

    delete from Applications where ApplicationId = @appId;
end

INSERT [dbo].[Applications] ([ApplicationName], [Code], [IsDeleted]) 
OUTPUT INSERTED.ApplicationId INTO @outputTbl(ID)
VALUES (N'Deutsche Bank Feed Manager', N'dbfm', 0)

set @appId = (select top 1 [id] from @outputTbl)
delete from @outputTbl;


INSERT [dbo].[Permissions] ([PermissionName], [PermissionDescription], [IsDeleted], [ApplicationId]) 
OUTPUT INSERTED.PermissionId INTO @outputTbl(ID)
VALUES (N'DeutscheBankFM', N'Allows to work with Deutsche Bank Feed Manager', 0, @appId)

set @permissionId = (select top 1 [id] from @outputTbl)
delete from @outputTbl;


INSERT [dbo].[Roles] ([RoleName], [RoleDescription], [IsDeleted], [ApplicationId]) 
OUTPUT INSERTED.RoleId INTO @outputTbl(ID)
VALUES (N'Deutsche Bank Feed Manager Users', N'Users of Deutsche Bank Feed Manager', 0, @appId)

set @roleId = (select top 1 [id] from @outputTbl)
delete from @outputTbl;


INSERT [dbo].[Sites] ([Name], [Host], [ShadowUser], [IsDeleted], [ApplicationId]) 
OUTPUT INSERTED.SiteId INTO @outputTbl(ID)
VALUES (N'Deutsche Bank Feed Manager', N'dbfm.dev', NULL, 0, @appId)

set @siteId = (select top 1 [id] from @outputTbl)
delete from @outputTbl;

INSERT [dbo].[RolePermission] ([RoleId], [PermissionId]) VALUES (@roleId, @permissionId);

if not exists (select * from users where username = 'scoughlan@mail.uk')
begin
    INSERT [dbo].[Users] ([CompanyId], [Firstname], [Lastname], [Username], [Password], [IsDeleted], [SessionId], [FailedAttemptsCnt], [LastAttempt]) 
    OUTPUT INSERTED.UserId INTO @outputTbl(ID)
    VALUES (1, N'Simon', N'Coughlan', N'scoughlan@mail.uk', NULL, 0, NULL, NULL, NULL)
    set @userId = (select top 1 [id] from @outputTbl)
end else
    set @userId = (select UserId from users where username = 'scoughlan@mail.uk')
delete from @outputTbl;
insert [dbo].[UserRole] (UserId, RoleId) values (@userId, @roleId);

if not exists (select * from users where username = 'vchupaev@mail.ru')
begin
    INSERT [dbo].[Users] ([CompanyId], [Firstname], [Lastname], [Username], [Password], [IsDeleted], [SessionId], [FailedAttemptsCnt], [LastAttempt]) 
    OUTPUT INSERTED.UserId INTO @outputTbl(ID)
    VALUES (2, N'Vitaly', N'Chupaev', N'vchupaev@mail.ru', NULL, 0, NULL, NULL, NULL)
    set @userId = (select top 1 [id] from @outputTbl)
end else
    set @userId = (select UserId from users where username = 'vchupaev@mail.ru')
delete from @outputTbl;
insert [dbo].[UserRole] (UserId, RoleId) values (@userId, @roleId);


enable trigger dbo.TRG_Applications on dbo.Applications;
enable trigger dbo.TRG_Permissions on dbo.[Permissions];
enable trigger dbo.TRG_Roles on dbo.Roles;
enable trigger dbo.TRG_Sites on dbo.Sites;
