select '"[' + schema_name(t.schema_id) + '].[' + t.name + ']",'
from sys.tables t
join sys.sysindexes i on t.object_id = i.ID
where 
	indid IN (0,1) 
	and schema_name(t.schema_id) = 'Interim' 
union
select '"' + schema_name(t.schema_id) + '.' + t.name + '",'
from sys.tables t
--join sys.columns c on c.object_id = t.object_id
join sys.sysindexes i on t.object_id = i.ID
where 
	indid IN (0,1) 
	and schema_name(t.schema_id) = 'Interim' 
