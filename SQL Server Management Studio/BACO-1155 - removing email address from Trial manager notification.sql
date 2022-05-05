use TrialManager

update TrialManager.dbo.SiteTrialOptions set
ApprovalUserEmails = 'james.anderson@globalcapital.com,mark.goodes@globalcapital.com'
where Id = 210
