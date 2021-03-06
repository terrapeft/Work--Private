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


SELECT
	'NewCentralUsers.dbo.UserDetails without uOldPassword',
	(
		SELECT
			COUNT(1)
		FROM
			NewCentralUsers.dbo.UserDetails
		WHERE
			uPassword NOT LIKE @Guid_23_characters
		AND uPassword NOT LIKE @Guid_36_characters
		AND uPassword NOT LIKE @Hex_10_characters
	)

	UNION ALL

SELECT
	'NewCentralUsers.dbo.UserDetails with uOldPassword',
	(
		SELECT
			COUNT(1)
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
	)

	UNION ALL

SELECT
	'NewCentralUsers.dbo.UserDetails_Stage without uOldPassword',
	(
		SELECT
			COUNT(1)
		FROM
			NewCentralUsers.dbo.UserDetails_Stage
		WHERE
			uPassword NOT LIKE @Guid_23_characters
		AND uPassword NOT LIKE @Guid_36_characters
		AND uPassword NOT LIKE @Hex_10_characters
	)

	UNION ALL

SELECT
	'NewCentralUsers.dbo.UserDetails_Stage with uOldPassword',
	(
		SELECT
			COUNT(1)
		FROM
			NewCentralUsers.dbo.UserDetails_Stage
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
	)