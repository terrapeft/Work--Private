use backoffice
go

declare @cid int
declare @ctid int

insert into Config.ConfigType (ConfigDescription, ApplicationId)
values ('GDPR replacement text', 1) -- 1 stands for Replication in the Logon.Applications
set @ctid = @@IDENTITY

insert into Config.Config (ConfigTypeId, ConfigKey, ConfigDescription, IsActive)
values (@ctid, 'AutoArchivingGDPR', 'The replacement text for expired users data. Change will impact replication triggers.', 1)
set @cid = @@IDENTITY

insert into Config.ConfigValue (ConfigId, Value)
values (@cid, N'Replaced in terms of the GDPR compliance')

insert into Config.Config (ConfigTypeId, ConfigKey, ConfigDescription, IsActive)
values (@ctid, 'AutoArchivingGDPRShort', 'The short replacement text for expired users data. GDPR compliance. Change will impact replication triggers.', 1)
set @cid = @@IDENTITY

insert into Config.ConfigValue (ConfigId, Value)
values (@cid, N'GDPR')




