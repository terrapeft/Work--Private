use Titan

-- [Titan].[dbo].[ConfigurationJson]
delete from [Titan].[dbo].[ConfigurationJson] where ConfigId like '%mipeventsmidas%'

-- [Titan].[dbo].[Clients]
delete from [Titan].[dbo].[Clients]
where ClientGuid in ('DEC2F177-A353-4C96-8F78-C0A5373EB61E',	'9BD0D66B-E615-4CE4-9AA5-C97CE764772C', 'B9216BDC-2E78-4F88-991F-10634340EA33')


