IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Report].[uspGetCCRSReport]') AND type in (N'P', N'PC'))
DROP PROCEDURE [Report].uspGetCCRSReport

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Report].[uspGetOrdersAndPaymentsReport]') AND type in (N'P', N'PC'))
DROP PROCEDURE [Report].[uspGetOrdersAndPaymentsReport]
