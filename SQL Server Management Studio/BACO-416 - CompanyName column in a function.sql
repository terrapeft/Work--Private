USE [BackOffice]
GO
/****** Object:  UserDefinedFunction [Customer].[ufGetDefaultUserContact]    Script Date: 2019-11-19 16:59:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER FUNCTION [Customer].[ufGetDefaultUserContact]
	(
	 @UserId	INT		--	Surrogate primary key for Logon.Users
	)
RETURNS TABLE
AS 
RETURN
	(
	SELECT TOP 1
		 --u.UserId
		 @UserId AS UserId
		,u.Forenames
		,u.Surname
		--,u.Initials
		--,u.TitleId
		,u.Title
		--,u.JobTitle
		--,u.JobTitleId
		--,u.GenderId
		--,u.Gender
		--,u.GenderCode
		--,u.EmailAddressId
		--,u.EmailAddress
		--,u.CompanyId
		,u.CompanyName -- BACO-416, CompanyName is required
		,u.UserContactAddressId
		--,u.IsDefaultUserContactAddress
	    ,upnp.PhoneId
		,upnp.Phone
		,upnp.Ext
		,upnp.FaxId
		,upnp.Fax
		,upnp.MobileId
		,upnp.Mobile
	FROM
		Customer.ufGetDefaultUserContactBasic(@UserId) u 
    OUTER APPLY
	    Customer.ufPhoneNumberPivot(@UserId) upnp
	) ;


