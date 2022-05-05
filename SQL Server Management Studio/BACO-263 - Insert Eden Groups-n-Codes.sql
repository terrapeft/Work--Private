use newcentralusers

/*
    BACO-263
*/

BEGIN TRY
    BEGIN TRANSACTION

        declare @tasks table (pubid int, prefixId int, groupName varchar(1024), codes xml)
        declare @pubId int
        declare @prefixId int
        declare @groupName varchar(1024)
        declare @code varchar(10)
        declare @codeId int

        -- LMG
        declare @areaOfInterestCodes xml = cast('<i>9614</i><i>9615</i><i>9616</i><i>9617</i><i>9618</i><i>9619</i><i>9620</i><i>9621</i><i>9622</i><i>9623</i><i>9624</i><i>9625</i>' as xml)
        declare @lmgCompanyTypeCodes xml = cast('<i>1560</i><i>1561</i><i>1562</i><i>1563</i><i>1564</i><i>1565</i>' as xml)
        declare @lmgJobFunctionCodes xml = cast('<i>6732</i><i>6733</i><i>6734</i><i>6735</i><i>6736</i><i>6737</i><i>6738</i><i>6739</i><i>6740</i><i>6741</i><i>6742</i><i>6743</i>' as xml)

        -- Commodities
		declare @interestAreaCodesCoaltrans xml = cast('<i>1503</i>' as xml)
		declare @interestAreaCodesGlobalGrain xml = cast('<i>1950</i>' as xml)
        declare @jobFunstionCodes xml = cast('<i>5041</i><i>6229</i><i>6385</i><i>5251</i><i>5258</i><i>6649</i><i>5395</i><i>6493</i><i>5447</i><i>5524</i><i>6297</i><i>5580</i><i>5664</i><i>6317</i><i>5832</i><i>6357</i><i>5923</i><i>6205</i><i>6489</i><i>5160</i><i>9999</i>' as xml)
        declare @interestAreaCodes xml = cast('<i>10000</i><i>11376</i><i>11002</i><i>11001</i><i>11377</i><i>12054</i><i>11296</i><i>11038</i><i>12252</i><i>13000</i><i>13003</i><i>13012</i><i>13025</i><i>13026</i><i>13018</i><i>13031</i><i>13035</i><i>12000</i><i>13036</i><i>12226</i><i>11161</i><i>12232</i><i>11065</i><i>11360</i><i>11267</i><i>11096</i><i>11000</i><i>11264</i><i>11160</i><i>14000</i><i>14004</i><i>14001</i><i>11239</i><i>12159</i><i>12001</i><i>12231</i><i>12229</i><i>11115</i><i>11419</i><i>11132</i>' as xml)
        declare @companyTypeCoaltransCodes xml = cast('<i>0090</i><i>0106</i><i>0101</i><i>0093</i><i>0097</i><i>1006</i><i>1008</i><i>1010</i>' as xml)
        declare @companyTypeGlobalGrainCodes xml = cast('<i>1228</i><i>1220</i><i>1222</i><i>1210</i><i>1226</i><i>1230</i><i>1218</i><i>1224</i><i>1206</i><i>1232</i><i>1214</i><i>1200</i><i>1204</i><i>1202</i><i>1208</i>' as xml)
        declare @companyTypeOtherCodes xml = cast('<i>0001</i><i>0052</i><i>0215</i><i>0783</i><i>0223</i><i>0211</i><i>0185</i><i>0195</i><i>0207</i><i>0171</i><i>0231</i><i>0186</i><i>0239</i><i>0441</i><i>0895</i><i>0167</i><i>0949</i><i>0039</i><i>0123</i><i>0049</i><i>0119</i><i>0031</i><i>0006</i><i>0159</i><i>0010</i><i>1070</i><i>1072</i><i>0976</i><i>0975</i><i>0815</i><i>9999</i><i>0183</i><i>0397</i><i>0027</i><i>0357</i><i>0019</i><i>0051</i><i>0075</i><i>0131</i><i>0193</i><i>0107</i><i>0124</i><i>0155</i><i>0143</i><i>0963</i><i>0103</i><i>0044</i><i>0015</i><i>0299</i><i>0079</i><i>0199</i>' as xml)

        insert into @tasks values 
        -- LMG Job Function
            (5023, 5, 'Job Function', @lmgJobFunctionCodes),
            (5027, 5, 'Job Function', @lmgJobFunctionCodes),
            (5029, 5, 'Job Function', @lmgJobFunctionCodes),
            (5032, 5, 'Job Function', @lmgJobFunctionCodes),
            (5035, 5, 'Job Function', @lmgJobFunctionCodes),
        -- LMG Company Type
            (5023, 2, 'Company Type', @lmgCompanyTypeCodes),
            (5027, 2, 'Company Type', @lmgCompanyTypeCodes),
            (5029, 2, 'Company Type', @lmgCompanyTypeCodes),
            (5032, 2, 'Company Type', @lmgCompanyTypeCodes),
            (5035, 2, 'Company Type', @lmgCompanyTypeCodes),
        -- LMG Areas of Interest
            (5023, 1, 'Areas of Interest', @areaOfInterestCodes),
            (5027, 1, 'Areas of Interest', @areaOfInterestCodes),
            (5029, 1, 'Areas of Interest', @areaOfInterestCodes),
            (5032, 1, 'Areas of Interest', @areaOfInterestCodes),
            (5035, 1, 'Areas of Interest', @areaOfInterestCodes),
        -- Commodities Job Function
            (66, 5, 'Job Function', @jobFunstionCodes),
            (392, 5, 'Job Function', @jobFunstionCodes),
            (223, 5, 'Job Function', @jobFunstionCodes),
            (225, 5, 'Job Function', @jobFunstionCodes),
            (291, 5, 'Job Function', @jobFunstionCodes),
        -- Commodities Company Type
            (66, 2, 'Company Type', @companyTypeCoaltransCodes),
            (392, 2, 'Company Type', @companyTypeGlobalGrainCodes),
            (223, 2, 'Company Type', @companyTypeOtherCodes),
            (225, 2, 'Company Type', @companyTypeOtherCodes),
            (291, 2, 'Company Type', @companyTypeOtherCodes),
        -- Commodities Interest Area
            (66, 1, 'Interest Area', @interestAreaCodesCoaltrans),
            (392, 1, 'Interest Area', @interestAreaCodesGlobalGrain),
            (223, 1, 'Interest Area', @interestAreaCodes),
            (225, 1, 'Interest Area', @interestAreaCodes),
            (291, 1, 'Interest Area', @interestAreaCodes)

        declare taskCursor cursor for  
        select pubid, prefixId, groupname, p.value('.', 'varchar(10)') as [code]
        from @tasks
        cross apply codes.nodes('/i') t(p)

        open taskCursor
    
        fetch next from taskCursor into @pubid, @prefixId, @groupName, @code
  
        while @@fetch_status = 0  
        begin
            if not exists (select 1 from [NewCentralUsers].[dbo].[EdenGroup] where edgPublicationID = @pubId and edgText = @groupName)
            begin
                insert into [NewCentralUsers].[dbo].[EdenGroup] (
                    edgText,
                    edgPublicationID,
                    edgMultiple,
                    edgIsPersistent,
                    edgAnswerFormat,
                    edgIsMandatory,
                    edgPrefixID,
                    edgHorizontalAlign)
                values (
                    @groupName,
                    @pubId, 
                    1,
                    1,
                    'dropdown',
                    1,
                    @prefixId,
                    1)
                print 'Insert EdenGroup, @pubId: ' + cast(@pubid as varchar(10)) + ', @groupName: ' + @groupName
            end

            declare @groupId int
            set @groupId = (select top 1 edgGroupId from EdenGroup where edgPublicationID = @pubId and edgText = @groupName order by edgGroupId desc)
            
            set @codeId = (select edcCodeId from EdenCode where edcCode = @code)
            if not exists (select 1 from EdenGroupCodes where egcGroupID = @groupId and egcCodeId = @codeId) 
            begin 
                insert into EdenGroupCodes (egcGroupID, egcCodeID) values (@groupId, @codeId)
                print 'Insert EdenGroupCodes, groupId: ' + convert(varchar, @groupId) + ', code: ' + @code +  ', codeId: ' + convert(varchar, @codeId)
            end

            fetch next from taskCursor into @pubid, @prefixId, @groupName, @code
        end

        close taskCursor
        deallocate taskCursor
		
    COMMIT TRANSACTION;
END TRY

BEGIN CATCH
    DECLARE @error NVARCHAR(1000)
    SELECT @error = ERROR_MESSAGE()
    PRINT @error
    SELECT ERROR_NUMBER() AS ErrorNumber,
        ERROR_SEVERITY() AS ErrorSeverity,
        ERROR_STATE() AS ErrorState,
        ERROR_PROCEDURE() AS ErrorProcedure,
        ERROR_LINE() AS ErrorLine,
        ERROR_MESSAGE() AS ErrorMessage

    IF @@TRANCOUNT > 0
        ROLLBACK TRANSACTION;
END CATCH;