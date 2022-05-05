USE [{DB_NAME}]
GO


IF (OBJECT_ID('spTDAppSelectExchangeCodes') IS NOT NULL)
	DROP PROCEDURE [dbo].[spTDAppSelectExchangeCodes];
GO
IF (OBJECT_ID('spTDAppSelectContractTypes') IS NOT NULL)
	DROP PROCEDURE [dbo].[spTDAppSelectContractTypes];
GO

IF (OBJECT_ID('spTDAppSelectAvailableSearchGroups') IS NOT NULL)
	DROP PROCEDURE [dbo].[spTDAppSelectAvailableSearchGroups];
GO

create procedure [dbo].[spTDAppSelectExchangeCodes] 
AS
select distinct ExchangeCode from [dbo].[XymRootLevelGLOBAL] order by ExchangeCode
GO

create procedure [dbo].[spTDAppSelectContractTypes] 
AS
select distinct ContractType from [dbo].[XymRootLevelGLOBAL] order by ContractType
GO

create procedure [dbo].[spTDAppSelectAvailableSearchGroups] 
AS
select Id, Name from [{DB_NAME}].[dbo].[SearchGroups]
where IsDeleted = 0
GO

GRANT EXECUTE ON dbo.spTDAppSelectExchangeCodes TO public
DENY EXECUTE ON dbo.spTDAppSelectExchangeCodes TO guest

GRANT EXECUTE ON dbo.spTDAppSelectContractTypes TO public
DENY EXECUTE ON dbo.spTDAppSelectContractTypes TO guest

GRANT EXECUTE ON dbo.spTDAppSelectAvailableSearchGroups TO public
DENY EXECUTE ON dbo.spTDAppSelectAvailableSearchGroups TO guest