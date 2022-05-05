use LegalCompliance

-- top 100 acceptances
select top 100 
	 u.Email
	,cv.ShortCopy
	,s.SiteUri
	,a.LatestUpdate
from Acceptance a 
join ContractVersion cv on a.ContractVersionID = cv.ContractVersionID
join [User] u on a.userid = u.UserId
join [Site] s on a.SiteID = s.SiteID
order by LatestUpdate desc

-- sites with acceptances for the last 3 months
select distinct s.SiteUri
from Acceptance a 
join ContractVersion cv on a.ContractVersionID = cv.ContractVersionID
join [User] u on a.userid = u.UserId
join [Site] s on a.SiteID = s.SiteID
where a.LatestUpdate > DATEADD(month, -3, getdate())




