drop table if exists #files

;with files as 
(
    select fn
    from (values 
        ('EIVS011120090236.TXT'),('EIVS011120093253.TXT'),('EIVS011120100303.TXT'),('EIVS011120103312.TXT'),('EIVS011120110331.TXT'),('EIVS011120113342.TXT'),('EIVS011120120338.TXT'),('EIVS011120123352.TXT'),('EIVS011120130347.TXT'),('EIVS011120133406.TXT'),('EIVS011120140404.TXT'),('EIVS011120143359.TXT'),('EIVS011120150423.TXT'),('EIVS011120153432.TXT'),('EIVS011120160441.TXT'),('EIVS011120163437.TXT'),('EIVS011120170436.TXT'),('EIVS011120173507.TXT'),('EIVS011120180507.TXT'),('EIVS011120183520.TXT'),('EIVS011120190528.TXT'),('EIVS011120193654.TXT'),('EIVS011120200542.TXT'),('EIVS011120203601.TXT'),('EIVS011120210606.TXT'),('EIVS011120213723.TXT'),('EIVS011120220609.TXT'),('EIVS011120223722.TXT'),('EIVS011120235912.TXT'),('EIVS021120020238.TXT'),('EIVS021120023209.TXT'),('EIVS021120030124.TXT'),('EIVS021120033133.TXT'),('EIVS021120040145.TXT'),('EIVS021120043229.TXT'),('EIVS021120050211.TXT'),('EIVS021120053210.TXT'),('EIVS021120060220.TXT'),('EIVS021120063230.TXT'),('EIVS021120070239.TXT'),('EIVS021120073256.TXT'),('EIVS021120080303.TXT'),('EIVS021120083312.TXT'),('EIVS021120090328.TXT'),('EIVS021120093348.TXT'),('EIVS021120100410.TXT'),('EIVS021120113442.TXT'),('EIVS021120120449.TXT'),('EIVS021120123459.TXT'),('EIVS021120130521.TXT'),('EIVS021120133459.TXT'),('EIVS021120140518.TXT'),('EIVS021120150556.TXT'),('EIVS021120153554.TXT'),('EIVS021120160548.TXT'),('EIVS021120163611.TXT'),('EIVS021120175149.TXT'),('EIVS021120182932.TXT'),('EIVS021120184941.TXT'),('EIVS021120193821.TXT'),('EIVS021120194608.TXT'),('EIVS021120201913.TXT'),('EIVS021120204643.TXT'),('EIVS021120211639.TXT'),('EIVS021120214806.TXT'),('EIVS021120221826.TXT'),('EIVS021120224642.TXT'),('EIVS031120000659.TXT'),('EIVS031120020154.TXT'),('EIVS031120023134.TXT'),('EIVS031120030128.TXT'),('EIVS031120033135.TXT'),('EIVS031120040158.TXT'),('EIVS031120043343.TXT'),('EIVS031120050218.TXT'),('EIVS031120053247.TXT'),('EIVS031120060318.TXT'),('EIVS031120063249.TXT'),('EIVS031120070248.TXT'),('EIVS031120073305.TXT'),('EIVS031120080327.TXT'),('EIVS031120083342.TXT'),('EIVS031120090347.TXT'),('EIVS031120093450.TXT'),('EIVS031120100534.TXT'),('EIVS031120103426.TXT'),('EIVS031120110609.TXT'),('EIVS031120113555.TXT'),('EIVS031120120531.TXT'),('EIVS031120175137.TXT'),('EIVS031120180531.TXT'),('EIVS031120184101.TXT'),('EIVS031120193653.TXT'),('EIVS031120200500.TXT'),('EIVS031120204350.TXT'),('EIVS031120210540.TXT'),('EIVS031120213610.TXT'),('EIVS031120220621.TXT'),('EIVS031120223533.TXT'),('EIVS041120003433.TXT'),('EIVS041120020213.TXT'),('EIVS041120023222.TXT'),('EIVS041120030122.TXT'),('EIVS041120033142.TXT'),('EIVS041120040221.TXT'),('EIVS041120043209.TXT'),('EIVS041120050229.TXT'),('EIVS041120053248.TXT'),('EIVS041120060254.TXT'),('EIVS041120063259.TXT'),('EIVS041120070315.TXT'),('EIVS041120073331.TXT'),('EIVS041120080334.TXT'),('EIVS041120083349.TXT'),('EIVS041120090410.TXT'),('EIVS041120093422.TXT'),('EIVS041120103511.TXT'),('EIVS041120110639.TXT'),('EIVS041120113617.TXT'),('EIVS041120120608.TXT'),('EIVS041120123544.TXT'),('EIVS041120130601.TXT'),('EIVS041120133650.TXT'),('EIVS041120140624.TXT'),('EIVS041120143646.TXT'),('EIVS041120153717.TXT'),('EIVS041120160753.TXT'),('EIVS041120163706.TXT'),('EIVS041120174330.TXT'),('EIVS041120183815.TXT'),('EIVS041120191925.TXT'),('EIVS041120193432.TXT'),('EIVS041120200512.TXT'),('EIVS041120203135.TXT'),('EIVS041120210231.TXT'),('EIVS041120213216.TXT'),('EIVS041120220130.TXT'),('EIVS041120223317.TXT'),('EIVS051120001438.TXT'),('EIVS051120023338.TXT'),('EIVS051120030127.TXT'),('EIVS051120033143.TXT'),('EIVS051120040212.TXT'),('EIVS051120043210.TXT'),('EIVS051120050230.TXT'),('EIVS051120053234.TXT'),('EIVS051120060242.TXT'),('EIVS051120063304.TXT'),('EIVS051120070310.TXT'),('EIVS051120073337.TXT'),('EIVS051120080346.TXT'),('EIVS051120083357.TXT'),('EIVS051120090425.TXT'),('EIVS051120093536.TXT'),('EIVS051120100503.TXT'),('EIVS051120103513.TXT'),('EIVS051120110532.TXT'),('EIVS051120113638.TXT'),('EIVS051120120641.TXT'),('EIVS051120123609.TXT'),('EIVS051120130723.TXT'),('EIVS051120133633.TXT'),('EIVS051120140644.TXT'),('EIVS051120150740.TXT'),('EIVS051120153818.TXT'),('EIVS051120160749.TXT'),('EIVS051120163757.TXT'),('EIVS051120172011.TXT'),('EIVS051120175614.TXT'),('EIVS051120181601.TXT'),('EIVS051120184128.TXT'),('EIVS051120192424.TXT'),('EIVS051120195015.TXT'),('EIVS051120201320.TXT'),('EIVS051120204406.TXT'),('EIVS051120211318.TXT'),('EIVS051120214341.TXT'),('EIVS051120221403.TXT'),('EIVS051120224243.TXT'),('EIVS061120001703.TXT'),('EIVS061120020241.TXT'),('EIVS061120023112.TXT'),('EIVS061120030133.TXT'),('EIVS061120033142.TXT'),('EIVS061120040206.TXT'),('EIVS061120043301.TXT'),('EIVS061120050301.TXT'),('EIVS061120053237.TXT'),('EIVS061120060254.TXT'),('EIVS061120063307.TXT'),('EIVS061120070331.TXT'),('EIVS061120073349.TXT'),('EIVS061120080406.TXT'),('EIVS061120083406.TXT'),('EIVS061120091930.TXT'),('EIVS061120093500.TXT'),('EIVS061120110627.TXT'),('EIVS061120123706.TXT'),('EIVS061120130658.TXT'),('EIVS061120133728.TXT'),('EIVS061120140747.TXT'),('EIVS061120143817.TXT'),('EIVS061120151033.TXT'),('EIVS061120153843.TXT'),('EIVS061120160917.TXT'),('EIVS061120163909.TXT'),('EIVS061120172124.TXT'),('EIVS061120180402.TXT'),('EIVS061120183353.TXT'),('EIVS061120185727.TXT'),('EIVS061120193006.TXT'),('EIVS061120195859.TXT'),('EIVS061120202708.TXT'),('EIVS061120205655.TXT'),('EIVS061120212753.TXT'),('EIVS061120215653.TXT'),('EIVS061120223123.TXT'),('EIVS061120225805.TXT'),('EIVS071120011223.TXT'),('EIVS071120030422.TXT'),('EIVS071120033410.TXT'),('EIVS071120040517.TXT'),('EIVS071120043434.TXT'),('EIVS071120050321.TXT'),('EIVS071120053320.TXT'),('EIVS071120060338.TXT'),('EIVS071120063337.TXT'),('EIVS071120070348.TXT'),('EIVS071120073423.TXT'),('EIVS071120080454.TXT'),('EIVS071120083457.TXT'),('EIVS071120090513.TXT'),('EIVS071120093522.TXT'),('EIVS071120100515.TXT'),('EIVS071120103536.TXT'),('EIVS071120110609.TXT'),('EIVS071120113611.TXT'),('EIVS071120120629.TXT'),('EIVS071120123645.TXT'),('EIVS071120130712.TXT'),('EIVS071120133723.TXT'),('EIVS071120140734.TXT'),('EIVS071120143741.TXT'),('EIVS071120150814.TXT'),('EIVS071120153818.TXT'),('EIVS071120160841.TXT'),('EIVS071120163852.TXT'),('EIVS071120170906.TXT'),('EIVS071120173913.TXT'),('EIVS071120180938.TXT'),('EIVS071120184001.TXT'),('EIVS071120190958.TXT'),('EIVS071120194020.TXT'),('EIVS071120201031.TXT'),('EIVS071120204040.TXT'),('EIVS071120211054.TXT'),('EIVS071120214121.TXT'),('EIVS071120221139.TXT'),('EIVS071120224148.TXT'),('EIVS071120235902.TXT'),('EIVS081120020101.TXT'),('EIVS081120023122.TXT'),('EIVS081120030133.TXT'),('EIVS081120033151.TXT'),('EIVS081120040217.TXT'),('EIVS081120043226.TXT'),('EIVS081120050229.TXT'),('EIVS081120053246.TXT'),('EIVS081120060312.TXT'),('EIVS081120063330.TXT'),('EIVS081120070341.TXT'),('EIVS081120073400.TXT'),('EIVS081120080427.TXT'),('EIVS081120083433.TXT'),('EIVS081120163333.TXT'),('EIVS081120170250.TXT'),('EIVS081120173320.TXT'),('EIVS081120180344.TXT'),('EIVS081120183346.TXT'),('EIVS081120190400.TXT'),('EIVS081120193425.TXT'),('EIVS081120200442.TXT'),('EIVS081120203454.TXT'),('EIVS081120210514.TXT'),('EIVS081120213610.TXT'),('EIVS081120220557.TXT'),('EIVS081120223610.TXT'),('EIVS081120235906.TXT'),('EIVS091120020149.TXT'),('EIVS091120023121.TXT'),('EIVS091120030140.TXT'),('EIVS091120033149.TXT'),('EIVS091120040217.TXT'),('EIVS091120043228.TXT'),('EIVS091120050253.TXT'),('EIVS091120053319.TXT'),('EIVS091120060328.TXT'),('EIVS091120063350.TXT'),('EIVS091120070358.TXT'),('EIVS091120073425.TXT'),('EIVS091120080455.TXT'),('EIVS091120083513.TXT'),('EIVS091120100608.TXT'),('EIVS091120103621.TXT'),('EIVS091120120741.TXT'),('EIVS091120123820.TXT'),('EIVS091120130832.TXT'),('EIVS091120133818.TXT'),('EIVS091120140845.TXT'),('EIVS091120143906.TXT'),('EIVS091120150920.TXT'),('EIVS091120153944.TXT'),('EIVS091120161236.TXT'),('EIVS091120164007.TXT'),('EIVS091120181700.TXT'),('EIVS091120185151.TXT'),('EIVS091120191347.TXT'),('EIVS091120195013.TXT'),('EIVS091120201600.TXT'),('EIVS091120204357.TXT'),('EIVS091120211459.TXT'),('EIVS091120214410.TXT'),('EIVS091120221514.TXT'),('EIVS091120224529.TXT'),('EIVS101120002616.TXT'),('EIVS101120023133.TXT'),('EIVS101120030156.TXT'),('EIVS101120033216.TXT'),('EIVS101120040231.TXT'),('EIVS101120043254.TXT'),('EIVS101120050320.TXT'),('EIVS101120053346.TXT'),('EIVS101120060350.TXT'),('EIVS101120063346.TXT'),('EIVS101120070439.TXT'),('EIVS101120073444.TXT'),('EIVS101120080503.TXT'),('EIVS101120083533.TXT'),('EIVS101120090540.TXT'),('EIVS101120093615.TXT'),('EIVS101120100632.TXT'),('EIVS101120103649.TXT'),('EIVS101120113743.TXT'),('EIVS101120120749.TXT'),('EIVS101120123805.TXT'),('EIVS101120140908.TXT'),('EIVS101120143944.TXT'),('EIVS101120151023.TXT'),('EIVS101120154045.TXT'),('EIVS111120023121.TXT'),('EIVS111120030138.TXT'),('EIVS111120060356.TXT'),('EIVS111120063414.TXT'),('EIVS111120070434.TXT'),('EIVS111120073505.TXT'),('EIVS111120080529.TXT'),('EIVS111120083538.TXT'),('EIVS111120090601.TXT'),('EIVS111120103800.TXT'),('EIVS111120110725.TXT'),('EIVS111120113754.TXT'),('EIVS111120154042.TXT'),('EIVS111120161116.TXT'),('EIVS111120164140.TXT'),('EIVS111120172748.TXT'),('EIVS111120175211.TXT'),('EIVS111120182332.TXT'),('EIVS111120191508.TXT'),('EIVS111120193417.TXT'),('EIVS111120200334.TXT'),('EIVS111120203305.TXT'),('EIVS111120210422.TXT'),('EIVS111120213445.TXT'),('EIVS111120220505.TXT'),('EIVS111120223351.TXT'),('EIVS121120004239.TXT'),('EIVS121120023312.TXT'),('EIVS121120030220.TXT'),('EIVS121120033228.TXT'),('EIVS121120040238.TXT'),('EIVS121120043324.TXT'),('EIVS121120050311.TXT'),('EIVS121120053347.TXT'),('EIVS121120060411.TXT'),('EIVS121120063426.TXT'),('EIVS121120070429.TXT'),('EIVS121120073458.TXT'),('EIVS121120080527.TXT'),('EIVS121120090708.TXT'),('EIVS121120113927.TXT'),('EIVS121120130926.TXT'),('EIVS121120133931.TXT'),('EIVS121120141013.TXT'),('EIVS121120144055.TXT'),('EIVS121120151155.TXT'),('EIVS121120154123.TXT'),('EIVS121120164156.TXT'),('EIVS121120182339.TXT'),('EIVS121120190629.TXT'),('EIVS121120192141.TXT'),('EIVS121120195243.TXT'),('EIVS121120205226.TXT'),('EIVS121120212452.TXT'),('EIVS121120215344.TXT'),('EIVS121120225357.TXT'),('EIVS131120003809.TXT'),('EIVS131120023239.TXT'),('EIVS131120030249.TXT'),('EIVS131120033211.TXT'),('EIVS131120040226.TXT'),('EIVS131120043257.TXT'),('EIVS131120050324.TXT'),('EIVS131120053359.TXT'),('EIVS131120060414.TXT'),('EIVS131120063436.TXT'),('EIVS131120070458.TXT'),('EIVS131120073522.TXT'),('EIVS131120080527.TXT'),('EIVS131120083604.TXT'),('EIVS131120113926.TXT'),('EIVS131120120928.TXT'),('EIVS131120130942.TXT'),('EIVS131120133958.TXT'),('EIVS131120141031.TXT'),('EIVS131120144100.TXT'),('EIVS131120151114.TXT'),('EIVS131120161216.TXT'),('EIVS131120164213.TXT'),('EIVS131120172437.TXT'),('EIVS131120183111.TXT'),('EIVS131120193820.TXT'),('EIVS131120201220.TXT'),('EIVS131120203756.TXT'),('EIVS131120210817.TXT'),('EIVS131120213739.TXT'),('EIVS131120220923.TXT'),('EIVS131120224014.TXT'),('EIVS141120002324.TXT'),('EIVS141120040817.TXT'),('EIVS141120043530.TXT'),('EIVS141120050559.TXT'),('EIVS141120053804.TXT'),('EIVS141120060752.TXT'),('EIVS141120063738.TXT'),('EIVS141120070645.TXT'),('EIVS141120073733.TXT'),('EIVS141120080752.TXT'),('EIVS141120083807.TXT'),('EIVS141120090837.TXT'),('EIVS141120093853.TXT'),('EIVS141120100927.TXT'),('EIVS141120103937.TXT'),('EIVS141120111023.TXT'),('EIVS141120114013.TXT'),('EIVS141120121034.TXT'),('EIVS141120124126.TXT'),('EIVS141120131151.TXT'),('EIVS141120134216.TXT'),('EIVS141120141228.TXT'),('EIVS141120144241.TXT'),('EIVS141120151330.TXT'),('EIVS141120154342.TXT'),('EIVS141120161411.TXT'),('EIVS141120164422.TXT'),('EIVS141120171453.TXT'),('EIVS141120174513.TXT'),('EIVS141120181544.TXT'),('EIVS141120184614.TXT'),('EIVS141120191630.TXT'),('EIVS141120194701.TXT'),('EIVS141120201720.TXT'),('EIVS141120204747.TXT'),('EIVS141120211805.TXT'),('EIVS141120214824.TXT'),('EIVS141120221849.TXT'),('EIVS141120224928.TXT'),('EIVS141120235909.TXT'),('EIVS151120020111.TXT'),('EIVS151120023135.TXT'),('EIVS151120030156.TXT'),('EIVS151120033217.TXT'),('EIVS151120040246.TXT'),('EIVS151120043311.TXT'),('EIVS151120050337.TXT'),('EIVS151120053411.TXT'),('EIVS151120060427.TXT'),('EIVS151120063451.TXT'),('EIVS151120070514.TXT'),('EIVS151120073537.TXT'),('EIVS151120080604.TXT'),('EIVS151120083630.TXT'),('EIVS151120090659.TXT'),('EIVS151120093716.TXT'),('EIVS151120100742.TXT'),('EIVS151120103815.TXT'),('EIVS151120110842.TXT'),('EIVS151120113859.TXT'),('EIVS151120120932.TXT'),('EIVS151120123957.TXT'),('EIVS151120131021.TXT'),('EIVS151120134047.TXT'),('EIVS151120141055.TXT'),('EIVS151120154218.TXT'),('EIVS151120161236.TXT'),('EIVS151120164304.TXT'),('EIVS151120171328.TXT'),('EIVS151120174356.TXT'),('EIVS151120181423.TXT'),('EIVS151120184447.TXT'),('EIVS151120191506.TXT'),('EIVS151120194535.TXT'),('EIVS151120201636.TXT'),('EIVS151120204627.TXT'),('EIVS151120211646.TXT'),('EIVS151120214714.TXT'),('EIVS151120221737.TXT'),('EIVS151120224806.TXT'),('EIVS161120000050.TXT'),('EIVS161120020244.TXT'),('EIVS161120023124.TXT'),('EIVS161120030155.TXT'),('EIVS161120033227.TXT'),('EIVS161120040314.TXT'),('EIVS161120043327.TXT'),('EIVS161120050348.TXT'),('EIVS161120053414.TXT'),('EIVS161120060447.TXT'),('EIVS161120063518.TXT'),('EIVS161120070528.TXT'),('EIVS161120073553.TXT'),('EIVS161120080619.TXT'),('EIVS161120083650.TXT'),('EIVS161120090734.TXT'),('EIVS161120113950.TXT'),('EIVS161120131150.TXT'),('EIVS161120134213.TXT'),('EIVS161120141159.TXT'),('EIVS161120144254.TXT'),('EIVS161120154321.TXT'),('EIVS161120161417.TXT'),('EIVS161120164435.TXT'),('EIVS161120181919.TXT'),('EIVS161120185341.TXT'),('EIVS161120191724.TXT'),('EIVS161120195104.TXT'),('EIVS161120204855.TXT'),('EIVS161120211917.TXT'),('EIVS161120214947.TXT'),('EIVS161120221934.TXT'),('EIVS171120002556.TXT'),('EIVS171120023134.TXT'),('EIVS171120030305.TXT'),('EIVS171120033225.TXT'),('EIVS171120040252.TXT'),('EIVS171120043320.TXT'),('EIVS171120050404.TXT'),('EIVS171120053429.TXT'),('EIVS171120060452.TXT'),('EIVS171120063530.TXT'),('EIVS171120070558.TXT'),('EIVS171120073609.TXT'),('EIVS171120080646.TXT'),('EIVS171120101012.TXT'),('EIVS171120114005.TXT'),('EIVS171120121032.TXT'),('EIVS171120124146.TXT'),('EIVS171120131123.TXT'),('EIVS171120134151.TXT'),('EIVS171120141300.TXT'),('EIVS171120144301.TXT'),('EIVS171120151324.TXT'),('EIVS171120154351.TXT'),('EIVS171120185304.TXT'),('EIVS171120191713.TXT'),('EIVS171120194832.TXT'),('EIVS171120205058.TXT'),('EIVS171120212201.TXT'),('EIVS171120215051.TXT'),('EIVS171120225043.TXT'),('EIVS181120023132.TXT'),('EIVS181120030203.TXT'),('EIVS181120033241.TXT'),('EIVS181120040343.TXT'),('EIVS181120043325.TXT'),('EIVS181120050352.TXT'),('EIVS181120053421.TXT'),('EIVS181120060500.TXT'),('EIVS181120063524.TXT'),('EIVS181120070554.TXT'),('EIVS181120073616.TXT'),('EIVS181120080709.TXT'),('EIVS181120083736.TXT'),('EIVS181120090813.TXT'),('EIVS181120103923.TXT'),('EIVS181120111028.TXT'),('EIVS181120114042.TXT'),('EIVS181120121119.TXT'),('EIVS181120124150.TXT'),('EIVS181120131151.TXT'),('EIVS181120134221.TXT'),('EIVS191020020206.TXT'),('EIVS191020023239.TXT'),('EIVS191020030341.TXT'),('EIVS191020033451.TXT'),('EIVS191020040607.TXT'),('EIVS191020043726.TXT'),('EIVS191020050848.TXT'),('EIVS191020054019.TXT'),('EIVS191020061123.TXT'),('EIVS191020064243.TXT'),('EIVS191020071353.TXT'),('EIVS191020074514.TXT'),('EIVS191020081654.TXT'),('EIVS191020084805.TXT'),('EIVS191020092014.TXT'),('EIVS191020095140.TXT'),('EIVS191020102304.TXT'),('EIVS191020105326.TXT'),('EIVS191020112446.TXT'),('EIVS191020115603.TXT'),('EIVS191020122749.TXT'),('EIVS191020125821.TXT'),('EIVS191020133113.TXT'),('EIVS191020140054.TXT'),('EIVS191020143320.TXT'),('EIVS191020150458.TXT'),('EIVS191020153613.TXT'),('EIVS191020160657.TXT'),('EIVS191020163750.TXT'),('EIVS191020171658.TXT'),('EIVS191020175206.TXT'),('EIVS191020181357.TXT'),('EIVS191020191309.TXT'),('EIVS191020193205.TXT'),('EIVS191020200200.TXT'),('EIVS191020203143.TXT'),('EIVS191020210306.TXT'),('EIVS191020213434.TXT'),('EIVS191020220554.TXT'),('EIVS191020223702.TXT'),('EIVS201020003434.TXT'),('EIVS201020023249.TXT'),('EIVS201020030355.TXT'),('EIVS201020033507.TXT'),('EIVS201020040626.TXT'),('EIVS201020043757.TXT'),('EIVS201020050856.TXT'),('EIVS201020054017.TXT'),('EIVS201020061153.TXT'),('EIVS201020064302.TXT'),('EIVS201020071432.TXT'),('EIVS201020074551.TXT'),('EIVS201020081736.TXT'),('EIVS201020084833.TXT'),('EIVS201020095332.TXT'),('EIVS201020102357.TXT'),('EIVS201020105438.TXT'),('EIVS201020112456.TXT'),('EIVS201020115622.TXT'),('EIVS201020122743.TXT'),('EIVS201020125901.TXT'),('EIVS201020133010.TXT'),('EIVS201020140125.TXT'),('EIVS201020143259.TXT'),('EIVS201020150417.TXT'),('EIVS201020153533.TXT'),('EIVS201020160655.TXT'),('EIVS201020175802.TXT'),('EIVS201020183402.TXT'),('EIVS201020190330.TXT'),('EIVS201020193406.TXT'),('EIVS201020200404.TXT'),('EIVS201020204425.TXT'),('EIVS201020210722.TXT'),('EIVS201020213848.TXT'),('EIVS201020221010.TXT'),('EIVS201020224118.TXT'),('EIVS211020004016.TXT'),('EIVS211020020210.TXT'),('EIVS211020023223.TXT'),('EIVS211020030336.TXT'),('EIVS211020033500.TXT'),('EIVS211020040625.TXT'),('EIVS211020043753.TXT'),('EIVS211020050934.TXT'),('EIVS211020054021.TXT'),('EIVS211020061143.TXT'),('EIVS211020064304.TXT'),('EIVS211020071416.TXT'),('EIVS211020074614.TXT'),('EIVS211020081715.TXT'),('EIVS211020084826.TXT'),('EIVS211020092153.TXT'),('EIVS211020095234.TXT'),('EIVS211020102436.TXT'),('EIVS211020105531.TXT'),('EIVS211020112543.TXT'),('EIVS211020115804.TXT'),('EIVS211020122746.TXT'),('EIVS211020125920.TXT'),('EIVS211020133031.TXT'),('EIVS211020140204.TXT'),('EIVS211020143338.TXT'),('EIVS211020150450.TXT'),('EIVS211020153612.TXT'),('EIVS211020160729.TXT'),('EIVS211020163847.TXT'),('EIVS211020173607.TXT'),('EIVS211020175834.TXT'),('EIVS211020182914.TXT'),('EIVS211020202626.TXT'),('EIVS211020203443.TXT'),('EIVS211020210728.TXT'),('EIVS211020213936.TXT'),('EIVS211020221037.TXT'),('EIVS211020223955.TXT'),('EIVS221020003236.TXT'),('EIVS221020020221.TXT'),('EIVS221020023233.TXT'),('EIVS221020030342.TXT'),('EIVS221020033518.TXT'),('EIVS221020040802.TXT'),('EIVS221020043829.TXT'),('EIVS221020050919.TXT'),('EIVS221020054034.TXT'),('EIVS221020061154.TXT'),('EIVS221020064317.TXT'),('EIVS221020071431.TXT'),('EIVS221020074609.TXT'),('EIVS221020081724.TXT'),('EIVS221020084849.TXT'),('EIVS221020092003.TXT'),('EIVS221020095149.TXT'),('EIVS221020102450.TXT'),('EIVS221020105516.TXT'),('EIVS221020140215.TXT'),('EIVS221020143534.TXT'),('EIVS221020150516.TXT'),('EIVS221020153630.TXT'),('EIVS221020160905.TXT'),('EIVS221020163927.TXT'),('EIVS221020172650.TXT'),('EIVS221020175707.TXT'),('EIVS221020182709.TXT'),('EIVS221020185629.TXT'),('EIVS221020192949.TXT'),('EIVS221020200343.TXT'),('EIVS221020203645.TXT'),('EIVS221020210246.TXT'),('EIVS221020213133.TXT'),('EIVS221020220234.TXT'),('EIVS221020223404.TXT'),('EIVS231020003733.TXT'),('EIVS231020023231.TXT'),('EIVS231020030344.TXT'),('EIVS231020033505.TXT'),('EIVS231020040636.TXT'),('EIVS231020043753.TXT'),('EIVS231020050915.TXT'),('EIVS231020054105.TXT'),('EIVS231020061208.TXT'),('EIVS231020064337.TXT'),('EIVS231020071439.TXT'),('EIVS231020074610.TXT'),('EIVS231020081738.TXT'),('EIVS231020084900.TXT'),('EIVS231020092202.TXT'),('EIVS231020095450.TXT'),('EIVS231020102537.TXT'),('EIVS231020105621.TXT'),('EIVS231020112722.TXT'),('EIVS231020115916.TXT'),('EIVS231020122850.TXT'),('EIVS231020133118.TXT'),('EIVS231020150628.TXT'),('EIVS231020163945.TXT'),('EIVS231020174332.TXT'),('EIVS231020210732.TXT'),('EIVS231020213948.TXT'),('EIVS231020222334.TXT'),('EIVS231020225539.TXT'),('EIVS241020013915.TXT'),('EIVS241020035612.TXT'),('EIVS241020042814.TXT'),('EIVS241020045354.TXT'),('EIVS241020052428.TXT'),('EIVS241020055729.TXT'),('EIVS241020062715.TXT'),('EIVS241020065809.TXT'),('EIVS241020072933.TXT'),('EIVS241020080057.TXT'),('EIVS241020083224.TXT'),('EIVS241020090403.TXT'),('EIVS241020093504.TXT'),('EIVS241020100629.TXT'),('EIVS241020103750.TXT'),('EIVS241020110912.TXT'),('EIVS241020114226.TXT'),('EIVS241020121206.TXT'),('EIVS241020124318.TXT'),('EIVS241020131444.TXT'),('EIVS241020134615.TXT'),('EIVS241020141735.TXT'),('EIVS241020152022.TXT'),('EIVS241020155143.TXT'),('EIVS241020162334.TXT'),('EIVS241020165505.TXT'),('EIVS241020172734.TXT'),('EIVS241020175753.TXT'),('EIVS241020182921.TXT'),('EIVS241020190047.TXT'),('EIVS241020193208.TXT'),('EIVS241020200326.TXT'),('EIVS241020203455.TXT'),('EIVS241020210618.TXT'),('EIVS241020213740.TXT'),('EIVS241020220918.TXT'),('EIVS241020224035.TXT'),('EIVS241020235930.TXT'),('EIVS251020020113.TXT'),('EIVS251020023241.TXT'),('EIVS251020030349.TXT'),('EIVS251020033511.TXT'),('EIVS251020040638.TXT'),('EIVS251020043801.TXT'),('EIVS251020050923.TXT'),('EIVS251020054145.TXT'),('EIVS251020061213.TXT'),('EIVS251020064341.TXT'),('EIVS251020071503.TXT'),('EIVS251020074735.TXT'),('EIVS251020082909.TXT'),('EIVS251020084911.TXT'),('EIVS251020092045.TXT'),('EIVS251020095200.TXT'),('EIVS251020102337.TXT'),('EIVS251020105450.TXT'),('EIVS251020112623.TXT'),('EIVS251020115747.TXT'),('EIVS251020122911.TXT'),('EIVS251020130026.TXT'),('EIVS251020133159.TXT'),('EIVS251020140346.TXT'),('EIVS251020143454.TXT'),('EIVS251020150630.TXT'),('EIVS251020153750.TXT'),('EIVS251020160913.TXT'),('EIVS251020164028.TXT'),('EIVS251020171212.TXT'),('EIVS251020174323.TXT'),('EIVS251020181434.TXT'),('EIVS251020184629.TXT'),('EIVS251020191735.TXT'),('EIVS251020194858.TXT'),('EIVS251020202020.TXT'),('EIVS251020205144.TXT'),('EIVS251020212317.TXT'),('EIVS251020215446.TXT'),('EIVS251020222604.TXT'),('EIVS251020225717.TXT'),('EIVS251020235858.TXT'),('EIVS261020020124.TXT'),('EIVS261020023249.TXT'),('EIVS261020030400.TXT'),('EIVS261020033534.TXT'),('EIVS261020040652.TXT'),('EIVS261020043814.TXT'),('EIVS261020050943.TXT'),('EIVS261020054106.TXT'),('EIVS261020061247.TXT'),('EIVS261020064358.TXT'),('EIVS261020071514.TXT'),('EIVS261020074643.TXT'),('EIVS261020081812.TXT'),('EIVS261020084945.TXT'),('EIVS261020092058.TXT'),('EIVS261020095249.TXT'),('EIVS261020095610.TXT'),('EIVS261020102405.TXT'),('EIVS261020112926.TXT'),('EIVS261020115815.TXT'),('EIVS261020122855.TXT'),('EIVS261020125833.TXT'),('EIVS261020132831.TXT'),('EIVS261020135703.TXT'),('EIVS261020152728.TXT'),('EIVS261020155846.TXT'),('EIVS261020162846.TXT'),('EIVS261020165748.TXT'),('EIVS261020173323.TXT'),('EIVS271020020211.TXT'),('EIVS271020023130.TXT'),('EIVS271020030119.TXT'),('EIVS271020033111.TXT'),('EIVS271020040122.TXT'),('EIVS271020043125.TXT'),('EIVS271020050117.TXT'),('EIVS271020053147.TXT'),('EIVS271020060151.TXT'),('EIVS271020063139.TXT'),('EIVS271020070131.TXT'),('EIVS271020073156.TXT'),('EIVS271020080136.TXT'),('EIVS271020083151.TXT'),('EIVS271020090332.TXT'),('EIVS271020103336.TXT'),('EIVS271020110355.TXT'),('EIVS271020120256.TXT'),('EIVS271020123201.TXT'),('EIVS271020130208.TXT'),('EIVS271020133153.TXT'),('EIVS271020140202.TXT'),('EIVS271020150321.TXT'),('EIVS271020153221.TXT'),('EIVS271020160221.TXT'),('EIVS271020163224.TXT'),('EIVS271020172920.TXT'),('EIVS271020215248.TXT'),('EIVS271020222226.TXT'),('EIVS271020225221.TXT'),('EIVS281020003901.TXT'),('EIVS281020023254.TXT'),('EIVS281020030124.TXT'),('EIVS281020033116.TXT'),('EIVS281020040135.TXT'),('EIVS281020043137.TXT'),('EIVS281020050121.TXT'),('EIVS281020053145.TXT'),('EIVS281020060139.TXT'),('EIVS281020063136.TXT'),('EIVS281020070142.TXT'),('EIVS281020073141.TXT'),('EIVS281020080153.TXT'),('EIVS281020083210.TXT'),('EIVS281020103242.TXT'),('EIVS281020110311.TXT'),('EIVS281020113238.TXT'),('EIVS281020123223.TXT'),('EIVS281020130227.TXT'),('EIVS281020133220.TXT'),('EIVS281020140320.TXT'),('EIVS281020143245.TXT'),('EIVS281020150243.TXT'),('EIVS281020153247.TXT'),('EIVS281020160233.TXT'),('EIVS281020163249.TXT'),('EIVS281020172824.TXT'),('EIVS281020175037.TXT'),('EIVS281020181243.TXT'),('EIVS281020191753.TXT'),('EIVS281020194300.TXT'),('EIVS281020195802.TXT'),('EIVS281020202942.TXT'),('EIVS281020205857.TXT'),('EIVS281020212940.TXT'),('EIVS281020220006.TXT'),('EIVS281020222904.TXT'),('EIVS281020225806.TXT'),('EIVS291020004554.TXT'),('EIVS291020023238.TXT'),('EIVS291020030140.TXT'),('EIVS291020033142.TXT'),('EIVS291020040157.TXT'),('EIVS291020043128.TXT'),('EIVS291020050144.TXT'),('EIVS291020053139.TXT'),('EIVS291020060129.TXT'),('EIVS291020063158.TXT'),('EIVS291020070158.TXT'),('EIVS291020073157.TXT'),('EIVS291020080207.TXT'),('EIVS291020083207.TXT'),('EIVS291020090224.TXT'),('EIVS291020093226.TXT'),('EIVS291020100331.TXT'),('EIVS291020103618.TXT'),('EIVS291020113301.TXT'),('EIVS291020120301.TXT'),('EIVS291020123305.TXT'),('EIVS291020180631.TXT'),('EIVS291020183023.TXT'),('EIVS291020191915.TXT'),('EIVS291020193032.TXT'),('EIVS291020200342.TXT'),('EIVS291020203125.TXT'),('EIVS291020210035.TXT'),('EIVS291020213006.TXT'),('EIVS291020215950.TXT'),('EIVS291020222945.TXT'),('EIVS291020230059.TXT'),('EIVS301020003914.TXT'),('EIVS301020023230.TXT'),('EIVS301020030119.TXT'),('EIVS301020033130.TXT'),('EIVS301020040127.TXT'),('EIVS301020043138.TXT'),('EIVS301020050128.TXT'),('EIVS301020053141.TXT'),('EIVS301020060138.TXT'),('EIVS301020063154.TXT'),('EIVS301020070150.TXT'),('EIVS301020073155.TXT'),('EIVS301020080157.TXT'),('EIVS301020083222.TXT'),('EIVS301020090220.TXT'),('EIVS301020093244.TXT'),('EIVS301020100358.TXT'),('EIVS301020103255.TXT'),('EIVS301020110309.TXT'),('EIVS301020113311.TXT'),('EIVS301020130325.TXT'),('EIVS301020133323.TXT'),('EIVS301020140326.TXT'),('EIVS301020143432.TXT'),('EIVS301020150352.TXT'),('EIVS301020153604.TXT'),('EIVS301020160421.TXT'),('EIVS301020171913.TXT'),('EIVS301020173537.TXT'),('EIVS311020025100.TXT'),('EIVS311020025442.TXT'),('EIVS311020032346.TXT'),('EIVS311020035036.TXT'),('EIVS311020042833.TXT'),('EIVS311020045131.TXT'),('EIVS311020052245.TXT'),('EIVS311020055056.TXT'),('EIVS311020062107.TXT'),('EIVS311020065116.TXT'),('EIVS311020072117.TXT'),('EIVS311020075124.TXT'),('EIVS311020082149.TXT'),('EIVS311020085159.TXT'),('EIVS311020092216.TXT'),('EIVS311020095209.TXT'),('EIVS311020102215.TXT'),('EIVS311020105226.TXT'),('EIVS311020112239.TXT'),('EIVS311020115243.TXT'),('EIVS311020122259.TXT'),('EIVS311020125300.TXT'),('EIVS311020132255.TXT'),('EIVS311020135249.TXT'),('EIVS311020142307.TXT'),('EIVS311020145316.TXT'),('EIVS311020152326.TXT'),('EIVS311020155320.TXT'),('EIVS311020162336.TXT'),('EIVS311020165338.TXT'),('EIVS311020172346.TXT'),('EIVS311020175356.TXT'),('EIVS311020182405.TXT'),('EIVS311020185353.TXT'),('EIVS311020192403.TXT'),('EIVS311020195424.TXT'),('EIVS311020202439.TXT'),('EIVS311020205439.TXT'),('EIVS311020212428.TXT'),('EIVS311020215437.TXT'),('EIVS311020222457.TXT'),('EIVS311020225445.TXT'),('EIVS311020235907.TXT')
    ) t(fn)
)
select distinct fn
into #files
from files
order by fn

begin try
	begin tran

	insert into FulfilmentImpUpdLog (Fulfilment,FileName,ActionTaken,ActionDate,Msg,ActionOK,ActionRecords,UpdateDone,UpdateDate,UpdateDone_2_8,UpdateDate_2_8,NewCentral,UpdateDoneCentral,UpdateDateCentral,Central,UpdateDoneEM_Old,UpdateDateEM_Old,EM_Old,UpdateDoneMarketing,UpdateDateMarketing,Marketing,expsent)
	select 'QSSH', fn, 'Logging', getdate(), 'Import File was empty.', 1, 0, 1, getdate(), 0, NULL, 1, 0, NULL, 1, 0, NULL, 1, 0, NULL, 1, 0
	from #files f
	left join FulfilmentImpUpdLog l on l.FileName = f.fn
	where l.FileName is null

	select *
	from #files f
	join FulfilmentImpUpdLog l on l.FileName = f.fn

	commit
end try
begin catch
	if (@@trancount > 0)
		rollback
	;throw
end catch



