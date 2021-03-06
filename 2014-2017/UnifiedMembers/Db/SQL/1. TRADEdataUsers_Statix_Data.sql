USE [{DB_NAME}]
GO

disable trigger dbo.TRG_Applications on dbo.Applications;
disable trigger dbo.TRG_Permissions on dbo.[Permissions];
disable trigger dbo.TRG_Roles on dbo.Roles;
disable trigger dbo.TRG_Sites on dbo.Sites;
disable trigger dbo.TRG_Referrers on dbo.Referrers;

declare @outputTbl table (ID int);
declare @permissionId int, @roleId int, @siteId int, @bnpSiteId int, @neSiteId int, @userId int, @refId int, @addrId int;
declare @appId int = (select ApplicationId from Applications where Code = 'statix');

if @appId is not null
begin
    delete from History where ApplicationId = @appId;

    delete from RolePermission where RoleId in (select RoleId from Roles where ApplicationId = @appId);
    delete from RolePermission where PermissionId in (select PermissionId from Permissions where [PermissionName] = 'Statix_TDAPI');
    
    delete from UserRole where RoleId in (select RoleId from Roles where ApplicationId = @appId);
    delete from Roles where ApplicationId = @appId;
    delete from [Permissions] where [PermissionName] = 'Statix_TDAPI';

    delete from SiteIPAddress where SiteId in (select SiteId from Sites where ApplicationId = @appId);
    delete from SiteReferrer where SiteId in (select SiteId from Sites where ApplicationId = @appId);

    -- delete referrers without assigned sites
    delete r from Referrers r left join SiteReferrer sr on r.ReferrerId = sr.ReferrerId where sr.ReferrerId is null;

    -- delete ips without assigned sites
    delete a from IPAddresses a left join SiteIPAddress ar on a.IPAddressId = ar.IPAddressId where ar.IPAddressId is null;
    
    delete from Sites where ApplicationId = @appId;

    delete from Applications where ApplicationId = @appId;
end

INSERT [dbo].[Applications] ([ApplicationName], [Code], [IsDeleted]) 
OUTPUT INSERTED.ApplicationId INTO @outputTbl(ID)
VALUES (N'Statix', N'statix', 0)

set @appId = (select top 1 [id] from @outputTbl)
delete from @outputTbl;


INSERT [dbo].[Permissions] ([PermissionName], [PermissionDescription], [IsDeleted], [ApplicationId]) 
OUTPUT INSERTED.PermissionId INTO @outputTbl(ID)
VALUES (N'Statix_TDAPI', N'Allows to select data from the Statix database via TDAPI', 0, @appId)

set @permissionId = (select top 1 [id] from @outputTbl)
delete from @outputTbl;


INSERT [dbo].[Roles] ([RoleName], [RoleDescription], [IsDeleted], [ApplicationId]) 
OUTPUT INSERTED.RoleId INTO @outputTbl(ID)
VALUES (N'Statix Users', N'Users alowed to access membership area', 0, @appId)

set @roleId = (select top 1 [id] from @outputTbl)
delete from @outputTbl;

INSERT [dbo].[RolePermission] ([RoleId], [PermissionId]) VALUES (@roleId, @permissionId);

if not exists (select * from users where username = 'simon.coughlan@euromoneytradedata.com')
begin
    INSERT [dbo].[Users] ([CompanyId], [Firstname], [Lastname], [Username], [Password], [IsDeleted], [SessionId], [FailedAttemptsCnt], [LastAttempt], [LastChange], [ChangedBy], [AccountExpirationDate]) VALUES 
    (1, N'Simon', N'Coughlan', N'simon.coughlan@euromoneytradedata.com', null, 0, NULL, NULL, NULL, CAST(0x0000A67801059A9B AS DateTime), N'Sep  5 2016  3:52PM', NULL)
    set @userId = (select UserId from users where username = 'simon.coughlan@euromoneytradedata.com')
    insert [dbo].[UserRole] (UserId, RoleId) values (@userId, @roleId);
end

if not exists (select * from users where username = 'vitaly.chupaev@gmail.com')
begin
    INSERT [dbo].[Users] ([CompanyId], [Firstname], [Lastname], [Username], [Password], [IsDeleted], [SessionId], [FailedAttemptsCnt], [LastAttempt], [LastChange], [ChangedBy], [AccountExpirationDate]) VALUES 
    (2, N'Vitaly', N'Chupaev', N'vitaly.chupaev@gmail.com', null, 0, NULL, NULL, NULL, CAST(0x0000A67801059A9E AS DateTime), N'Sep  5 2016  3:52PM', NULL)
    set @userId = (select UserId from users where username = 'vitaly.chupaev@gmail.com')
    insert [dbo].[UserRole] (UserId, RoleId) values (@userId, @roleId);
end

if not exists (select * from users where username = 'bnp_anonymous')
begin
    INSERT [dbo].[Users] ([CompanyId], [Firstname], [Lastname], [Username], [Password], [IsDeleted], [SessionId], [FailedAttemptsCnt], [LastAttempt], [LastChange], [ChangedBy], [AccountExpirationDate]) VALUES 
    (1, N'BNP', N'Anonymous', N'bnp_anonymous', 0x008AEE5B28CE1DEE64ACA13D33C04B06010000000C6779E9738A39DBB5DB4ED9E606AED0C0DF2D3FF17868F30F834CFAF800820315477B4BD91E344F4B76DF1C19F659E2C6054E05EC61A20C6F576AFB67BCAC81, 0, NULL, NULL, NULL, CAST(0x0000A67801059A9E AS DateTime), N'Sep  5 2016  3:52PM', NULL)
    set @userId = (select UserId from users where username = 'bnp_anonymous')
    insert [dbo].[UserRole] (UserId, RoleId) values (@userId, @roleId);
end

if not exists (select * from users where username = 'newedge_anonymous')
begin
    INSERT [dbo].[Users] ([CompanyId], [Firstname], [Lastname], [Username], [Password], [IsDeleted], [SessionId], [FailedAttemptsCnt], [LastAttempt], [LastChange], [ChangedBy], [AccountExpirationDate]) VALUES 
    (1, N'Newedge', N'Anonymous', N'newedge_anonymous', 0x008AEE5B28CE1DEE64ACA13D33C04B060100000027F77702AF6764A17A50738A531499957D13C6342640D9CCDF124B17D6C747BAB9D14C7D70526C37DCC1D5FB68DEC13382B4AE437E2BB0D827D0DA6D43CC89C8, 0, NULL, NULL, NULL, CAST(0x0000A67801059A9E AS DateTime), N'Sep  5 2016  3:52PM', NULL)
    set @userId = (select UserId from users where username = 'newedge_anonymous')
    insert [dbo].[UserRole] (UserId, RoleId) values (@userId, @roleId);
end

INSERT [dbo].[Sites] ([Name], [Host], [ShadowUser], [IsDeleted], [ApplicationId]) 
OUTPUT INSERTED.SiteId INTO @outputTbl(ID)
VALUES (N'Statix', N'{STATIX_DNS}', NULL, 0, @appId);
set @siteId = (select top 1 [id] from @outputTbl)
delete from @outputTbl;


INSERT [dbo].[Sites] ([Name], [Host], [ShadowUser], [IsDeleted], [ApplicationId]) 
OUTPUT INSERTED.SiteId INTO @outputTbl(ID)
VALUES (N'Newedge', N'{NE_DNS}', N'newedge_anonymous', 0, @appId);
set @neSiteId = (select top 1 [id] from @outputTbl)
delete from @outputTbl;


INSERT [dbo].[Sites] ([Name], [Host], [ShadowUser], [IsDeleted], [ApplicationId], [RequireReferrerCheck]) 
OUTPUT INSERTED.SiteId INTO @outputTbl(ID)
VALUES (N'BNP Paribas', N'{BNP_DNS}', N'bnp_anonymous', 0, @appId, 1);
set @bnpSiteId = (select top 1 [id] from @outputTbl)
delete from @outputTbl;



-- referrers are only for BNP site
insert into Referrers (Referrer) 
output INSERTED.ReferrerId INTO @outputTbl(ID)
values ('bnpparibas.com');
set @refId = (select top 1 [id] from @outputTbl)
delete from @outputTbl;
insert into SiteReferrer (SiteId, ReferrerId) values (@bnpSiteId, @refId);

insert into Referrers (Referrer) 
output INSERTED.ReferrerId INTO @outputTbl(ID)
values ('is.echonet');
set @refId = (select top 1 [id] from @outputTbl)
delete from @outputTbl;
insert into SiteReferrer (SiteId, ReferrerId) values (@bnpSiteId, @refId);

insert into Referrers (Referrer) 
output INSERTED.ReferrerId INTO @outputTbl(ID)
values ('{BNP_DNS}');
set @refId = (select top 1 [id] from @outputTbl)
delete from @outputTbl;
insert into SiteReferrer (SiteId, ReferrerId) values (@bnpSiteId, @refId);



insert into IPAddresses (IPAddress) 
output INSERTED.IPAddressId INTO @outputTbl(ID)
values ('127.0.0.1');
set @addrId = (select top 1 [id] from @outputTbl)
delete from @outputTbl;
insert into SiteIPAddress (SiteId, IPAddressId) values (@siteId, @addrId);
insert into SiteIPAddress (SiteId, IPAddressId) values (@bnpSiteId, @addrId);
insert into SiteIPAddress (SiteId, IPAddressId) values (@neSiteId, @addrId);

insert into IPAddresses (IPAddress) 
output INSERTED.IPAddressId INTO @outputTbl(ID)
values ('37.205.61.242');
set @addrId = (select top 1 [id] from @outputTbl)
delete from @outputTbl;
insert into SiteIPAddress (SiteId, IPAddressId) values (@siteId, @addrId);
insert into SiteIPAddress (SiteId, IPAddressId) values (@bnpSiteId, @addrId);
insert into SiteIPAddress (SiteId, IPAddressId) values (@neSiteId, @addrId);

insert into IPAddresses (IPAddress) 
output INSERTED.IPAddressId INTO @outputTbl(ID)
values ('146.255.13.55');
set @addrId = (select top 1 [id] from @outputTbl)
delete from @outputTbl;
insert into SiteIPAddress (SiteId, IPAddressId) values (@siteId, @addrId);
insert into SiteIPAddress (SiteId, IPAddressId) values (@bnpSiteId, @addrId);
insert into SiteIPAddress (SiteId, IPAddressId) values (@neSiteId, @addrId);

insert into IPAddresses (IPAddress) 
output INSERTED.IPAddressId INTO @outputTbl(ID)
values ('213.174.212.32/27');
set @addrId = (select top 1 [id] from @outputTbl)
delete from @outputTbl;
insert into SiteIPAddress (SiteId, IPAddressId) values (@siteId, @addrId);
insert into SiteIPAddress (SiteId, IPAddressId) values (@bnpSiteId, @addrId);
insert into SiteIPAddress (SiteId, IPAddressId) values (@neSiteId, @addrId);

insert into IPAddresses (IPAddress) 
output INSERTED.IPAddressId INTO @outputTbl(ID)
values ('213.174.212.158');
set @addrId = (select top 1 [id] from @outputTbl)
delete from @outputTbl;
insert into SiteIPAddress (SiteId, IPAddressId) values (@siteId, @addrId);
insert into SiteIPAddress (SiteId, IPAddressId) values (@bnpSiteId, @addrId);
insert into SiteIPAddress (SiteId, IPAddressId) values (@neSiteId, @addrId);

insert into IPAddresses (IPAddress) 
output INSERTED.IPAddressId INTO @outputTbl(ID)
values ('213.174.212.179');
set @addrId = (select top 1 [id] from @outputTbl)
delete from @outputTbl;
insert into SiteIPAddress (SiteId, IPAddressId) values (@siteId, @addrId);
insert into SiteIPAddress (SiteId, IPAddressId) values (@bnpSiteId, @addrId);
insert into SiteIPAddress (SiteId, IPAddressId) values (@neSiteId, @addrId);

insert into IPAddresses (IPAddress) 
output INSERTED.IPAddressId INTO @outputTbl(ID)
values ('213.174.212.181');
set @addrId = (select top 1 [id] from @outputTbl)
delete from @outputTbl;
insert into SiteIPAddress (SiteId, IPAddressId) values (@siteId, @addrId);
insert into SiteIPAddress (SiteId, IPAddressId) values (@bnpSiteId, @addrId);
insert into SiteIPAddress (SiteId, IPAddressId) values (@neSiteId, @addrId);

insert into IPAddresses (IPAddress) 
output INSERTED.IPAddressId INTO @outputTbl(ID)
values ('185.134.74.5');
set @addrId = (select top 1 [id] from @outputTbl)
delete from @outputTbl;
insert into SiteIPAddress (SiteId, IPAddressId) values (@siteId, @addrId);
insert into SiteIPAddress (SiteId, IPAddressId) values (@bnpSiteId, @addrId);
insert into SiteIPAddress (SiteId, IPAddressId) values (@neSiteId, @addrId);

insert into IPAddresses (IPAddress) 
output INSERTED.IPAddressId INTO @outputTbl(ID)
values ('10.107.180.0/24');
set @addrId = (select top 1 [id] from @outputTbl)
delete from @outputTbl;
insert into SiteIPAddress (SiteId, IPAddressId) values (@siteId, @addrId);
insert into SiteIPAddress (SiteId, IPAddressId) values (@bnpSiteId, @addrId);
insert into SiteIPAddress (SiteId, IPAddressId) values (@neSiteId, @addrId);

insert into IPAddresses (IPAddress) 
output INSERTED.IPAddressId INTO @outputTbl(ID)
values ('205.217.108.16');
set @addrId = (select top 1 [id] from @outputTbl)
delete from @outputTbl;
insert into SiteIPAddress (SiteId, IPAddressId) values (@siteId, @addrId);
insert into SiteIPAddress (SiteId, IPAddressId) values (@bnpSiteId, @addrId);
insert into SiteIPAddress (SiteId, IPAddressId) values (@neSiteId, @addrId);

insert into IPAddresses (IPAddress) 
output INSERTED.IPAddressId INTO @outputTbl(ID)
values ('205.217.108.23');
set @addrId = (select top 1 [id] from @outputTbl)
delete from @outputTbl;
insert into SiteIPAddress (SiteId, IPAddressId) values (@siteId, @addrId);
insert into SiteIPAddress (SiteId, IPAddressId) values (@bnpSiteId, @addrId);
insert into SiteIPAddress (SiteId, IPAddressId) values (@neSiteId, @addrId);

insert into IPAddresses (IPAddress) 
output INSERTED.IPAddressId INTO @outputTbl(ID)
values ('205.217.108.5');
set @addrId = (select top 1 [id] from @outputTbl)
delete from @outputTbl;
insert into SiteIPAddress (SiteId, IPAddressId) values (@siteId, @addrId);
insert into SiteIPAddress (SiteId, IPAddressId) values (@bnpSiteId, @addrId);
insert into SiteIPAddress (SiteId, IPAddressId) values (@neSiteId, @addrId);


enable trigger dbo.TRG_Applications on dbo.Applications;
enable trigger dbo.TRG_Permissions on dbo.[Permissions];
enable trigger dbo.TRG_Roles on dbo.Roles;
enable trigger dbo.TRG_Sites on dbo.Sites;
enable trigger dbo.TRG_Referrers on dbo.Referrers;