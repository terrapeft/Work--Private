USE [NewCentralUsers]
GO
/****** Object:  StoredProcedure [dbo].[admin_user_update]    Script Date: 2019-07-16 14:34:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
ALTER PROCEDURE [dbo].[admin_user_update]
 (@userId int,
  @firstName varchar(100),
  @lastName varchar(100),
  @username varchar(100),
  @password varchar(100)
)
AS 

update admin_users
set auFIRST_NAME	= @firstName,
	auLAST_NAME		= @lastName,
	auUSERNAME		= @username
where 
	auId = @userId

if @password is not null and @password <> ''
begin
	declare @salt varbinary(66) = CRYPT_GEN_RANDOM(32)
	declare @hash varbinary(134)
	set @hash = @salt + HASHBYTES('SHA2_256', CAST(@password AS VARBINARY(256)) + @salt);

	update admin_users
	set auPasswordHash = @hash,
		auSalt = @salt
		--auPASSWORD = null
	where 
		auId = @userId
end