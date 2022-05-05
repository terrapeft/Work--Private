select distinct cBusinessID, b.bName, cManagerID, m.mName, count(cManagerID) [Number of Campaigns]
from C_Campaigns c join C_Managers m on c.cmanagerid = m.mIndex
join C_Business b on cBusinessID = b.bIndex
where cBusinessID in (399, 203, 204)
group by cBusinessID, b.bName, cManagerID, m.mName
order by cBusinessID, b.bName, count(cManagerID) desc, m.mName



select * 
from C_Campaigns
where cManagerID = 386 and cBusinessID in (399, 203, 204)
