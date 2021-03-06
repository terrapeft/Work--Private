DECLARE @Guid_23_characters VARCHAR(MAX) =
    REPLICATE('[A-F0-9]', 8) + '-' +
    REPLICATE('[A-F0-9]', 4) + '-' +
    REPLICATE('[A-F0-9]', 4) + '-' +
    REPLICATE('[A-F0-9]', 4)
 
DECLARE @Guid_36_characters VARCHAR(MAX) =
    REPLICATE('[A-F0-9]', 8) + '-' +
    REPLICATE('[A-F0-9]', 4) + '-' +
    REPLICATE('[A-F0-9]', 4) + '-' +
    REPLICATE('[A-F0-9]', 4) + '-' +
    REPLICATE('[A-F0-9]', 12)
 
DECLARE @Hex_10_characters VARCHAR(MAX) = REPLICATE('[A-F0-9]', 10)

update NewCentralUsers.dbo.UserDetails
set uUpdateDate = getdate()
WHERE
	(
		uPassword NOT LIKE @Guid_23_characters
	AND uPassword NOT LIKE @Guid_36_characters
	AND uPassword NOT LIKE @Hex_10_characters
	)
	OR
	(
		uOldPassword NOT LIKE @Guid_23_characters
	AND uOldPassword NOT LIKE @Guid_36_characters
	AND uOldPassword NOT LIKE @Hex_10_characters
	)


SELECT *
FROM
	NewCentralUsers.dbo.UserDetails
WHERE
	(
		uPassword NOT LIKE @Guid_23_characters
	AND uPassword NOT LIKE @Guid_36_characters
	AND uPassword NOT LIKE @Hex_10_characters
	)
	OR
	(
		uOldPassword NOT LIKE @Guid_23_characters
	AND uOldPassword NOT LIKE @Guid_36_characters
	AND uOldPassword NOT LIKE @Hex_10_characters
	)
