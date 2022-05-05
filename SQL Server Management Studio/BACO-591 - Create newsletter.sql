/*********************************************
*
*   BACO-591: Patent Strategy Newsletter
*
**********************************************/
use newcentralusers

begin try

    begin transaction

	declare @newsletterId int, @nlnId int
	declare @gowiList table (uusername nvarchar(256) primary key)

	set @newsletterId = (select max(nNewsletterID) + 1 from Newsletters)
	select 'NewsletterId: ' + cast(@newsletterId as varchar(12))

	/*
	* list of users from GOWI team
	*/
	insert into @gowiList
	select uusername  
	from (values ('sunil@krishnaandsaurastri.com',60104),
('Dick.Vanengelen@Ventouxlaw.Com',1514879),
('eran@copyright.co.il',1702440),
('senatarchini@senatarchini.com',1716311),
('smangat@marks-clerk.ca',1720778),
('john.cloke@dlapiper.com',1735638),
('SHSUTRO@DUANEMORRIS.COM',1737826),
('JESKIE@DUANEMORRIS.COM',1738375),
('shwang@sheppardmullin.com',1748460),
('XERXES@NEOLEGAL.IN',1764386),
('CONNIEGONZALEZ@UHTHOFF.COM.MX',1764395),
('bruce.falby@dlapiper.com',1774266),
('isabel.perez.cabrero@garrigues.com',1788129),
('michael@purdylucey.com',2203563),
('f.buzzi@bnaturin.com',2210650),
('widmer@fmp-law.ch',2231454),
('GABRIEL.DIBLASI@DIBLASI.COM.BR',2244088),
('MPOLANCO@BOLYTER.COM',2246813),
('RANA.GOSAIN@DANIEL.ADV.BR',2247596),
('selma.unlu@nsn-law.com',2262276),
('ahlert@dannemann.com.br',652767),
('mark.ridgway@allenovery.com',976612),
('abarlocci@zbm-patents.eu',1006000),
('goddar@boehmert.de',1019120),
('jmb@carpmaels.com',1020363),
('hayati@sirim.my',1025028),
('joann.neth@finnegan.com',1042619),
('margaretha.f.holmberg@zacco.com',1577923),
('monica.riva@cliffordchance.com',1594676),
('mauricio.villegas@ucr.ac.cr',1599090),
('jhutchi@bigpond.net.au',1617894),
('marc.richard@gowlings.com',2014797),
('thuongntc@viettel.com.vn',2018590),
('nupur@anandandanand.com',2026731),
('donald.lawrie@lawrie-ip.com',2045447),
('william.minor@dlapiper.com',2058374),
('jim.ford@allenovery.com',1143876),
('VANDYKE@ACM.ORG',1153621),
('aeguchi@tmi.gr.jp',1154343),
('jpegana@sargent.cl',1180215),
('elliottj@gtlaw.com',1188770),
('knk@kankrishme.com',1205976),
('clane@tomkins.com',1894844),
('c.casalonga@casalonga.com',1894857),
('tone.tangevald-jensen@zacco.com',1907975),
('helen.wakerley@reddie.co.uk',1910351),
('minjae.kang@finnegan.com',1911454),
('richard.bauer@kattenlaw.com',1912144),
('madhu@anandandanand.com',1922675),
('ALASDAIR.POORE@MILLS-REEVE.COM',1924590),
('gina.durham@dlapiper.com',1925220),
('alban.kang@twobirds.com',1935362),
('mascha.grundmann@twobirds.com',2291043),
('ABM@GBREUER.COM.AR',2303324),
('agrunewaldt@silva.cl',2331974),
('zhangya@acip.cn',719476),
('sforeman@davies.com.au',1047485),
('hlindner@aml.com.mx',1085496),
('ggao@fangdalaw.com',1093987),
('bir4d@hotmail.com',1097568),
('natalia.pakhomovska@dlapiper.com',1106792),
('natalie.clayton@alston.com',1109008),
('pdcozens@mathys-squire.com',1112576),
('yulan.kuo@taiwanlaw.com',1688518),
('mark.radcliffe@dlapiper.com',2377867),
('gbelvira@smart-biggar.ca',2399104),
('bershl@gtlaw.com',2417624),
('atz@blakes.com',728740),
('anthony.day@dlapiper.com',734749),
('tanteejim@leenlee.com.sg',755797),
('jthakur_1@hotmail.com',1798914),
('vchew@duanemorris.com',1810693),
('jcgregoire@marks-clerk.ca',1812989),
('jonas.westerberg@lindahl.se',1823990),
('bob.stewart@linatex.com',1832120),
('aoife.murphy@whitneymoore.ie',2116665),
('jmgunther@duanemorris.com',2170529),
('cattoors@hoyngmonegier.com',2181238),
('xqh@mailbox.lungtin.com',2439496),
('mango0716@126.com',2452928),
('tarun@khuranaandkhurana.com',2459020),
('denise.main@finnegan.com',2461434),
('patrick.coyne@finnegan.com',2461545),
('upatel@marks-clerk.com.sg',2466636),
('hajo.peters@zacco.com',2482803),
('melinda.upton@dlapiper.com',2492667),
('perrons@gtlaw.com',2493879),
('niels.mulder@dlapiper.com',911350),
('jferdinand@marks-clerk.com',915278),
('hiroshi.kobayashi@aiklaw.co.jp',944995),
('LUIS@LEGARRETA.COM.MX',965737),
('rarochi@aml.com.mx',972920),
('tim.jackson@baldwins.com',973023),
('jgarretson@shb.com',2598502),
('mhuget@honigman.com',2598548),
('m.lincoln@lincoln-ip.com',2641036),
('jenniferlin@tsartsai.com.tw',2652334),
('ykim@kimchang.com',5206434))
	l(uusername, uid)


	--select count(*) from @gowiList
	--select distinct count(*) from @gowiList

	/*
	* take nlnAvailableToTrialImport, nlnRank, nlnIsBreakingNews settings from the old Premium newsletter
	* select * from NewsletterNames where nlnName like '%mip premium%'
	*/
	insert into NewsletterNames (nlnNewsletterId, nlnName, nlnPubId, nlnAvailableToTrialImport, nlnRank, nlnIsBreakingNews)
	values (@newsletterId, 'Patent Strategy', 5027, 1, 1, 0)
	set @nlnId = @@identity

	/*
	* GOWI sends all in HTML format
	*/
	insert into Newsletters (nPublication, nUId, nNewsletterID, nPlain, nHTML)
	select 5027, uid, @newsletterId, 0, 1
	from @gowiList gl 
	join UserDetails ud on gl.uusername = ud.uusername

	--select @nlnId
	--rollback
	
	commit transaction;
end try
begin catch
    declare @ERROR nvarchar(1000)
    select @ERROR = error_message()
    print @ERROR
    select ERROR_NUMBER() AS ErrorNumber,
        ERROR_SEVERITY() AS ErrorSeverity,
        ERROR_STATE() AS ErrorState,
        ERROR_PROCEDURE() AS ErrorProcedure,
        ERROR_LINE() AS ErrorLine,
        ERROR_MESSAGE() AS ErrorMessage

    if @@trancount > 0
        rollback transaction;
end catch;