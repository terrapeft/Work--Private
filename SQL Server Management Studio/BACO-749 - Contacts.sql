	select distinct u.userid, u.usertypeid, a.ContactId, Forenames, Surname, Initials, genderid, titleid
	from backoffice.customer.contact a
	join backoffice.customer.usercontactaddress uca on a.ContactId = uca.ContactId
	join backoffice.logon.users u on uca.userid = u.userid
	where u.userid in (21438,23065,26307,30164,30438,30441,31517,32329,35510,46207,58709,58758,71302,71574,28312,81039,80500,70299,84559,83007,72044,86395,86709,80652,83077,87455,87456,80095,90046,80433,82887,82140,83924,94683,87357,85715,97431,94339,87933,90017,90400,92147,88265,89450,91413,128351,131206,96478,149592,115810,121566,131203,191197,136162,146943,150968,153904,150883,153540,250024,164228,275729,147032,148950,143933,149524,150687,155675,301748,150722,152027,160768,185139,381610,392313,392372,392589,393600,395647,240564,313998,388664,392380,416706,405209,437997,412234,363905,366893,338697,445193,369264,377559,462129,389487,390806,393213,394131,392411,402108,393605,487808,487901,405860,395559,414081,491176,495155,394667,394685,395620,435289,406633,455052,436944,412233,503520,414095,415424,463160,465559,514792,428802,469751,517255,440499,442089,487794,487869,449176,449967,488079,460725,487836,488085,475815,494312,466305,548283,487916,511005,508925,497264,528162,528297,493389,509881,510241,541405,547046,539388,578666,593322,579200,594510,577301,592500,597918,609378,596452,606843,623699,623907,605034,614716,622500,635147,653816,655242,646476,652112,651308,682277,685494,699090,663759,648880,657366,726423,730359,720557,722476,739960,770742,770750,719271,722144,750690,780812,681830,740746,689457,767527,709590,761117,815448,716773,717093,824197,784404,803418,830166,816526,737783,746824,854030,753022,755892,857722,863788,823511,873048,779731,781024,835297,780565,858678,837934,849355,785563,792098,789339,791648,797930,908965,818602,917748,887890,829284,826351,923084,924624,927330,895420,842788,905394,913144,855102,942655,922686,857810,864093,868923,863828,931458,932096,872458,960679,966030,939285,939956,888110,879428,954013,976917,924612,975186,982090,978580,1017209,1020537,1024731,932006,996196,1032886,1034325,960584,952671,952914,1006590,966409,962592,1027113,1027180,980332,1072536,1046046,996357,1060136,1005866,1060128,1018311,1019996,1027169,1035680,1086743,1046427,1112755,1097389,1097850,1097938,1044925,1102835,1134707,1125231,1125406,1091859,1137733,1138459,1098806,1140834,1109811,1111866,1183107,1117307,1192642,1126506,1130274,1170389,1139499,1219784,1140354,1182356,1186909,1156414,1156422,1165471,1200553,1210196,1211692,1169273,1170428,1174529,1404696,1192220,80036,81033,1186904,1435633,1192628,1200760,1204103,1444407,1227115,1210680,1234600,1426390,1219151,1244626,1515385,1435632,1436300,1234629,1225594,1246185,1235773,1435472,1405226,1550723,1440309,1477128,1571698,1435543,1529140,1488014,1597335,1518793,1539291,1525159,1612709,1552404,1521314,1615877,1529208,1646870,1652978,1662820,1552882,1534556,1593038,1597049,1566319,1548478,1692573,1585043,1698695,1588308,1702286,1599973,1571699,1709456,1623522,1614397,1716869,1580886,1589011,1594164,1594188,1732037,1620979,1751985,1692044,1647041,1774162,1710810,1710860,1699332,1797288,1728141,1732739,1703698,1705411,1703780,1708025,1709879,1717291,1732164,1772029,1725899,1753569,1835544,1837510,1783203,1744099,1769129,1769139,1775113,1767420,1769134,1776250,1756756,1788777,1783433,1767907,1790897,1812447,1794761,1800185,1821867,1792933,1881722,1886745,1837477,1839774,1840326,1826465,1845774,1832532,1838846,1832892,1864733,1852544,1853375,1854401,1846831,1865899,1853374,1884587,1860719,1862858,1900555,1889346,1889529,1892164,1908025,1907646,1908858,1914693,1918017,1918224,1914163,2033586,1947985,2049441,1929048,1953804,2059916,1943754,2072094,87760,2021393,2108735,2011748,2012860,2049473,2039360,2053168,2045460,2060326,2037036,2060228,2060714,2047438,2141325,2049526,2098868,2151545,2116013,2100490,2179906,2111531,2180793,2182070,2119844,2192899,2139134,2200803,2203468,2203510,2146195,2147032,2162550,2210172,2157608,2212830,2212862,2146224,2217675,2147420,2173252,2219615,2221493,2178023,2171736,2171681,2174564,2187843,2177013,2191177,2231873,2182068,2183554,2172129,2189010,2174986,2177128,2207065,2210198,2199237,2182097,2200063,2217257,2263193,2207751,2207916,2209628,2210170,2210092,2223877,2212828,2212861,2199038,2200649,2212831,2216754,2203475,2203516,2206049,2221222,2232682,2235732,2293892,2209631,2210199,2210201,2212833,2212883,2253140,2227075,2305723,2254977,2230627,2221139,2252470,2323238,2262319,2337529,2337530,2264759,2273749,2305558,2306945,2347522,2348391,2275081,2277030,2294156,2328619,2290159,2305703,2305650,2378423,2336565,2325052,2351357,2395102,2396224,2396624,2355810,2342530,2326326,2406243,2337507,2344773,2412502,2413101,2413813,2342396,2418993,2367953,2388518,2363300,2377356,2396623,2363965,2370663,2439638,2407704,2369236,2410965,2373207,2444965,2448581,2417396,2391949,2396152,2399000,2428154,2409094,2410199,2397809,2400219,2401582,2475064,2403006,2413118,2416422,2417354,2416014,2491601,2460113,2418999,2439178,2429758,2468512,2448720,2432253,2450800,2434574,2432497,2474648,2436076,2439639,2459275,2460293,2452481,2451687,2462175,2456186,2455276,2458309,2458643,2459240,2462146,2464651,2466115,2468528,90843,2469753,2480719,2502306,2545608,2510226,2554998,2495904,2503786,2591660,2592788,2594749,2552966,2573644,2556423,2618544,2583679,2557237,2628027,2592496,2594150,2629972,2595136,2634778,2565631,2568686,2573805,2575661,2574394,2600755,2595229,2652742,2593524,2594031,2595705,2606713,2627055,2672315,2633314,2618998,2614819,2674571,2641329,2624765,2628013,2647334,2650173,2651450,2640234,2661937,2674403,2704425,2663426,2685224,2718396,2720652,2693311,2684527,2685763,2681682,2685223,2685316,2685226,2686112,2702054,2696761,2689098,2733565,2693128,2695077,2740635,2696426,2742027,2701926,2703640,2720947,2703647,2723360,2723585,2709346,2720624,2730104,2731743,2715780,2732814,2719175,2719216,2726876,2718175,2764615,2765219,2744133,2745370,2730223,2743519,2744056,2736076,2790415,2794078,2750140,2781064,2770068,2794071,2790420,2861503,2780115,2793456,2782611,2873916,2797091,2786987,2884279,2817278,2790931,2837175,2839031,2793910,2793455,2815150,2797397,2838905,2804857,2867004,2816644,2823014,2864024,2867017,2893996,2847740,2850281,2923018,2876512,3027653,2897031,2944516,2896818,2917023,2958911,3012056,3016044,3018947,3110655,3121124,2969459,3056986,3012809,3001774,3006344,3097486,3158102,3073996,3077375,3174075,3281303,3180026,3158312,3178262,3319522,3172993,3268478,3333498,3277072,3340309,3281302,3359688,3202658,3307303,3276838,3223484,3388857,3388859,3389083,3390115,3255490,3483810,3517820,3519828,3530917,5000173,5000196,5000232,5000239,5000264,3334651,5001169,5002421,3310389,5003170,5003767,3280780,3323175,3327723,3277065,5005222,5005269,5005335,5005586,3335528,3342174,5007409,3387364,3388843,3389058,5008069,3435138,5009684,3461217,3512730,5000198,5011821,5012201,5013767,5015239,5000405,5001808,5017228,5017229,5017234,5019024,5019030,5020315,3367537,3372843,5022214,5022457,5023638,5002972,5003733,3334596,5024407,3390333,5025780,5026309,5026821,5027310,5029067,3360134,3457636,5004292,5029481,5029649,3341916,3461229,3466344,5004680,5005687,5000185,5000243,5000469,5031995,5033579,3367497,3367511,5038461,5038514,5040248,5041506,3371487,5042050,5043338,5044248,5044838,5048624,5002409,5049136,5049875,5050052,5052047,5052048,5052052,5053015,3389329,5008247,5056396,5059377,5059491,5008941,5009175,5010240,5010490,5063665,5063891,5065866,5066525,5067114,5067136,5067719,5073377,5073384,5077264,5003052,5011789,3457934,3492657,5003530,5015411,5083626,5087144,5089540,5094006,5094384,3589388,5000177,5000191,5000227,5000543,5017682,5017784,5018355,5018837,3395802,3411204,5098565,5100230,5004583,5005331,5019124,5019348,5019478,3417995,5106199,5106361,5109936,5113443,5005340,3447587,3455343,3458771,5114891,3490522,3503505,5119534,5120083,5123899,5126455,5002701,5007485,5000165,5000440,5000441,5139798,5140572,5140886,5142694,5144553,5144729,5145408,5145731,5000789,5152093,5154072,5157647,5160093,5024893,5026120,5026121,5026538,5026675,5007760,5008252,5170820,5172562,5175021,5176659,5028343,5009184,5009942,5179487,5179579,5180073,5180695,5180786,5182026,5182726,5188132,5195651,5195832,5196122,5200460,5201351,5206310,5206502,5011389,5011519,5011884,5011903,5012871,5013097,5013756,5004682,5005318,5005412,5209292,5211846,5215765,5216016,5219889,5219891,5220810,5221532,5222094,5030604,5030605,5035373,5017239,5017240,5038258,5038261,5039645,5007116,5002990,5041931,5043567,5047150,5047448,5048059,5018121,5018136,5018894,5019127,5020584,5021335,5058442,5058868,5060114,5060563,5008809,5009509,5063492,5063892,5064654,5065393,5066008,5068559,5022453,5022455,5023619,5078557,5079132,5081767,5081882,5011253,5011403,5011890,5012473,5004905,5082877,5087153,5088766,5089790,5091765,5013757,5017238,5024567,5024911,5025316,5092338,5094594,5026433,5097670,5098159,5099304,5100017,5102295,5103828,5104103,5026824,5027133,5027856,5027993,5029021,5007826,5113217,5018388,5019113,5019309,5019782,5020696,5020703,5021429,5114857,5115928,5030603,5010485,5123571,5124191,5132841,5139948,5035993,5037440,5144586,5144818,5152095,5153025,5154207,5023794,5047164,5047693,5048060,5011512,5012479,5012906,5013190,5013307,5013451,5013758,5159506,5172665,5050215,5053368,5053608,5013777,5014361,5017237,5179488,5185129,5185347,5190657,5025586,5025723,5025758,5026099,5026119,5026300,5056554,5058862,5059379,5196948,5198020,5199640,5199641,5199698,5200133,5202089,5208087,5027823,5028707,5063428,5064816,5067118,5067138,5069001,5069453,5216017,5216820,5219624,5221533,5223171,5225870,5226521,5228361,5029236,5029627,5029636,5030034,5030239,5073389,5081056,5019781,5020632,5084938,5085383,5085479,5087247,5088495,5089235,5090103,5091682,5092452,5092453,5020842,5021081,5036549,5096608,5098632,5100224,5102978,5037497,5038257,5040971,5041102,5108262,5109109,5109974,5110187,5022846,5023072,5047254,5051719,5114546,5114547,5052924,5054522,5056016,5127185,5136690,5138719,5139949,5025736,5025781,5026428,5056390,5061290,5141330,5144556,5151536,5152490,5157687,5159166,5062532,5063109,5063429,5064814,5160031,5165092,5027312,5027457,5027804,5029040,5029109,5066000,5067137,5069036,5073387,5074092,5074201,5077500,5077786,5179578,5182567,5183184,5183329,5192717,5196558,5196560,5080474,5197879,5206510,5206542,5223065,5032954,5086279,5087842,5089016,5036485,5037078,5038260,5038877,5039994,5089062,5092395,5043637,5047169,5099427,5100955,5109970,5111611,5113385,5113390,5113844,5113846,5053701,5114770,5060214,5060555,5062417,5062425,5116330,5119858,5131106,5064635,5065873,5066414,5067113,5073376,5133878,5136602,5137264,5137737,5137822,5137832,5137948,5138972,5147020,5147040,5087152,5087162,5148199,5152589,5154130,5162041,5088517,5089065,5089100,5092284,5170753,5172490,5178412,5179737,5099305,5102880,5106089,5106684,5107226,5184189,5190659,5193157,5194082,5196822,5110183,5111096,5111984,5112655,5112656,5201229,5205206,5205932,5207192,5209948,5216022,5217910,5218883,5229002,5229019,5114688,5133080,5134726,5139677,5140792,5142137,5142669,5143948,5143949,5145156,5145608,5147901,5148422,5149296,5165535,5172456,5177432,5178496,5179644,5181336,5183142,5183366,5184866,5188592,5189685,5190685,5196121,5199956,5204621,5205745,5206661,5206704,5207931,5208899,5210487,5210573,5217408,5222477,5226041,129341,130399,143253,155737,155914,240496,291143,314156,337802,391744,392192,394534,406634,417288,435103,439348,449984,487763,487957,488063,506757,535303,598274,614578,615303,616108,620495,653115,669288,709573,716541,727019,736444,807414,811902,825948,885572,890085,933609,941516,964695,982413,990550,999910,1044256,1049527,1062958,1063008,1067570,1080579,1094182,1100484,1112668,1114415,1124917,1139165,5229558,1176452,1184475,1194023,1195118,1195638,1203360,1219895,1236759,1238119,1417920,5224175,5226243,5230573,5233975,5234585,1450169,1451178,5232923,5233407,5233665,5234597,1495093,1529136,1529142,5230345,5228892,5233646,1548940,1558105,1596386,1617938,1624753,1666485,1677684,1680447,1717001,1720376,1754727,1754901,1755913,1769144,1800161,1806518,1856948,1857525,1861209,1875427,1880522,1887760,1901229,1936555,1964199,2034417,2044926,2060715,2088892,2140592,2165686,2167686,2173242,2193086,2193489,2203708,2207755,2207911,2210093,2210169,2220888,2226220,2235731,2262240,2262278,2280838,2291608,2305688,2309407,2323668,2335501,2345323,2346564,2353992,2389841,2394190,2396622,2398308,2400044,2407707,2414351,2416107,2418990,2440826,2446948,2451201,2466929,2468589,2483079,2550374,2579687,2590800,2591420,2617166,2626691,2631524,2672316,2687342,2720501,2733767,2741817,2790214,2828360,2871773,2901030,2949087,3041861,3095010,3113468,3178260,3232487,3233676,3233988,3311985,3345974,3347275,3384068,3389056,3414827,3434270,3516764,5000233,5000241,5000244,5000383,5000385,5000467,5003214,5003368,5004666,5005341,5006019,5007822,5007977,5008860,5010444,5011415,5011509,5013754,5014758,5016021,5016286,5017233,5017292,5018120,5019026,5019112,5019517,5022531,5022841,5023281,5024569,5025235,5026882,5027307,5027353,5027448,5029968,5030366,5032511,5039570,5043607,5046830,5050065,5050207,5053869,5058869,5059362,5059372,5062809,5065395,5067139,5068566,5068744,5069118,5072420,5072630,5072886,5073061,5079899,5083072,5084514,5086595,5087155,5088811,5089060,5089071,5092206,5096830,5100511,5100761,5102671,5103463,5105721,5107353,5110048,5114174,5114771,5115915,5119764,5123570,5124504,5127488,5133880,5134338,5134775,5136626,5139951,5140690,5142693,5144602,5146707,5151035,5152514,5157978,5163604,5165536,5169158,5170754,5171120,5171201,5176498,5179499,5179990,5190660,5196559,5197878,5200256,5207201,5210952,5219621,5220478,5221222,5227569,5229022,5230376,5232341)
	and concat(forenames, Surname, Initials) like '%Replaced in terms of the GDPR%'
	order by contactid, u.userid

	select distinct u.userid, u.usertypeid, a.ContactId, Forenames, Surname, Initials, genderid, titleid
	from backoffice_backup.customer.contact a
	join backoffice_backup.customer.usercontactaddress uca on a.ContactId = uca.ContactId
	join backoffice_backup.logon.users u on uca.userid = u.userid
	where a.ContactId in (
		select distinct a.ContactId
		from backoffice.customer.contact a
		join backoffice.customer.usercontactaddress uca on a.ContactId = uca.ContactId
		join backoffice.logon.users u on uca.userid = u.userid
		where u.userid in (21438,23065,26307,30164,30438,30441,31517,32329,35510,46207,58709,58758,71302,71574,28312,81039,80500,70299,84559,83007,72044,86395,86709,80652,83077,87455,87456,80095,90046,80433,82887,82140,83924,94683,87357,85715,97431,94339,87933,90017,90400,92147,88265,89450,91413,128351,131206,96478,149592,115810,121566,131203,191197,136162,146943,150968,153904,150883,153540,250024,164228,275729,147032,148950,143933,149524,150687,155675,301748,150722,152027,160768,185139,381610,392313,392372,392589,393600,395647,240564,313998,388664,392380,416706,405209,437997,412234,363905,366893,338697,445193,369264,377559,462129,389487,390806,393213,394131,392411,402108,393605,487808,487901,405860,395559,414081,491176,495155,394667,394685,395620,435289,406633,455052,436944,412233,503520,414095,415424,463160,465559,514792,428802,469751,517255,440499,442089,487794,487869,449176,449967,488079,460725,487836,488085,475815,494312,466305,548283,487916,511005,508925,497264,528162,528297,493389,509881,510241,541405,547046,539388,578666,593322,579200,594510,577301,592500,597918,609378,596452,606843,623699,623907,605034,614716,622500,635147,653816,655242,646476,652112,651308,682277,685494,699090,663759,648880,657366,726423,730359,720557,722476,739960,770742,770750,719271,722144,750690,780812,681830,740746,689457,767527,709590,761117,815448,716773,717093,824197,784404,803418,830166,816526,737783,746824,854030,753022,755892,857722,863788,823511,873048,779731,781024,835297,780565,858678,837934,849355,785563,792098,789339,791648,797930,908965,818602,917748,887890,829284,826351,923084,924624,927330,895420,842788,905394,913144,855102,942655,922686,857810,864093,868923,863828,931458,932096,872458,960679,966030,939285,939956,888110,879428,954013,976917,924612,975186,982090,978580,1017209,1020537,1024731,932006,996196,1032886,1034325,960584,952671,952914,1006590,966409,962592,1027113,1027180,980332,1072536,1046046,996357,1060136,1005866,1060128,1018311,1019996,1027169,1035680,1086743,1046427,1112755,1097389,1097850,1097938,1044925,1102835,1134707,1125231,1125406,1091859,1137733,1138459,1098806,1140834,1109811,1111866,1183107,1117307,1192642,1126506,1130274,1170389,1139499,1219784,1140354,1182356,1186909,1156414,1156422,1165471,1200553,1210196,1211692,1169273,1170428,1174529,1404696,1192220,80036,81033,1186904,1435633,1192628,1200760,1204103,1444407,1227115,1210680,1234600,1426390,1219151,1244626,1515385,1435632,1436300,1234629,1225594,1246185,1235773,1435472,1405226,1550723,1440309,1477128,1571698,1435543,1529140,1488014,1597335,1518793,1539291,1525159,1612709,1552404,1521314,1615877,1529208,1646870,1652978,1662820,1552882,1534556,1593038,1597049,1566319,1548478,1692573,1585043,1698695,1588308,1702286,1599973,1571699,1709456,1623522,1614397,1716869,1580886,1589011,1594164,1594188,1732037,1620979,1751985,1692044,1647041,1774162,1710810,1710860,1699332,1797288,1728141,1732739,1703698,1705411,1703780,1708025,1709879,1717291,1732164,1772029,1725899,1753569,1835544,1837510,1783203,1744099,1769129,1769139,1775113,1767420,1769134,1776250,1756756,1788777,1783433,1767907,1790897,1812447,1794761,1800185,1821867,1792933,1881722,1886745,1837477,1839774,1840326,1826465,1845774,1832532,1838846,1832892,1864733,1852544,1853375,1854401,1846831,1865899,1853374,1884587,1860719,1862858,1900555,1889346,1889529,1892164,1908025,1907646,1908858,1914693,1918017,1918224,1914163,2033586,1947985,2049441,1929048,1953804,2059916,1943754,2072094,87760,2021393,2108735,2011748,2012860,2049473,2039360,2053168,2045460,2060326,2037036,2060228,2060714,2047438,2141325,2049526,2098868,2151545,2116013,2100490,2179906,2111531,2180793,2182070,2119844,2192899,2139134,2200803,2203468,2203510,2146195,2147032,2162550,2210172,2157608,2212830,2212862,2146224,2217675,2147420,2173252,2219615,2221493,2178023,2171736,2171681,2174564,2187843,2177013,2191177,2231873,2182068,2183554,2172129,2189010,2174986,2177128,2207065,2210198,2199237,2182097,2200063,2217257,2263193,2207751,2207916,2209628,2210170,2210092,2223877,2212828,2212861,2199038,2200649,2212831,2216754,2203475,2203516,2206049,2221222,2232682,2235732,2293892,2209631,2210199,2210201,2212833,2212883,2253140,2227075,2305723,2254977,2230627,2221139,2252470,2323238,2262319,2337529,2337530,2264759,2273749,2305558,2306945,2347522,2348391,2275081,2277030,2294156,2328619,2290159,2305703,2305650,2378423,2336565,2325052,2351357,2395102,2396224,2396624,2355810,2342530,2326326,2406243,2337507,2344773,2412502,2413101,2413813,2342396,2418993,2367953,2388518,2363300,2377356,2396623,2363965,2370663,2439638,2407704,2369236,2410965,2373207,2444965,2448581,2417396,2391949,2396152,2399000,2428154,2409094,2410199,2397809,2400219,2401582,2475064,2403006,2413118,2416422,2417354,2416014,2491601,2460113,2418999,2439178,2429758,2468512,2448720,2432253,2450800,2434574,2432497,2474648,2436076,2439639,2459275,2460293,2452481,2451687,2462175,2456186,2455276,2458309,2458643,2459240,2462146,2464651,2466115,2468528,90843,2469753,2480719,2502306,2545608,2510226,2554998,2495904,2503786,2591660,2592788,2594749,2552966,2573644,2556423,2618544,2583679,2557237,2628027,2592496,2594150,2629972,2595136,2634778,2565631,2568686,2573805,2575661,2574394,2600755,2595229,2652742,2593524,2594031,2595705,2606713,2627055,2672315,2633314,2618998,2614819,2674571,2641329,2624765,2628013,2647334,2650173,2651450,2640234,2661937,2674403,2704425,2663426,2685224,2718396,2720652,2693311,2684527,2685763,2681682,2685223,2685316,2685226,2686112,2702054,2696761,2689098,2733565,2693128,2695077,2740635,2696426,2742027,2701926,2703640,2720947,2703647,2723360,2723585,2709346,2720624,2730104,2731743,2715780,2732814,2719175,2719216,2726876,2718175,2764615,2765219,2744133,2745370,2730223,2743519,2744056,2736076,2790415,2794078,2750140,2781064,2770068,2794071,2790420,2861503,2780115,2793456,2782611,2873916,2797091,2786987,2884279,2817278,2790931,2837175,2839031,2793910,2793455,2815150,2797397,2838905,2804857,2867004,2816644,2823014,2864024,2867017,2893996,2847740,2850281,2923018,2876512,3027653,2897031,2944516,2896818,2917023,2958911,3012056,3016044,3018947,3110655,3121124,2969459,3056986,3012809,3001774,3006344,3097486,3158102,3073996,3077375,3174075,3281303,3180026,3158312,3178262,3319522,3172993,3268478,3333498,3277072,3340309,3281302,3359688,3202658,3307303,3276838,3223484,3388857,3388859,3389083,3390115,3255490,3483810,3517820,3519828,3530917,5000173,5000196,5000232,5000239,5000264,3334651,5001169,5002421,3310389,5003170,5003767,3280780,3323175,3327723,3277065,5005222,5005269,5005335,5005586,3335528,3342174,5007409,3387364,3388843,3389058,5008069,3435138,5009684,3461217,3512730,5000198,5011821,5012201,5013767,5015239,5000405,5001808,5017228,5017229,5017234,5019024,5019030,5020315,3367537,3372843,5022214,5022457,5023638,5002972,5003733,3334596,5024407,3390333,5025780,5026309,5026821,5027310,5029067,3360134,3457636,5004292,5029481,5029649,3341916,3461229,3466344,5004680,5005687,5000185,5000243,5000469,5031995,5033579,3367497,3367511,5038461,5038514,5040248,5041506,3371487,5042050,5043338,5044248,5044838,5048624,5002409,5049136,5049875,5050052,5052047,5052048,5052052,5053015,3389329,5008247,5056396,5059377,5059491,5008941,5009175,5010240,5010490,5063665,5063891,5065866,5066525,5067114,5067136,5067719,5073377,5073384,5077264,5003052,5011789,3457934,3492657,5003530,5015411,5083626,5087144,5089540,5094006,5094384,3589388,5000177,5000191,5000227,5000543,5017682,5017784,5018355,5018837,3395802,3411204,5098565,5100230,5004583,5005331,5019124,5019348,5019478,3417995,5106199,5106361,5109936,5113443,5005340,3447587,3455343,3458771,5114891,3490522,3503505,5119534,5120083,5123899,5126455,5002701,5007485,5000165,5000440,5000441,5139798,5140572,5140886,5142694,5144553,5144729,5145408,5145731,5000789,5152093,5154072,5157647,5160093,5024893,5026120,5026121,5026538,5026675,5007760,5008252,5170820,5172562,5175021,5176659,5028343,5009184,5009942,5179487,5179579,5180073,5180695,5180786,5182026,5182726,5188132,5195651,5195832,5196122,5200460,5201351,5206310,5206502,5011389,5011519,5011884,5011903,5012871,5013097,5013756,5004682,5005318,5005412,5209292,5211846,5215765,5216016,5219889,5219891,5220810,5221532,5222094,5030604,5030605,5035373,5017239,5017240,5038258,5038261,5039645,5007116,5002990,5041931,5043567,5047150,5047448,5048059,5018121,5018136,5018894,5019127,5020584,5021335,5058442,5058868,5060114,5060563,5008809,5009509,5063492,5063892,5064654,5065393,5066008,5068559,5022453,5022455,5023619,5078557,5079132,5081767,5081882,5011253,5011403,5011890,5012473,5004905,5082877,5087153,5088766,5089790,5091765,5013757,5017238,5024567,5024911,5025316,5092338,5094594,5026433,5097670,5098159,5099304,5100017,5102295,5103828,5104103,5026824,5027133,5027856,5027993,5029021,5007826,5113217,5018388,5019113,5019309,5019782,5020696,5020703,5021429,5114857,5115928,5030603,5010485,5123571,5124191,5132841,5139948,5035993,5037440,5144586,5144818,5152095,5153025,5154207,5023794,5047164,5047693,5048060,5011512,5012479,5012906,5013190,5013307,5013451,5013758,5159506,5172665,5050215,5053368,5053608,5013777,5014361,5017237,5179488,5185129,5185347,5190657,5025586,5025723,5025758,5026099,5026119,5026300,5056554,5058862,5059379,5196948,5198020,5199640,5199641,5199698,5200133,5202089,5208087,5027823,5028707,5063428,5064816,5067118,5067138,5069001,5069453,5216017,5216820,5219624,5221533,5223171,5225870,5226521,5228361,5029236,5029627,5029636,5030034,5030239,5073389,5081056,5019781,5020632,5084938,5085383,5085479,5087247,5088495,5089235,5090103,5091682,5092452,5092453,5020842,5021081,5036549,5096608,5098632,5100224,5102978,5037497,5038257,5040971,5041102,5108262,5109109,5109974,5110187,5022846,5023072,5047254,5051719,5114546,5114547,5052924,5054522,5056016,5127185,5136690,5138719,5139949,5025736,5025781,5026428,5056390,5061290,5141330,5144556,5151536,5152490,5157687,5159166,5062532,5063109,5063429,5064814,5160031,5165092,5027312,5027457,5027804,5029040,5029109,5066000,5067137,5069036,5073387,5074092,5074201,5077500,5077786,5179578,5182567,5183184,5183329,5192717,5196558,5196560,5080474,5197879,5206510,5206542,5223065,5032954,5086279,5087842,5089016,5036485,5037078,5038260,5038877,5039994,5089062,5092395,5043637,5047169,5099427,5100955,5109970,5111611,5113385,5113390,5113844,5113846,5053701,5114770,5060214,5060555,5062417,5062425,5116330,5119858,5131106,5064635,5065873,5066414,5067113,5073376,5133878,5136602,5137264,5137737,5137822,5137832,5137948,5138972,5147020,5147040,5087152,5087162,5148199,5152589,5154130,5162041,5088517,5089065,5089100,5092284,5170753,5172490,5178412,5179737,5099305,5102880,5106089,5106684,5107226,5184189,5190659,5193157,5194082,5196822,5110183,5111096,5111984,5112655,5112656,5201229,5205206,5205932,5207192,5209948,5216022,5217910,5218883,5229002,5229019,5114688,5133080,5134726,5139677,5140792,5142137,5142669,5143948,5143949,5145156,5145608,5147901,5148422,5149296,5165535,5172456,5177432,5178496,5179644,5181336,5183142,5183366,5184866,5188592,5189685,5190685,5196121,5199956,5204621,5205745,5206661,5206704,5207931,5208899,5210487,5210573,5217408,5222477,5226041,129341,130399,143253,155737,155914,240496,291143,314156,337802,391744,392192,394534,406634,417288,435103,439348,449984,487763,487957,488063,506757,535303,598274,614578,615303,616108,620495,653115,669288,709573,716541,727019,736444,807414,811902,825948,885572,890085,933609,941516,964695,982413,990550,999910,1044256,1049527,1062958,1063008,1067570,1080579,1094182,1100484,1112668,1114415,1124917,1139165,5229558,1176452,1184475,1194023,1195118,1195638,1203360,1219895,1236759,1238119,1417920,5224175,5226243,5230573,5233975,5234585,1450169,1451178,5232923,5233407,5233665,5234597,1495093,1529136,1529142,5230345,5228892,5233646,1548940,1558105,1596386,1617938,1624753,1666485,1677684,1680447,1717001,1720376,1754727,1754901,1755913,1769144,1800161,1806518,1856948,1857525,1861209,1875427,1880522,1887760,1901229,1936555,1964199,2034417,2044926,2060715,2088892,2140592,2165686,2167686,2173242,2193086,2193489,2203708,2207755,2207911,2210093,2210169,2220888,2226220,2235731,2262240,2262278,2280838,2291608,2305688,2309407,2323668,2335501,2345323,2346564,2353992,2389841,2394190,2396622,2398308,2400044,2407707,2414351,2416107,2418990,2440826,2446948,2451201,2466929,2468589,2483079,2550374,2579687,2590800,2591420,2617166,2626691,2631524,2672316,2687342,2720501,2733767,2741817,2790214,2828360,2871773,2901030,2949087,3041861,3095010,3113468,3178260,3232487,3233676,3233988,3311985,3345974,3347275,3384068,3389056,3414827,3434270,3516764,5000233,5000241,5000244,5000383,5000385,5000467,5003214,5003368,5004666,5005341,5006019,5007822,5007977,5008860,5010444,5011415,5011509,5013754,5014758,5016021,5016286,5017233,5017292,5018120,5019026,5019112,5019517,5022531,5022841,5023281,5024569,5025235,5026882,5027307,5027353,5027448,5029968,5030366,5032511,5039570,5043607,5046830,5050065,5050207,5053869,5058869,5059362,5059372,5062809,5065395,5067139,5068566,5068744,5069118,5072420,5072630,5072886,5073061,5079899,5083072,5084514,5086595,5087155,5088811,5089060,5089071,5092206,5096830,5100511,5100761,5102671,5103463,5105721,5107353,5110048,5114174,5114771,5115915,5119764,5123570,5124504,5127488,5133880,5134338,5134775,5136626,5139951,5140690,5142693,5144602,5146707,5151035,5152514,5157978,5163604,5165536,5169158,5170754,5171120,5171201,5176498,5179499,5179990,5190660,5196559,5197878,5200256,5207201,5210952,5219621,5220478,5221222,5227569,5229022,5230376,5232341)
		and concat(forenames, Surname, Initials) like '%Replaced in terms of the GDPR%'
		)
	and u.usertypeid <> 11
	order by contactid, u.userid