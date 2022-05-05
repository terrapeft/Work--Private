/*
*
*
*
*
**************************** Rollback EmailCampaign ******************************
*
*
*
*/
USE [EmailCampaign]
DROP PROCEDURE IF EXISTS dbo.C_BusinessAdminByManagerID
GO
DROP PROCEDURE IF EXISTS dbo.C_BusinessBybIndex
GO
DROP PROCEDURE IF EXISTS dbo.C_BusinessLogon
GO
DROP PROCEDURE IF EXISTS dbo.C_CampaignDataSourcesBycIndex
GO
DROP PROCEDURE IF EXISTS dbo.C_CampaignDetailsByManagerIDSelective
GO
DROP PROCEDURE IF EXISTS dbo.C_CampaignsByManagerID
GO
DROP PROCEDURE IF EXISTS dbo.C_DataSourcesBycBusiness
GO
DROP PROCEDURE IF EXISTS dbo.C_Mailinglist_CheckEmailAddress
GO
DROP PROCEDURE IF EXISTS dbo.C_ManagersByLocation
GO
DROP PROCEDURE IF EXISTS dbo.C_ManagersByManagerID
GO
DROP PROCEDURE IF EXISTS dbo.EMSSchedule
GO
DROP PROCEDURE IF EXISTS dbo.ET_UsersLogon
GO