use NewCentralUsers


/*

dev

*/


select top 10 *
from Backoffice.Logon.Users u
where u.UserId = 3567818


select top 10 *
from UserDetails u
where u.uID = 3567818

select count(*)
from userdetails
where uusername like 'Replaced in terms of the GDPR compliance%'


use backoffice

 

drop table if exists #tbls
drop table if exists #tbl

 

declare @sql nvarchar(1024), @table nvarchar(256)
create table #tbl (name nvarchar(256), count int)

 

SELECT 'Interim.' + name AS [Name]
into #tbls       
FROM sys.objects
WHERE type ='u'
and SCHEMA_NAME(schema_id) = 'Interim'
and (name like '%_Stage' and name not like 'InitialLoad_%' and name not like 'report_%')

 

while (select count(*) from #tbls) > 0
begin
    set @table = (select top 1 name from #tbls)
    set @sql = N'insert into #tbl select ''' + @table + ''', count(*) from ' + @table
    exec sp_executesql @sql

 

    delete top (1) 
    from #tbls
end

 

select * from #tbl
order by count