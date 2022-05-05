SELECT *

FROM dbo.Subscriptions S WITH (NOLOCK)
INNER JOIN dbo.UserDetails U WITH (NOLOCK) ON S.sUID = U.uID
--INNER JOIN dbo.Addresses A WITH (NOLOCK) ON U.uID = A.aUID AND A.aDefault = 1 --AND A.aActive = 1 
--INNER JOIN dbo.Publications PB WITH (NOLOCK) ON S.sPID = PB.pID 
WHERE 
--S.sStartDate >= DATEADD(dd, -31, DATEDIFF(dd, 0, GETDATE())) -- yesterday at midnight
--AND S.sStartDate < DATEADD(dd, 0, DATEDIFF(dd, 0, GETDATE())) -- today at midnight
--AND (O.oTest = 0 OR O.oTest IS NULL)
--AND pID NOT IN (275, 240) -- Issue tracker 60065
--AND (O.oOrderFrom <> 207 OR O.oOrderFrom IS NULL) -- Issue Tracker 63519
--AND ((s.sPID=320 
--	AND ((s.sStatus & 2 != 0)
--		OR (s.sStatus & 806560004 != 0)
--		OR (s.sStatus & 806562116 != 0)
--		OR (s.sStatus & 813688828 != 0))
--	) OR (S.sPID<>320 /*AND S.sExpirydate IS NULL AND S.sTrialExpirydate IS NOT NULL*/)) -- Issue tracker 62468


--AND 
spid = 5047
and 
u.uEmailAddress in ('Sales@alfaferroalloys.com')
order by sStartDate asc


/*
select *
from UserDetails u
where u.uEmailAddress in ('abdelhakim.benfakir@emiratessteel.com', 'abhishek.patil@cwbearing.com', 'adam.dudley@kloeckner.com', 'c.sanchez@vortix.com', 'dawn.nudi@delmonte.com')
*/