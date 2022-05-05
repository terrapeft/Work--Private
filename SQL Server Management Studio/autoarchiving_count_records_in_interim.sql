use backoffice

--DBCC UPDATEUSAGE(0)

select schema_name(t.schema_id) + '.' + t.name as TableName, i.Rows as NumberOfRows
from sys.tables t
--join sys.columns c on c.object_id = t.object_id
join sys.sysindexes i on t.object_id = i.ID
where 
	indid IN (0,1) 
	and schema_name(t.schema_id) = 'Interim' 
	--and t.name like ('%_stage%')
order by i.Rows desc,T.name



-- tables with userid, addressid
select schema_name(t.schema_id) + '.' + t.name as TableName, c.Name
from sys.tables t
join sys.columns c on c.object_id = t.object_id
where schema_name(t.schema_id) = 'Interim' 
	  and c.name in ('uid', 'userid')
order by T.name


select distinct schema_name(t.schema_id) + '.' + t.name as TableName, c.Name
from sys.tables t
join sys.columns c on c.object_id = t.object_id
where schema_name(t.schema_id) = 'Interim' 
	  and c.name like '%id'
	  and c.system_type_id = 56
