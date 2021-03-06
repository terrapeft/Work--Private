USE [Admin]
GO
/****** Object:  StoredProcedure [dbo].[CULT_DisableUserNonCULT]    Script Date: 2021-03-12 14:30:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
ALTER PROCEDURE [dbo].[CULT_DisableUserNonCULT]

   @EmailAddress varchar(1000)

AS
	SET NOCOUNT ON;
	--NCU
	EXEC [SQL-NCU].[NewCentralUsers].dbo.[CULT_DisableUser] @EmailAddress, 'CULT', 'Disabled via CULT'
	--Content
	EXEC [UK-SQL-04].[Content].dbo.[CULT_DisableUser] @EmailAddress
	--Events
	EXEC [UK-SQL-04].[Events].dbo.[CULT_DisableUser] @EmailAddress
	--OSCAR
	EXEC [UK-SQL-02].[OSCAR].dbo.[CULT_DisableUser] @EmailAddress
