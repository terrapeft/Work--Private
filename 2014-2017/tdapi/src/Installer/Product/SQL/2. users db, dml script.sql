/****** Data Script for Users   Script Date: 09-12-2014 17:07:53 ******/

SET XACT_ABORT ON

USE [{DB_NAME}]

BEGIN TRANSACTION

SET IDENTITY_INSERT [dbo].[ResourceType] ON
INSERT [dbo].[ResourceType] ([Id], [Name], [Description]) VALUES (1, N'String', NULL)
INSERT [dbo].[ResourceType] ([Id], [Name], [Description]) VALUES (2, N'Int', NULL)
INSERT [dbo].[ResourceType] ([Id], [Name], [Description]) VALUES (3, N'String List', N'Content is splitted by a number of delimiters: new line, comma, whitespace, tab')
INSERT [dbo].[ResourceType] ([Id], [Name], [Description]) VALUES (4, N'Integer List', N'Same as for String List but value is converted to integer')
INSERT [dbo].[ResourceType] ([Id], [Name], [Description]) VALUES (5, N'Boolean', NULL)
INSERT [dbo].[ResourceType] ([Id], [Name], [Description]) VALUES (6, N'String Strict List', N'Unlike the String List, the new line is the only delimiter here.')
SET IDENTITY_INSERT [dbo].[ResourceType] OFF
SET IDENTITY_INSERT [dbo].[TimeZones] ON
INSERT [dbo].[TimeZones] ([Id], [Name], [Code], [IsDeleted]) VALUES (1, N'(UTC-12:00) International Date Line West', N'Dateline Standard Time', 0)
INSERT [dbo].[TimeZones] ([Id], [Name], [Code], [IsDeleted]) VALUES (2, N'(UTC-11:00) Coordinated Universal Time-11', N'UTC-11', 0)
INSERT [dbo].[TimeZones] ([Id], [Name], [Code], [IsDeleted]) VALUES (3, N'(UTC-10:00) Hawaii', N'Hawaiian Standard Time', 0)
INSERT [dbo].[TimeZones] ([Id], [Name], [Code], [IsDeleted]) VALUES (4, N'(UTC-09:00) Alaska', N'Alaskan Standard Time', 0)
INSERT [dbo].[TimeZones] ([Id], [Name], [Code], [IsDeleted]) VALUES (5, N'(UTC-08:00) Baja California', N'Pacific Standard Time (Mexico)', 0)
INSERT [dbo].[TimeZones] ([Id], [Name], [Code], [IsDeleted]) VALUES (6, N'(UTC-08:00) Pacific Time (US & Canada)', N'Pacific Standard Time', 0)
INSERT [dbo].[TimeZones] ([Id], [Name], [Code], [IsDeleted]) VALUES (7, N'(UTC-07:00) Arizona', N'US Mountain Standard Time', 0)
INSERT [dbo].[TimeZones] ([Id], [Name], [Code], [IsDeleted]) VALUES (8, N'(UTC-07:00) Chihuahua, La Paz, Mazatlan', N'Mountain Standard Time (Mexico)', 0)
INSERT [dbo].[TimeZones] ([Id], [Name], [Code], [IsDeleted]) VALUES (9, N'(UTC-07:00) Mountain Time (US & Canada)', N'Mountain Standard Time', 0)
INSERT [dbo].[TimeZones] ([Id], [Name], [Code], [IsDeleted]) VALUES (10, N'(UTC-06:00) Central America', N'Central America Standard Time', 0)
INSERT [dbo].[TimeZones] ([Id], [Name], [Code], [IsDeleted]) VALUES (11, N'(UTC-06:00) Central Time (US & Canada)', N'Central Standard Time', 0)
INSERT [dbo].[TimeZones] ([Id], [Name], [Code], [IsDeleted]) VALUES (12, N'(UTC-06:00) Guadalajara, Mexico City, Monterrey', N'Central Standard Time (Mexico)', 0)
INSERT [dbo].[TimeZones] ([Id], [Name], [Code], [IsDeleted]) VALUES (13, N'(UTC-06:00) Saskatchewan', N'Canada Central Standard Time', 0)
INSERT [dbo].[TimeZones] ([Id], [Name], [Code], [IsDeleted]) VALUES (14, N'(UTC-05:00) Bogota, Lima, Quito, Rio Branco', N'SA Pacific Standard Time', 0)
INSERT [dbo].[TimeZones] ([Id], [Name], [Code], [IsDeleted]) VALUES (15, N'(UTC-05:00) Eastern Time (US & Canada)', N'Eastern Standard Time', 0)
INSERT [dbo].[TimeZones] ([Id], [Name], [Code], [IsDeleted]) VALUES (16, N'(UTC-05:00) Indiana (East)', N'US Eastern Standard Time', 0)
INSERT [dbo].[TimeZones] ([Id], [Name], [Code], [IsDeleted]) VALUES (17, N'(UTC-04:30) Caracas', N'Venezuela Standard Time', 0)
INSERT [dbo].[TimeZones] ([Id], [Name], [Code], [IsDeleted]) VALUES (18, N'(UTC-04:00) Asuncion', N'Paraguay Standard Time', 0)
INSERT [dbo].[TimeZones] ([Id], [Name], [Code], [IsDeleted]) VALUES (19, N'(UTC-04:00) Atlantic Time (Canada)', N'Atlantic Standard Time', 0)
INSERT [dbo].[TimeZones] ([Id], [Name], [Code], [IsDeleted]) VALUES (20, N'(UTC-04:00) Cuiaba', N'Central Brazilian Standard Time', 0)
INSERT [dbo].[TimeZones] ([Id], [Name], [Code], [IsDeleted]) VALUES (21, N'(UTC-04:00) Georgetown, La Paz, Manaus, San Juan', N'SA Western Standard Time', 0)
INSERT [dbo].[TimeZones] ([Id], [Name], [Code], [IsDeleted]) VALUES (22, N'(UTC-04:00) Santiago', N'Pacific SA Standard Time', 0)
INSERT [dbo].[TimeZones] ([Id], [Name], [Code], [IsDeleted]) VALUES (23, N'(UTC-03:30) Newfoundland', N'Newfoundland Standard Time', 0)
INSERT [dbo].[TimeZones] ([Id], [Name], [Code], [IsDeleted]) VALUES (24, N'(UTC-03:00) Brasilia', N'E. South America Standard Time', 0)
INSERT [dbo].[TimeZones] ([Id], [Name], [Code], [IsDeleted]) VALUES (25, N'(UTC-03:00) Buenos Aires', N'Argentina Standard Time', 0)
INSERT [dbo].[TimeZones] ([Id], [Name], [Code], [IsDeleted]) VALUES (26, N'(UTC-03:00) Cayenne, Fortaleza', N'SA Eastern Standard Time', 0)
INSERT [dbo].[TimeZones] ([Id], [Name], [Code], [IsDeleted]) VALUES (27, N'(UTC-03:00) Greenland', N'Greenland Standard Time', 0)
INSERT [dbo].[TimeZones] ([Id], [Name], [Code], [IsDeleted]) VALUES (28, N'(UTC-03:00) Montevideo', N'Montevideo Standard Time', 0)
INSERT [dbo].[TimeZones] ([Id], [Name], [Code], [IsDeleted]) VALUES (29, N'(UTC-03:00) Salvador', N'Bahia Standard Time', 0)
INSERT [dbo].[TimeZones] ([Id], [Name], [Code], [IsDeleted]) VALUES (30, N'(UTC-02:00) Coordinated Universal Time-02', N'UTC-02', 0)
INSERT [dbo].[TimeZones] ([Id], [Name], [Code], [IsDeleted]) VALUES (31, N'(UTC-02:00) Mid-Atlantic - Old', N'Mid-Atlantic Standard Time', 0)
INSERT [dbo].[TimeZones] ([Id], [Name], [Code], [IsDeleted]) VALUES (32, N'(UTC-01:00) Azores', N'Azores Standard Time', 0)
INSERT [dbo].[TimeZones] ([Id], [Name], [Code], [IsDeleted]) VALUES (33, N'(UTC-01:00) Cape Verde Is.', N'Cape Verde Standard Time', 0)
INSERT [dbo].[TimeZones] ([Id], [Name], [Code], [IsDeleted]) VALUES (34, N'(UTC) Casablanca', N'Morocco Standard Time', 0)
INSERT [dbo].[TimeZones] ([Id], [Name], [Code], [IsDeleted]) VALUES (35, N'(UTC) Coordinated Universal Time', N'UTC', 0)
INSERT [dbo].[TimeZones] ([Id], [Name], [Code], [IsDeleted]) VALUES (36, N'(UTC) Dublin, Edinburgh, Lisbon, London', N'GMT Standard Time', 0)
INSERT [dbo].[TimeZones] ([Id], [Name], [Code], [IsDeleted]) VALUES (37, N'(UTC) Monrovia, Reykjavik', N'Greenwich Standard Time', 0)
INSERT [dbo].[TimeZones] ([Id], [Name], [Code], [IsDeleted]) VALUES (38, N'(UTC+01:00) Amsterdam, Berlin, Bern, Rome, Stockholm, Vienna', N'W. Europe Standard Time', 0)
INSERT [dbo].[TimeZones] ([Id], [Name], [Code], [IsDeleted]) VALUES (39, N'(UTC+01:00) Belgrade, Bratislava, Budapest, Ljubljana, Prague', N'Central Europe Standard Time', 0)
INSERT [dbo].[TimeZones] ([Id], [Name], [Code], [IsDeleted]) VALUES (40, N'(UTC+01:00) Brussels, Copenhagen, Madrid, Paris', N'Romance Standard Time', 0)
INSERT [dbo].[TimeZones] ([Id], [Name], [Code], [IsDeleted]) VALUES (41, N'(UTC+01:00) Sarajevo, Skopje, Warsaw, Zagreb', N'Central European Standard Time', 0)
INSERT [dbo].[TimeZones] ([Id], [Name], [Code], [IsDeleted]) VALUES (42, N'(UTC+01:00) West Central Africa', N'W. Central Africa Standard Time', 0)
INSERT [dbo].[TimeZones] ([Id], [Name], [Code], [IsDeleted]) VALUES (43, N'(UTC+01:00) Windhoek', N'Namibia Standard Time', 0)
INSERT [dbo].[TimeZones] ([Id], [Name], [Code], [IsDeleted]) VALUES (44, N'(UTC+02:00) Amman', N'Jordan Standard Time', 0)
INSERT [dbo].[TimeZones] ([Id], [Name], [Code], [IsDeleted]) VALUES (45, N'(UTC+02:00) Athens, Bucharest', N'GTB Standard Time', 0)
INSERT [dbo].[TimeZones] ([Id], [Name], [Code], [IsDeleted]) VALUES (46, N'(UTC+02:00) Beirut', N'Middle East Standard Time', 0)
INSERT [dbo].[TimeZones] ([Id], [Name], [Code], [IsDeleted]) VALUES (47, N'(UTC+02:00) Cairo', N'Egypt Standard Time', 0)
INSERT [dbo].[TimeZones] ([Id], [Name], [Code], [IsDeleted]) VALUES (48, N'(UTC+02:00) Damascus', N'Syria Standard Time', 0)
INSERT [dbo].[TimeZones] ([Id], [Name], [Code], [IsDeleted]) VALUES (49, N'(UTC+02:00) E. Europe', N'E. Europe Standard Time', 0)
INSERT [dbo].[TimeZones] ([Id], [Name], [Code], [IsDeleted]) VALUES (50, N'(UTC+02:00) Harare, Pretoria', N'South Africa Standard Time', 0)
INSERT [dbo].[TimeZones] ([Id], [Name], [Code], [IsDeleted]) VALUES (51, N'(UTC+02:00) Helsinki, Kyiv, Riga, Sofia, Tallinn, Vilnius', N'FLE Standard Time', 0)
INSERT [dbo].[TimeZones] ([Id], [Name], [Code], [IsDeleted]) VALUES (52, N'(UTC+02:00) Istanbul', N'Turkey Standard Time', 0)
INSERT [dbo].[TimeZones] ([Id], [Name], [Code], [IsDeleted]) VALUES (53, N'(UTC+02:00) Jerusalem', N'Israel Standard Time', 0)
INSERT [dbo].[TimeZones] ([Id], [Name], [Code], [IsDeleted]) VALUES (54, N'(UTC+02:00) Kaliningrad (RTZ 1)', N'Kaliningrad Standard Time', 0)
INSERT [dbo].[TimeZones] ([Id], [Name], [Code], [IsDeleted]) VALUES (55, N'(UTC+02:00) Tripoli', N'Libya Standard Time', 0)
INSERT [dbo].[TimeZones] ([Id], [Name], [Code], [IsDeleted]) VALUES (56, N'(UTC+03:00) Baghdad', N'Arabic Standard Time', 0)
INSERT [dbo].[TimeZones] ([Id], [Name], [Code], [IsDeleted]) VALUES (57, N'(UTC+03:00) Kuwait, Riyadh', N'Arab Standard Time', 0)
INSERT [dbo].[TimeZones] ([Id], [Name], [Code], [IsDeleted]) VALUES (58, N'(UTC+03:00) Minsk', N'Belarus Standard Time', 0)
INSERT [dbo].[TimeZones] ([Id], [Name], [Code], [IsDeleted]) VALUES (59, N'(UTC+03:00) Moscow, St. Petersburg, Volgograd (RTZ 2)', N'Russian Standard Time', 0)
INSERT [dbo].[TimeZones] ([Id], [Name], [Code], [IsDeleted]) VALUES (60, N'(UTC+03:00) Nairobi', N'E. Africa Standard Time', 0)
INSERT [dbo].[TimeZones] ([Id], [Name], [Code], [IsDeleted]) VALUES (61, N'(UTC+03:30) Tehran', N'Iran Standard Time', 0)
INSERT [dbo].[TimeZones] ([Id], [Name], [Code], [IsDeleted]) VALUES (62, N'(UTC+04:00) Abu Dhabi, Muscat', N'Arabian Standard Time', 0)
INSERT [dbo].[TimeZones] ([Id], [Name], [Code], [IsDeleted]) VALUES (63, N'(UTC+04:00) Baku', N'Azerbaijan Standard Time', 0)
INSERT [dbo].[TimeZones] ([Id], [Name], [Code], [IsDeleted]) VALUES (64, N'(UTC+04:00) Izhevsk, Samara (RTZ 3)', N'Russia Time Zone 3', 0)
INSERT [dbo].[TimeZones] ([Id], [Name], [Code], [IsDeleted]) VALUES (65, N'(UTC+04:00) Port Louis', N'Mauritius Standard Time', 0)
INSERT [dbo].[TimeZones] ([Id], [Name], [Code], [IsDeleted]) VALUES (66, N'(UTC+04:00) Tbilisi', N'Georgian Standard Time', 0)
INSERT [dbo].[TimeZones] ([Id], [Name], [Code], [IsDeleted]) VALUES (67, N'(UTC+04:00) Yerevan', N'Caucasus Standard Time', 0)
INSERT [dbo].[TimeZones] ([Id], [Name], [Code], [IsDeleted]) VALUES (68, N'(UTC+04:30) Kabul', N'Afghanistan Standard Time', 0)
INSERT [dbo].[TimeZones] ([Id], [Name], [Code], [IsDeleted]) VALUES (69, N'(UTC+05:00) Ashgabat, Tashkent', N'West Asia Standard Time', 0)
INSERT [dbo].[TimeZones] ([Id], [Name], [Code], [IsDeleted]) VALUES (70, N'(UTC+05:00) Ekaterinburg (RTZ 4)', N'Ekaterinburg Standard Time', 0)
INSERT [dbo].[TimeZones] ([Id], [Name], [Code], [IsDeleted]) VALUES (71, N'(UTC+05:00) Islamabad, Karachi', N'Pakistan Standard Time', 0)
INSERT [dbo].[TimeZones] ([Id], [Name], [Code], [IsDeleted]) VALUES (72, N'(UTC+05:30) Chennai, Kolkata, Mumbai, New Delhi', N'India Standard Time', 0)
INSERT [dbo].[TimeZones] ([Id], [Name], [Code], [IsDeleted]) VALUES (73, N'(UTC+05:30) Sri Jayawardenepura', N'Sri Lanka Standard Time', 0)
INSERT [dbo].[TimeZones] ([Id], [Name], [Code], [IsDeleted]) VALUES (74, N'(UTC+05:45) Kathmandu', N'Nepal Standard Time', 0)
INSERT [dbo].[TimeZones] ([Id], [Name], [Code], [IsDeleted]) VALUES (75, N'(UTC+06:00) Astana', N'Central Asia Standard Time', 0)
INSERT [dbo].[TimeZones] ([Id], [Name], [Code], [IsDeleted]) VALUES (76, N'(UTC+06:00) Dhaka', N'Bangladesh Standard Time', 0)
INSERT [dbo].[TimeZones] ([Id], [Name], [Code], [IsDeleted]) VALUES (77, N'(UTC+06:00) Novosibirsk (RTZ 5)', N'N. Central Asia Standard Time', 0)
INSERT [dbo].[TimeZones] ([Id], [Name], [Code], [IsDeleted]) VALUES (78, N'(UTC+06:30) Yangon (Rangoon)', N'Myanmar Standard Time', 0)
INSERT [dbo].[TimeZones] ([Id], [Name], [Code], [IsDeleted]) VALUES (79, N'(UTC+07:00) Bangkok, Hanoi, Jakarta', N'SE Asia Standard Time', 0)
INSERT [dbo].[TimeZones] ([Id], [Name], [Code], [IsDeleted]) VALUES (80, N'(UTC+07:00) Krasnoyarsk (RTZ 6)', N'North Asia Standard Time', 0)
INSERT [dbo].[TimeZones] ([Id], [Name], [Code], [IsDeleted]) VALUES (81, N'(UTC+08:00) Beijing, Chongqing, Hong Kong, Urumqi', N'China Standard Time', 0)
INSERT [dbo].[TimeZones] ([Id], [Name], [Code], [IsDeleted]) VALUES (82, N'(UTC+08:00) Irkutsk (RTZ 7)', N'North Asia East Standard Time', 0)
INSERT [dbo].[TimeZones] ([Id], [Name], [Code], [IsDeleted]) VALUES (83, N'(UTC+08:00) Kuala Lumpur, Singapore', N'Singapore Standard Time', 0)
INSERT [dbo].[TimeZones] ([Id], [Name], [Code], [IsDeleted]) VALUES (84, N'(UTC+08:00) Perth', N'W. Australia Standard Time', 0)
INSERT [dbo].[TimeZones] ([Id], [Name], [Code], [IsDeleted]) VALUES (85, N'(UTC+08:00) Taipei', N'Taipei Standard Time', 0)
INSERT [dbo].[TimeZones] ([Id], [Name], [Code], [IsDeleted]) VALUES (86, N'(UTC+08:00) Ulaanbaatar', N'Ulaanbaatar Standard Time', 0)
INSERT [dbo].[TimeZones] ([Id], [Name], [Code], [IsDeleted]) VALUES (87, N'(UTC+09:00) Osaka, Sapporo, Tokyo', N'Tokyo Standard Time', 0)
INSERT [dbo].[TimeZones] ([Id], [Name], [Code], [IsDeleted]) VALUES (88, N'(UTC+09:00) Seoul', N'Korea Standard Time', 0)
INSERT [dbo].[TimeZones] ([Id], [Name], [Code], [IsDeleted]) VALUES (89, N'(UTC+09:00) Yakutsk (RTZ 8)', N'Yakutsk Standard Time', 0)
INSERT [dbo].[TimeZones] ([Id], [Name], [Code], [IsDeleted]) VALUES (90, N'(UTC+09:30) Adelaide', N'Cen. Australia Standard Time', 0)
INSERT [dbo].[TimeZones] ([Id], [Name], [Code], [IsDeleted]) VALUES (91, N'(UTC+09:30) Darwin', N'AUS Central Standard Time', 0)
INSERT [dbo].[TimeZones] ([Id], [Name], [Code], [IsDeleted]) VALUES (92, N'(UTC+10:00) Brisbane', N'E. Australia Standard Time', 0)
INSERT [dbo].[TimeZones] ([Id], [Name], [Code], [IsDeleted]) VALUES (93, N'(UTC+10:00) Canberra, Melbourne, Sydney', N'AUS Eastern Standard Time', 0)
INSERT [dbo].[TimeZones] ([Id], [Name], [Code], [IsDeleted]) VALUES (94, N'(UTC+10:00) Guam, Port Moresby', N'West Pacific Standard Time', 0)
INSERT [dbo].[TimeZones] ([Id], [Name], [Code], [IsDeleted]) VALUES (95, N'(UTC+10:00) Hobart', N'Tasmania Standard Time', 0)
INSERT [dbo].[TimeZones] ([Id], [Name], [Code], [IsDeleted]) VALUES (96, N'(UTC+10:00) Magadan', N'Magadan Standard Time', 0)
INSERT [dbo].[TimeZones] ([Id], [Name], [Code], [IsDeleted]) VALUES (97, N'(UTC+10:00) Vladivostok, Magadan (RTZ 9)', N'Vladivostok Standard Time', 0)
INSERT [dbo].[TimeZones] ([Id], [Name], [Code], [IsDeleted]) VALUES (98, N'(UTC+11:00) Chokurdakh (RTZ 10)', N'Russia Time Zone 10', 0)
INSERT [dbo].[TimeZones] ([Id], [Name], [Code], [IsDeleted]) VALUES (99, N'(UTC+11:00) Solomon Is., New Caledonia', N'Central Pacific Standard Time', 0)
INSERT [dbo].[TimeZones] ([Id], [Name], [Code], [IsDeleted]) VALUES (100, N'(UTC+12:00) Anadyr, Petropavlovsk-Kamchatsky (RTZ 11)', N'Russia Time Zone 11', 0)
INSERT [dbo].[TimeZones] ([Id], [Name], [Code], [IsDeleted]) VALUES (101, N'(UTC+12:00) Auckland, Wellington', N'New Zealand Standard Time', 0)
INSERT [dbo].[TimeZones] ([Id], [Name], [Code], [IsDeleted]) VALUES (102, N'(UTC+12:00) Coordinated Universal Time+12', N'UTC+12', 0)
INSERT [dbo].[TimeZones] ([Id], [Name], [Code], [IsDeleted]) VALUES (103, N'(UTC+12:00) Fiji', N'Fiji Standard Time', 0)
INSERT [dbo].[TimeZones] ([Id], [Name], [Code], [IsDeleted]) VALUES (104, N'(UTC+12:00) Petropavlovsk-Kamchatsky - Old', N'Kamchatka Standard Time', 0)
INSERT [dbo].[TimeZones] ([Id], [Name], [Code], [IsDeleted]) VALUES (105, N'(UTC+13:00) Nuku''alofa', N'Tonga Standard Time', 0)
INSERT [dbo].[TimeZones] ([Id], [Name], [Code], [IsDeleted]) VALUES (106, N'(UTC+13:00) Samoa', N'Samoa Standard Time', 0)
INSERT [dbo].[TimeZones] ([Id], [Name], [Code], [IsDeleted]) VALUES (107, N'(UTC+14:00) Kiritimati Island', N'Line Islands Standard Time', 0)
SET IDENTITY_INSERT [dbo].[TimeZones] OFF
SET IDENTITY_INSERT [dbo].[ThresholdPeriods] ON
INSERT [dbo].[ThresholdPeriods] ([Id], [Name], [HowLong], [DatePart], [IsDeleted]) VALUES (1, N'Day', 1, N'dd', 0)
INSERT [dbo].[ThresholdPeriods] ([Id], [Name], [HowLong], [DatePart], [IsDeleted]) VALUES (2, N'Week', 1, N'ww', 0)
INSERT [dbo].[ThresholdPeriods] ([Id], [Name], [HowLong], [DatePart], [IsDeleted]) VALUES (3, N'Month', 1, N'mm', 0)
INSERT [dbo].[ThresholdPeriods] ([Id], [Name], [HowLong], [DatePart], [IsDeleted]) VALUES (4, N'Year', 1, N'yy', 0)
INSERT [dbo].[ThresholdPeriods] ([Id], [Name], [HowLong], [DatePart], [IsDeleted]) VALUES (5, N'Fortnight', 2, N'ww', 0)
SET IDENTITY_INSERT [dbo].[ThresholdPeriods] OFF
SET IDENTITY_INSERT [dbo].[SubscriptionRequestType] ON
INSERT [dbo].[SubscriptionRequestType] ([Id], [Name], [IsDeleted]) VALUES (1, N'Add', 0)
INSERT [dbo].[SubscriptionRequestType] ([Id], [Name], [IsDeleted]) VALUES (2, N'Remove', 0)
INSERT [dbo].[SubscriptionRequestType] ([Id], [Name], [IsDeleted]) VALUES (3, N'Trial', 0)
SET IDENTITY_INSERT [dbo].[SubscriptionRequestType] OFF
SET IDENTITY_INSERT [dbo].[Statuses] ON
INSERT [dbo].[Statuses] ([Id], [Name], [IsDeleted]) VALUES (1, N'Succeeded', 0)
INSERT [dbo].[Statuses] ([Id], [Name], [IsDeleted]) VALUES (2, N'Failed', 0)
SET IDENTITY_INSERT [dbo].[Statuses] OFF

/****** Object:  Table [dbo].[ServiceConfiguration]    Script Date: 09/29/2016 19:21:34 ******/
SET IDENTITY_INSERT [dbo].[ServiceConfiguration] ON
INSERT [dbo].[ServiceConfiguration] ([Id], [Name], [Value], [Description], [IsDeleted], [ResourceTypeId], [GroupName]) VALUES (1, N'Smtp Sender', N'noreply@fowtradedata.com', N'Is used in the FROM field.', 0, 1, N'Smtp')
INSERT [dbo].[ServiceConfiguration] ([Id], [Name], [Value], [Description], [IsDeleted], [ResourceTypeId], [GroupName]) VALUES (2, N'Enable SSL', N'False', N'This option should be set to True if TLS is enabled.', 0, 5, N'Smtp')
INSERT [dbo].[ServiceConfiguration] ([Id], [Name], [Value], [Description], [IsDeleted], [ResourceTypeId], [GroupName]) VALUES (3, N'Smtp Host', N'smtp.fowtradedata.com', NULL, 0, 1, N'Smtp')
INSERT [dbo].[ServiceConfiguration] ([Id], [Name], [Value], [Description], [IsDeleted], [ResourceTypeId], [GroupName]) VALUES (4, N'Smtp Port', N'25', NULL, 0, 2, N'Smtp')
INSERT [dbo].[ServiceConfiguration] ([Id], [Name], [Value], [Description], [IsDeleted], [ResourceTypeId], [GroupName]) VALUES (5, N'Smtp Recipients', N'simon.coughlan@euromoneytradedata.com', N'Email(s) of person(s) in charge to receive notifications from the system.', 0, 1, N'Smtp')
INSERT [dbo].[ServiceConfiguration] ([Id], [Name], [Value], [Description], [IsDeleted], [ResourceTypeId], [GroupName]) VALUES (6, N'IP Lookup URL', N'http://www.geoplugin.net/json.gp?ip={0}', N'URL of the web service which provides geolocation details about requested IP.
The expected output is:

{
  "geoplugin_countryName":"Spain",
  "geoplugin_continentCode":"EU"
}

It may contain more properties, but only these two are required.', 0, 1, N'Common')
INSERT [dbo].[ServiceConfiguration] ([Id], [Name], [Value], [Description], [IsDeleted], [ResourceTypeId], [GroupName]) VALUES (11, N'CSV Convertor Tables Separator', N'[Table{0}]', N'When service method returns several tables, and format is CSV, this is a text before each table.', 0, 1, N'Service output')
INSERT [dbo].[ServiceConfiguration] ([Id], [Name], [Value], [Description], [IsDeleted], [ResourceTypeId], [GroupName]) VALUES (12, N'Max Login Attempts', N'3', N'Number of failed attempts before a user is got locked', 0, 2, N'Common')
INSERT [dbo].[ServiceConfiguration] ([Id], [Name], [Value], [Description], [IsDeleted], [ResourceTypeId], [GroupName]) VALUES (14, N'Error 500 Contact Person', N'vitaly.chupaev@arcadia.spb.ru', N'This email is used on Error.aspx page in suggestion to contact administrator.', 0, 1, N'Common')
INSERT [dbo].[ServiceConfiguration] ([Id], [Name], [Value], [Description], [IsDeleted], [ResourceTypeId], [GroupName]) VALUES (18, N'Prediction Number Of Suggestions', N'10', N'Maximum number of suggestions for Search.', 0, 2, N'Customer UI')
INSERT [dbo].[ServiceConfiguration] ([Id], [Name], [Value], [Description], [IsDeleted], [ResourceTypeId], [GroupName]) VALUES (22, N'Prediction Min Length', N'2', N'Minimal length of search string to activate autocomplete feature.', 0, 2, N'Customer UI')
INSERT [dbo].[ServiceConfiguration] ([Id], [Name], [Value], [Description], [IsDeleted], [ResourceTypeId], [GroupName]) VALUES (23, N'Search Results Page Size', N'10', N'In UI - how many results to return from service and show on page.
In Service - how many results to return for request without specified Page Size parameter (ps).', 0, 2, N'Customer UI')
INSERT [dbo].[ServiceConfiguration] ([Id], [Name], [Value], [Description], [IsDeleted], [ResourceTypeId], [GroupName]) VALUES (24, N'Home Page Refresh Interval', N'10', N'Time in minutes to refresh the Admin''s home page. Not in use at the moment.', 0, 2, N'NOT IN USE')
INSERT [dbo].[ServiceConfiguration] ([Id], [Name], [Value], [Description], [IsDeleted], [ResourceTypeId], [GroupName]) VALUES (33, N'Default Search Option', N'3', N'Starts With = 1
Ends With = 2
Contains = 3
Equals = 4', 0, 2, N'Customer UI')
INSERT [dbo].[ServiceConfiguration] ([Id], [Name], [Value], [Description], [IsDeleted], [ResourceTypeId], [GroupName]) VALUES (34, N'Default Search Groups', N'0', N'0 for all, otherwise group ids separated by comma, e.g.: 121,134,12', 0, 3, N'Customer UI')
INSERT [dbo].[ServiceConfiguration] ([Id], [Name], [Value], [Description], [IsDeleted], [ResourceTypeId], [GroupName]) VALUES (42, N'CUI Export Archive Filename', N'FowTradeData-SearchResults-{0}', N'The name of the archive (zip), which is send to user in response for export request.

Placeholder is for date, check the CUI Export Date Format in this section.', 0, 1, N'Customer UI Export')
INSERT [dbo].[ServiceConfiguration] ([Id], [Name], [Value], [Description], [IsDeleted], [ResourceTypeId], [GroupName]) VALUES (43, N'CUI Export Date Format', N'yyyy-MMM-dd-HHmmss', N'Used for archive file name.', 0, 1, N'Customer UI Export')
INSERT [dbo].[ServiceConfiguration] ([Id], [Name], [Value], [Description], [IsDeleted], [ResourceTypeId], [GroupName]) VALUES (44, N'CUI Export Series Filename', N'series', N'The name of the file inside the archive for series data.

File name will be appeneded with extension appropriate to chosen format.', 0, 1, N'Customer UI Export')
INSERT [dbo].[ServiceConfiguration] ([Id], [Name], [Value], [Description], [IsDeleted], [ResourceTypeId], [GroupName]) VALUES (45, N'CUI Export Root Filename', N'root', N'The name of the file inside the archive for root data.

File name will be appeneded with extension appropriate to chosen format.', 0, 1, N'Customer UI Export')
INSERT [dbo].[ServiceConfiguration] ([Id], [Name], [Value], [Description], [IsDeleted], [ResourceTypeId], [GroupName]) VALUES (46, N'Search Keys Aliases', N's=Keyword
ec=Exchange Codes
ct=Contract Types
so=Comparison Type
sc=Search Groups IDs
ps=Page Size
pn=Page Number
se=Include Series
u=Username
p=Password
cn=Show Columns (CSV)
q=Force Quotes (CSV)
ij=Indent JSON
d=Delimiter (CSV)', N'URL parameters for search requests are not meaningful, so mapping allows to change them to something readable, when looking into statistics.', 0, 6, N'Usage Stats Config')
INSERT [dbo].[ServiceConfiguration] ([Id], [Name], [Value], [Description], [IsDeleted], [ResourceTypeId], [GroupName]) VALUES (47, N'GetBySymbol API Help', N'GetBySymbol
---------------------------------------------------------------------------------
Input:
                [s]: required, search phrase;
                [sc]: optonal, column group id or list separated with comma, without whitespace, like 1,2,3,4, use the GetAvailableSearchGroups method to load up-to-date list to search over all the groups omit the parameter;
                [se]: optional, 1 - include series in result set, default is 0
                [re]: optional, 1 - include root data in result set, default is 1
                [so]: optional, comparison option id, 1 (Starts With), 2 (Ends With), 3 (Contains) or 4 (Equals), default is {0}
                [ec]: optional, exchange code, use the GetExchangeCodes method to load up-to-date list, using all codes by default
                [ct]: optional, contract type, use the GetContractTypes method to load up-to-date list, using all types by default
                [sa]: optional, advanced search, in case series are not included into the result set (se=0), this will provide an additional table in result set with keys for which serieas are available, e.g. string AMEX12622, which is ContractName + ContractType
                [zip]: optional, 1 - return results as zip archive (stream, browser will start file download automatically)
                [u]: required, username
                [p]: required, password

Output, result sets:
RootCount:      shows total root records number when re=1 option is used, otherwise is zero
SeriesCount:    shows total series records number when se=1 option is used, otherwise is zero
Table0:         root level data
Series0:        series
Availability0:  presents when sa=1 and se=0, keys for which serieas are available, the key is a concatenation of ContractName and ContractType
Protection0:    presents when sa=1, specifies if there are protected columns in the output, columns data is replaced with notification if current subscription doesn''''t allow to view the content

Examples:

https://127.0.0.1/GetBySymbol/count?s=arc&so=3&ec=BATS&ct=Q&u=user1&p=pwd1
https://127.0.0.1/GetBySymbol/csv?s=arc&sc=1,2,3,16,17&so=3&ec=AMEX,ADEX&ct=A,C,E&u=user1&p=pwd1', N'Help template for the GetBySymbol pseudo method, which actually stands for the search call.

Notice the placeholder for a default comparison type.', 0, 1, N'Search')
INSERT [dbo].[ServiceConfiguration] ([Id], [Name], [Value], [Description], [IsDeleted], [ResourceTypeId], [GroupName]) VALUES (48, N'Exclude Series Columns', N'row_number
CFIUnderlyingAssetCode
ContractNumber
CycleCode
rowId
ID', N'A way to exclude columns from search and from results set for series table.', 0, 3, N'Search')
INSERT [dbo].[ServiceConfiguration] ([Id], [Name], [Value], [Description], [IsDeleted], [ResourceTypeId], [GroupName]) VALUES (49, N'Exclude Root Columns', NULL, N'A way to exclude columns from search and from results set for series table.', 0, 3, N'Search')
INSERT [dbo].[ServiceConfiguration] ([Id], [Name], [Value], [Description], [IsDeleted], [ResourceTypeId], [GroupName]) VALUES (50, N'SubscriptionRequest ToString Template', N'<span class="entity-data-coll-header">Request {0}:</span><br>{1}<br>', N'Used in the overridden ToString method of the corresponding EF entity.

{0} is for Id, {1} is for packages list.', 0, 1, N'Class Output Format')
INSERT [dbo].[ServiceConfiguration] ([Id], [Name], [Value], [Description], [IsDeleted], [ResourceTypeId], [GroupName]) VALUES (51, N'New Line', N'<br>', N'Used in several places, when html output should have a new line.', 0, 1, N'Class Output Format')
INSERT [dbo].[ServiceConfiguration] ([Id], [Name], [Value], [Description], [IsDeleted], [ResourceTypeId], [GroupName]) VALUES (58, N'Original To New Template', N'<b>{0}:</b> <span style="color: grey">{1}</span> ➜ <span style="color: black">{2}</span><br>', N'Update template for Audit Parameter to format output before showing in the grid.

{0} is for parameter name
{1} is for original value
{2} is for new value', 0, 1, N'Class Output Format')
INSERT [dbo].[ServiceConfiguration] ([Id], [Name], [Value], [Description], [IsDeleted], [ResourceTypeId], [GroupName]) VALUES (59, N'Key Value Template', N'<b>{0}</b>: {1}<br>', N'Template for different purposes, when a key-value pair should be formatted for output.

{0} is for parameter name
{1} is for parameter value', 0, 1, N'Class Output Format')
INSERT [dbo].[ServiceConfiguration] ([Id], [Name], [Value], [Description], [IsDeleted], [ResourceTypeId], [GroupName]) VALUES (60, N'Subscription Request Subject', N'Subscription request.', NULL, 0, 1, N'Subscription Request Notification')
INSERT [dbo].[ServiceConfiguration] ([Id], [Name], [Value], [Description], [IsDeleted], [ResourceTypeId], [GroupName]) VALUES (61, N'Subscription Request Body', N'This is an automated message. Please do not reply.

A new subsrciption request was created.
Please check the Today''s Request informer or Subscrription Requests page.', NULL, 0, 1, N'Subscription Request Notification')
INSERT [dbo].[ServiceConfiguration] ([Id], [Name], [Value], [Description], [IsDeleted], [ResourceTypeId], [GroupName]) VALUES (62, N'Subscription Request Accepted Notification Subject', N'Subscription request has been accepted.', NULL, 0, 1, N'Subscription Request Notification')
INSERT [dbo].[ServiceConfiguration] ([Id], [Name], [Value], [Description], [IsDeleted], [ResourceTypeId], [GroupName]) VALUES (63, N'Subscription Request Accepted Notification Body', N'Dear, 
Your subscription request has been accepted. 
You can now use requested methods.', N'', 0, 1, N'Subscription Request Notification')
INSERT [dbo].[ServiceConfiguration] ([Id], [Name], [Value], [Description], [IsDeleted], [ResourceTypeId], [GroupName]) VALUES (64, N'Subscription Request Declined Notification Subject', N'Subscription request has been declined.', NULL, 0, 1, N'Subscription Request Notification')
INSERT [dbo].[ServiceConfiguration] ([Id], [Name], [Value], [Description], [IsDeleted], [ResourceTypeId], [GroupName]) VALUES (65, N'Subscription Request Declined Notification Body', N'Dear, 
Your subscription request has been declined, you can find the reason on the My Accout page in the Requests History.', N'', 0, 1, N'Subscription Request Notification')
INSERT [dbo].[ServiceConfiguration] ([Id], [Name], [Value], [Description], [IsDeleted], [ResourceTypeId], [GroupName]) VALUES (82, N'TradeData API Service URL', N'{API_PROTOCOL}://{API_DNS}/', N'The root path of the service.', 0, 1, N'Service')
INSERT [dbo].[ServiceConfiguration] ([Id], [Name], [Value], [Description], [IsDeleted], [ResourceTypeId], [GroupName]) VALUES (84, N'Contact Information Email', N'support@euromoneytradedata.com', N'Anywhere, where contact email required.', 0, 1, N'Contact Information')
INSERT [dbo].[ServiceConfiguration] ([Id], [Name], [Value], [Description], [IsDeleted], [ResourceTypeId], [GroupName]) VALUES (85, N'Contact Information Phone', N'+44 (0)1277 633777', N'Anywhere, where a contact email required.', 0, 1, N'Contact Information')
INSERT [dbo].[ServiceConfiguration] ([Id], [Name], [Value], [Description], [IsDeleted], [ResourceTypeId], [GroupName]) VALUES (91, N'Database Mail Profile Name', N'{DB_MAIL_PROFILE}', NULL, 0, 1, N'Smtp')
SET IDENTITY_INSERT [dbo].[ServiceConfiguration] OFF



SET IDENTITY_INSERT [dbo].[SearchTables] ON
INSERT [dbo].[SearchTables] ([Id], [Name], [IsDeleted]) VALUES (1, N'XymRootLevelGLOBAL', 0)
INSERT [dbo].[SearchTables] ([Id], [Name], [IsDeleted]) VALUES (2, N'XymREUTERSTradedSeriesGLOBAL', 0)
SET IDENTITY_INSERT [dbo].[SearchTables] OFF
SET IDENTITY_INSERT [dbo].[Roles] ON
INSERT [dbo].[Roles] ([Id], [Name], [IsDeleted]) VALUES (1, N'Administrator', 0)
INSERT [dbo].[Roles] ([Id], [Name], [IsDeleted]) VALUES (2, N'Customer', 0)
INSERT [dbo].[Roles] ([Id], [Name], [IsDeleted]) VALUES (3, N'Trial User', 0)
INSERT [dbo].[Roles] ([Id], [Name], [IsDeleted]) VALUES (4, N'Reuters reader', 0)
INSERT [dbo].[Roles] ([Id], [Name], [IsDeleted]) VALUES (5, N'Resources Admin', 0)
INSERT [dbo].[Roles] ([Id], [Name], [IsDeleted]) VALUES (6, N'Bloomberg reader', 0)
SET IDENTITY_INSERT [dbo].[Roles] OFF
SET IDENTITY_INSERT [dbo].[Actions] ON
INSERT [dbo].[Actions] ([Id], [Name], [IsDeleted]) VALUES (1, N'Create', 0)
INSERT [dbo].[Actions] ([Id], [Name], [IsDeleted]) VALUES (2, N'Update', 0)
INSERT [dbo].[Actions] ([Id], [Name], [IsDeleted]) VALUES (3, N'Delete', 0)
INSERT [dbo].[Actions] ([Id], [Name], [IsDeleted]) VALUES (4, N'Log in', 0)
INSERT [dbo].[Actions] ([Id], [Name], [IsDeleted]) VALUES (5, N'Concurrent log off', 0)
INSERT [dbo].[Actions] ([Id], [Name], [IsDeleted]) VALUES (6, N'Forbidden IP Address', 0)
SET IDENTITY_INSERT [dbo].[Actions] OFF
SET IDENTITY_INSERT [dbo].[MethodGroups] ON
INSERT [dbo].[MethodGroups] ([Id], [Name], [Shared], [IsDeleted], [IsTrial]) VALUES (16, N'Trial TDA 1', 0, 0, 1)
INSERT [dbo].[MethodGroups] ([Id], [Name], [Shared], [IsDeleted], [IsTrial]) VALUES (17, N'Trial TDA 2', 0, 0, 1)
INSERT [dbo].[MethodGroups] ([Id], [Name], [Shared], [IsDeleted], [IsTrial]) VALUES (18, N'Absolutely Free', 1, 0, 0)
INSERT [dbo].[MethodGroups] ([Id], [Name], [Shared], [IsDeleted], [IsTrial]) VALUES (19, N'Search', 1, 0, 0)

SET IDENTITY_INSERT [dbo].[MethodGroups] OFF
SET IDENTITY_INSERT [dbo].[Resources] ON
INSERT [dbo].[Resources] ([Id], [Name], [Value], [Description], [IsDeleted], [ResourceTypeId], [GroupName]) VALUES (1, N'Dataset Is Null Or Empty', N'Data set is null or contains no tables.', N'When user requests some data from the service and returned DataSet has no tables, this message will occur. In current implementation most likely this message won''t ever occur.', 0, 1, N'API response')
INSERT [dbo].[Resources] ([Id], [Name], [Value], [Description], [IsDeleted], [ResourceTypeId], [GroupName]) VALUES (2, N'Dataset No Tables', N'No results.', N'When therу are no results to return for user''s request, this message is provided.', 0, 1, N'API response')
INSERT [dbo].[Resources] ([Id], [Name], [Value], [Description], [IsDeleted], [ResourceTypeId], [GroupName]) VALUES (3, N'Help Has No Input Params', N' This method has no input parameters.
', N'When user requests a help for the method(s), this is a part of generated help for the case when method has no parameters.', 0, 1, N'API Help Generation')
INSERT [dbo].[Resources] ([Id], [Name], [Value], [Description], [IsDeleted], [ResourceTypeId], [GroupName]) VALUES (5, N'Help Options', N'

General help:
---------------------------------------------------------------------------------

Dates:
If you need to pass dates, use ISO 8601 format, e.g.:
"startDate=2014-12-21"
"startDate=2014-12-21T12:12:12"
"startDate=2014-12-21T12:12:12Z"
"startDate=2014-12-21T12:12:12+3"
"startDate=2014-12-21T12:12:12+0300"

CSV options:
add column names: "cn=true",
specify custom delimiter: "d=;" or "d=%3b"
force quotes: "q=true"

JSON options:
use indents: "ij=true"

Filter, sort output:
You can apply filters to the output and sort records.
When providing column name, use prefixes like t0, t1, etc.
Method may return several tables and index should match the table index started from zero, so if there is one table, always use t0, if there are two use t0 and t1.
If table prefix is omitted, the parameter is treated as method''s argument, but not as a filter.

Available filters are:
"=": equal, t0.ColumnName=Value
"gt": greater then, t0.ColumnName-gt=Value
"lt": less then, t0.ColumnName-lt=Value
"gte": greater then or equal, t0.ColumnName-gte=Value
"lte": less then or equal, t0.ColumnName-lte=Value
"like": SQL "like" operator, use "%" as a wildcard, you MUST use URL encoded percent sign - "%25", t0.ColumnName-like=%25Value%25, t0.ColumnName=Value%25
"in": SQL "in", separate values with comma, without quotes, t0.ColumnName-in=1,2,3 or t0.ColumnName-in=new year,old school,red fox
"notin": SQL "not in" same rules like for "in", t0.ColumnName-notin=1,2,3 or t0.ColumnName-notin=new year,old school,red fox
"sort": you can order output by column or by several columns, t0.ColumnName-sort=ASC&t0.AnotherColumnName-sort=DESC
"and": concatenate current condition with previous one, "and" is a default value and can be omitted, t0.ColumnName=14&t0.and-AnotherColumnName=AMEX same as t0.ColumnName=14&t0.AnotherColumnName=AMEX
"or": t0.ColumnName=14&t0.or-AnotherColumnName=AMEX

you can specify several filters for one column.', N'This is a common part of help, which is generated for the help request.', 0, 1, N'API Help Generation')
INSERT [dbo].[Resources] ([Id], [Name], [Value], [Description], [IsDeleted], [ResourceTypeId], [GroupName]) VALUES (6, N'Help Sp Suggest To Specify Params', N'Specify at least all not nullable method parameters to see the output definition.

', N'When user requests help for the method without parameters, this message appears.
When parameters are specified it is possible to execute the procedure and obtain output details, so it is suggested to do.', 0, 1, N'API Help Generation')
INSERT [dbo].[Resources] ([Id], [Name], [Value], [Description], [IsDeleted], [ResourceTypeId], [GroupName]) VALUES (7, N'Not Implemented Message', N'Method and/or format are not supported.
Try to change method format.', N'User will see the message in case he attempts to call the method with unsupported data format, for example call search with format set to "list".', 0, 1, N'API')
INSERT [dbo].[Resources] ([Id], [Name], [Value], [Description], [IsDeleted], [ResourceTypeId], [GroupName]) VALUES (8, N'Service No SP Name', N'Stored procedure name was not specified.', N'Exception message, shown on request parameters validation.', 0, 1, N'Validation')
INSERT [dbo].[Resources] ([Id], [Name], [Value], [Description], [IsDeleted], [ResourceTypeId], [GroupName]) VALUES (9, N'Service Parameter Is Null', N'No parameters were provided.', N'Exception message, shown on request parameters validation.', 0, 1, N'Validation')
INSERT [dbo].[Resources] ([Id], [Name], [Value], [Description], [IsDeleted], [ResourceTypeId], [GroupName]) VALUES (10, N'Email Account Locked Body', N'Your account has been locked because the number of consecutive log-in failures exceeded the maximum allowed.', N'Notification email body.', 0, 1, N'User lock notification')
INSERT [dbo].[Resources] ([Id], [Name], [Value], [Description], [IsDeleted], [ResourceTypeId], [GroupName]) VALUES (11, N'Email Account Locked Subject', N'Your TradeData account has been locked.', N'Notification email subject.', 0, 1, N'User lock notification')
INSERT [dbo].[Resources] ([Id], [Name], [Value], [Description], [IsDeleted], [ResourceTypeId], [GroupName]) VALUES (12, N'Error 401 No Credentials', N'Username and password are required, please specify "u" and "p" parameters.', N'User may see this message in response for his request.', 0, 1, N'API response')
INSERT [dbo].[Resources] ([Id], [Name], [Value], [Description], [IsDeleted], [ResourceTypeId], [GroupName]) VALUES (13, N'Error 403 Exceeds Hits', N'Exceeding the limit of hits.
Your current limitation is {0} hits per {1}.', N'Threshold limit exceeded.', 0, 1, N'API response')
INSERT [dbo].[Resources] ([Id], [Name], [Value], [Description], [IsDeleted], [ResourceTypeId], [GroupName]) VALUES (14, N'Error 405 Method Not Allowed', N'Unknown method or not in a subscription.', N'Occurs when user is not authorized to use the requested method.', 0, 1, N'API response')
INSERT [dbo].[Resources] ([Id], [Name], [Value], [Description], [IsDeleted], [ResourceTypeId], [GroupName]) VALUES (15, N'Error 403 Restricted IP', N'Your IP address is not recognized.', N'Occurs when clients IP is not in allowed list.', 0, 1, N'API response')
INSERT [dbo].[Resources] ([Id], [Name], [Value], [Description], [IsDeleted], [ResourceTypeId], [GroupName]) VALUES (16, N'Error 500', N'An internal server error occurred, please contact administrator.', N'When some fault is occured in the service, this message will be sent to the client. Usage Stats will contain some information about the error and Error log will contain technical details.', 0, 1, N'API response')
INSERT [dbo].[Resources] ([Id], [Name], [Value], [Description], [IsDeleted], [ResourceTypeId], [GroupName]) VALUES (17, N'Error 401 Incorrect Credentials', N'Invalid username or password.', NULL, 0, 1, N'API response')
INSERT [dbo].[Resources] ([Id], [Name], [Value], [Description], [IsDeleted], [ResourceTypeId], [GroupName]) VALUES (19, N'Unique Constraint Violation Error', N'Value already exists in database. Note that it could be a deleted record.', N'Occurs in Admin UI on attempt to save a duplicate, like username.', 0, 1, N'Admin UI')
INSERT [dbo].[Resources] ([Id], [Name], [Value], [Description], [IsDeleted], [ResourceTypeId], [GroupName]) VALUES (20, N'Search Results Require Permission', N'To view this column you require additional permissions, please contact administrator.', N'The real values of protected columns will be replaced with this message in search results', 0, 1, N'Search results')
INSERT [dbo].[Resources] ([Id], [Name], [Value], [Description], [IsDeleted], [ResourceTypeId], [GroupName]) VALUES (21, N'Search Results Found In Restricted Column', N'Found in restricted column', N'Displayed on search results page, in the panel caption, when the search text was found in restricted columns.', 0, 1, N'Search results')
INSERT [dbo].[Resources] ([Id], [Name], [Value], [Description], [IsDeleted], [ResourceTypeId], [GroupName]) VALUES (22, N'Error 400 No Parameter Value', N'Method parameters without values are not allowed.', N'When using Search and providing some parmaeters without values, like 

http://127.0.0.1/count?&ec=&ct=', 0, 1, N'API response')
INSERT [dbo].[Resources] ([Id], [Name], [Value], [Description], [IsDeleted], [ResourceTypeId], [GroupName]) VALUES (23, N'Error 400 No Keyword', N'Search keyword was not specified.', N'Search keyword was not specified for Search request.', 0, 1, N'API response')
INSERT [dbo].[Resources] ([Id], [Name], [Value], [Description], [IsDeleted], [ResourceTypeId], [GroupName]) VALUES (24, N'Account Expired Notification Subject', N'You TradeData account expired.', N'Coming expiration notification, can be send only manualy by clicking the ''Notify'' link of the ''Recent Expirations'' informer.', 0, 1, N'User Account Notification')
INSERT [dbo].[Resources] ([Id], [Name], [Value], [Description], [IsDeleted], [ResourceTypeId], [GroupName]) VALUES (25, N'Account Expired Notification Body', N'Dear User, see the subject.', N'Coming expiration notification, can be send only manualy by clicking the ''Notify'' link of the ''Recent Expirations'' informer.', 0, 1, N'User Account Notification')
INSERT [dbo].[Resources] ([Id], [Name], [Value], [Description], [IsDeleted], [ResourceTypeId], [GroupName]) VALUES (26, N'Account Expires Soon Notification Subject', N'You TradeData account will expire soon.', N'Coming expiration notification, can be send only manualy by clicking the ''Notify'' link of the ''Coming Expirations'' informer.', 0, 1, N'User Account Notification')
INSERT [dbo].[Resources] ([Id], [Name], [Value], [Description], [IsDeleted], [ResourceTypeId], [GroupName]) VALUES (27, N'Account Expires Soon Notification Body', N'Dear User, see the subject.', N'Coming expiration notification, can be send only manualy by clicking the ''Notify'' link of the ''Coming Expirations'' informer.', 0, 1, N'User Account Notification')
INSERT [dbo].[Resources] ([Id], [Name], [Value], [Description], [IsDeleted], [ResourceTypeId], [GroupName]) VALUES (28, N'TrialAdmin Reference to Trial CUI Group', N'Change in the [System Settings/ServiceConfiguration], the Trial group.', N'This message is shown when you preview the email template.', 0, 1, N'Admin UI')
INSERT [dbo].[Resources] ([Id], [Name], [Value], [Description], [IsDeleted], [ResourceTypeId], [GroupName]) VALUES (29, N'Trial Email Exists', N'User with provided email already exists.', N'Trial request comment, in case user provided existed email.', 0, 1, N'Trial')
INSERT [dbo].[Resources] ([Id], [Name], [Value], [Description], [IsDeleted], [ResourceTypeId], [GroupName]) VALUES (30, N'Error 404 Packages Not Found', N'No available methods found for the specified account.', N'When user requests a list of methods and there is no any available.', 0, 1, N'API response')
INSERT [dbo].[Resources] ([Id], [Name], [Value], [Description], [IsDeleted], [ResourceTypeId], [GroupName]) VALUES (31, N'Error 404 Method Not Found', N'Method not found.', N'Unknown method requested.', 1, 1, N'API response')
INSERT [dbo].[Resources] ([Id], [Name], [Value], [Description], [IsDeleted], [ResourceTypeId], [GroupName]) VALUES (32, N'CUI Invalid Login Attempt Label', N'<br>
                        Invalid username and / or password.
                        <br>
                        <br>
                        If you have forgotten your password please contact your Account Manager <a href="mailto:{0}">{0}</a> or call us on  {1}&nbsp;<br>
                        <br>
                        <br>', N'Shown on the login control panel, which becomes visible on failed attempt.

{0} stands for an email,
{1} stands for a phone number', 0, 1, N'UI Text')
INSERT [dbo].[Resources] ([Id], [Name], [Value], [Description], [IsDeleted], [ResourceTypeId], [GroupName]) VALUES (33, N'Submit Trial Request Success', N'Dear {0}, your request was successfully submitted.
You will receive an email with your account details shortly.', N'{0} stands for the name provided in the submission form.', 0, 1, N'Trial')
INSERT [dbo].[Resources] ([Id], [Name], [Value], [Description], [IsDeleted], [ResourceTypeId], [GroupName]) VALUES (34, N'Submit Trial Error', N'An error occurred while processing your request. Please use another way to contact us.', N'When user submits a trial request, but something goes wrong.', 0, 1, N'Trial')
SET IDENTITY_INSERT [dbo].[Resources] OFF
SET IDENTITY_INSERT [dbo].[PermissionType] ON
INSERT [dbo].[PermissionType] ([Id], [Name], [IsDeleted]) VALUES (1, N'Built In', 0)
INSERT [dbo].[PermissionType] ([Id], [Name], [IsDeleted]) VALUES (2, N'Search Groups', 0)
INSERT [dbo].[PermissionType] ([Id], [Name], [IsDeleted]) VALUES (3, N'SuperAdmin', 1)
SET IDENTITY_INSERT [dbo].[PermissionType] OFF
SET IDENTITY_INSERT [dbo].[MethodTypes] ON
INSERT [dbo].[MethodTypes] ([Id], [Name], [IsDeleted]) VALUES (1, N'Data', 0)
INSERT [dbo].[MethodTypes] ([Id], [Name], [IsDeleted]) VALUES (2, N'Informer', 0)
INSERT [dbo].[MethodTypes] ([Id], [Name], [IsDeleted]) VALUES (3, N'Virtual', 0)
INSERT [dbo].[MethodTypes] ([Id], [Name], [IsDeleted]) VALUES (4, N'Site Data', 0)
SET IDENTITY_INSERT [dbo].[MethodTypes] OFF
SET IDENTITY_INSERT [dbo].[DataFormats] ON
INSERT [dbo].[DataFormats] ([Id], [Name], [IsDeleted]) VALUES (0, N'TEXT', 0)
INSERT [dbo].[DataFormats] ([Id], [Name], [IsDeleted]) VALUES (1, N'JSON', 0)
INSERT [dbo].[DataFormats] ([Id], [Name], [IsDeleted]) VALUES (2, N'XML', 0)
INSERT [dbo].[DataFormats] ([Id], [Name], [IsDeleted]) VALUES (3, N'CSV', 0)
INSERT [dbo].[DataFormats] ([Id], [Name], [IsDeleted]) VALUES (4, N'HELP', 0)
INSERT [dbo].[DataFormats] ([Id], [Name], [IsDeleted]) VALUES (5, N'LIST', 0)
INSERT [dbo].[DataFormats] ([Id], [Name], [IsDeleted]) VALUES (6, N'COUNT', 0)
SET IDENTITY_INSERT [dbo].[DataFormats] OFF
SET IDENTITY_INSERT [dbo].[DatabaseConfiguration] ON
INSERT [dbo].[DatabaseConfiguration] ([Id], [Alias], [ConnectionString], [StoredProcPrefix], [StoredProcParamPrefix], [StoredProcMethodPrefix], [StoredProcOwner], [StoredProcInformerPrefix], [IsDefault], [IsDeleted]) VALUES (1, N'tda', N'Server={TDA_SERVER};Database=TRADEdataAPI;Timeout=180;{TDA_USER};', N'spTDAppSelect', N'@param', N'Get', N'dbo', N'spInformer', 1, 0)
INSERT [dbo].[DatabaseConfiguration] ([Id], [Alias], [ConnectionString], [StoredProcPrefix], [StoredProcParamPrefix], [StoredProcMethodPrefix], [StoredProcOwner], [StoredProcInformerPrefix], [IsDefault], [IsDeleted]) VALUES (2, N'gs', N'Data Source={GS_SERVER};Initial Catalog=GenericSpecs;Connect Timeout=180;{GS_USER};', N'spBRSelectBR', N'@param', N'Get', N'dbo', N'spInformer', NULL, 0)
--INSERT [dbo].[DatabaseConfiguration] ([Id], [Alias], [ConnectionString], [StoredProcPrefix], [StoredProcParamPrefix], [StoredProcMethodPrefix], [StoredProcOwner], [StoredProcInformerPrefix], [IsDefault], [IsDeleted]) VALUES (1, N'tda', N'Server=.;Database=TRADEdataAPI;Timeout=180;Integrated Security=SSPI;', N'spTDAppSelect', N'@param', N'Get', N'dbo', N'spInformer', 1, 0)
--INSERT [dbo].[DatabaseConfiguration] ([Id], [Alias], [ConnectionString], [StoredProcPrefix], [StoredProcParamPrefix], [StoredProcMethodPrefix], [StoredProcOwner], [StoredProcInformerPrefix], [IsDefault], [IsDeleted]) VALUES (2, N'gs', N'Data Source=.;Initial Catalog=GenericSpecs;Integrated Security=True;Connect Timeout=180', N'spBRSelectBR', N'@param', N'Get', N'dbo', N'spInformer', NULL, 0)
--INSERT [dbo].[DatabaseConfiguration] ([Id], [Alias], [ConnectionString], [StoredProcPrefix], [StoredProcParamPrefix], [StoredProcMethodPrefix], [StoredProcOwner], [StoredProcInformerPrefix], [IsDefault], [IsDeleted]) VALUES (4, N'usr', N'Data Source=.;Initial Catalog=Users;Integrated Security=True;Connect Timeout=180', N'spSelect', N'@', N'Get', N'dbo', N'spInformer', 0, 0)
SET IDENTITY_INSERT [dbo].[DatabaseConfiguration] OFF
SET IDENTITY_INSERT [dbo].[Countries] ON
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (1, N'Afghanistan', N'AF', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (2, N'Albania', N'AL', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (3, N'Algeria', N'DZ', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (4, N'American Samoa', N'AS', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (5, N'Andorra', N'AD', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (6, N'Angola', N'AO', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (7, N'Anguilla', N'AI', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (8, N'Antarctica', N'AQ', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (9, N'Antigua and Barbuda', N'AG', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (10, N'Argentina', N'AR', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (11, N'Armenia', N'AM', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (12, N'Aruba', N'AW', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (13, N'Australia', N'AU', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (14, N'Austria', N'AT', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (15, N'Azerbaijan', N'AZ', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (16, N'Bahamas', N'BS', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (17, N'Bahrain', N'BH', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (18, N'Bangladesh', N'BD', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (19, N'Barbados', N'BB', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (20, N'Belarus', N'BY', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (21, N'Belgium', N'BE', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (22, N'Belize', N'BZ', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (23, N'Benin', N'BJ', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (24, N'Bermuda', N'BM', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (25, N'Bhutan', N'BT', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (26, N'Bolivia', N'BO', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (27, N'Bosnia and Herzegovina', N'BA', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (28, N'Botswana', N'BW', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (29, N'Bouvet Island', N'BV', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (30, N'Brazil', N'BR', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (31, N'British Antarctic Territory', N'BQ', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (32, N'British Indian Ocean Territory', N'IO', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (33, N'British Virgin Islands', N'VG', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (34, N'Brunei', N'BN', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (35, N'Bulgaria', N'BG', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (36, N'Burkina Faso', N'BF', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (37, N'Burundi', N'BI', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (38, N'Cambodia', N'KH', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (39, N'Cameroon', N'CM', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (40, N'Canada', N'CA', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (41, N'Canton and Enderbury Islands', N'CT', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (42, N'Cape Verde', N'CV', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (43, N'Cayman Islands', N'KY', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (44, N'Central African Republic', N'CF', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (45, N'Chad', N'TD', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (46, N'Chile', N'CL', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (47, N'China', N'CN', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (48, N'Christmas Island', N'CX', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (49, N'Cocos [Keeling] Islands', N'CC', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (50, N'Colombia', N'CO', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (51, N'Comoros', N'KM', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (52, N'Congo - Brazzaville', N'CG', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (53, N'Congo - Kinshasa', N'CD', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (54, N'Cook Islands', N'CK', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (55, N'Costa Rica', N'CR', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (56, N'Croatia', N'HR', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (57, N'Cuba', N'CU', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (58, N'Cyprus', N'CY', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (59, N'Czech Republic', N'CZ', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (60, N'Cote d’Ivoire', N'CI', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (61, N'Denmark', N'DK', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (62, N'Djibouti', N'DJ', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (63, N'Dominica', N'DM', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (64, N'Dominican Republic', N'DO', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (65, N'Dronning Maud Land', N'NQ', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (66, N'East Germany', N'DD', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (67, N'Ecuador', N'EC', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (68, N'Egypt', N'EG', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (69, N'El Salvador', N'SV', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (70, N'Equatorial Guinea', N'GQ', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (71, N'Eritrea', N'ER', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (72, N'Estonia', N'EE', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (73, N'Ethiopia', N'ET', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (74, N'Falkland Islands', N'FK', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (75, N'Faroe Islands', N'FO', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (76, N'Fiji', N'FJ', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (77, N'Finland', N'FI', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (78, N'France', N'FR', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (79, N'French Guiana', N'GF', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (80, N'French Polynesia', N'PF', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (81, N'French Southern Territories', N'TF', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (82, N'French Southern and Antarctic Territories', N'FQ', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (83, N'Gabon', N'GA', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (84, N'Gambia', N'GM', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (85, N'Georgia', N'GE', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (86, N'Germany', N'DE', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (87, N'Ghana', N'GH', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (88, N'Gibraltar', N'GI', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (89, N'Greece', N'GR', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (90, N'Greenland', N'GL', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (91, N'Grenada', N'GD', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (92, N'Guadeloupe', N'GP', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (93, N'Guam', N'GU', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (94, N'Guatemala', N'GT', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (95, N'Guernsey', N'GG', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (96, N'Guinea', N'GN', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (97, N'Guinea-Bissau', N'GW', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (98, N'Guyana', N'GY', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (99, N'Haiti', N'HT', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (100, N'Heard Island and McDonald Islands', N'HM', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (101, N'Honduras', N'HN', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (102, N'Hong Kong SAR China', N'HK', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (103, N'Hungary', N'HU', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (104, N'Iceland', N'IS', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (105, N'India', N'IN', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (106, N'Indonesia', N'ID', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (107, N'Iran', N'IR', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (108, N'Iraq', N'IQ', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (109, N'Ireland', N'IE', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (110, N'Isle of Man', N'IM', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (111, N'Israel', N'IL', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (112, N'Italy', N'IT', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (113, N'Jamaica', N'JM', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (114, N'Japan', N'JP', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (115, N'Jersey', N'JE', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (116, N'Johnston Island', N'JT', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (117, N'Jordan', N'JO', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (118, N'Kazakhstan', N'KZ', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (119, N'Kenya', N'KE', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (120, N'Kiribati', N'KI', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (121, N'Kuwait', N'KW', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (122, N'Kyrgyzstan', N'KG', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (123, N'Laos', N'LA', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (124, N'Latvia', N'LV', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (125, N'Lebanon', N'LB', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (126, N'Lesotho', N'LS', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (127, N'Liberia', N'LR', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (128, N'Libya', N'LY', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (129, N'Liechtenstein', N'LI', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (130, N'Lithuania', N'LT', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (131, N'Luxembourg', N'LU', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (132, N'Macau SAR China', N'MO', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (133, N'Macedonia', N'MK', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (134, N'Madagascar', N'MG', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (135, N'Malawi', N'MW', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (136, N'Malaysia', N'MY', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (137, N'Maldives', N'MV', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (138, N'Mali', N'ML', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (139, N'Malta', N'MT', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (140, N'Marshall Islands', N'MH', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (141, N'Martinique', N'MQ', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (142, N'Mauritania', N'MR', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (143, N'Mauritius', N'MU', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (144, N'Mayotte', N'YT', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (145, N'Metropolitan France', N'FX', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (146, N'Mexico', N'MX', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (147, N'Micronesia', N'FM', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (148, N'Midway Islands', N'MI', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (149, N'Moldova', N'MD', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (150, N'Monaco', N'MC', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (151, N'Mongolia', N'MN', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (152, N'Montenegro', N'ME', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (153, N'Montserrat', N'MS', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (154, N'Morocco', N'MA', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (155, N'Mozambique', N'MZ', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (156, N'Myanmar [Burma]', N'MM', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (157, N'Namibia', N'NA', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (158, N'Nauru', N'NR', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (159, N'Nepal', N'NP', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (160, N'Netherlands', N'NL', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (161, N'Netherlands Antilles', N'AN', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (162, N'Neutral Zone', N'NT', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (163, N'New Caledonia', N'NC', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (164, N'New Zealand', N'NZ', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (165, N'Nicaragua', N'NI', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (166, N'Niger', N'NE', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (167, N'Nigeria', N'NG', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (168, N'Niue', N'NU', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (169, N'Norfolk Island', N'NF', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (170, N'North Korea', N'KP', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (171, N'North Vietnam', N'VD', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (172, N'Northern Mariana Islands', N'MP', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (173, N'Norway', N'NO', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (174, N'Oman', N'OM', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (175, N'Pacific Islands Trust Territory', N'PC', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (176, N'Pakistan', N'PK', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (177, N'Palau', N'PW', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (178, N'Palestinian Territories', N'PS', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (179, N'Panama', N'PA', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (180, N'Panama Canal Zone', N'PZ', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (181, N'Papua New Guinea', N'PG', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (182, N'Paraguay', N'PY', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (183, N'People''s Democratic Republic of Yemen', N'YD', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (184, N'Peru', N'PE', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (185, N'Philippines', N'PH', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (186, N'Pitcairn Islands', N'PN', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (187, N'Poland', N'PL', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (188, N'Portugal', N'PT', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (189, N'Puerto Rico', N'PR', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (190, N'Qatar', N'QA', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (191, N'Romania', N'RO', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (192, N'Russia', N'RU', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (193, N'Rwanda', N'RW', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (194, N'Reunion', N'RE', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (195, N'Saint Barthelemy', N'BL', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (196, N'Saint Helena', N'SH', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (197, N'Saint Kitts and Nevis', N'KN', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (198, N'Saint Lucia', N'LC', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (199, N'Saint Martin', N'MF', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (200, N'Saint Pierre and Miquelon', N'PM', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (201, N'Saint Vincent and the Grenadines', N'VC', 0)

INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (202, N'Samoa', N'WS', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (203, N'San Marino', N'SM', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (204, N'Saudi Arabia', N'SA', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (205, N'Senegal', N'SN', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (206, N'Serbia', N'RS', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (207, N'Serbia and Montenegro', N'CS', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (208, N'Seychelles', N'SC', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (209, N'Sierra Leone', N'SL', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (210, N'Singapore', N'SG', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (211, N'Slovakia', N'SK', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (212, N'Slovenia', N'SI', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (213, N'Solomon Islands', N'SB', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (214, N'Somalia', N'SO', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (215, N'South Africa', N'ZA', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (216, N'South Georgia and the South Sandwich Islands', N'GS', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (217, N'South Korea', N'KR', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (218, N'Spain', N'ES', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (219, N'Sri Lanka', N'LK', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (220, N'Sudan', N'SD', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (221, N'Suriname', N'SR', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (222, N'Svalbard and Jan Mayen', N'SJ', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (223, N'Swaziland', N'SZ', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (224, N'Sweden', N'SE', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (225, N'Switzerland', N'CH', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (226, N'Syria', N'SY', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (227, N'Sao Tome and Principe', N'ST', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (228, N'Taiwan', N'TW', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (229, N'Tajikistan', N'TJ', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (230, N'Tanzania', N'TZ', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (231, N'Thailand', N'TH', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (232, N'Timor-Leste', N'TL', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (233, N'Togo', N'TG', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (234, N'Tokelau', N'TK', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (235, N'Tonga', N'TO', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (236, N'Trinidad and Tobago', N'TT', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (237, N'Tunisia', N'TN', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (238, N'Turkey', N'TR', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (239, N'Turkmenistan', N'TM', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (240, N'Turks and Caicos Islands', N'TC', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (241, N'Tuvalu', N'TV', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (242, N'U.S. Minor Outlying Islands', N'UM', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (243, N'U.S. Miscellaneous Pacific Islands', N'PU', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (244, N'U.S. Virgin Islands', N'VI', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (245, N'Uganda', N'UG', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (246, N'Ukraine', N'UA', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (247, N'Union of Soviet Socialist Republics', N'SU', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (248, N'United Arab Emirates', N'AE', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (249, N'United Kingdom', N'GB', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (250, N'United States', N'US', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (251, N'Unknown or Invalid Region', N'ZZ', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (252, N'Uruguay', N'UY', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (253, N'Uzbekistan', N'UZ', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (254, N'Vanuatu', N'VU', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (255, N'Vatican City', N'VA', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (256, N'Venezuela', N'VE', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (257, N'Vietnam', N'VN', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (258, N'Wake Island', N'WK', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (259, N'Wallis and Futuna', N'WF', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (260, N'Western Sahara', N'EH', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (261, N'Yemen', N'YE', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (262, N'Zambia', N'ZM', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (263, N'Zimbabwe', N'ZW', 0)
INSERT [dbo].[Countries] ([Id], [Name], [Code], [IsDeleted]) VALUES (264, N'Aland Islands', N'AX', 0)
SET IDENTITY_INSERT [dbo].[Countries] OFF
SET IDENTITY_INSERT [dbo].[Companies] ON
INSERT [dbo].[Companies] ([Id], [Name], [Address], [Phone], [Fax], [CountryId], [IsDeleted]) VALUES (1, N'TradeData', N'81 High St, Billericay, Essex CM12 9AS, United Kingdom', N'441277633777', N'441277633777', 249, 0)
INSERT [dbo].[Companies] ([Id], [Name], [Address], [Phone], [Fax], [CountryId], [IsDeleted]) VALUES (2, N'Arcadia', N'Zanevskiy prospect 30 k2, St Petersburg, Russia', N'78126105955', NULL, 192, 0)
SET IDENTITY_INSERT [dbo].[Companies] OFF
SET IDENTITY_INSERT [dbo].[Methods] ON
INSERT [dbo].[Methods] ([Id], [Name], [DisplayName], [TypeId], [IsDeleted], [DatabaseId]) VALUES (3, N'GetAIIExchangeContractType', N'Get AII Exchange Contract Type', 1, 0, 1)
INSERT [dbo].[Methods] ([Id], [Name], [DisplayName], [TypeId], [IsDeleted], [DatabaseId]) VALUES (4, N'GetBankHolidayDescription', N'Get Bank Holiday Description', 1, 0, 1)
INSERT [dbo].[Methods] ([Id], [Name], [DisplayName], [TypeId], [IsDeleted], [DatabaseId]) VALUES (5, N'GetBankHolidayDescriptionByISOTerritory', N'Get Bank Holiday Description By ISO Territory', 1, 0, 1)
INSERT [dbo].[Methods] ([Id], [Name], [DisplayName], [TypeId], [IsDeleted], [DatabaseId]) VALUES (6, N'GetBankHolidays', N'Get Bank Holidays', 1, 0, 1)
INSERT [dbo].[Methods] ([Id], [Name], [DisplayName], [TypeId], [IsDeleted], [DatabaseId]) VALUES (7, N'GetCFICodeByExchangeCodeAndContractNumber', N'Get CFI Code By Exchange Code And Contract Number', 1, 0, 1)
INSERT [dbo].[Methods] ([Id], [Name], [DisplayName], [TypeId], [IsDeleted], [DatabaseId]) VALUES (8, N'GetCFIUnderlyingAsset', N'Get CFI Underlying Asset', 1, 0, 1)
INSERT [dbo].[Methods] ([Id], [Name], [DisplayName], [TypeId], [IsDeleted], [DatabaseId]) VALUES (9, N'GetCFIUnderlyingAssetContractTypeMap', N'Get CFI Underlying Asset Contract Type Map', 1, 0, 1)
INSERT [dbo].[Methods] ([Id], [Name], [DisplayName], [TypeId], [IsDeleted], [DatabaseId]) VALUES (10, N'GetCFTCData', N'Get CFTC Data', 1, 0, 1)
INSERT [dbo].[Methods] ([Id], [Name], [DisplayName], [TypeId], [IsDeleted], [DatabaseId]) VALUES (11, N'GetCFTCDataByExchangeCodeAndContractNumber', N'Get CFTC Data By Exchange Code And Contract Number', 1, 0, 1)
INSERT [dbo].[Methods] ([Id], [Name], [DisplayName], [TypeId], [IsDeleted], [DatabaseId]) VALUES (12, N'GetContinent', N'Get Continent', 1, 0, 1)
INSERT [dbo].[Methods] ([Id], [Name], [DisplayName], [TypeId], [IsDeleted], [DatabaseId]) VALUES (13, N'GetContinentForControl', N'Get Continent For Control', 1, 0, 1)
INSERT [dbo].[Methods] ([Id], [Name], [DisplayName], [TypeId], [IsDeleted], [DatabaseId]) VALUES (14, N'GetContractAndRelatedByExchangeCodeAndContractNumber', N'Get Contract And Related By Exchange Code And Contract Number', 1, 0, 1)
INSERT [dbo].[Methods] ([Id], [Name], [DisplayName], [TypeId], [IsDeleted], [DatabaseId]) VALUES (15, N'GetContractAuditAmendByDateAndExchangeCode', N'Get Contract Audit Amend By Date And Exchange Code', 1, 0, 1)
INSERT [dbo].[Methods] ([Id], [Name], [DisplayName], [TypeId], [IsDeleted], [DatabaseId]) VALUES (16, N'GetContractAuditInsertOrDeleteByDateAndExchangeCode', N'Get Contract Audit Insert Or Delete By Date And Exchange Code', 1, 0, 1)
INSERT [dbo].[Methods] ([Id], [Name], [DisplayName], [TypeId], [IsDeleted], [DatabaseId]) VALUES (17, N'GetContractAuditStatsByYear', N'Get Contract Audit Stats By Year', 1, 0, 1)
INSERT [dbo].[Methods] ([Id], [Name], [DisplayName], [TypeId], [IsDeleted], [DatabaseId]) VALUES (18, N'GetContractAuditStatsByYearAndMonth', N'Get Contract Audit Stats By Year And Month', 1, 0, 1)
INSERT [dbo].[Methods] ([Id], [Name], [DisplayName], [TypeId], [IsDeleted], [DatabaseId]) VALUES (19, N'GetContractByArrayForPaging', N'Get Contract By Array For Paging', 1, 0, 1)
INSERT [dbo].[Methods] ([Id], [Name], [DisplayName], [TypeId], [IsDeleted], [DatabaseId]) VALUES (20, N'GetContractByExchange', N'Get Contract By Exchange', 1, 0, 1)
INSERT [dbo].[Methods] ([Id], [Name], [DisplayName], [TypeId], [IsDeleted], [DatabaseId]) VALUES (21, N'GetContractByExchangeCodeAndContractNumber', N'Get Contract By Exchange Code And Contract Number', 1, 0, 1)
INSERT [dbo].[Methods] ([Id], [Name], [DisplayName], [TypeId], [IsDeleted], [DatabaseId]) VALUES (22, N'GetContractByExchangeCodeAndTickerCodeAndFOrO', N'Get Contract By Exchange Code And Ticker Code And F Or O', 1, 0, 1)
INSERT [dbo].[Methods] ([Id], [Name], [DisplayName], [TypeId], [IsDeleted], [DatabaseId]) VALUES (23, N'GetContractByExchangeForControl', N'Get Contract By Exchange For Control', 1, 0, 1)
INSERT [dbo].[Methods] ([Id], [Name], [DisplayName], [TypeId], [IsDeleted], [DatabaseId]) VALUES (24, N'GetContractByExchangeForControlCombine', N'Get Contract By Exchange For Control Combine', 1, 0, 1)
INSERT [dbo].[Methods] ([Id], [Name], [DisplayName], [TypeId], [IsDeleted], [DatabaseId]) VALUES (25, N'GetContractByExchangeForPaging', N'Get Contract By Exchange For Paging', 1, 0, 1)
INSERT [dbo].[Methods] ([Id], [Name], [DisplayName], [TypeId], [IsDeleted], [DatabaseId]) VALUES (26, N'GetContractByGlossaryCode', N'Get Contract By Glossary Code', 1, 0, 1)
INSERT [dbo].[Methods] ([Id], [Name], [DisplayName], [TypeId], [IsDeleted], [DatabaseId]) VALUES (27, N'GetContractByMPFDescriptionTypeID', N'Get Contract By MPF Description Type ID', 1, 0, 1)
INSERT [dbo].[Methods] ([Id], [Name], [DisplayName], [TypeId], [IsDeleted], [DatabaseId]) VALUES (28, N'GetContractBySessionDescriptionTypeID', N'Get Contract By Session Description Type ID', 1, 0, 1)
INSERT [dbo].[Methods] ([Id], [Name], [DisplayName], [TypeId], [IsDeleted], [DatabaseId]) VALUES (29, N'GetContractChangesData', N'Get Contract Changes Data', 1, 0, 1)
INSERT [dbo].[Methods] ([Id], [Name], [DisplayName], [TypeId], [IsDeleted], [DatabaseId]) VALUES (30, N'GetContractETDToOTCMap', N'Get Contract ETD To OTC Map', 1, 0, 1)
INSERT [dbo].[Methods] ([Id], [Name], [DisplayName], [TypeId], [IsDeleted], [DatabaseId]) VALUES (31, N'GetContractExport', N'Get Contract Export', 1, 0, 1)
INSERT [dbo].[Methods] ([Id], [Name], [DisplayName], [TypeId], [IsDeleted], [DatabaseId]) VALUES (32, N'GetContractExportByID', N'Get Contract Export By ID', 1, 0, 1)
INSERT [dbo].[Methods] ([Id], [Name], [DisplayName], [TypeId], [IsDeleted], [DatabaseId]) VALUES (33, N'GetContractExportList', N'Get Contract Export List', 1, 0, 1)
INSERT [dbo].[Methods] ([Id], [Name], [DisplayName], [TypeId], [IsDeleted], [DatabaseId]) VALUES (34, N'GetContractHistory', N'Get Contract History', 1, 0, 1)
INSERT [dbo].[Methods] ([Id], [Name], [DisplayName], [TypeId], [IsDeleted], [DatabaseId]) VALUES (35, N'GetContractInfo', N'Get Contract Info', 1, 0, 1)
INSERT [dbo].[Methods] ([Id], [Name], [DisplayName], [TypeId], [IsDeleted], [DatabaseId]) VALUES (36, N'GetContractInputPopulate', N'Get Contract Input Populate', 1, 0, 1)
INSERT [dbo].[Methods] ([Id], [Name], [DisplayName], [TypeId], [IsDeleted], [DatabaseId]) VALUES (37, N'GetContractNames', N'Get Contract Names', 1, 0, 1)
INSERT [dbo].[Methods] ([Id], [Name], [DisplayName], [TypeId], [IsDeleted], [DatabaseId]) VALUES (38, N'GetContractNewAndAmendData', N'Get Contract New And Amend Data', 1, 0, 1)
INSERT [dbo].[Methods] ([Id], [Name], [DisplayName], [TypeId], [IsDeleted], [DatabaseId]) VALUES (39, N'GetContractNumberByExchangeTickerDeliveryAndFOrO', N'Get Contract Number By Exchange Ticker Delivery And F Or O', 1, 0, 1)
INSERT [dbo].[Methods] ([Id], [Name], [DisplayName], [TypeId], [IsDeleted], [DatabaseId]) VALUES (40, N'GetContractNumberByRelatedID', N'Get Contract Number By Related ID', 1, 0, 1)
INSERT [dbo].[Methods] ([Id], [Name], [DisplayName], [TypeId], [IsDeleted], [DatabaseId]) VALUES (41, N'GetContractNumberForNav', N'Get Contract Number For Nav', 1, 0, 1)
INSERT [dbo].[Methods] ([Id], [Name], [DisplayName], [TypeId], [IsDeleted], [DatabaseId]) VALUES (42, N'GetContractNumberForNavWithArray', N'Get Contract Number For Nav With Array', 1, 0, 1)
INSERT [dbo].[Methods] ([Id], [Name], [DisplayName], [TypeId], [IsDeleted], [DatabaseId]) VALUES (43, N'GetContractsByExchangeAndTicker', N'Get Contracts By Exchange And Ticker', 1, 0, 1)
INSERT [dbo].[Methods] ([Id], [Name], [DisplayName], [TypeId], [IsDeleted], [DatabaseId]) VALUES (44, N'GetContractsByExchangeForTickerCodeMatch', N'Get Contracts By Exchange For Ticker Code Match', 1, 0, 1)
INSERT [dbo].[Methods] ([Id], [Name], [DisplayName], [TypeId], [IsDeleted], [DatabaseId]) VALUES (45, N'GetContractsCheckUpdatedReport', N'Get Contracts Check Updated Report', 1, 0, 1)
INSERT [dbo].[Methods] ([Id], [Name], [DisplayName], [TypeId], [IsDeleted], [DatabaseId]) VALUES (46, N'GetContractsForDatesBulkLoad', N'Get Contracts For Dates Bulk Load', 1, 0, 1)
INSERT [dbo].[Methods] ([Id], [Name], [DisplayName], [TypeId], [IsDeleted], [DatabaseId]) VALUES (47, N'GetContractsForExport', N'Get Contracts For Export', 1, 0, 1)
INSERT [dbo].[Methods] ([Id], [Name], [DisplayName], [TypeId], [IsDeleted], [DatabaseId]) VALUES (48, N'GetContractsForExtendedDataCopy', N'Get Contracts For Extended Data Copy', 1, 0, 1)
INSERT [dbo].[Methods] ([Id], [Name], [DisplayName], [TypeId], [IsDeleted], [DatabaseId]) VALUES (49, N'GetContractsMissingDateRuleDetail', N'Get Contracts Missing Date Rule Detail', 1, 0, 1)
INSERT [dbo].[Methods] ([Id], [Name], [DisplayName], [TypeId], [IsDeleted], [DatabaseId]) VALUES (50, N'GetContractsMissingDateRuleDetailByExchangeAndContractType', N'Get Contracts Missing Date Rule Detail By Exchange And Contract Type', 1, 0, 1)
INSERT [dbo].[Methods] ([Id], [Name], [DisplayName], [TypeId], [IsDeleted], [DatabaseId]) VALUES (51, N'GetContractsMissingExtendedData', N'Get Contracts Missing Extended Data', 1, 0, 1)
INSERT [dbo].[Methods] ([Id], [Name], [DisplayName], [TypeId], [IsDeleted], [DatabaseId]) VALUES (52, N'GetContractsNoGroupAndHidden', N'Get Contracts No Group And Hidden', 1, 0, 1)
INSERT [dbo].[Methods] ([Id], [Name], [DisplayName], [TypeId], [IsDeleted], [DatabaseId]) VALUES (53, N'GetContractStartDate', N'Get Contract Start Date', 1, 0, 1)
INSERT [dbo].[Methods] ([Id], [Name], [DisplayName], [TypeId], [IsDeleted], [DatabaseId]) VALUES (54, N'GetContractsWithDupeTickers', N'Get Contracts With Dupe Tickers', 1, 0, 1)
INSERT [dbo].[Methods] ([Id], [Name], [DisplayName], [TypeId], [IsDeleted], [DatabaseId]) VALUES (55, N'GetContractsWithMissingSessions', N'Get Contracts With Missing Sessions', 1, 0, 1)
INSERT [dbo].[Methods] ([Id], [Name], [DisplayName], [TypeId], [IsDeleted], [DatabaseId]) VALUES (56, N'GetContractsWithXDAndNoEXPDates', N'Get Contracts With XD And No EXP Dates', 1, 0, 1)
INSERT [dbo].[Methods] ([Id], [Name], [DisplayName], [TypeId], [IsDeleted], [DatabaseId]) VALUES (57, N'GetContractType', N'Get Contract Type', 1, 0, 1)
INSERT [dbo].[Methods] ([Id], [Name], [DisplayName], [TypeId], [IsDeleted], [DatabaseId]) VALUES (58, N'GetContractTypeByExchangeCodeAndContractNumber', N'Get Contract Type By Exchange Code And Contract Number', 1, 0, 1)
INSERT [dbo].[Methods] ([Id], [Name], [DisplayName], [TypeId], [IsDeleted], [DatabaseId]) VALUES (59, N'GetContractTypeForControl', N'Get Contract Type For Control', 1, 0, 1)
INSERT [dbo].[Methods] ([Id], [Name], [DisplayName], [TypeId], [IsDeleted], [DatabaseId]) VALUES (60, N'GetContractTypeFutureOrOptionAndDeliveryByExchangeCodeAndContractNumber', N'Get Contract Type Future Or Option And Delivery By Exchange Code And Contract Number', 1, 0, 1)
INSERT [dbo].[Methods] ([Id], [Name], [DisplayName], [TypeId], [IsDeleted], [DatabaseId]) VALUES (61, N'GetContractURLByExchangeCodeAndContractNumber', N'Get Contract URL By Exchange Code And Contract Number', 1, 0, 1)
INSERT [dbo].[Methods] ([Id], [Name], [DisplayName], [TypeId], [IsDeleted], [DatabaseId]) VALUES (62, N'GetContractURLCategory', N'Get Contract URL Category', 1, 0, 1)
INSERT [dbo].[Methods] ([Id], [Name], [DisplayName], [TypeId], [IsDeleted], [DatabaseId]) VALUES (63, N'GetCountAuditChecked', N'Get Count Audit Checked', 1, 0, 1)
INSERT [dbo].[Methods] ([Id], [Name], [DisplayName], [TypeId], [IsDeleted], [DatabaseId]) VALUES (64, N'GetCurrency', N'Get Currency', 1, 0, 1)
INSERT [dbo].[Methods] ([Id], [Name], [DisplayName], [TypeId], [IsDeleted], [DatabaseId]) VALUES (65, N'GetCurrencyForControl', N'Get Currency For Control', 1, 0, 1)
INSERT [dbo].[Methods] ([Id], [Name], [DisplayName], [TypeId], [IsDeleted], [DatabaseId]) VALUES (66, N'GetCycleCodeAndDescriptionByExchangeCode', N'Get Cycle Code And Description By Exchange Code', 1, 0, 1)
INSERT [dbo].[Methods] ([Id], [Name], [DisplayName], [TypeId], [IsDeleted], [DatabaseId]) VALUES (67, N'GetCycleCodeAndRelatedForContract', N'Get Cycle Code And Related For Contract', 1, 0, 1)
INSERT [dbo].[Methods] ([Id], [Name], [DisplayName], [TypeId], [IsDeleted], [DatabaseId]) VALUES (68, N'GetCycleCodeByExchangeCode', N'Get Cycle Code By Exchange Code', 1, 0, 1)
INSERT [dbo].[Methods] ([Id], [Name], [DisplayName], [TypeId], [IsDeleted], [DatabaseId]) VALUES (69, N'GetCycleCodeForCopyContract', N'Get Cycle Code For Copy Contract', 1, 0, 1)
INSERT [dbo].[Methods] ([Id], [Name], [DisplayName], [TypeId], [IsDeleted], [DatabaseId]) VALUES (70, N'GetDateChangeData', N'Get Date Change Data', 1, 0, 1)
INSERT [dbo].[Methods] ([Id], [Name], [DisplayName], [TypeId], [IsDeleted], [DatabaseId]) VALUES (71, N'GetDateRuleDetailAndSchedulesByDate', N'Get Date Rule Detail And Schedules By Date', 1, 0, 1)
INSERT [dbo].[Methods] ([Id], [Name], [DisplayName], [TypeId], [IsDeleted], [DatabaseId]) VALUES (72, N'GetDateRuleDetailAndSchedulesByExchangeCodeAndContractNumber', N'Get Date Rule Detail And Schedules By Exchange Code And Contract Number', 1, 0, 1)
INSERT [dbo].[Methods] ([Id], [Name], [DisplayName], [TypeId], [IsDeleted], [DatabaseId]) VALUES (73, N'GetDateRuleDetailContractsByDate', N'Get Date Rule Detail Contracts By Date', 1, 0, 1)
INSERT [dbo].[Methods] ([Id], [Name], [DisplayName], [TypeId], [IsDeleted], [DatabaseId]) VALUES (74, N'GetDateRuleMasterAndChildren', N'Get Date Rule Master And Children', 1, 0, 1)
INSERT [dbo].[Methods] ([Id], [Name], [DisplayName], [TypeId], [IsDeleted], [DatabaseId]) VALUES (75, N'GetDateRuleMastersWithDetail', N'Get Date Rule Masters With Detail', 1, 0, 1)
INSERT [dbo].[Methods] ([Id], [Name], [DisplayName], [TypeId], [IsDeleted], [DatabaseId]) VALUES (76, N'GetDateRuleScheduleType', N'Get Date Rule Schedule Type', 1, 0, 1)
INSERT [dbo].[Methods] ([Id], [Name], [DisplayName], [TypeId], [IsDeleted], [DatabaseId]) VALUES (77, N'GetDateRulesHolidayClashes', N'Get Date Rules Holiday Clashes', 1, 0, 1)
INSERT [dbo].[Methods] ([Id], [Name], [DisplayName], [TypeId], [IsDeleted], [DatabaseId]) VALUES (78, N'GetDateRulesProcessingStatus', N'Get Date Rules Processing Status', 1, 0, 1)
INSERT [dbo].[Methods] ([Id], [Name], [DisplayName], [TypeId], [IsDeleted], [DatabaseId]) VALUES (79, N'GetDateRulesTargetHolidays', N'Get Date Rules Target Holidays', 1, 0, 1)
INSERT [dbo].[Methods] ([Id], [Name], [DisplayName], [TypeId], [IsDeleted], [DatabaseId]) VALUES (80, N'GetDatesRulesExcludedContracts', N'Get Dates Rules Excluded Contracts', 1, 0, 1)
INSERT [dbo].[Methods] ([Id], [Name], [DisplayName], [TypeId], [IsDeleted], [DatabaseId]) VALUES (81, N'GetDateType', N'Get Date Type', 1, 0, 1)
INSERT [dbo].[Methods] ([Id], [Name], [DisplayName], [TypeId], [IsDeleted], [DatabaseId]) VALUES (82, N'GetDateTypeForTradingDates', N'Get Date Type For Trading Dates', 1, 0, 1)
INSERT [dbo].[Methods] ([Id], [Name], [DisplayName], [TypeId], [IsDeleted], [DatabaseId]) VALUES (83, N'GetDBTotals', N'Get DB Totals', 1, 0, 1)
INSERT [dbo].[Methods] ([Id], [Name], [DisplayName], [TypeId], [IsDeleted], [DatabaseId]) VALUES (84, N'GetDistinctTDLinks', N'Get Distinct TD Links', 1, 0, 1)
INSERT [dbo].[Methods] ([Id], [Name], [DisplayName], [TypeId], [IsDeleted], [DatabaseId]) VALUES (85, N'GetDistinctTradingYear', N'Get Distinct Trading Year', 1, 0, 1)
INSERT [dbo].[Methods] ([Id], [Name], [DisplayName], [TypeId], [IsDeleted], [DatabaseId]) VALUES (86, N'GetETDToOTCSessionDescriptionMap', N'Get ETD To OTC Session Description Map', 1, 0, 1)
INSERT [dbo].[Methods] ([Id], [Name], [DisplayName], [TypeId], [IsDeleted], [DatabaseId]) VALUES (87, N'GetExceptions', N'Get Exceptions', 1, 0, 1)
INSERT [dbo].[Methods] ([Id], [Name], [DisplayName], [TypeId], [IsDeleted], [DatabaseId]) VALUES (88, N'GetExchange', N'Get Exchange', 1, 0, 1)
INSERT [dbo].[Methods] ([Id], [Name], [DisplayName], [TypeId], [IsDeleted], [DatabaseId]) VALUES (89, N'GetExchangeAuditByDateAndExchangeCode', N'Get Exchange Audit By Date And Exchange Code', 1, 0, 1)
INSERT [dbo].[Methods] ([Id], [Name], [DisplayName], [TypeId], [IsDeleted], [DatabaseId]) VALUES (90, N'GetExchangeByExchangeCode', N'Get Exchange By Exchange Code', 1, 0, 1)
INSERT [dbo].[Methods] ([Id], [Name], [DisplayName], [TypeId], [IsDeleted], [DatabaseId]) VALUES (91, N'GetExchangeCodeAndConNumFromConCode', N'Get Exchange Code And Con Num From Con Code', 1, 0, 1)
INSERT [dbo].[Methods] ([Id], [Name], [DisplayName], [TypeId], [IsDeleted], [DatabaseId]) VALUES (92, N'GetExchangeCodeAndCycleCodeFromConCode', N'Get Exchange Code And Cycle Code From Con Code', 1, 0, 1)
INSERT [dbo].[Methods] ([Id], [Name], [DisplayName], [TypeId], [IsDeleted], [DatabaseId]) VALUES (93, N'GetExchangeContactCategoryByID', N'Get Exchange Contact Category By ID', 1, 0, 1)
INSERT [dbo].[Methods] ([Id], [Name], [DisplayName], [TypeId], [IsDeleted], [DatabaseId]) VALUES (94, N'GetExchangeContactInternalByExchangeCode', N'Get Exchange Contact Internal By Exchange Code', 1, 0, 1)
INSERT [dbo].[Methods] ([Id], [Name], [DisplayName], [TypeId], [IsDeleted], [DatabaseId]) VALUES (95, N'GetExchangeContactInternalCategory', N'Get Exchange Contact Internal Category', 1, 0, 1)
INSERT [dbo].[Methods] ([Id], [Name], [DisplayName], [TypeId], [IsDeleted], [DatabaseId]) VALUES (96, N'GetExchangeContractGroupByContract', N'Get Exchange Contract Group By Contract', 1, 0, 1)
INSERT [dbo].[Methods] ([Id], [Name], [DisplayName], [TypeId], [IsDeleted], [DatabaseId]) VALUES (97, N'GetExchangeContractGroupContracts', N'Get Exchange Contract Group Contracts', 1, 0, 1)
INSERT [dbo].[Methods] ([Id], [Name], [DisplayName], [TypeId], [IsDeleted], [DatabaseId]) VALUES (98, N'GetExchangeContractGroups', N'Get Exchange Contract Groups', 1, 0, 1)
INSERT [dbo].[Methods] ([Id], [Name], [DisplayName], [TypeId], [IsDeleted], [DatabaseId]) VALUES (99, N'GetExchangeContractGroupsByExchange', N'Get Exchange Contract Groups By Exchange', 1, 0, 1)
INSERT [dbo].[Methods] ([Id], [Name], [DisplayName], [TypeId], [IsDeleted], [DatabaseId]) VALUES (100, N'GetExchangeETDToOTCMap', N'Get Exchange ETD To OTC Map', 1, 0, 1)
INSERT [dbo].[Methods] ([Id], [Name], [DisplayName], [TypeId], [IsDeleted], [DatabaseId]) VALUES (101, N'GetExchangeForControl', N'Get Exchange For Control', 1, 0, 1)
INSERT [dbo].[Methods] ([Id], [Name], [DisplayName], [TypeId], [IsDeleted], [DatabaseId]) VALUES (102, N'GetExchangeHolidayAuditByDateAndExchangeCode', N'Get Exchange Holiday Audit By Date And Exchange Code', 1, 0, 1)
INSERT [dbo].[Methods] ([Id], [Name], [DisplayName], [TypeId], [IsDeleted], [DatabaseId]) VALUES (103, N'GetExchangeHolidayContracts', N'Get Exchange Holiday Contracts', 1, 0, 1)
INSERT [dbo].[Methods] ([Id], [Name], [DisplayName], [TypeId], [IsDeleted], [DatabaseId]) VALUES (104, N'GetExchangeHolidayDescription', N'Get Exchange Holiday Description', 1, 0, 1)
INSERT [dbo].[Methods] ([Id], [Name], [DisplayName], [TypeId], [IsDeleted], [DatabaseId]) VALUES (105, N'GetExchangeHolidayGroups', N'Get Exchange Holiday Groups', 1, 0, 1)
INSERT [dbo].[Methods] ([Id], [Name], [DisplayName], [TypeId], [IsDeleted], [DatabaseId]) VALUES (106, N'GetExchangeHolidays', N'Get Exchange Holidays', 1, 0, 1)
INSERT [dbo].[Methods] ([Id], [Name], [DisplayName], [TypeId], [IsDeleted], [DatabaseId]) VALUES (107, N'GetExchangeHolidaysByExchange', N'Get Exchange Holidays By Exchange', 1, 0, 1)
INSERT [dbo].[Methods] ([Id], [Name], [DisplayName], [TypeId], [IsDeleted], [DatabaseId]) VALUES (108, N'GetExchangeHolidaysWithNoContractsOrGroups', N'Get Exchange Holidays With No Contracts Or Groups', 1, 0, 1)
INSERT [dbo].[Methods] ([Id], [Name], [DisplayName], [TypeId], [IsDeleted], [DatabaseId]) VALUES (109, N'GetExchangeHolidayType', N'Get Exchange Holiday Type', 1, 0, 1)
INSERT [dbo].[Methods] ([Id], [Name], [DisplayName], [TypeId], [IsDeleted], [DatabaseId]) VALUES (110, N'GetExchangeInputPopulate', N'Get Exchange Input Populate', 1, 0, 1)
INSERT [dbo].[Methods] ([Id], [Name], [DisplayName], [TypeId], [IsDeleted], [DatabaseId]) VALUES (111, N'GetExchangeMemberAuditByDateAndExchangeCode', N'Get Exchange Member Audit By Date And Exchange Code', 1, 0, 1)
INSERT [dbo].[Methods] ([Id], [Name], [DisplayName], [TypeId], [IsDeleted], [DatabaseId]) VALUES (112, N'GetExchangeMemberByID', N'Get Exchange Member By ID', 1, 0, 1)
INSERT [dbo].[Methods] ([Id], [Name], [DisplayName], [TypeId], [IsDeleted], [DatabaseId]) VALUES (113, N'GetExchangeMembers', N'Get Exchange Members', 1, 0, 1)
INSERT [dbo].[Methods] ([Id], [Name], [DisplayName], [TypeId], [IsDeleted], [DatabaseId]) VALUES (114, N'GetExchangeMembersAll', N'Get Exchange Members All', 1, 0, 1)
INSERT [dbo].[Methods] ([Id], [Name], [DisplayName], [TypeId], [IsDeleted], [DatabaseId]) VALUES (115, N'GetExchangeNoteByID', N'Get Exchange Note By ID', 1, 0, 1)
INSERT [dbo].[Methods] ([Id], [Name], [DisplayName], [TypeId], [IsDeleted], [DatabaseId]) VALUES (116, N'GetExchangeNotes', N'Get Exchange Notes', 1, 0, 1)
INSERT [dbo].[Methods] ([Id], [Name], [DisplayName], [TypeId], [IsDeleted], [DatabaseId]) VALUES (117, N'GetExchangePreferencesByUser', N'Get Exchange Preferences By User', 1, 0, 1)
INSERT [dbo].[Methods] ([Id], [Name], [DisplayName], [TypeId], [IsDeleted], [DatabaseId]) VALUES (118, N'GetExchangeRelatedCategory', N'Get Exchange Related Category', 1, 0, 1)
INSERT [dbo].[Methods] ([Id], [Name], [DisplayName], [TypeId], [IsDeleted], [DatabaseId]) VALUES (119, N'GetExchangeRelatedExchangesByCategoryID', N'Get Exchange Related Exchanges By Category ID', 1, 0, 1)
INSERT [dbo].[Methods] ([Id], [Name], [DisplayName], [TypeId], [IsDeleted], [DatabaseId]) VALUES (120, N'GetExchangeRelatedExchangesCategoryByExchange', N'Get Exchange Related Exchanges Category By Exchange', 1, 0, 1)
INSERT [dbo].[Methods] ([Id], [Name], [DisplayName], [TypeId], [IsDeleted], [DatabaseId]) VALUES (121, N'GetExchangeTerritory', N'Get Exchange Territory', 1, 0, 1)
INSERT [dbo].[Methods] ([Id], [Name], [DisplayName], [TypeId], [IsDeleted], [DatabaseId]) VALUES (122, N'GetExchangeTimes', N'Get Exchange Times', 1, 0, 1)
INSERT [dbo].[Methods] ([Id], [Name], [DisplayName], [TypeId], [IsDeleted], [DatabaseId]) VALUES (123, N'GetExchangeTradingMethods', N'Get Exchange Trading Methods', 1, 0, 1)
INSERT [dbo].[Methods] ([Id], [Name], [DisplayName], [TypeId], [IsDeleted], [DatabaseId]) VALUES (124, N'GetExerciseType', N'Get Exercise Type', 1, 0, 1)
INSERT [dbo].[Methods] ([Id], [Name], [DisplayName], [TypeId], [IsDeleted], [DatabaseId]) VALUES (125, N'GetExpiryDatesContractAllow', N'Get Expiry Dates Contract Allow', 1, 0, 1)
INSERT [dbo].[Methods] ([Id], [Name], [DisplayName], [TypeId], [IsDeleted], [DatabaseId]) VALUES (126, N'GetExpiryDatesContractAllowForApp', N'Get Expiry Dates Contract Allow For App', 1, 0, 1)
INSERT [dbo].[Methods] ([Id], [Name], [DisplayName], [TypeId], [IsDeleted], [DatabaseId]) VALUES (127, N'GetExpiryDatesContractTypeAllow', N'Get Expiry Dates Contract Type Allow', 1, 0, 1)
INSERT [dbo].[Methods] ([Id], [Name], [DisplayName], [TypeId], [IsDeleted], [DatabaseId]) VALUES (128, N'GetExpiryDatesContractTypeAllowForApp', N'Get Expiry Dates Contract Type Allow For App', 1, 0, 1)
INSERT [dbo].[Methods] ([Id], [Name], [DisplayName], [TypeId], [IsDeleted], [DatabaseId]) VALUES (129, N'GetExpiryDatesExchangeAllow', N'Get Expiry Dates Exchange Allow', 1, 0, 1)
INSERT [dbo].[Methods] ([Id], [Name], [DisplayName], [TypeId], [IsDeleted], [DatabaseId]) VALUES (130, N'GetExpiryDatesExchangeAllowForApp', N'Get Expiry Dates Exchange Allow For App', 1, 0, 1)
INSERT [dbo].[Methods] ([Id], [Name], [DisplayName], [TypeId], [IsDeleted], [DatabaseId]) VALUES (131, N'GetExtendedDataByExchangeCodeAndContractNumber', N'Get Extended Data By Exchange Code And Contract Number', 1, 0, 1)
INSERT [dbo].[Methods] ([Id], [Name], [DisplayName], [TypeId], [IsDeleted], [DatabaseId]) VALUES (132, N'GetExtendedDataType', N'Get Extended Data Type', 1, 0, 1)
INSERT [dbo].[Methods] ([Id], [Name], [DisplayName], [TypeId], [IsDeleted], [DatabaseId]) VALUES (133, N'GetFeeNoteByExchangeCodeConTypeAndFOrO', N'Get Fee Note By Exchange Code Con Type And F Or O', 1, 0, 1)
INSERT [dbo].[Methods] ([Id], [Name], [DisplayName], [TypeId], [IsDeleted], [DatabaseId]) VALUES (134, N'GetFNDDatesOnNonPhysicalContracts', N'Get FND Dates On Non Physical Contracts', 1, 0, 1)
INSERT [dbo].[Methods] ([Id], [Name], [DisplayName], [TypeId], [IsDeleted], [DatabaseId]) VALUES (135, N'GetFNDRuleCodeType', N'Get FND Rule Code Type', 1, 0, 1)
INSERT [dbo].[Methods] ([Id], [Name], [DisplayName], [TypeId], [IsDeleted], [DatabaseId]) VALUES (136, N'GetFOIndicatorType', N'Get FO Indicator Type', 1, 0, 1)
INSERT [dbo].[Methods] ([Id], [Name], [DisplayName], [TypeId], [IsDeleted], [DatabaseId]) VALUES (137, N'GetFOWProdMapDiffs', N'Get FOW Prod Map Diffs', 1, 0, 1)
INSERT [dbo].[Methods] ([Id], [Name], [DisplayName], [TypeId], [IsDeleted], [DatabaseId]) VALUES (138, N'GetFuturesWithoutMargins', N'Get Futures Without Margins', 1, 0, 1)
INSERT [dbo].[Methods] ([Id], [Name], [DisplayName], [TypeId], [IsDeleted], [DatabaseId]) VALUES (139, N'GetIntDialPrefix', N'Get Int Dial Prefix', 1, 0, 1)
INSERT [dbo].[Methods] ([Id], [Name], [DisplayName], [TypeId], [IsDeleted], [DatabaseId]) VALUES (140, N'GetIntDialPrefixByTerrCode', N'Get Int Dial Prefix By Terr Code', 1, 0, 1)
INSERT [dbo].[Methods] ([Id], [Name], [DisplayName], [TypeId], [IsDeleted], [DatabaseId]) VALUES (141, N'GetIonProductCodes', N'Get Ion Product Codes', 1, 0, 1)
INSERT [dbo].[Methods] ([Id], [Name], [DisplayName], [TypeId], [IsDeleted], [DatabaseId]) VALUES (142, N'GetIsContractEquityOption', N'Get Is Contract Equity Option', 1, 0, 1)
INSERT [dbo].[Methods] ([Id], [Name], [DisplayName], [TypeId], [IsDeleted], [DatabaseId]) VALUES (143, N'GetLatestDatesReport', N'Get Latest Dates Report', 1, 0, 1)
INSERT [dbo].[Methods] ([Id], [Name], [DisplayName], [TypeId], [IsDeleted], [DatabaseId]) VALUES (144, N'GetLDDDatesOnNonPhysicalContracts', N'Get LDD Dates On Non Physical Contracts', 1, 0, 1)
INSERT [dbo].[Methods] ([Id], [Name], [DisplayName], [TypeId], [IsDeleted], [DatabaseId]) VALUES (145, N'GetLDDRuleCodeType', N'Get LDD Rule Code Type', 1, 0, 1)
INSERT [dbo].[Methods] ([Id], [Name], [DisplayName], [TypeId], [IsDeleted], [DatabaseId]) VALUES (146, N'GetLSEChangesData', N'Get LSE Changes Data', 1, 0, 1)
INSERT [dbo].[Methods] ([Id], [Name], [DisplayName], [TypeId], [IsDeleted], [DatabaseId]) VALUES (147, N'GetLSENewAndAmendData', N'Get LSE New And Amend Data', 1, 0, 1)
INSERT [dbo].[Methods] ([Id], [Name], [DisplayName], [TypeId], [IsDeleted], [DatabaseId]) VALUES (148, N'GetLTDRuleCodeType', N'Get LTD Rule Code Type', 1, 0, 1)
INSERT [dbo].[Methods] ([Id], [Name], [DisplayName], [TypeId], [IsDeleted], [DatabaseId]) VALUES (149, N'GetMarginAuditByDateAndExchangeCode', N'Get Margin Audit By Date And Exchange Code', 1, 0, 1)
INSERT [dbo].[Methods] ([Id], [Name], [DisplayName], [TypeId], [IsDeleted], [DatabaseId]) VALUES (150, N'GetMarginByExchangeCode', N'Get Margin By Exchange Code', 1, 0, 1)
INSERT [dbo].[Methods] ([Id], [Name], [DisplayName], [TypeId], [IsDeleted], [DatabaseId]) VALUES (151, N'GetMarginByExchangeCodeAndContractNumber', N'Get Margin By Exchange Code And Contract Number', 1, 0, 1)
INSERT [dbo].[Methods] ([Id], [Name], [DisplayName], [TypeId], [IsDeleted], [DatabaseId]) VALUES (152, N'GetMarginByExchangeCodeAndContractNumbersForPaging', N'Get Margin By Exchange Code And Contract Numbers For Paging', 1, 0, 1)
INSERT [dbo].[Methods] ([Id], [Name], [DisplayName], [TypeId], [IsDeleted], [DatabaseId]) VALUES (153, N'GetMarginByExchangeCodeWithFilters', N'Get Margin By Exchange Code With Filters', 1, 0, 1)
INSERT [dbo].[Methods] ([Id], [Name], [DisplayName], [TypeId], [IsDeleted], [DatabaseId]) VALUES (154, N'GetMarginByExchangeCodeWithFiltersForPaging', N'Get Margin By Exchange Code With Filters For Paging', 1, 0, 1)
INSERT [dbo].[Methods] ([Id], [Name], [DisplayName], [TypeId], [IsDeleted], [DatabaseId]) VALUES (155, N'GetMarginCategory', N'Get Margin Category', 1, 0, 1)
INSERT [dbo].[Methods] ([Id], [Name], [DisplayName], [TypeId], [IsDeleted], [DatabaseId]) VALUES (156, N'GetMarginsCheckUpdatedReport', N'Get Margins Check Updated Report', 1, 0, 1)
INSERT [dbo].[Methods] ([Id], [Name], [DisplayName], [TypeId], [IsDeleted], [DatabaseId]) VALUES (157, N'GetMarginsTBA', N'Get Margins TBA', 1, 0, 1)
INSERT [dbo].[Methods] ([Id], [Name], [DisplayName], [TypeId], [IsDeleted], [DatabaseId]) VALUES (158, N'GetMarginType', N'Get Margin Type', 1, 0, 1)
INSERT [dbo].[Methods] ([Id], [Name], [DisplayName], [TypeId], [IsDeleted], [DatabaseId]) VALUES (159, N'GetMarginTypeForControl', N'Get Margin Type For Control', 1, 0, 1)
INSERT [dbo].[Methods] ([Id], [Name], [DisplayName], [TypeId], [IsDeleted], [DatabaseId]) VALUES (160, N'GetMaturityType', N'Get Maturity Type', 1, 0, 1)
INSERT [dbo].[Methods] ([Id], [Name], [DisplayName], [TypeId], [IsDeleted], [DatabaseId]) VALUES (161, N'GetMemberCompanyNames', N'Get Member Company Names', 1, 0, 1)
INSERT [dbo].[Methods] ([Id], [Name], [DisplayName], [TypeId], [IsDeleted], [DatabaseId]) VALUES (162, N'GetMemberInputPopulate', N'Get Member Input Populate', 1, 0, 1)
INSERT [dbo].[Methods] ([Id], [Name], [DisplayName], [TypeId], [IsDeleted], [DatabaseId]) VALUES (163, N'GetMemberSchedule', N'Get Member Schedule', 1, 0, 1)
INSERT [dbo].[Methods] ([Id], [Name], [DisplayName], [TypeId], [IsDeleted], [DatabaseId]) VALUES (164, N'GetMemberType', N'Get Member Type', 1, 0, 1)
INSERT [dbo].[Methods] ([Id], [Name], [DisplayName], [TypeId], [IsDeleted], [DatabaseId]) VALUES (165, N'GetMICChangesData', N'Get MIC Changes Data', 1, 0, 1)
INSERT [dbo].[Methods] ([Id], [Name], [DisplayName], [TypeId], [IsDeleted], [DatabaseId]) VALUES (166, N'GetMICNewAndAmendData', N'Get MIC New And Amend Data', 1, 0, 1)
INSERT [dbo].[Methods] ([Id], [Name], [DisplayName], [TypeId], [IsDeleted], [DatabaseId]) VALUES (167, N'GetMissingFNDDatesOnPhysicalContracts', N'Get Missing FND Dates On Physical Contracts', 1, 0, 1)
INSERT [dbo].[Methods] ([Id], [Name], [DisplayName], [TypeId], [IsDeleted], [DatabaseId]) VALUES (168, N'GetMissingLDDDatesOnPhysicalContracts', N'Get Missing LDD Dates On Physical Contracts', 1, 0, 1)
INSERT [dbo].[Methods] ([Id], [Name], [DisplayName], [TypeId], [IsDeleted], [DatabaseId]) VALUES (169, N'GetMonthLetterAndNumber', N'Get Month Letter And Number', 1, 0, 1)
INSERT [dbo].[Methods] ([Id], [Name], [DisplayName], [TypeId], [IsDeleted], [DatabaseId]) VALUES (170, N'GetMonthNameAndLetter', N'Get Month Name And Letter', 1, 0, 1)
INSERT [dbo].[Methods] ([Id], [Name], [DisplayName], [TypeId], [IsDeleted], [DatabaseId]) VALUES (171, N'GetMonthNumberAndName', N'Get Month Number And Name', 1, 0, 1)
INSERT [dbo].[Methods] ([Id], [Name], [DisplayName], [TypeId], [IsDeleted], [DatabaseId]) VALUES (172, N'GetMonthNumberAndNameWithLetter', N'Get Month Number And Name With Letter', 1, 0, 1)
INSERT [dbo].[Methods] ([Id], [Name], [DisplayName], [TypeId], [IsDeleted], [DatabaseId]) VALUES (173, N'GetMPFAuditByDateAndExchangeCode', N'Get MPF Audit By Date And Exchange Code', 1, 0, 1)
INSERT [dbo].[Methods] ([Id], [Name], [DisplayName], [TypeId], [IsDeleted], [DatabaseId]) VALUES (174, N'GetMPFByExchangeCode', N'Get MPF By Exchange Code', 1, 0, 1)
INSERT [dbo].[Methods] ([Id], [Name], [DisplayName], [TypeId], [IsDeleted], [DatabaseId]) VALUES (175, N'GetMPFByExchangeCodeAndContractNumber', N'Get MPF By Exchange Code And Contract Number', 1, 0, 1)
INSERT [dbo].[Methods] ([Id], [Name], [DisplayName], [TypeId], [IsDeleted], [DatabaseId]) VALUES (176, N'GetMPFChangeData', N'Get MPF Change Data', 1, 0, 1)
INSERT [dbo].[Methods] ([Id], [Name], [DisplayName], [TypeId], [IsDeleted], [DatabaseId]) VALUES (177, N'GetMPFDescriptionType', N'Get MPF Description Type', 1, 0, 1)
INSERT [dbo].[Methods] ([Id], [Name], [DisplayName], [TypeId], [IsDeleted], [DatabaseId]) VALUES (178, N'GetMPFDescriptionTypeByID', N'Get MPF Description Type By ID', 1, 0, 1)
INSERT [dbo].[Methods] ([Id], [Name], [DisplayName], [TypeId], [IsDeleted], [DatabaseId]) VALUES (179, N'GetMPFDescriptionTypeForControl', N'Get MPF Description Type For Control', 1, 0, 1)
INSERT [dbo].[Methods] ([Id], [Name], [DisplayName], [TypeId], [IsDeleted], [DatabaseId]) VALUES (180, N'GetNewAndDeactivatedExchanges', N'Get New And Deactivated Exchanges', 1, 0, 1)
INSERT [dbo].[Methods] ([Id], [Name], [DisplayName], [TypeId], [IsDeleted], [DatabaseId]) VALUES (181, N'GetNewContractNumber', N'Get New Contract Number', 1, 0, 1)
INSERT [dbo].[Methods] ([Id], [Name], [DisplayName], [TypeId], [IsDeleted], [DatabaseId]) VALUES (182, N'GetOCCContractCompare_ExExistsOCC', N'Get OCC Contract Compare _ Ex Exists OCC', 1, 0, 1)
INSERT [dbo].[Methods] ([Id], [Name], [DisplayName], [TypeId], [IsDeleted], [DatabaseId]) VALUES (183, N'GetOCCContractCompare_ExExistsTD', N'Get OCC Contract Compare _ Ex Exists TD', 1, 0, 1)
INSERT [dbo].[Methods] ([Id], [Name], [DisplayName], [TypeId], [IsDeleted], [DatabaseId]) VALUES (184, N'GetOCCContractCompare_ExNotOCC', N'Get OCC Contract Compare _ Ex Not OCC', 1, 0, 1)
INSERT [dbo].[Methods] ([Id], [Name], [DisplayName], [TypeId], [IsDeleted], [DatabaseId]) VALUES (185, N'GetOCCContractCompare_ExNotTD', N'Get OCC Contract Compare _ Ex Not TD', 1, 0, 1)
INSERT [dbo].[Methods] ([Id], [Name], [DisplayName], [TypeId], [IsDeleted], [DatabaseId]) VALUES (186, N'GetOCCPositionLimitsCompare', N'Get OCC Position Limits Compare', 1, 0, 1)
INSERT [dbo].[Methods] ([Id], [Name], [DisplayName], [TypeId], [IsDeleted], [DatabaseId]) VALUES (187, N'GetOCCPotentialDupes', N'Get OCC Potential Dupes', 1, 0, 1)
INSERT [dbo].[Methods] ([Id], [Name], [DisplayName], [TypeId], [IsDeleted], [DatabaseId]) VALUES (188, N'GetOtherUnit', N'Get Other Unit', 1, 0, 1)
INSERT [dbo].[Methods] ([Id], [Name], [DisplayName], [TypeId], [IsDeleted], [DatabaseId]) VALUES (189, N'GetPhysicalContractsWhereFNDIsWithinSixMonths', N'Get Physical Contracts Where FND Is Within Six Months', 1, 0, 1)
INSERT [dbo].[Methods] ([Id], [Name], [DisplayName], [TypeId], [IsDeleted], [DatabaseId]) VALUES (190, N'GetPhysicalContractsWhereLDDIsWithinTwelveMonths', N'Get Physical Contracts Where LDD Is Within Twelve Months', 1, 0, 1)
INSERT [dbo].[Methods] ([Id], [Name], [DisplayName], [TypeId], [IsDeleted], [DatabaseId]) VALUES (191, N'GetPositionLimitAuditByDateAndExchangeCode', N'Get Position Limit Audit By Date And Exchange Code', 1, 0, 1)
INSERT [dbo].[Methods] ([Id], [Name], [DisplayName], [TypeId], [IsDeleted], [DatabaseId]) VALUES (192, N'GetPositionLimitsByExchangeCode', N'Get Position Limits By Exchange Code', 1, 0, 1)
INSERT [dbo].[Methods] ([Id], [Name], [DisplayName], [TypeId], [IsDeleted], [DatabaseId]) VALUES (193, N'GetPositionLimitsByExchangeCodeAndContractNumber', N'Get Position Limits By Exchange Code And Contract Number', 1, 0, 1)
INSERT [dbo].[Methods] ([Id], [Name], [DisplayName], [TypeId], [IsDeleted], [DatabaseId]) VALUES (194, N'GetPositionLimitsByExchangeCodeAndContractNumbersForPaging', N'Get Position Limits By Exchange Code And Contract Numbers For Paging', 1, 0, 1)
INSERT [dbo].[Methods] ([Id], [Name], [DisplayName], [TypeId], [IsDeleted], [DatabaseId]) VALUES (195, N'GetPositionLimitsByExchangeCodeWithFiltersForPaging', N'Get Position Limits By Exchange Code With Filters For Paging', 1, 0, 1)
INSERT [dbo].[Methods] ([Id], [Name], [DisplayName], [TypeId], [IsDeleted], [DatabaseId]) VALUES (196, N'GetPositionLimitsCheckUpdatedReport', N'Get Position Limits Check Updated Report', 1, 0, 1)
INSERT [dbo].[Methods] ([Id], [Name], [DisplayName], [TypeId], [IsDeleted], [DatabaseId]) VALUES (197, N'GetPositionLimitType', N'Get Position Limit Type', 1, 0, 1)
INSERT [dbo].[Methods] ([Id], [Name], [DisplayName], [TypeId], [IsDeleted], [DatabaseId]) VALUES (198, N'GetProductType', N'Get Product Type', 1, 0, 1)
INSERT [dbo].[Methods] ([Id], [Name], [DisplayName], [TypeId], [IsDeleted], [DatabaseId]) VALUES (199, N'GetRandNContractCode', N'Get Rand N Contract Code', 1, 0, 1)
INSERT [dbo].[Methods] ([Id], [Name], [DisplayName], [TypeId], [IsDeleted], [DatabaseId]) VALUES (200, N'GetReutersMatchInvalidFTD', N'Get Reuters Match Invalid FTD', 1, 0, 1)
INSERT [dbo].[Methods] ([Id], [Name], [DisplayName], [TypeId], [IsDeleted], [DatabaseId]) VALUES (201, N'GetReutersTDDatesDiff', N'Get Reuters TD Dates Diff', 1, 0, 1)
INSERT [dbo].[Methods] ([Id], [Name], [DisplayName], [TypeId], [IsDeleted], [DatabaseId]) VALUES (202, N'GetSessionAuditByDate', N'Get Session Audit By Date', 1, 0, 1)
INSERT [dbo].[Methods] ([Id], [Name], [DisplayName], [TypeId], [IsDeleted], [DatabaseId]) VALUES (203, N'GetSessionAuditByDateAndExchangeCode', N'Get Session Audit By Date And Exchange Code', 1, 0, 1)

INSERT [dbo].[Methods] ([Id], [Name], [DisplayName], [TypeId], [IsDeleted], [DatabaseId]) VALUES (204, N'GetSessionByExchangeCode', N'Get Session By Exchange Code', 1, 0, 1)
INSERT [dbo].[Methods] ([Id], [Name], [DisplayName], [TypeId], [IsDeleted], [DatabaseId]) VALUES (205, N'GetSessionByExchangeCodeAndContractNumber', N'Get Session By Exchange Code And Contract Number', 1, 0, 1)
INSERT [dbo].[Methods] ([Id], [Name], [DisplayName], [TypeId], [IsDeleted], [DatabaseId]) VALUES (206, N'GetSessionByExchangeCodeConTypeAndFOrO', N'Get Session By Exchange Code Con Type And F Or O', 1, 0, 1)
INSERT [dbo].[Methods] ([Id], [Name], [DisplayName], [TypeId], [IsDeleted], [DatabaseId]) VALUES (207, N'GetSessionDelete', N'Get Session Delete', 1, 0, 1)
INSERT [dbo].[Methods] ([Id], [Name], [DisplayName], [TypeId], [IsDeleted], [DatabaseId]) VALUES (208, N'GetSessionDescriptionDays', N'Get Session Description Days', 1, 0, 1)
INSERT [dbo].[Methods] ([Id], [Name], [DisplayName], [TypeId], [IsDeleted], [DatabaseId]) VALUES (209, N'GetSessionDescriptionType', N'Get Session Description Type', 1, 0, 1)
INSERT [dbo].[Methods] ([Id], [Name], [DisplayName], [TypeId], [IsDeleted], [DatabaseId]) VALUES (210, N'GetSessionDescriptionTypeByID', N'Get Session Description Type By ID', 1, 0, 1)
INSERT [dbo].[Methods] ([Id], [Name], [DisplayName], [TypeId], [IsDeleted], [DatabaseId]) VALUES (211, N'GetSessionDescriptionTypeForControl', N'Get Session Description Type For Control', 1, 0, 1)
INSERT [dbo].[Methods] ([Id], [Name], [DisplayName], [TypeId], [IsDeleted], [DatabaseId]) VALUES (212, N'GetSessionDescriptionTypeForControlAlpha', N'Get Session Description Type For Control Alpha', 1, 0, 1)
INSERT [dbo].[Methods] ([Id], [Name], [DisplayName], [TypeId], [IsDeleted], [DatabaseId]) VALUES (213, N'GetSessionExchangeDiffs', N'Get Session Exchange Diffs', 1, 0, 1)
INSERT [dbo].[Methods] ([Id], [Name], [DisplayName], [TypeId], [IsDeleted], [DatabaseId]) VALUES (214, N'GetSessionPotentialDuplicates', N'Get Session Potential Duplicates', 1, 0, 1)
INSERT [dbo].[Methods] ([Id], [Name], [DisplayName], [TypeId], [IsDeleted], [DatabaseId]) VALUES (215, N'GetSessionsForTradingHours', N'Get Sessions For Trading Hours', 1, 0, 1)
INSERT [dbo].[Methods] ([Id], [Name], [DisplayName], [TypeId], [IsDeleted], [DatabaseId]) VALUES (216, N'GetShortContractNames', N'Get Short Contract Names', 1, 0, 1)
INSERT [dbo].[Methods] ([Id], [Name], [DisplayName], [TypeId], [IsDeleted], [DatabaseId]) VALUES (217, N'GetTableColumnNames', N'Get Table Column Names', 1, 0, 1)
INSERT [dbo].[Methods] ([Id], [Name], [DisplayName], [TypeId], [IsDeleted], [DatabaseId]) VALUES (218, N'GetTDLinksAll', N'Get TD Links All', 1, 0, 1)
INSERT [dbo].[Methods] ([Id], [Name], [DisplayName], [TypeId], [IsDeleted], [DatabaseId]) VALUES (219, N'GetTDLinksByID', N'Get TD Links By ID', 1, 0, 1)
INSERT [dbo].[Methods] ([Id], [Name], [DisplayName], [TypeId], [IsDeleted], [DatabaseId]) VALUES (220, N'GetTDLinksForJPM', N'Get TD Links For JPM', 1, 0, 1)
INSERT [dbo].[Methods] ([Id], [Name], [DisplayName], [TypeId], [IsDeleted], [DatabaseId]) VALUES (221, N'GetTDLinksMaxUpdated', N'Get TD Links Max Updated', 1, 0, 1)
INSERT [dbo].[Methods] ([Id], [Name], [DisplayName], [TypeId], [IsDeleted], [DatabaseId]) VALUES (222, N'GetTerritory', N'Get Territory', 1, 0, 1)
INSERT [dbo].[Methods] ([Id], [Name], [DisplayName], [TypeId], [IsDeleted], [DatabaseId]) VALUES (223, N'GetTerritoryByISOAlpha2', N'Get Territory By ISO Alpha 2', 1, 0, 1)
INSERT [dbo].[Methods] ([Id], [Name], [DisplayName], [TypeId], [IsDeleted], [DatabaseId]) VALUES (224, N'GetTickerChangesData', N'Get Ticker Changes Data', 1, 0, 1)
INSERT [dbo].[Methods] ([Id], [Name], [DisplayName], [TypeId], [IsDeleted], [DatabaseId]) VALUES (225, N'GetTickerDefaultByExchangeCodeAndContractNumber', N'Get Ticker Default By Exchange Code And Contract Number', 1, 0, 1)
INSERT [dbo].[Methods] ([Id], [Name], [DisplayName], [TypeId], [IsDeleted], [DatabaseId]) VALUES (226, N'GetTickerNewAndAmendData', N'Get Ticker New And Amend Data', 1, 0, 1)
INSERT [dbo].[Methods] ([Id], [Name], [DisplayName], [TypeId], [IsDeleted], [DatabaseId]) VALUES (227, N'GetTickerNonDefaultAuditByDateAndExchangeCode', N'Get Ticker Non Default Audit By Date And Exchange Code', 1, 0, 1)
INSERT [dbo].[Methods] ([Id], [Name], [DisplayName], [TypeId], [IsDeleted], [DatabaseId]) VALUES (228, N'GetTickerNonDefaultByExchangeCodeAndContractNumber', N'Get Ticker Non Default By Exchange Code And Contract Number', 1, 0, 1)
INSERT [dbo].[Methods] ([Id], [Name], [DisplayName], [TypeId], [IsDeleted], [DatabaseId]) VALUES (229, N'GetTickersNonDefaultByExchangeCode', N'Get Tickers Non Default By Exchange Code', 1, 0, 1)
INSERT [dbo].[Methods] ([Id], [Name], [DisplayName], [TypeId], [IsDeleted], [DatabaseId]) VALUES (230, N'GetTickerTradeType', N'Get Ticker Trade Type', 1, 0, 1)
INSERT [dbo].[Methods] ([Id], [Name], [DisplayName], [TypeId], [IsDeleted], [DatabaseId]) VALUES (231, N'GetTradingDateByExchangeCode', N'Get Trading Date By Exchange Code', 1, 0, 1)
INSERT [dbo].[Methods] ([Id], [Name], [DisplayName], [TypeId], [IsDeleted], [DatabaseId]) VALUES (232, N'GetTradingDateDiffContractExclude', N'Get Trading Date Diff Contract Exclude', 1, 0, 1)
INSERT [dbo].[Methods] ([Id], [Name], [DisplayName], [TypeId], [IsDeleted], [DatabaseId]) VALUES (233, N'GetTradingDateFromExchangeHoliday', N'Get Trading Date From Exchange Holiday', 1, 0, 1)
INSERT [dbo].[Methods] ([Id], [Name], [DisplayName], [TypeId], [IsDeleted], [DatabaseId]) VALUES (234, N'GetTradingDateIDByPrimaryKey', N'Get Trading Date ID By Primary Key', 1, 0, 1)
INSERT [dbo].[Methods] ([Id], [Name], [DisplayName], [TypeId], [IsDeleted], [DatabaseId]) VALUES (235, N'GetTradingDatesAuditStatsByYear', N'Get Trading Dates Audit Stats By Year', 1, 0, 1)
INSERT [dbo].[Methods] ([Id], [Name], [DisplayName], [TypeId], [IsDeleted], [DatabaseId]) VALUES (236, N'GetTradingDatesAuditStatsByYearAndMonth', N'Get Trading Dates Audit Stats By Year And Month', 1, 0, 1)
INSERT [dbo].[Methods] ([Id], [Name], [DisplayName], [TypeId], [IsDeleted], [DatabaseId]) VALUES (237, N'GetTradingDatesByExchangeAndCycleCode', N'Get Trading Dates By Exchange And Cycle Code', 1, 0, 1)
INSERT [dbo].[Methods] ([Id], [Name], [DisplayName], [TypeId], [IsDeleted], [DatabaseId]) VALUES (238, N'GetTradingDatesByExchangeAndCycleCodeAsTruthTable', N'Get Trading Dates By Exchange And Cycle Code As Truth Table', 1, 0, 1)
INSERT [dbo].[Methods] ([Id], [Name], [DisplayName], [TypeId], [IsDeleted], [DatabaseId]) VALUES (239, N'GetTradingDatesByExchangeAndCycleCodeAsTruthTableByYear', N'Get Trading Dates By Exchange And Cycle Code As Truth Table By Year', 1, 0, 1)
INSERT [dbo].[Methods] ([Id], [Name], [DisplayName], [TypeId], [IsDeleted], [DatabaseId]) VALUES (240, N'GetTradingDatesByExchangeCycleCodeAndDateType', N'Get Trading Dates By Exchange Cycle Code And Date Type', 1, 0, 1)
INSERT [dbo].[Methods] ([Id], [Name], [DisplayName], [TypeId], [IsDeleted], [DatabaseId]) VALUES (241, N'GetTradingDatesExchangeHolidayCompare', N'Get Trading Dates Exchange Holiday Compare', 1, 0, 1)
INSERT [dbo].[Methods] ([Id], [Name], [DisplayName], [TypeId], [IsDeleted], [DatabaseId]) VALUES (242, N'GetTradingHoursByExchangeCodeAndContractNumber', N'Get Trading Hours By Exchange Code And Contract Number', 1, 0, 1)
INSERT [dbo].[Methods] ([Id], [Name], [DisplayName], [TypeId], [IsDeleted], [DatabaseId]) VALUES (243, N'GetTradingHoursByExchangeCodeConTypeAndFOrO', N'Get Trading Hours By Exchange Code Con Type And F Or O', 1, 0, 1)
INSERT [dbo].[Methods] ([Id], [Name], [DisplayName], [TypeId], [IsDeleted], [DatabaseId]) VALUES (244, N'GetTradingStaging', N'Get Trading Staging', 1, 0, 1)
INSERT [dbo].[Methods] ([Id], [Name], [DisplayName], [TypeId], [IsDeleted], [DatabaseId]) VALUES (245, N'GetUnderlyingFutureContractByExchangeCodeAndContractNumber', N'Get Underlying Future Contract By Exchange Code And Contract Number', 1, 0, 1)
INSERT [dbo].[Methods] ([Id], [Name], [DisplayName], [TypeId], [IsDeleted], [DatabaseId]) VALUES (246, N'GetUSAACNsThatDiffer', N'Get USAAC Ns That Differ', 1, 0, 1)
INSERT [dbo].[Methods] ([Id], [Name], [DisplayName], [TypeId], [IsDeleted], [DatabaseId]) VALUES (247, N'GetUSAContractNamesThatDiffer', N'Get USA Contract Names That Differ', 1, 0, 1)
INSERT [dbo].[Methods] ([Id], [Name], [DisplayName], [TypeId], [IsDeleted], [DatabaseId]) VALUES (248, N'GetUSAContractSizesThatDiffer', N'Get USA Contract Sizes That Differ', 1, 0, 1)
INSERT [dbo].[Methods] ([Id], [Name], [DisplayName], [TypeId], [IsDeleted], [DatabaseId]) VALUES (249, N'GetUSACycleLongDescriptionThatDiffer', N'Get USA Cycle Long Description That Differ', 1, 0, 1)
INSERT [dbo].[Methods] ([Id], [Name], [DisplayName], [TypeId], [IsDeleted], [DatabaseId]) VALUES (250, N'GetUSAExerciseTypesThatDiffer', N'Get USA Exercise Types That Differ', 1, 0, 1)
INSERT [dbo].[Methods] ([Id], [Name], [DisplayName], [TypeId], [IsDeleted], [DatabaseId]) VALUES (251, N'GetUSAPremiumPaymentsThatDiffer', N'Get USA Premium Payments That Differ', 1, 0, 1)
INSERT [dbo].[Methods] ([Id], [Name], [DisplayName], [TypeId], [IsDeleted], [DatabaseId]) VALUES (252, N'GetUSASettlementCurrenciesThatDiffer', N'Get USA Settlement Currencies That Differ', 1, 0, 1)
INSERT [dbo].[Methods] ([Id], [Name], [DisplayName], [TypeId], [IsDeleted], [DatabaseId]) VALUES (253, N'GetUSASettlementTypesThatDiffer', N'Get USA Settlement Types That Differ', 1, 0, 1)
INSERT [dbo].[Methods] ([Id], [Name], [DisplayName], [TypeId], [IsDeleted], [DatabaseId]) VALUES (254, N'GetUserAuditStatsByYear', N'Get User Audit Stats By Year', 1, 0, 1)
INSERT [dbo].[Methods] ([Id], [Name], [DisplayName], [TypeId], [IsDeleted], [DatabaseId]) VALUES (255, N'GetUserAuditStatsByYearAndUser', N'Get User Audit Stats By Year And User', 1, 0, 1)
INSERT [dbo].[Methods] ([Id], [Name], [DisplayName], [TypeId], [IsDeleted], [DatabaseId]) VALUES (256, N'GetVolumesByExchangeYearMonth', N'Get Volumes By Exchange Year Month', 1, 0, 1)
INSERT [dbo].[Methods] ([Id], [Name], [DisplayName], [TypeId], [IsDeleted], [DatabaseId]) VALUES (257, N'GetVolumesExchangeTerrReport', N'Get Volumes Exchange Terr Report', 1, 0, 1)
INSERT [dbo].[Methods] ([Id], [Name], [DisplayName], [TypeId], [IsDeleted], [DatabaseId]) VALUES (258, N'GetVolumesLastUpdated', N'Get Volumes Last Updated', 1, 0, 1)
INSERT [dbo].[Methods] ([Id], [Name], [DisplayName], [TypeId], [IsDeleted], [DatabaseId]) VALUES (259, N'GetVolumesTopContractReport', N'Get Volumes Top Contract Report', 1, 0, 1)
INSERT [dbo].[Methods] ([Id], [Name], [DisplayName], [TypeId], [IsDeleted], [DatabaseId]) VALUES (260, N'GetVolumesTopExchangeReport', N'Get Volumes Top Exchange Report', 1, 0, 1)
INSERT [dbo].[Methods] ([Id], [Name], [DisplayName], [TypeId], [IsDeleted], [DatabaseId]) VALUES (261, N'GetVolumesUnreleased', N'Get Volumes Unreleased', 1, 0, 1)
INSERT [dbo].[Methods] ([Id], [Name], [DisplayName], [TypeId], [IsDeleted], [DatabaseId]) VALUES (262, N'GetListOfCountries', N'Get List Of Countries', 2, 0, 1)
INSERT [dbo].[Methods] ([Id], [Name], [DisplayName], [TypeId], [IsDeleted], [DatabaseId]) VALUES (263, N'GetNumberOfActiveUsers', N'Get Number Of Active Users', 2, 0, 1)
INSERT [dbo].[Methods] ([Id], [Name], [DisplayName], [TypeId], [IsDeleted], [DatabaseId]) VALUES (265, N'GetTodaysRequests', N'Get Todays Requests', 2, 0, 1)
INSERT [dbo].[Methods] ([Id], [Name], [DisplayName], [TypeId], [IsDeleted], [DatabaseId]) VALUES (266, N'GetNumberOfExpiredUsers', N'Get Number Of Expired Users', 2, 0, 1)
INSERT [dbo].[Methods] ([Id], [Name], [DisplayName], [TypeId], [IsDeleted], [DatabaseId]) VALUES (267, N'GetRecentExpirations', N'Get Recent Expirations', 2, 0, 1)
INSERT [dbo].[Methods] ([Id], [Name], [DisplayName], [TypeId], [IsDeleted], [DatabaseId]) VALUES (268, N'GetComingExpirations', N'Get Coming Expirations', 2, 0, 1)
INSERT [dbo].[Methods] ([Id], [Name], [DisplayName], [TypeId], [IsDeleted], [DatabaseId]) VALUES (269, N'GetCUIErrors', N'Get CUI Errors', 2, 0, 1)
INSERT [dbo].[Methods] ([Id], [Name], [DisplayName], [TypeId], [IsDeleted], [DatabaseId]) VALUES (270, N'GetUnregisteredIPs', N'Get Unregistered I Ps', 2, 0, 1)
INSERT [dbo].[Methods] ([Id], [Name], [DisplayName], [TypeId], [IsDeleted], [DatabaseId]) VALUES (279, N'GetSubscriptionRequests', N'Get Subscription Requests', 2, 0, 1)
INSERT [dbo].[Methods] ([Id], [Name], [DisplayName], [TypeId], [IsDeleted], [DatabaseId]) VALUES (280, N'GetAUIErrors', N'Get AUI Errors', 2, 0, 1)
INSERT [dbo].[Methods] ([Id], [Name], [DisplayName], [TypeId], [IsDeleted], [DatabaseId]) VALUES (281, N'GetAPIErrors', N'Get API Errors', 2, 0, 1)
INSERT [dbo].[Methods] ([Id], [Name], [DisplayName], [TypeId], [IsDeleted], [DatabaseId]) VALUES (282, N'GetBySymbol', N'Get By Symbol', 3, 0, 1)
INSERT [dbo].[Methods] ([Id], [Name], [DisplayName], [TypeId], [IsDeleted], [DatabaseId]) VALUES (283, N'GetExchangeCodes', N'Get Exchange Codes', 1, 0, 1)
INSERT [dbo].[Methods] ([Id], [Name], [DisplayName], [TypeId], [IsDeleted], [DatabaseId]) VALUES (284, N'GetContractTypes', N'Get Contract Types', 1, 0, 1)
INSERT [dbo].[Methods] ([Id], [Name], [DisplayName], [TypeId], [IsDeleted], [DatabaseId]) VALUES (285, N'GetAvailableSearchGroups', N'Get Available Search Groups', 1, 0, 1)
INSERT [dbo].[Methods] ([Id], [Name], [DisplayName], [TypeId], [IsDeleted], [DatabaseId]) VALUES (286, N'GetAPIFailedCalls', N'Get API Failed Calls', 2, 0, 1)
INSERT [dbo].[Methods] ([Id], [Name], [DisplayName], [TypeId], [IsDeleted], [DatabaseId]) VALUES (287, N'GetOBMS', N'Get OBMS', 1, 0, 2)
INSERT [dbo].[Methods] ([Id], [Name], [DisplayName], [TypeId], [IsDeleted], [DatabaseId]) VALUES (288, N'GetMargin', N'Get Margin', 1, 0, 2)
INSERT [dbo].[Methods] ([Id], [Name], [DisplayName], [TypeId], [IsDeleted], [DatabaseId]) VALUES (289, N'GetHoliday', N'Get Holiday', 1, 0, 2)
INSERT [dbo].[Methods] ([Id], [Name], [DisplayName], [TypeId], [IsDeleted], [DatabaseId]) VALUES (290, N'GetExchangeMember', N'Get Exchange Member', 1, 0, 2)
INSERT [dbo].[Methods] ([Id], [Name], [DisplayName], [TypeId], [IsDeleted], [DatabaseId]) VALUES (291, N'GetExchange', N'Get Exchange', 1, 0, 2)
INSERT [dbo].[Methods] ([Id], [Name], [DisplayName], [TypeId], [IsDeleted], [DatabaseId]) VALUES (292, N'GetDate', N'Get Date', 1, 0, 2)
INSERT [dbo].[Methods] ([Id], [Name], [DisplayName], [TypeId], [IsDeleted], [DatabaseId]) VALUES (293, N'GetContract', N'Get Contract', 1, 0, 2)
INSERT [dbo].[Methods] ([Id], [Name], [DisplayName], [TypeId], [IsDeleted], [DatabaseId]) VALUES (294, N'GetCFTC', N'Get CFTC', 1, 0, 2)
INSERT [dbo].[Methods] ([Id], [Name], [DisplayName], [TypeId], [IsDeleted], [DatabaseId]) VALUES (295, N'GetVolume', N'Get Volume', 1, 0, 2)
INSERT [dbo].[Methods] ([Id], [Name], [DisplayName], [TypeId], [IsDeleted], [DatabaseId]) VALUES (296, N'GetTradedSeriesTT', N'Get Traded Series TT', 1, 0, 2)
INSERT [dbo].[Methods] ([Id], [Name], [DisplayName], [TypeId], [IsDeleted], [DatabaseId]) VALUES (297, N'GetTradedSeriesSEDOL', N'Get Traded Series SEDOL', 1, 0, 2)
INSERT [dbo].[Methods] ([Id], [Name], [DisplayName], [TypeId], [IsDeleted], [DatabaseId]) VALUES (298, N'GetTradedSeriesRIC', N'Get Traded Series RIC', 1, 0, 2)
INSERT [dbo].[Methods] ([Id], [Name], [DisplayName], [TypeId], [IsDeleted], [DatabaseId]) VALUES (299, N'GetTradedSeriesISIN', N'Get Traded Series ISIN', 1, 0, 2)
INSERT [dbo].[Methods] ([Id], [Name], [DisplayName], [TypeId], [IsDeleted], [DatabaseId]) VALUES (300, N'GetTradedseriesFidessa', N'Get Traded series Fidessa', 1, 0, 2)
INSERT [dbo].[Methods] ([Id], [Name], [DisplayName], [TypeId], [IsDeleted], [DatabaseId]) VALUES (301, N'GetTradedSeriesCUSIP', N'Get Traded Series CUSIP', 1, 0, 2)
INSERT [dbo].[Methods] ([Id], [Name], [DisplayName], [TypeId], [IsDeleted], [DatabaseId]) VALUES (302, N'GetTradedSeriesBBG', N'Get Traded Series BBG', 1, 0, 2)
INSERT [dbo].[Methods] ([Id], [Name], [DisplayName], [TypeId], [IsDeleted], [DatabaseId]) VALUES (303, N'GetTradedSeriesAIIISIN', N'Get Traded Series AII ISIN', 1, 0, 2)
INSERT [dbo].[Methods] ([Id], [Name], [DisplayName], [TypeId], [IsDeleted], [DatabaseId]) VALUES (304, N'GetTradedSeriesAII', N'Get Traded Series AII', 1, 0, 2)
INSERT [dbo].[Methods] ([Id], [Name], [DisplayName], [TypeId], [IsDeleted], [DatabaseId]) VALUES (305, N'GetTradableProduct', N'Get Tradable Product', 1, 0, 2)
INSERT [dbo].[Methods] ([Id], [Name], [DisplayName], [TypeId], [IsDeleted], [DatabaseId]) VALUES (306, N'GetTickSize', N'Get Tick Size', 1, 0, 2)
INSERT [dbo].[Methods] ([Id], [Name], [DisplayName], [TypeId], [IsDeleted], [DatabaseId]) VALUES (307, N'GetSession', N'Get Session', 1, 0, 2)
INSERT [dbo].[Methods] ([Id], [Name], [DisplayName], [TypeId], [IsDeleted], [DatabaseId]) VALUES (308, N'GetRootTT', N'Get Root TT', 1, 0, 2)
INSERT [dbo].[Methods] ([Id], [Name], [DisplayName], [TypeId], [IsDeleted], [DatabaseId]) VALUES (309, N'GetRootRic', N'Get Root Ric', 1, 0, 2)
INSERT [dbo].[Methods] ([Id], [Name], [DisplayName], [TypeId], [IsDeleted], [DatabaseId]) VALUES (310, N'GetRootLevel', N'Get Root Level', 1, 0, 2)
INSERT [dbo].[Methods] ([Id], [Name], [DisplayName], [TypeId], [IsDeleted], [DatabaseId]) VALUES (311, N'GetRootGL', N'Get Root GL', 1, 0, 2)
INSERT [dbo].[Methods] ([Id], [Name], [DisplayName], [TypeId], [IsDeleted], [DatabaseId]) VALUES (312, N'GetRootFidessa', N'Get Root Fidessa', 1, 0, 2)
INSERT [dbo].[Methods] ([Id], [Name], [DisplayName], [TypeId], [IsDeleted], [DatabaseId]) VALUES (313, N'GetRootCQG', N'Get Root CQG', 1, 0, 2)

INSERT [dbo].[Methods] ([Id], [Name], [DisplayName], [TypeId], [IsDeleted], [DatabaseId]) VALUES (314, N'GetRootAII', N'Get Root AII', 1, 0, 2)
INSERT [dbo].[Methods] ([Id], [Name], [DisplayName], [TypeId], [IsDeleted], [DatabaseId]) VALUES (315, N'GetPositionLimit', N'Get Position Limit', 1, 0, 2)
INSERT [dbo].[Methods] ([Id], [Name], [DisplayName], [TypeId], [IsDeleted], [DatabaseId]) VALUES (316, N'GetRecentTrialRequests', N'Get Recent Trial Requests (30 days)', 2, 0, 1)

SET IDENTITY_INSERT [dbo].[Methods] OFF


/****** Object:  Table [dbo].[MethodGroupMethod]    Script Date: 02/02/2016 16:24:02 ******/
INSERT [dbo].[MethodGroupMethod] ([MethodId], [MethodGroupId]) VALUES (3, 16)
INSERT [dbo].[MethodGroupMethod] ([MethodId], [MethodGroupId]) VALUES (4, 16)
INSERT [dbo].[MethodGroupMethod] ([MethodId], [MethodGroupId]) VALUES (5, 16)
INSERT [dbo].[MethodGroupMethod] ([MethodId], [MethodGroupId]) VALUES (6, 16)
INSERT [dbo].[MethodGroupMethod] ([MethodId], [MethodGroupId]) VALUES (6, 18)
INSERT [dbo].[MethodGroupMethod] ([MethodId], [MethodGroupId]) VALUES (12, 18)
INSERT [dbo].[MethodGroupMethod] ([MethodId], [MethodGroupId]) VALUES (13, 18)
INSERT [dbo].[MethodGroupMethod] ([MethodId], [MethodGroupId]) VALUES (20, 18)
INSERT [dbo].[MethodGroupMethod] ([MethodId], [MethodGroupId]) VALUES (31, 18)
INSERT [dbo].[MethodGroupMethod] ([MethodId], [MethodGroupId]) VALUES (110, 17)
INSERT [dbo].[MethodGroupMethod] ([MethodId], [MethodGroupId]) VALUES (112, 17)
INSERT [dbo].[MethodGroupMethod] ([MethodId], [MethodGroupId]) VALUES (113, 17)
INSERT [dbo].[MethodGroupMethod] ([MethodId], [MethodGroupId]) VALUES (114, 17)
INSERT [dbo].[MethodGroupMethod] ([MethodId], [MethodGroupId]) VALUES (116, 18)
INSERT [dbo].[MethodGroupMethod] ([MethodId], [MethodGroupId]) VALUES (188, 17)
INSERT [dbo].[MethodGroupMethod] ([MethodId], [MethodGroupId]) VALUES (282, 19)

SET IDENTITY_INSERT [dbo].[SearchColumns] ON
INSERT [dbo].[SearchColumns] ([Id], [Name], [Alias], [TableId], [IsDeleted]) VALUES (1, N'CompositeReutersExchange', N'Composite Reuters Exchange', 1, 0)
INSERT [dbo].[SearchColumns] ([Id], [Name], [Alias], [TableId], [IsDeleted]) VALUES (2, N'CompositeReutersUnderlyingRIC', N'Composite Reuters Underlying RIC', 1, 0)
INSERT [dbo].[SearchColumns] ([Id], [Name], [Alias], [TableId], [IsDeleted]) VALUES (3, N'CompositeReutersRootRIC', N'Composite Reuters Root RIC', 1, 0)
INSERT [dbo].[SearchColumns] ([Id], [Name], [Alias], [TableId], [IsDeleted]) VALUES (4, N'ElectronicReutersExchange', N'Electronic Reuters Exchange', 1, 0)
INSERT [dbo].[SearchColumns] ([Id], [Name], [Alias], [TableId], [IsDeleted]) VALUES (5, N'ElectronicReutersUnderlyingRIC', N'Electronic Reuters Underlying RIC', 1, 0)
INSERT [dbo].[SearchColumns] ([Id], [Name], [Alias], [TableId], [IsDeleted]) VALUES (6, N'ElectronicReutersRootRIC', N'Electronic Reuters Root RIC', 1, 0)
INSERT [dbo].[SearchColumns] ([Id], [Name], [Alias], [TableId], [IsDeleted]) VALUES (7, N'FloorReutersExchange', N'Floor Reuters Exchange', 1, 0)
INSERT [dbo].[SearchColumns] ([Id], [Name], [Alias], [TableId], [IsDeleted]) VALUES (8, N'FloorReutersUnderlyingRIC', N'Floor Reuters Underlying RIC', 1, 0)
INSERT [dbo].[SearchColumns] ([Id], [Name], [Alias], [TableId], [IsDeleted]) VALUES (9, N'FloorReutersRootRIC', N'Floor Reuters Root RIC', 1, 0)
INSERT [dbo].[SearchColumns] ([Id], [Name], [Alias], [TableId], [IsDeleted]) VALUES (10, N'BloombergExchangeCode', N'Bloomberg Exchange Code', 1, 0)
INSERT [dbo].[SearchColumns] ([Id], [Name], [Alias], [TableId], [IsDeleted]) VALUES (11, N'BloombergCode', N'Bloomberg Code', 1, 0)
INSERT [dbo].[SearchColumns] ([Id], [Name], [Alias], [TableId], [IsDeleted]) VALUES (12, N'BloombergYellowKey', N'Bloomberg Yellow Key', 1, 0)
INSERT [dbo].[SearchColumns] ([Id], [Name], [Alias], [TableId], [IsDeleted]) VALUES (13, N'GMIExchangeCode', N'GMI Exchange Code', 1, 0)
INSERT [dbo].[SearchColumns] ([Id], [Name], [Alias], [TableId], [IsDeleted]) VALUES (14, N'GMIContractCode', N'GMI Contract Code', 1, 0)
INSERT [dbo].[SearchColumns] ([Id], [Name], [Alias], [TableId], [IsDeleted]) VALUES (15, N'GMIFutureOrOption', N'GMI Future Or Option', 1, 0)
INSERT [dbo].[SearchColumns] ([Id], [Name], [Alias], [TableId], [IsDeleted]) VALUES (16, N'ClearingExchangeTicker', N'Clearing Exchange Ticker', 1, 0)
INSERT [dbo].[SearchColumns] ([Id], [Name], [Alias], [TableId], [IsDeleted]) VALUES (17, N'ElectronicExchangeTicker', N'Electronic Exchange Ticker', 1, 0)
INSERT [dbo].[SearchColumns] ([Id], [Name], [Alias], [TableId], [IsDeleted]) VALUES (18, N'FloorExchangeTicker', N'Floor Exchange Ticker', 1, 0)
INSERT [dbo].[SearchColumns] ([Id], [Name], [Alias], [TableId], [IsDeleted]) VALUES (19, N'ACN', N'ACN', 1, 0)
INSERT [dbo].[SearchColumns] ([Id], [Name], [Alias], [TableId], [IsDeleted]) VALUES (20, N'TickerCode', N'Ticker Code', 1, 0)
INSERT [dbo].[SearchColumns] ([Id], [Name], [Alias], [TableId], [IsDeleted]) VALUES (21, N'GLCodeMarket', N'GL Code Market', 1, 0)
INSERT [dbo].[SearchColumns] ([Id], [Name], [Alias], [TableId], [IsDeleted]) VALUES (22, N'GLMapCode', N'GL Map Code', 1, 0)
INSERT [dbo].[SearchColumns] ([Id], [Name], [Alias], [TableId], [IsDeleted]) VALUES (23, N'GLCodeExchangePlace', N'GL Code Exchange Place', 1, 0)
INSERT [dbo].[SearchColumns] ([Id], [Name], [Alias], [TableId], [IsDeleted]) VALUES (24, N'GLCode', N'GL Code', 1, 0)
INSERT [dbo].[SearchColumns] ([Id], [Name], [Alias], [TableId], [IsDeleted]) VALUES (25, N'UBIXExchangeCode', N'UBIX Exchange Code', 1, 0)
INSERT [dbo].[SearchColumns] ([Id], [Name], [Alias], [TableId], [IsDeleted]) VALUES (26, N'UBIXContractCodeInternal', N'UBIX Contract Code Internal', 1, 0)
INSERT [dbo].[SearchColumns] ([Id], [Name], [Alias], [TableId], [IsDeleted]) VALUES (27, N'UBIXFOQualifier', N'UBIXFO Qualifier', 1, 0)
INSERT [dbo].[SearchColumns] ([Id], [Name], [Alias], [TableId], [IsDeleted]) VALUES (28, N'ISOMIC', N'ISOMIC', 1, 0)
INSERT [dbo].[SearchColumns] ([Id], [Name], [Alias], [TableId], [IsDeleted]) VALUES (29, N'ClearVisionCode', N'Clear Vision Code', 1, 0)
INSERT [dbo].[SearchColumns] ([Id], [Name], [Alias], [TableId], [IsDeleted]) VALUES (30, N'RISCCode', N'RISC Code', 1, 0)
INSERT [dbo].[SearchColumns] ([Id], [Name], [Alias], [TableId], [IsDeleted]) VALUES (31, N'TickValueChar', N'Tick Value Char', 1, 0)
INSERT [dbo].[SearchColumns] ([Id], [Name], [Alias], [TableId], [IsDeleted]) VALUES (32, N'AIIExchangeSymbol', N'AII Exchange Symbol', 1, 0)
INSERT [dbo].[SearchColumns] ([Id], [Name], [Alias], [TableId], [IsDeleted]) VALUES (33, N'GMISubExchangeCode', N'GMI Sub Exchange Code', 1, 0)
INSERT [dbo].[SearchColumns] ([Id], [Name], [Alias], [TableId], [IsDeleted]) VALUES (34, N'RandNMarketCode', N'Rand N Market Code', 1, 0)
INSERT [dbo].[SearchColumns] ([Id], [Name], [Alias], [TableId], [IsDeleted]) VALUES (35, N'RandNExchangeID', N'Rand N Exchange ID', 1, 0)
INSERT [dbo].[SearchColumns] ([Id], [Name], [Alias], [TableId], [IsDeleted]) VALUES (36, N'RandNCode', N'Rand N Code', 1, 0)
INSERT [dbo].[SearchColumns] ([Id], [Name], [Alias], [TableId], [IsDeleted]) VALUES (37, N'RandNExchangeCode', N'Rand N Exchange Code', 1, 0)
INSERT [dbo].[SearchColumns] ([Id], [Name], [Alias], [TableId], [IsDeleted]) VALUES (38, N'RandNExternalCode', N'Rand N External Code', 1, 0)
INSERT [dbo].[SearchColumns] ([Id], [Name], [Alias], [TableId], [IsDeleted]) VALUES (39, N'ElectronicCQGName', N'Electronic CQG Name', 1, 0)
INSERT [dbo].[SearchColumns] ([Id], [Name], [Alias], [TableId], [IsDeleted]) VALUES (40, N'BloombergExchangeCodeUSByTicker', N'Bloomberg Exchange Code US By Ticker', 1, 0)
INSERT [dbo].[SearchColumns] ([Id], [Name], [Alias], [TableId], [IsDeleted]) VALUES (41, N'BloombergCodeUSByTicker', N'Bloomberg Code US By Ticker', 1, 0)
INSERT [dbo].[SearchColumns] ([Id], [Name], [Alias], [TableId], [IsDeleted]) VALUES (42, N'BloombergYellowKeyUSByTicker', N'Bloomberg Yellow Key US By Ticker', 1, 0)
INSERT [dbo].[SearchColumns] ([Id], [Name], [Alias], [TableId], [IsDeleted]) VALUES (43, N'ExchangeCode', N'Exchange Code', 2, 0)
INSERT [dbo].[SearchColumns] ([Id], [Name], [Alias], [TableId], [IsDeleted]) VALUES (44, N'ISOMIC', N'ISOMIC', 2, 0)
INSERT [dbo].[SearchColumns] ([Id], [Name], [Alias], [TableId], [IsDeleted]) VALUES (45, N'ContractNumber', N'Contract Number', 2, 0)
INSERT [dbo].[SearchColumns] ([Id], [Name], [Alias], [TableId], [IsDeleted]) VALUES (46, N'ContractCode', N'Contract Code', 2, 0)
INSERT [dbo].[SearchColumns] ([Id], [Name], [Alias], [TableId], [IsDeleted]) VALUES (47, N'ContractName', N'Contract Name', 2, 0)
INSERT [dbo].[SearchColumns] ([Id], [Name], [Alias], [TableId], [IsDeleted]) VALUES (48, N'FutureOrOption', N'Future Or Option', 2, 0)
INSERT [dbo].[SearchColumns] ([Id], [Name], [Alias], [TableId], [IsDeleted]) VALUES (49, N'ContractSize', N'Contract Size', 2, 0)
INSERT [dbo].[SearchColumns] ([Id], [Name], [Alias], [TableId], [IsDeleted]) VALUES (50, N'ContractType', N'Contract Type', 2, 0)
INSERT [dbo].[SearchColumns] ([Id], [Name], [Alias], [TableId], [IsDeleted]) VALUES (51, N'FSAContractType', N'FSA Contract Type', 2, 0)
INSERT [dbo].[SearchColumns] ([Id], [Name], [Alias], [TableId], [IsDeleted]) VALUES (52, N'StartDate', N'Start Date', 2, 0)
INSERT [dbo].[SearchColumns] ([Id], [Name], [Alias], [TableId], [IsDeleted]) VALUES (53, N'DelistDate', N'Delist Date', 2, 0)
INSERT [dbo].[SearchColumns] ([Id], [Name], [Alias], [TableId], [IsDeleted]) VALUES (54, N'ReutersExchangeCode', N'Reuters Exchange Code', 2, 0)
INSERT [dbo].[SearchColumns] ([Id], [Name], [Alias], [TableId], [IsDeleted]) VALUES (55, N'ReutersUnderlyingRIC', N'Reuters Underlying RIC', 2, 0)
INSERT [dbo].[SearchColumns] ([Id], [Name], [Alias], [TableId], [IsDeleted]) VALUES (56, N'ReutersRootRIC', N'Reuters Root RIC', 2, 0)
INSERT [dbo].[SearchColumns] ([Id], [Name], [Alias], [TableId], [IsDeleted]) VALUES (57, N'ReutersRIC', N'Reuters RIC', 2, 0)
INSERT [dbo].[SearchColumns] ([Id], [Name], [Alias], [TableId], [IsDeleted]) VALUES (58, N'DateType', N'Date Type', 2, 0)
INSERT [dbo].[SearchColumns] ([Id], [Name], [Alias], [TableId], [IsDeleted]) VALUES (59, N'PromptMonth', N'Prompt Month', 2, 0)
INSERT [dbo].[SearchColumns] ([Id], [Name], [Alias], [TableId], [IsDeleted]) VALUES (60, N'PromptMonthCode', N'Prompt Month Code', 2, 0)
INSERT [dbo].[SearchColumns] ([Id], [Name], [Alias], [TableId], [IsDeleted]) VALUES (61, N'ActionDate', N'Action Date', 2, 0)
INSERT [dbo].[SearchColumns] ([Id], [Name], [Alias], [TableId], [IsDeleted]) VALUES (62, N'ReutersStrikePrice', N'Reuters Strike Price', 2, 0)
INSERT [dbo].[SearchColumns] ([Id], [Name], [Alias], [TableId], [IsDeleted]) VALUES (63, N'ReutersStrikePriceCurrency', N'Reuters Strike Price Currency', 2, 0)
INSERT [dbo].[SearchColumns] ([Id], [Name], [Alias], [TableId], [IsDeleted]) VALUES (64, N'ReutersFOIndicator', N'Reuters FO Indicator', 2, 0)
INSERT [dbo].[SearchColumns] ([Id], [Name], [Alias], [TableId], [IsDeleted]) VALUES (65, N'ReutersSessionTypeIndicator', N'Reuters Session Type Indicator', 2, 0)
INSERT [dbo].[SearchColumns] ([Id], [Name], [Alias], [TableId], [IsDeleted]) VALUES (66, N'ReutersCompositeIndicator', N'Reuters Composite Indicator', 2, 0)
INSERT [dbo].[SearchColumns] ([Id], [Name], [Alias], [TableId], [IsDeleted]) VALUES (67, N'ACN', N'ACN', 2, 0)
INSERT [dbo].[SearchColumns] ([Id], [Name], [Alias], [TableId], [IsDeleted]) VALUES (68, N'ActionIndicator', N'Action Indicator', 2, 0)
INSERT [dbo].[SearchColumns] ([Id], [Name], [Alias], [TableId], [IsDeleted]) VALUES (69, N'ReutersExpiryDate', N'Reuters Expiry Date', 2, 0)
INSERT [dbo].[SearchColumns] ([Id], [Name], [Alias], [TableId], [IsDeleted]) VALUES (70, N'ProductType', N'Product Type', 2, 0)
INSERT [dbo].[SearchColumns] ([Id], [Name], [Alias], [TableId], [IsDeleted]) VALUES (71, N'ISIN', N'ISIN', 2, 0)
INSERT [dbo].[SearchColumns] ([Id], [Name], [Alias], [TableId], [IsDeleted]) VALUES (72, N'ActualContractType', N'Actual Contract Type', 2, 0)
INSERT [dbo].[SearchColumns] ([Id], [Name], [Alias], [TableId], [IsDeleted]) VALUES (73, N'TickerCode', N'Ticker Code', 2, 0)
INSERT [dbo].[SearchColumns] ([Id], [Name], [Alias], [TableId], [IsDeleted]) VALUES (74, N'ContractYear', N'Contract Year', 2, 0)
INSERT [dbo].[SearchColumns] ([Id], [Name], [Alias], [TableId], [IsDeleted]) VALUES (75, N'ContractMonth', N'Contract Month', 2, 0)
INSERT [dbo].[SearchColumns] ([Id], [Name], [Alias], [TableId], [IsDeleted]) VALUES (76, N'FirstTradingDate', N'First Trading Date', 2, 0)
INSERT [dbo].[SearchColumns] ([Id], [Name], [Alias], [TableId], [IsDeleted]) VALUES (77, N'AIIExchangeCode', N'AII Exchange Code', 2, 0)
INSERT [dbo].[SearchColumns] ([Id], [Name], [Alias], [TableId], [IsDeleted]) VALUES (78, N'AIIExchangeProductCode', N'AII Exchange Product Code', 2, 0)
INSERT [dbo].[SearchColumns] ([Id], [Name], [Alias], [TableId], [IsDeleted]) VALUES (79, N'AIIDerivativeType', N'AII Derivative Type', 2, 0)
INSERT [dbo].[SearchColumns] ([Id], [Name], [Alias], [TableId], [IsDeleted]) VALUES (80, N'AIIPutCallIdentifier', N'AII Put Call Identifier', 2, 0)
INSERT [dbo].[SearchColumns] ([Id], [Name], [Alias], [TableId], [IsDeleted]) VALUES (81, N'AIIExpiryOrDeliveryDate', N'AII Expiry Or Delivery Date', 2, 0)
INSERT [dbo].[SearchColumns] ([Id], [Name], [Alias], [TableId], [IsDeleted]) VALUES (82, N'AIIStrikePrice', N'AII Strike Price', 2, 0)
INSERT [dbo].[SearchColumns] ([Id], [Name], [Alias], [TableId], [IsDeleted]) VALUES (83, N'CycleCode', N'Cycle Code', 2, 0)
INSERT [dbo].[SearchColumns] ([Id], [Name], [Alias], [TableId], [IsDeleted]) VALUES (84, N'LotSize', N'Lot Size', 2, 0)
INSERT [dbo].[SearchColumns] ([Id], [Name], [Alias], [TableId], [IsDeleted]) VALUES (85, N'StrikePriceMultiplier', N'Strike Price Multiplier', 2, 0)
INSERT [dbo].[SearchColumns] ([Id], [Name], [Alias], [TableId], [IsDeleted]) VALUES (86, N'CFICode', N'CFI Code', 2, 0)
INSERT [dbo].[SearchColumns] ([Id], [Name], [Alias], [TableId], [IsDeleted]) VALUES (87, N'CFIUnderlyingAssetCode', N'CFI Underlying Asset Code', 2, 0)
SET IDENTITY_INSERT [dbo].[SearchColumns] OFF
SET IDENTITY_INSERT [dbo].[Permissions] ON
INSERT [dbo].[Permissions] ([Id], [Name], [PermissionTypeId], [IsDeleted]) VALUES (1, N'Access Admin UI', 1, 0)
INSERT [dbo].[Permissions] ([Id], [Name], [PermissionTypeId], [IsDeleted]) VALUES (2, N'Access Customers UI', 1, 0)
INSERT [dbo].[Permissions] ([Id], [Name], [PermissionTypeId], [IsDeleted]) VALUES (3, N'View Bloomberg columns', 2, 0)
INSERT [dbo].[Permissions] ([Id], [Name], [PermissionTypeId], [IsDeleted]) VALUES (4, N'View Reuters columns', 2, 0)
INSERT [dbo].[Permissions] ([Id], [Name], [PermissionTypeId], [IsDeleted]) VALUES (5, N'Resources Admin', 1, 0)
INSERT [dbo].[Permissions] ([Id], [Name], [PermissionTypeId], [IsDeleted]) VALUES (6, N'Query Exchange Methods', 3, 0)
INSERT [dbo].[Permissions] ([Id], [Name], [PermissionTypeId], [IsDeleted]) VALUES (7, N'Trialist', 1, 0)
SET IDENTITY_INSERT [dbo].[Permissions] OFF
SET IDENTITY_INSERT [dbo].[SearchGroups] ON
INSERT [dbo].[SearchGroups] ([Id], [Name], [TableId], [IsDeleted]) VALUES (1, N'Bloomberg', 1, 0)
INSERT [dbo].[SearchGroups] ([Id], [Name], [TableId], [IsDeleted]) VALUES (2, N'Composite Reuters', 1, 0)
INSERT [dbo].[SearchGroups] ([Id], [Name], [TableId], [IsDeleted]) VALUES (3, N'Electronic Reuters', 1, 0)
INSERT [dbo].[SearchGroups] ([Id], [Name], [TableId], [IsDeleted]) VALUES (4, N'Floor Reuters', 1, 0)
INSERT [dbo].[SearchGroups] ([Id], [Name], [TableId], [IsDeleted]) VALUES (5, N'GMI', 1, 0)
INSERT [dbo].[SearchGroups] ([Id], [Name], [TableId], [IsDeleted]) VALUES (6, N'UBIX', 1, 0)
INSERT [dbo].[SearchGroups] ([Id], [Name], [TableId], [IsDeleted]) VALUES (7, N'Rand N', 1, 0)
INSERT [dbo].[SearchGroups] ([Id], [Name], [TableId], [IsDeleted]) VALUES (8, N'Bloomberg US', 1, 0)
INSERT [dbo].[SearchGroups] ([Id], [Name], [TableId], [IsDeleted]) VALUES (9, N'GL', 1, 0)
INSERT [dbo].[SearchGroups] ([Id], [Name], [TableId], [IsDeleted]) VALUES (10, N'ACN', 1, 0)
INSERT [dbo].[SearchGroups] ([Id], [Name], [TableId], [IsDeleted]) VALUES (11, N'ISOMIC', 1, 0)
INSERT [dbo].[SearchGroups] ([Id], [Name], [TableId], [IsDeleted]) VALUES (12, N'Clear Vision', 1, 0)
INSERT [dbo].[SearchGroups] ([Id], [Name], [TableId], [IsDeleted]) VALUES (13, N'RISC', 1, 0)
INSERT [dbo].[SearchGroups] ([Id], [Name], [TableId], [IsDeleted]) VALUES (14, N'All Exchange', 1, 0)
INSERT [dbo].[SearchGroups] ([Id], [Name], [TableId], [IsDeleted]) VALUES (15, N'Exchange Ticker', 1, 0)
INSERT [dbo].[SearchGroups] ([Id], [Name], [TableId], [IsDeleted]) VALUES (16, N'Electronic CQG', 1, 0)
INSERT [dbo].[SearchGroups] ([Id], [Name], [TableId], [IsDeleted]) VALUES (17, N'Protected REUTERS Columns', 2, 0)
SET IDENTITY_INSERT [dbo].[SearchGroups] OFF
SET IDENTITY_INSERT [dbo].[Users] ON
INSERT [dbo].[Users] ([Id], [CompanyId], [TimeZoneId], [Firstname], [Middlename], [Lastname], [Email], [Phone], [PhoneExt], [Username], [Password], [Salt], [IsActive], [FailedLoginAttemptsCnt], [LastFailedAttempt], [AccountExpirationDate], [ThresholdPeriodId], [ThresholdPeriodEnd], [Hits], [HitsLimit], [IsDeleted], [SessionId]) VALUES 
(1, 1, 36, N'system', NULL, N'user', N'noreply@euromoneytradedata.com', NULL, NULL, N'sys_user', N'{DEFAULT_PASSWORD}', N'{SALT}', 1, 0, NULL, CAST(0x0000AB3500000000 AS DateTime), 1, CAST(0xD83A0B00 AS Date), 0, 100000000, 0, NULL)
INSERT [dbo].[Users] ([Id], [CompanyId], [TimeZoneId], [Firstname], [Middlename], [Lastname], [Email], [Phone], [PhoneExt], [Username], [Password], [Salt], [IsActive], [FailedLoginAttemptsCnt], [LastFailedAttempt], [AccountExpirationDate], [ThresholdPeriodId], [ThresholdPeriodEnd], [Hits], [HitsLimit], [IsDeleted], [SessionId]) VALUES 
(2, 1, 36, N'Simon', NULL, N'Coughlan', N'simon.coughlan@euromoneytradedata.com', NULL, NULL, N'simon.coughlan@euromoneytradedata.com', N'{DEFAULT_PASSWORD}', N'{SALT}', 1, 0, NULL, CAST(0x0000AB3500000000 AS DateTime), 1, CAST(0xD83A0B00 AS Date), 0, 10000000, 0, NULL)
INSERT [dbo].[Users] ([Id], [CompanyId], [TimeZoneId], [Firstname], [Middlename], [Lastname], [Email], [Phone], [PhoneExt], [Username], [Password], [Salt], [IsActive], [FailedLoginAttemptsCnt], [LastFailedAttempt], [AccountExpirationDate], [ThresholdPeriodId], [ThresholdPeriodEnd], [Hits], [HitsLimit], [IsDeleted], [SessionId]) 
VALUES (3, 2, 59, N'Vitaly', NULL, N'Chupaev', N'vitaly.chupaev@gmail.com', NULL, NULL, N'vitaly.chupaev@gmail.com', N'{DEFAULT_PASSWORD}', N'{SALT}', 1, 0, NULL, CAST(0x0000AB3500000000 AS DateTime), 1, CAST(0xD83A0B00 AS Date), 0, 10000000, 0, NULL)
INSERT [dbo].[Users] ([Id], [CompanyId], [TimeZoneId], [Firstname], [Middlename], [Lastname], [Email], [Phone], [PhoneExt], [Username], [Password], [Salt], [IsActive], [FailedLoginAttemptsCnt], [LastFailedAttempt], [AccountExpirationDate], [ThresholdPeriodId], [ThresholdPeriodEnd], [Hits], [HitsLimit], [IsDeleted], [SessionId]) VALUES 
(4, 1, 35, N'Newedge', NULL, N'Anonymous Access', N'noreply@euromoneytradedata.com', NULL, NULL, N'newedge_anonymous', N'{DEFAULT_PASSWORD}', N'{SALT}', 1, NULL, NULL, CAST(0x0000B30D00000000 AS DateTime), 1, CAST(0xED3B0B00 AS Date), 0, 10000000, 0, NULL)
INSERT [dbo].[Users] ([Id], [CompanyId], [TimeZoneId], [Firstname], [Middlename], [Lastname], [Email], [Phone], [PhoneExt], [Username], [Password], [Salt], [IsActive], [FailedLoginAttemptsCnt], [LastFailedAttempt], [AccountExpirationDate], [ThresholdPeriodId], [ThresholdPeriodEnd], [Hits], [HitsLimit], [IsDeleted], [SessionId]) VALUES 
(5, 1, 35, N'BP2S', NULL, N'Anonymous Access', N'noreply@euromoneytradedata.com', NULL, NULL, N'bnp_anonymous', N'{DEFAULT_PASSWORD}', N'{SALT}', 1, NULL, NULL, CAST(0x0000B36900000000 AS DateTime), 1, CAST(0xED3B0B00 AS Date), 0, 10000000, 0, NULL)

SET IDENTITY_INSERT [dbo].[Users] OFF
INSERT [dbo].[SearchGroupColumns] ([SearchGroupId], [SearchColumnId]) VALUES (1, 10)
INSERT [dbo].[SearchGroupColumns] ([SearchGroupId], [SearchColumnId]) VALUES (1, 11)
INSERT [dbo].[SearchGroupColumns] ([SearchGroupId], [SearchColumnId]) VALUES (1, 12)
INSERT [dbo].[SearchGroupColumns] ([SearchGroupId], [SearchColumnId]) VALUES (2, 1)
INSERT [dbo].[SearchGroupColumns] ([SearchGroupId], [SearchColumnId]) VALUES (2, 2)
INSERT [dbo].[SearchGroupColumns] ([SearchGroupId], [SearchColumnId]) VALUES (2, 3)
INSERT [dbo].[SearchGroupColumns] ([SearchGroupId], [SearchColumnId]) VALUES (3, 4)
INSERT [dbo].[SearchGroupColumns] ([SearchGroupId], [SearchColumnId]) VALUES (3, 5)
INSERT [dbo].[SearchGroupColumns] ([SearchGroupId], [SearchColumnId]) VALUES (3, 6)
INSERT [dbo].[SearchGroupColumns] ([SearchGroupId], [SearchColumnId]) VALUES (4, 7)
INSERT [dbo].[SearchGroupColumns] ([SearchGroupId], [SearchColumnId]) VALUES (4, 8)
INSERT [dbo].[SearchGroupColumns] ([SearchGroupId], [SearchColumnId]) VALUES (4, 9)
INSERT [dbo].[SearchGroupColumns] ([SearchGroupId], [SearchColumnId]) VALUES (5, 13)
INSERT [dbo].[SearchGroupColumns] ([SearchGroupId], [SearchColumnId]) VALUES (5, 14)
INSERT [dbo].[SearchGroupColumns] ([SearchGroupId], [SearchColumnId]) VALUES (5, 15)
INSERT [dbo].[SearchGroupColumns] ([SearchGroupId], [SearchColumnId]) VALUES (5, 33)
INSERT [dbo].[SearchGroupColumns] ([SearchGroupId], [SearchColumnId]) VALUES (6, 25)
INSERT [dbo].[SearchGroupColumns] ([SearchGroupId], [SearchColumnId]) VALUES (6, 26)
INSERT [dbo].[SearchGroupColumns] ([SearchGroupId], [SearchColumnId]) VALUES (6, 27)
INSERT [dbo].[SearchGroupColumns] ([SearchGroupId], [SearchColumnId]) VALUES (7, 34)
INSERT [dbo].[SearchGroupColumns] ([SearchGroupId], [SearchColumnId]) VALUES (7, 35)
INSERT [dbo].[SearchGroupColumns] ([SearchGroupId], [SearchColumnId]) VALUES (7, 36)
INSERT [dbo].[SearchGroupColumns] ([SearchGroupId], [SearchColumnId]) VALUES (7, 37)
INSERT [dbo].[SearchGroupColumns] ([SearchGroupId], [SearchColumnId]) VALUES (7, 38)
INSERT [dbo].[SearchGroupColumns] ([SearchGroupId], [SearchColumnId]) VALUES (8, 40)
INSERT [dbo].[SearchGroupColumns] ([SearchGroupId], [SearchColumnId]) VALUES (8, 41)
INSERT [dbo].[SearchGroupColumns] ([SearchGroupId], [SearchColumnId]) VALUES (8, 42)
INSERT [dbo].[SearchGroupColumns] ([SearchGroupId], [SearchColumnId]) VALUES (9, 21)
INSERT [dbo].[SearchGroupColumns] ([SearchGroupId], [SearchColumnId]) VALUES (9, 22)
INSERT [dbo].[SearchGroupColumns] ([SearchGroupId], [SearchColumnId]) VALUES (9, 23)
INSERT [dbo].[SearchGroupColumns] ([SearchGroupId], [SearchColumnId]) VALUES (9, 24)
INSERT [dbo].[SearchGroupColumns] ([SearchGroupId], [SearchColumnId]) VALUES (10, 19)
INSERT [dbo].[SearchGroupColumns] ([SearchGroupId], [SearchColumnId]) VALUES (11, 28)
INSERT [dbo].[SearchGroupColumns] ([SearchGroupId], [SearchColumnId]) VALUES (12, 29)
INSERT [dbo].[SearchGroupColumns] ([SearchGroupId], [SearchColumnId]) VALUES (13, 30)
INSERT [dbo].[SearchGroupColumns] ([SearchGroupId], [SearchColumnId]) VALUES (14, 32)
INSERT [dbo].[SearchGroupColumns] ([SearchGroupId], [SearchColumnId]) VALUES (15, 16)
INSERT [dbo].[SearchGroupColumns] ([SearchGroupId], [SearchColumnId]) VALUES (15, 17)
INSERT [dbo].[SearchGroupColumns] ([SearchGroupId], [SearchColumnId]) VALUES (15, 18)
INSERT [dbo].[SearchGroupColumns] ([SearchGroupId], [SearchColumnId]) VALUES (15, 20)
INSERT [dbo].[SearchGroupColumns] ([SearchGroupId], [SearchColumnId]) VALUES (15, 31)
INSERT [dbo].[SearchGroupColumns] ([SearchGroupId], [SearchColumnId]) VALUES (16, 39)
INSERT [dbo].[SearchGroupColumns] ([SearchGroupId], [SearchColumnId]) VALUES (17, 54)
INSERT [dbo].[SearchGroupColumns] ([SearchGroupId], [SearchColumnId]) VALUES (17, 55)
INSERT [dbo].[SearchGroupColumns] ([SearchGroupId], [SearchColumnId]) VALUES (17, 56)
INSERT [dbo].[SearchGroupColumns] ([SearchGroupId], [SearchColumnId]) VALUES (17, 57)
INSERT [dbo].[SearchGroupColumns] ([SearchGroupId], [SearchColumnId]) VALUES (17, 62)
INSERT [dbo].[SearchGroupColumns] ([SearchGroupId], [SearchColumnId]) VALUES (17, 63)
INSERT [dbo].[SearchGroupColumns] ([SearchGroupId], [SearchColumnId]) VALUES (17, 64)
INSERT [dbo].[SearchGroupColumns] ([SearchGroupId], [SearchColumnId]) VALUES (17, 65)
INSERT [dbo].[SearchGroupColumns] ([SearchGroupId], [SearchColumnId]) VALUES (17, 66)
INSERT [dbo].[SearchGroupColumns] ([SearchGroupId], [SearchColumnId]) VALUES (17, 69)
INSERT [dbo].[RolePermission] ([RoleId], [PermissionId]) VALUES (1, 1)
INSERT [dbo].[RolePermission] ([RoleId], [PermissionId]) VALUES (1, 2)
INSERT [dbo].[RolePermission] ([RoleId], [PermissionId]) VALUES (1, 3)
INSERT [dbo].[RolePermission] ([RoleId], [PermissionId]) VALUES (1, 4)
INSERT [dbo].[RolePermission] ([RoleId], [PermissionId]) VALUES (2, 6)
INSERT [dbo].[RolePermission] ([RoleId], [PermissionId]) VALUES (2, 2)
INSERT [dbo].[RolePermission] ([RoleId], [PermissionId]) VALUES (3, 7)
INSERT [dbo].[RolePermission] ([RoleId], [PermissionId]) VALUES (4, 4)
INSERT [dbo].[RolePermission] ([RoleId], [PermissionId]) VALUES (5, 5)
INSERT [dbo].[RolePermission] ([RoleId], [PermissionId]) VALUES (6, 3)
INSERT [dbo].[PermissionSearchGroup] ([PermissionId], [SearchGroupId]) VALUES (3, 1)
INSERT [dbo].[PermissionSearchGroup] ([PermissionId], [SearchGroupId]) VALUES (3, 8)
INSERT [dbo].[PermissionSearchGroup] ([PermissionId], [SearchGroupId]) VALUES (4, 2)
INSERT [dbo].[PermissionSearchGroup] ([PermissionId], [SearchGroupId]) VALUES (4, 3)
INSERT [dbo].[PermissionSearchGroup] ([PermissionId], [SearchGroupId]) VALUES (4, 4)
INSERT [dbo].[PermissionSearchGroup] ([PermissionId], [SearchGroupId]) VALUES (4, 17)

SET IDENTITY_INSERT [dbo].[IPs] ON
INSERT [dbo].[IPs] ([Id], [IP], [GeoLocationCountryId], [IsAllowed], [IsDeleted], [CompanyId]) VALUES (1, N'127.0.0.1', 249, 1, 0, 1)
SET IDENTITY_INSERT [dbo].[IPs] OFF

SET IDENTITY_INSERT [dbo].[Informers] ON
INSERT [dbo].[Informers] ([Id], [Title], [HeaderColor], [ContentColor], [FooterColor], [InformerStyle], [ContentStyle], [TitleStyle], [FooterStyle], [ContentProviderId], [UserId], [IsDeleted], [Xslt], [XsltParameters], [ShowFooter]) VALUES (1, N'Calls by countries', N'rgb(132, 212, 255)', N'rgb(204, 252, 255)', NULL, N'width:280px;top:155px;left:5px;height:155px', N'text-align: left; font-size: 12px', NULL, NULL, 262, 1, 0, N'DataSet.xslt', N'showColumnNames=True|alternativeItemColor=rgb(171, 234, 238)', 0)
INSERT [dbo].[Informers] ([Id], [Title], [HeaderColor], [ContentColor], [FooterColor], [InformerStyle], [ContentStyle], [TitleStyle], [FooterStyle], [ContentProviderId], [UserId], [IsDeleted], [Xslt], [XsltParameters], [ShowFooter]) VALUES (2, N'Active', NULL, N'rgb(130, 251, 109)', NULL, N'transform:rotate(5deg);width:70px;height:80px;top:32.1017608642578px;left:731.64697265625px;z-index:2', N'text-align:center; font-size: 17px; font-weight: bold; position:relative; top: 10px;', NULL, NULL, 263, 1, 0, N'DataSet.xslt', N'showColumnNames=|alternativeItemColor=rgb(171, 234, 238)', 0)
INSERT [dbo].[Informers] ([Id], [Title], [HeaderColor], [ContentColor], [FooterColor], [InformerStyle], [ContentStyle], [TitleStyle], [FooterStyle], [ContentProviderId], [UserId], [IsDeleted], [Xslt], [XsltParameters], [ShowFooter]) VALUES (15, N'Top 100 today''s data queries', N'rgb(132, 212, 255)', N'rgb(204, 252, 255)', NULL, N'top:155px;left:300px;width:600px;height:495px', NULL, NULL, NULL, 265, 1, 0, N'TodaysRequests.xslt', N'showColumnNames=|alternativeItemColor=rgb(171, 234, 238)', 0)
INSERT [dbo].[Informers] ([Id], [Title], [HeaderColor], [ContentColor], [FooterColor], [InformerStyle], [ContentStyle], [TitleStyle], [FooterStyle], [ContentProviderId], [UserId], [IsDeleted], [Xslt], [XsltParameters], [ShowFooter]) VALUES (16, N'Locked', NULL, N'rgb(251, 195, 140)', NULL, N'transform:rotate(-5deg);width:70px;height:80px;top:32.1017608642578px;left:801.64697265625px;z-index:0', N'text-align:center; font-size: 17px; font-weight: bold; position:relative; top: 10px;', NULL, NULL, 266, 1, 0, N'DataSet.xslt', N'showColumnNames=|alternativeItemColor=', 0)
INSERT [dbo].[Informers] ([Id], [Title], [HeaderColor], [ContentColor], [FooterColor], [InformerStyle], [ContentStyle], [TitleStyle], [FooterStyle], [ContentProviderId], [UserId], [IsDeleted], [Xslt], [XsltParameters], [ShowFooter]) VALUES (17, N'Coming expirations (30 days)', N'rgb(217, 194, 143)', N'rgb(252, 255, 189)', NULL, N'width:280px;height:170px;top:480px;left:5px', N'text-align:center;', NULL, NULL, 268, 1, 0, N'Expirations.xslt', N'showColumnNames=|alternativeItemColor=rgb(232, 236, 161)', 0)
INSERT [dbo].[Informers] ([Id], [Title], [HeaderColor], [ContentColor], [FooterColor], [InformerStyle], [ContentStyle], [TitleStyle], [FooterStyle], [ContentProviderId], [UserId], [IsDeleted], [Xslt], [XsltParameters], [ShowFooter]) VALUES (18, N'Recent expirations (30 days)', N'rgb(217, 194, 143)', N'rgb(251, 195, 140)', NULL, N'width:280px;height:160px;top:315px;left:5px', N'text-align:center;', NULL, NULL, 267, 1, 0, N'Expirations.xslt', N'showColumnNames=|alternativeItemColor=rgb(253, 183, 114)', 0)
INSERT [dbo].[Informers] ([Id], [Title], [HeaderColor], [ContentColor], [FooterColor], [InformerStyle], [ContentStyle], [TitleStyle], [FooterStyle], [ContentProviderId], [UserId], [IsDeleted], [Xslt], [XsltParameters], [ShowFooter]) VALUES (21, N'CUI Errors', N'rgb(212, 185, 145)', N'rgb(255, 255, 255)', N'rgb(212, 185, 145)', N'top:5px;left:305px;width:85px;height:120px', N'text-align:center; font-size: 27px; font-weight: bold; position:relative; top: 10px; color:red;', NULL, N'align: right;', 269, 1, 0, N'RecentErrors.xslt', N'showColumnNames=False|alternativeItemColor=rgb(249, 110, 110)', 1)
INSERT [dbo].[Informers] ([Id], [Title], [HeaderColor], [ContentColor], [FooterColor], [InformerStyle], [ContentStyle], [TitleStyle], [FooterStyle], [ContentProviderId], [UserId], [IsDeleted], [Xslt], [XsltParameters], [ShowFooter]) VALUES (23, N'Unregistered IPs', N'rgb(217, 194, 143)', N'rgb(252, 255, 189)', NULL, N'width:280px;height:145px;top:5px;left:5px', N'text-align: left; font-size: 12px', NULL, NULL, 270, 1, 0, N'UnregisteredIPs.xslt', N'showColumnNames=True|alternativeItemColor=rgb(255, 221, 140)', 0)
INSERT [dbo].[Informers] ([Id], [Title], [HeaderColor], [ContentColor], [FooterColor], [InformerStyle], [ContentStyle], [TitleStyle], [FooterStyle], [ContentProviderId], [UserId], [IsDeleted], [Xslt], [XsltParameters], [ShowFooter]) VALUES (25, N'Subscription requests', N'rgb(139, 223, 185)', N'rgb(187, 244, 219)', NULL, N'width:275px;height:335px;top:5px;left:915px;z-index:3', NULL, NULL, NULL, 279, 1, 0, N'SubscriptionRequests.xslt', N'showColumnNames=True|alternativeItemColor=rgb(175, 234, 208)', 0)
INSERT [dbo].[Informers] ([Id], [Title], [HeaderColor], [ContentColor], [FooterColor], [InformerStyle], [ContentStyle], [TitleStyle], [FooterStyle], [ContentProviderId], [UserId], [IsDeleted], [Xslt], [XsltParameters], [ShowFooter]) VALUES (29, N'Recent trial requests', N'rgb(139, 223, 185)', N'rgb(187, 244, 219)', N'rgb(218, 139, 163)', N'width:275px;height:300px;top:350px;left:915px;z-index:4', NULL, NULL, NULL, 316, 1, 0, N'SubscriptionRequests.xslt', N'showColumnNames=True|alternativeItemColor=rgb(175, 234, 208)', 0)
INSERT [dbo].[Informers] ([Id], [Title], [HeaderColor], [ContentColor], [FooterColor], [InformerStyle], [ContentStyle], [TitleStyle], [FooterStyle], [ContentProviderId], [UserId], [IsDeleted], [Xslt], [XsltParameters], [ShowFooter]) VALUES (26, N'AUI Errors', N'rgb(212, 185, 145)', N'rgb(255, 255, 255)', N'rgb(212, 185, 145)', N'top:5px;left:395px;width:85px;height:120px', N'text-align:center; font-size: 27px; font-weight: bold; position:relative; top: 10px; color:red;', NULL, N'align: right;', 280, 1, 0, N'RecentErrors.xslt', N'showColumnNames=False|alternativeItemColor=rgb(249, 110, 110)', 1)
INSERT [dbo].[Informers] ([Id], [Title], [HeaderColor], [ContentColor], [FooterColor], [InformerStyle], [ContentStyle], [TitleStyle], [FooterStyle], [ContentProviderId], [UserId], [IsDeleted], [Xslt], [XsltParameters], [ShowFooter]) VALUES (27, N'API Errors', N'rgb(212, 185, 145)', N'rgb(255, 255, 255)', N'rgb(212, 185, 145)', N'top:5px;left:485px;width:85px;height:120px', N'text-align:center; font-size: 27px; font-weight: bold; position:relative; top: 10px; color:red;', NULL, N'align: right;', 281, 1, 0, N'RecentErrors.xslt', N'showColumnNames=False|alternativeItemColor=rgb(249, 110, 110)', 1)
INSERT [dbo].[Informers] ([Id], [Title], [HeaderColor], [ContentColor], [FooterColor], [InformerStyle], [ContentStyle], [TitleStyle], [FooterStyle], [ContentProviderId], [UserId], [IsDeleted], [Xslt], [XsltParameters], [ShowFooter]) VALUES (28, N'Failed API Calls', N'rgb(212, 185, 145)', N'rgb(255, 255, 255)', N'rgb(212, 185, 145)', N'top:5px;left:575px;width:110px;height:120px;z-index:2', N'text-align:center; font-size: 27px; font-weight: bold; position:relative; top: 10px; color:red;', NULL, N'align: right;', 286, 1, 0, N'RecentErrors.xslt', N'showColumnNames=False|alternativeItemColor=rgb(249, 110, 110)', 1)
SET IDENTITY_INSERT [dbo].[Informers] OFF

INSERT [dbo].[UserRole] ([RoleId], [UserId]) VALUES (1, 1)
INSERT [dbo].[UserRole] ([RoleId], [UserId]) VALUES (1, 2)
INSERT [dbo].[UserRole] ([RoleId], [UserId]) VALUES (1, 3)
INSERT [dbo].[UserRole] ([RoleId], [UserId]) VALUES (2, 2)
INSERT [dbo].[UserRole] ([RoleId], [UserId]) VALUES (2, 3)
INSERT [dbo].[UserRole] ([RoleId], [UserId]) VALUES (5, 1)
INSERT [dbo].[UserRole] ([RoleId], [UserId]) VALUES (6, 2)
INSERT [dbo].[UserRole] ([RoleId], [UserId]) VALUES (6, 3)
INSERT [dbo].[UserRole] ([RoleId], [UserId]) VALUES (2, 4)
INSERT [dbo].[UserRole] ([RoleId], [UserId]) VALUES (2, 5)


/****** Object:  Table [dbo].[EmailTemplates]    Script Date: 09/29/2016 19:18:53 ******/
SET IDENTITY_INSERT [dbo].[EmailTemplates] ON
INSERT [dbo].[EmailTemplates] ([Id], [Name], [Description], [Subject], [Body], [IsDeleted]) VALUES (1, N'Trial Notification', N'Template for email send to a new trial user after subscription.

Outlook only recognize inline styles, so it is necessary to set them to each element.
As it is boring to edit manually each tag, it is possible to use online tools which will take markup, 
styles and will give in response html with applied styles.

However such tools require html WITHOUT inline styles, because they skip elements, which are already styled.

Thus the complex way to update template - clean inline styles, update the styles block in a way you need, convert all that into html with inline styles.

The template below contains both the styles block - for future changes, and inline styles for the mail clients.

***

Remove inline styles: https://html-online.com/editor/

Style block to inline styles convertion tool: 
http://templates.mailchimp.com/resources/inline-css/

Keep styles in the style block, use the tools to apply 
to elements.

Styles must be removed before using that 
tool, otherwise they will not be updated.

Available placeholders:

{email}
{methodName} - the API service method for queries examples
{ServiceUrl} - the API service URL
{link} - activation link, leads to the Symbology login page
{username}
{password}
{name}', N'EuromoneyTRADEDATA Trial Subscription details.', N'<style>
    body {
        font-family: Calibri, Tahoma, Arial;
        font-size: 11pt;
        color: black;
    }

    pre {
        font-family: Calibri, Tahoma, Arial;
        font-size: 10pt;
    }

        pre.example {
            font-family: Courier New;
            font-size: 10pt;
        }

    li {
        margin-top: 10pt;
        margin-bottom: 10pt;
    }

    table.header {
        border: none;
        width: 100%;
        padding: 0;
        border-spacing: 0;
        border-collapse: collapse;
    }

        table.header td.logo {
            text-align: right;
            vertical-align: top;
        }

        table.header td.hello {
            text-align: left;
            vertical-align: bottom;
        }

    table.commands {
        width: 100%;
        border-collapse: collapse;
        font-size: 10pt;
    }

        table.commands td {
            border: solid 1px lightgrey;
            vertical-align: top;
            padding: 3px;
        }

    .example {
        border: solid 1px lightgrey;
        padding: 7px;
        font-size: 12pt;
    }

    h4 {
        font-size: 12pt;
        font-weight: bold;
    }

    .fs10 {
        font-size: 10pt;
    }

    .fs11 {
        font-size: 11pt;
    }

    .fs12 {
        font-size: 11pt;
    }

    .underline {
        text-decoration: underline;
    }

    .italic {
        font-style: italic;
    }

    .bold {
        font-weight: bold;
    }

    .normal {
        font-weight: normal;
    }

</style>
<body style="font-family: Calibri, Tahoma, Arial;font-size: 11pt;color: black;">
    <table class="header" style="border: none;width: 100%;padding: 0;border-spacing: 0;border-collapse: collapse;">
        <tr>
            <td class="hello fs12 bold" style="font-size: 11pt;font-weight: bold;text-align: left;vertical-align: bottom;">Hello {name}!</td>
            <td class="logo" style="text-align: right;vertical-align: top;"><img src="http://lookup.etdplatform.dev/images/emailLogo.png" alt="Euromoney TRADEDATA"></td>
        </tr>
    </table>
    <br>
    <div>
        This is an automated notification, which has been created from your submission {email} to subscribe to access a trial at
        <a href="https://www.fowtradedata-customer.com">https://www.fowtradedata-customer.com</a><br>
        <br>
        Your trial was accepted and your subscription details are below.
    </div>
    <div>
        <br>
        To activate your account, please follow this link:<br>
        {link}<br>
        <br>
        <div class="bold underline" style="text-decoration: underline;font-weight: bold;">Members area access:</div>
        <div class="bold" style="font-weight: bold;">Username:&nbsp;<span class="normal" style="font-weight: normal;">{username}</span></div>
        <div class="bold" style="font-weight: bold;">Password:&nbsp;<span class="normal" style="font-weight: normal;">{password}</span></div>
    </div>
    <br>
    <div class="bold italic" style="font-style: italic;font-weight: bold;">You now have access to our web service, via the browser or from your own client. See below examples of usage.</div>
    <br>
    <br>
    <div class="bold underline" style="text-decoration: underline;font-weight: bold;">How the URL is structured:</div>

    <ul>
        <li style="margin-top: 10pt;margin-bottom: 10pt;">tda stands for the database alias, during the trial period, this is the only DB you can use.</li>
        <li style="margin-top: 10pt;margin-bottom: 10pt;">GetExchangeCodes - method name</li>
        <li style="margin-top: 10pt;margin-bottom: 10pt;">csv - data format</li>
        <li style="margin-top: 10pt;margin-bottom: 10pt;">then go parameters and filters</li>
    </ul>

    <br>
    <div class="fs10" style="font-size: 10pt;">
        <div class="bold underline" style="text-decoration: underline;font-weight: bold;">There are a number of available commands and options:</div>
        <ol>
            <li style="margin-top: 10pt;margin-bottom: 10pt;">
                <strong>List</strong> all available methods with parameters:<br>
                <a href="{ServiceUrl}tda/list?u={username}&p={password}">{ServiceUrl}tda/list?u={username}&p={password}</a><br>
            </li>
            <li style="margin-top: 10pt;margin-bottom: 10pt;">
                When you have a list of methods, you can query for the method <strong>help</strong>, for example lets query method GetExchangeCodes:
                <br><a href="{ServiceUrl}tda/{methodName}/help?u={username}&p={password}">{ServiceUrl}tda/{methodName}/help?u={username}&p={password}</a><br>
            </li>
            <li style="margin-top: 10pt;margin-bottom: 10pt;">
                And you can <strong>count</strong> number of results:
                <br><a href="{ServiceUrl}tda/{methodName}/count?u={username}&p={password}">{ServiceUrl}tda/{methodName}/count?u={username}&p={password}</a><br>
            </li>
            <li style="margin-top: 10pt;margin-bottom: 10pt;">
                <strong>Query</strong> a method for data in:
                <ul>
                    <li style="margin-top: 10pt;margin-bottom: 10pt;">
                        <strong>csv</strong> format:<br>
                        <a href="{ServiceUrl}tda/{methodName}/csv?u={username}&p={password}">
                            {ServiceUrl}tda/{methodName}/csv?u={username}&p={password}
                        </a>
                        <ul>
                            <li style="margin-top: 10pt;margin-bottom: 10pt;">
                                add <strong>column headers</strong>:<br>
                                <a href="{ServiceUrl}tda/{methodName}/csv?cn=true&u={username}&p={password}">{ServiceUrl}tda/{methodName}/csv?cn=true&u={username}&p={password}</a>
                            </li>
                            <li style="margin-top: 10pt;margin-bottom: 10pt;">
                                <strong>force quotes</strong>:<br>
                                <a href="{ServiceUrl}tda/{methodName}/csv?cn=true&q=true&u={username}&p={password}">{ServiceUrl}tda/{methodName}/csv?cn=true&q=true&u={username}&p={password}</a>
                            </li>
                            <li style="margin-top: 10pt;margin-bottom: 10pt;">
                                specify <strong>custom delimiter</strong>:<br>
                                <a href="{ServiceUrl}tda/{methodName}/csv?cn=true&q=true&d=;&u={username}&p={password}">{ServiceUrl}tda/{methodName}/csv?cn=true&q=true&d=;&u={username}&p={password}</a>
                            </li>
                        </ul>
                    </li>
                    <li style="margin-top: 10pt;margin-bottom: 10pt;">
                        <strong>xml</strong> format:<br>
                        <a href="{ServiceUrl}tda/{methodName}/xml?u={username}&p={password}">{ServiceUrl}tda/{methodName}/xml?u={username}&p={password}</a>
                    </li>
                    <li style="margin-top: 10pt;margin-bottom: 10pt;">
                        <strong>json</strong> format:<br>
                        <a href="{ServiceUrl}tda/{methodName}/json?u={username}&p={password}">
                            {ServiceUrl}tda/{methodName}/json?u={username}&p={password}
                        </a>
                        <ul>
                            <li style="margin-top: 10pt;margin-bottom: 10pt;">
                                <strong>add indents</strong>:<br>
                                <a href="{ServiceUrl}tda/{methodName}/json?ij=true&u={username}&p={password}">{ServiceUrl}tda/{methodName}/json?ij=true&u={username}&p={password}</a>
                            </li>
                        </ul>
                    </li>
                </ul>
            </li>
            <li style="margin-top: 10pt;margin-bottom: 10pt;">
                Specify page size and page number:<br><br>
                <strong>pg</strong> - page size,<br>
                <strong>pn</strong> - page number<br>
                <br>
                Show first 50 records:<br>
                <br><a href="{ServiceUrl}tda/{methodName}/help?u={username}&p={password}&ps=50&pn=1">{ServiceUrl}tda/{methodName}/help?u={username}&p={password}&ps=50&pn=1</a><br>
            </li>
            <li style="margin-top: 10pt;margin-bottom: 10pt;">
                Specify filters.<br>
                <br>
                Available filters are:
                <table class="commands" style="width: 100%;border-collapse: collapse;font-size: 10pt;">
                    <tr>
                        <td style="border: solid 1px lightgrey;vertical-align: top;padding: 3px;">
                            <strong>Equal (=)</strong>:<br>
                            <pre style="font-family: Calibri, Tahoma, Arial;font-size: 10pt;">t0.ColumnName=Value</pre>
                        </td>
                        <td style="border: solid 1px lightgrey;vertical-align: top;padding: 3px;">
                            <strong>Greater than (gt)</strong>: <pre style="font-family: Calibri, Tahoma, Arial;font-size: 10pt;">t0.ColumnName-gt=Value</pre>
                        </td>
                    </tr>
                    <tr>
                        <td style="border: solid 1px lightgrey;vertical-align: top;padding: 3px;">
                            <strong>Less than (lt)</strong>: <pre style="font-family: Calibri, Tahoma, Arial;font-size: 10pt;">t0.ColumnName-lt=Value</pre>
                        </td>
                        <td style="border: solid 1px lightgrey;vertical-align: top;padding: 3px;">
                            <strong>Greater than or equal (gte)</strong>: <pre style="font-family: Calibri, Tahoma, Arial;font-size: 10pt;">t0.ColumnName-gte=Value</pre>
                        </td>
                    </tr>
                    <tr>
                        <td style="border: solid 1px lightgrey;vertical-align: top;padding: 3px;">
                            <strong>Less than or equal (lte)</strong>: <pre style="font-family: Calibri, Tahoma, Arial;font-size: 10pt;">t0.ColumnName-lte=Value</pre>
                        </td>
                        <td style="border: solid 1px lightgrey;vertical-align: top;padding: 3px;">
                            <strong>LIKE</strong>: SQL "like" operator, use "%" as a wildcard, you MUST use URL encoded percent sign - "%25", <pre style="font-family: Calibri, Tahoma, Arial;font-size: 10pt;">t0.ColumnName-like=%25Value%25, t0.ColumnName=Value%25</pre>
                        </td>
                    </tr>
                    <tr>
                        <td style="border: solid 1px lightgrey;vertical-align: top;padding: 3px;">
                            <strong>IN</strong>: SQL "in", separate values with comma, without quotes, <pre style="font-family: Calibri, Tahoma, Arial;font-size: 10pt;">t0.ColumnName-in=new year,old school,red fox</pre>
                        </td>
                        <td style="border: solid 1px lightgrey;vertical-align: top;padding: 3px;">
                            <strong>NOTIN</strong>: SQL "not in" same rules like for "in", <pre style="font-family: Calibri, Tahoma, Arial;font-size: 10pt;">t0.ColumnName-notin=new year,old school,red fox</pre>
                        </td>
                    </tr>
                    <tr>
                        <td style="border: solid 1px lightgrey;vertical-align: top;padding: 3px;">
                            <strong>SORT</strong>: you can order output by column or by several columns, <pre style="font-family: Calibri, Tahoma, Arial;font-size: 10pt;">t0.ColumnName-sort=ASC&t0.AnotherColumnName-sort=DESC</pre>
                        </td>
                        <td style="border: solid 1px lightgrey;vertical-align: top;padding: 3px;">
                            <strong>AND</strong>: concatenate current condition with previous one, "and" is a default value and can be omitted, <pre style="font-family: Calibri, Tahoma, Arial;font-size: 10pt;">t0.ColumnName=14&t0.AnotherColumnName=AMEX</pre>
                        </td>
                    </tr>
                    <tr>
                        <td style="border: solid 1px lightgrey;vertical-align: top;padding: 3px;">
                            <strong>OR</strong>: <pre style="font-family: Calibri, Tahoma, Arial;font-size: 10pt;">t0.ColumnName=14&t0.or-AnotherColumnName=AMEX</pre>
                        </td>
                        <td style="border: solid 1px lightgrey;vertical-align: top;padding: 3px;"></td>
                    </tr>
                </table>
            </li>
            <li style="margin-top: 10pt;margin-bottom: 10pt;">You can specify several filters for one column.</li>
        </ol>
        <br>
        <br>
        <br>
    </div>
    <strong>
        <u>You can call the service from your application.</u><br>
        C# example
    </strong>:
<pre class="example" style="font-family: Courier New;font-size: 10pt;border: solid 1px lightgrey;padding: 7px;">
using System;
using System.Diagnostics;
using System.IO;
using System.Net;
using System.Net.Http;

namespace TdApiExample
{
    class Program
    {
        static void Main(string[] args)
        {
            ServicePointManager.ServerCertificateValidationCallback = delegate { return true; };

            // take some data from the service and output to console
            DownloadData();

            // export search results into zip file and open it
            ExportSearchData();
        }

        static private void DownloadData()
        {
            using (var client = new HttpClient())
            {
                client.BaseAddress = new Uri("{ServiceUrl}");
                client.DefaultRequestHeaders.Accept.Clear();

                HttpResponseMessage response = null;

                try
                {
                    response = client.GetAsync("tda/{methodName}/csv?u={username}&p={password}").Result;
                    response.EnsureSuccessStatusCode(); // treat http error codes as exceptions

                    var content = response.Content.ReadAsStringAsync().Result;
                    Console.WriteLine(content);
                }
                catch (HttpRequestException rex)
                {
                    var status = response?.StatusCode;
                    if (status != null)
                    {
                        Console.WriteLine($"{(int) status} {status}");
                    }
                    else
                    {
                        Console.WriteLine(rex);
                    }

                    response?.Dispose();
                }
                catch (Exception ex)
                {
                    Console.WriteLine(ex);
                }
            }
        }

        static private void ExportSearchData()
        {
            const string fileName = "example.zip";

            using (var client = new HttpClient())
            {
                client.BaseAddress = new Uri("{ServiceUrl}");

                HttpResponseMessage response = null;

                try
                {
                    // for search we use the GetBySymbol method 
                    // s - search string
                    // zip=1 - results will be compressed and send as file
                    // se=1 - include series information
                    // ps=3 - page size
                    // pn=1 - page number
                    response = client.GetAsync("tda/GetBySymbol/csv?u={username}&p={password}&s=amex&zip=1&se=1&ps=30&pn=1").Result;
                    response.EnsureSuccessStatusCode(); // treat http error codes as exceptions

                    SaveStreamInFile(response.Content.ReadAsStreamAsync().Result, fileName);
                    
                }
                catch (HttpRequestException rex)
                {
                    var status = response?.StatusCode;
                    if (status != null)
                    {
                        Console.WriteLine($"{(int)status} {status}");
                    }
                    else
                    {
                        Console.WriteLine(rex);
                    }

                    response?.Dispose();
                }
                catch (Exception ex)
                {
                    Console.WriteLine(ex);
                }
            }
        }

        private static void SaveStreamInFile(Stream stream, string fileName)
        {
            if (stream == null)
                return;

            var filePath = Path.Combine(Environment.CurrentDirectory, fileName);

            if (File.Exists(filePath))
            {
                File.Delete(filePath);
            }

            using (stream)
            using (var file = new FileStream(filePath, FileMode.Create, FileAccess.Write))
            {
                stream.CopyTo(file);
            }

            Process.Start(filePath);
        }
    }
}

</pre>
    <br>
    <br>
    <b>If you have any further questions contact <a href="mailto:support@euromoneytradedata.com">support@euromoneytradedata.com</a></b>
</body>', 0)
INSERT [dbo].[EmailTemplates] ([Id], [Name], [Description], [Subject], [Body], [IsDeleted]) VALUES (2, N'Trial Request', N'This is a notification email for the administrator.
It''s being sent on new trial request.

Available placeholders:

{email}
{phone}
{name}
{company}
{username}
{password}
{comment} - stands for the comment, from the acceptance form of the request, via Admin UI
{id} (stands for the trial request ID)', N'Trial request from {email}. ID: {id}.', N'<p>Hello, TradeData.</p>
<p>A new trial request was submitted from the site with the following parameters:<br>
Name: {name}<br>
Email: {email}<br>
Phone: {phone}<br>
Company: {company}<br>
</p>
<p>The system has created user accounts in the Users and the TRADEDataUsers databases.</p>
<p>
Username and password were generated:<br>
<br>
Username: {username}<br>
Password: {password}.<br>
</p>
<p>The default settings for the trial period can be verified in the Administrative UI, please go to the<br>
System Settings/Service Configuration page, the Trial group.
</p>
<p>To accept or decline the request, please go to the Subscriptions / Subscriptions Requests page<br>
Request ID: {id}
</p>', 0)
INSERT [dbo].[EmailTemplates] ([Id], [Name], [Description], [Subject], [Body], [IsDeleted]) VALUES (3, N'Trial Declined Email', N'This email will be automatically send to the user, in case the request is declined and notification is enabled.

Available placeholders:

{email}
{phone}
{name}
{company}
{username}
{comment} - stands for the comment, from the acceptance form of the request, via Admin UI
{id} (stands for the trial request ID)', N'TRADEData trial request details.', N'{comment}', 0)
SET IDENTITY_INSERT [dbo].[EmailTemplates] OFF


COMMIT TRANSACTION


/****** Create diagram using 'official' Stored Procedure ******/

-- Backup script:
-- 1. Read from DB, using XML to workaround the 65535 character limit:
/*

declare @definition varbinary(max)
select @definition = definition from dbo.sysdiagrams where name = 'Users' 

select
    '0x' + cast('' as xml).value('xs:hexBinary(sql:variable("@definition") )', 'varchar(max)')
for xml path('')

*/

-- 2. Open the result XML in Management Studio

-- 3. Copy the result

-- 4. Paste this in backup script for @definition variable:
/*
declare @definition varbinary(max)
set @definition = 0xD0[...]

exec dbo.sp_creatediagram
    @diagramname = 'Users',
    @owner_id = null,
    @version = 1,
    @definition = @definition

*/