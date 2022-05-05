use NewCentralUsers;

update [Publications]
set pName = 'IFLR - Midas'
where pid = 5029

update [NewCentralUsers].[dbo].[Statuses]
set stMask = 2
where stID = 1173


