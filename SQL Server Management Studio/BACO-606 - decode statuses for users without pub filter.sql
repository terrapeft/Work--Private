-- Finaly not all users were found in the results, because they do not have subscriptions
-- for provided publications
-- here is the list of statuses without publication filter for 45 emails missed in previous results

select distinct uEmailAddress as Email, pname as Site, string_agg(s.stName, ', ') as Permissions
from statuses s
join publications p on s.stpid = p.pid
join subscriptions su on su.spid = p.pid
join userdetails u on su.suid = u.uid
where --stpid in (225, 291, 223)
sstatus & s.stMask = s.stMask
and uUsername in (
	'tatiana.mikhaylova@nornickel.net',
	'frederique.schmidt@britishsteel.fr',
	'myriam.faouzi@vtbcapital.com',
	'blatovi@nornik.ru',
	'kiykogm@nornik.ru',
	'viktorovdv@nornickel.net',
	'linchikal@nornik.ru',
	'korneychukea@nornik.ru',
	'pitirimovdf@nornik.ru',
	'petrovskayaoa@nornik.ru',
	'kirushinvvl@nornik.ru',
	'vladimir.kalsin@vtbcapital.com',
	'sylvain.van.heeghe@britishsteel.fr',
	'inoue.takaaki@kobelco.com',
	'federovdt@nornik.ru',
	'hara-shu@itochu.co.jp',
	'alla.zhorina@nornik.ru',
	'fastmarkets data licence - precious',
	'petar.georgiev@vtbcapital.com',
	'irene.lau@nornickel.net',
	'vadim.boldyrev@nornickel.net',
	'mykola.zuyev@britishsteel.fr',
	'thanos.dimou@vtbcapital.com',
	'patrick.laudamy@britishsteel.fr',
	'thierry.alary@ferroglobe.com',
	'martino.bonesso@salini-impregilo.com',
	'chung_hung_diong@cargill.com',
	'ino-d@itochu.co.jp',
	'jerome.bonef@britishsteel.fr',
	'denis.kuznetsov@nornickel.net',
	'cherednykma@nornik.ru',
	'guylaine.peron@britishsteel.fr',
	'hubert.dabas@britishsteel.fr',
	'stephan.marshall@vtbcapital.com',
	'kati.kulvala@nornickel.net',
	'ivan.petev@vtbcapital.com',
	'dmitry.zamula@nornik.net',
	'laure.cousin@britishsteel.fr',
	'elisabeth.bremski@britishsteel.fr',
	'izumi-ta@itochu.co.jp',
	'hang.jiang@gmcorp.com.cn',
	'kevin.ma@nornickel.net',
	'isabelle_zou@cargill.com',
	'daniel_lim@cargill.com',
	'kerstin.smudia@nidec-ma.com')
group by uEmailAddress, pname
order by uEmailAddress, pname
