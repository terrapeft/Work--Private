use backoffice

create fulltext catalog Backoffice as default;  

create fulltext index on dbo.SentEmail([Message]) 
key index PK_SentEmail
with stoplist = system;