use trialmanager

select [Id]
      ,[Name]
      ,[State]
      ,[PublicationId]
from [TrialManager].[dbo].[Domain]
where publicationid = 1087798
and state = 0 -- blocked
--and state = 1 -- manual approval
--where name in ('allergist.com', 'angelic.com', 'brew-master.com', 'stantonprm.com')
