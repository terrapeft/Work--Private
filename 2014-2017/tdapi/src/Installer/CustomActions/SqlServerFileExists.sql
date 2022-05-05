DECLARE @result INT
EXEC master.dbo.xp_fileexist '{0}', @result OUTPUT

select @result