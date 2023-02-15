SELECT  
  C5.C5_FILIAL,
  C6.C6_IDFAT,
  C5.C5_NUMECO,
  C5.C5_NUMECLI
FROM
  SC5030 C5
  INNER JOIN SC6030 C6 ON C6.C6_FILIAL = C5.C5_FILIAL AND C6.C6_NUM = C5.C5_NUM AND C6.C6_BLQ <> 'R' AND C6.C6_NOTA = ' ' AND C6.C6_SERIE = ' ' AND C6.D_E_L_E_T_ <> '*'
WHERE 
  C5.C5_FILIAL = '04' AND
  C5.D_E_L_E_T_ <> '*' AND
  C5.C5_NUM IN('184593',
'182440',
'182790',
'182790',
'182790',
'182790',
'182790',
'182790',
'182790',
'182790',
'182790',
'183366',
'182428',
'182414',
'182837',
'182429',
'184694',
'182451',
'182451',
'182427',
'184583',
'183140',
'182819',
'184568',
'184903',
'182814',
'182832',
'182832',
'185829',
'186751',
'182643',
'182643',
'184937',
'186252',
'184934',
'182669',
'184626',
'188385',
'188385',
'188385',
'188385',
'188385',
'188385',
'188385',
'113496',
'184678',
'182830',
'182657',
'182838',
'182838',
'184684',
'184684',
'184684',
'184684',
'184684',
'184684',
'186012',
'184931',
'186208',
'186208',
'186208',
'186208',
'186208',
'186208',
'182722',
'182722',
'182722',
'182722',
'182722',
'186842',
'183190',
'184643',
'188481',
'188481',
'188481',
'188481',
'185883',
'185883',
'185883',
'182711',
'184625',
'184625',
'184625',
'184625',
'187004',
'187004',
'183239',
'183239',
'183380',
'183380',
'183380',
'183380',
'184635',
'184946',
'184615',
'183187',
'183187',
'183187',
'183187',
'183187',
'183187',
'183187',
'183187',
'184959',
'182690',
'182690',
'121904',
'183171',
'121905',
'121905',
'121905',
'121905',
'121905',
'121905',
'121905',
'121905',
'121905',
'121905',
'183198',
'182806',
'182806',
'183201',
'184648',
'121906',
'121906',
'121906',
'121906',
'121906',
'185874',
'091491',
'186195',
'184654',
'184941',
'184941',
'184941',
'184941',
'184941',
'184995',
'184955',
'121907',
'183269',
'184638',
'183188',
'183260',
'184628',
'183185',
'182688',
'183387',
'183387',
'183387',
'183387',
'183387',
'183387',
'184953',
'184613',
'184613',
'184613',
'185020',
'183384',
'183274',
'185027',
'185014',
'184631',
'184616',
'121908',
'121908',
'185006',
'185016',
'185016',
'185016',
'185016',
'182825',
'184996',
'184584',
'121909',
'121910',
'183256',
'183256',
'185000',
'185000',
'185000',
'183396',
'183396',
'185040',
'185046',
'184697',
'185035',
'182817',
'121911',
'182817',
'184617',
'184617',
'184617',
'184617',
'227434',
'227403',
'227434',
'227403',
'183352',
'184640',
'184640',
'184640',
'184640',
'183373',
'184679',
'185057',
'121912',
'183399',
'183399',
'183399',
'185060',
'183193',
'183193',
'185085',
'185041',
'183361',
'184676',
'184676',
'184676',
'184676',
'184676',
'185030',
'183224',
'185110',
'185110',
'121913',
'121913',
'121914',
'185968',
'185968',
'185968',
'163588',
'163588',
'185078',
'121915',
'121915',
'121915',
'121915',
'121915',
'121915',
'121915',
'121915',
'121915',
'121915',
'184703',
'184703',
'185116',
'183263',
'183263',
'227277',
'221370',
'185088',
'183249',
'121919',
'185151',
'183251',
'121920',
'183196',
'121921',
'185166',
'121922',
'121923',
'121923',
'121923',
'121923',
'121923',
'121924',
'121925',
'121926',
'121926',
'121926',
'121926',
'182821',
'185131',
'185131',
'185131',
'184704',
'185172',
'185157',
'185142',
'185158',
'121929',
'182721',
'185124',
'185126',
'183184',
'183184',
'121930',
'185125',
'185177',
'183268',
'183219',
'121931',
'121932',
'121932',
'121932',
'121932',
'121932',
'121932',
'121932',
'121932',
'121932',
'121932',
'227409',
'227388',
'227388',
'227388',
'227409',
'227409',
'183253',
'185204',
'185204',
'185204',
'185830',
'185830',
'185209',
'185209',
'185209',
'185186',
'185186',
'185182',
'185182',
'185227',
'182717',
'184711',
'182726',
'121935',
'185211',
'185194',
'185199',
'121936',
'121936',
'183262',
'185187',
'185195',
'182712',
'183200',
'185210',
'121937',
'121937',
'121937',
'121937',
'185188',
'184612',
'121939',
'185234',
'185524',
'184709',
'182729',
'182729',
'183186',
'183186',
'183186',
'185208',
'185212',
'185190',
'183279',
'183266',
'185192',
'121942',
'185518',
'227438',
'227393',
'227438',
'227438',
'227393',
'227393',
'121943',
'121944',
'121945',
'121945',
'121946',
'121946',
'121946',
'227391',
'227431',
'227431',
'227391',
'186045',
'227394',
'227394',
'227394',
'227394',
'227394',
'227394',
'227394',
'227394',
'227433',
'227433',
'227433',
'227433',
'227433',
'227433',
'227433',
'227433',
'227433',
'227433',
'227433',
'227433',
'227394',
'227394',
'227394',
'227394',
'227394',
'227433',
'227390',
'227390',
'227390',
'185220',
'221349',
'221349',
'183261',
'121947',
'184664',
'184664',
'185229',
'183247',
'185233',
'185233',
'185231',
'185238',
'182864',
'185242',
'185256',
'185256',
'121948',
'183225',
'227410',
'227389',
'227389',
'227410',
'185254',
'185254',
'121949',
'185248',
'121950',
'184713',
'229998',
'227400',
'183250',
'212985',
'184705',
'183241',
'185504',
'185252',
'227387',
'227387',
'227408',
'227408',
'183248',
'121952',
'184714',
'227407',
'227407',
'227386',
'227386',
'227386',
'227407',
'227386',
'227407',
'121954',
'121955',
'121955',
'121956',
'121956',
'121956',
'121956',
'121956',
'121956',
'121956',
'185277',
'183397',
'213035',
'215132',
'212983',
'212946',
'212982',
'227214',
'227385',
'227385',
'227385',
'227406',
'227406',
'227406',
'227405',
'227405',
'227384',
'227384',
'121958',
'121959',
'121959',
'227383',
'227383',
'227383',
'227404',
'227404',
'227404',
'185294',
'121961',
'185296',
'121962',
'227380',
'227401',
'227401',
'227380',
'186186',
'186186',
'186186',
'121964',
'121964',
'183275',
'183275',
'185530',
'121965',
'185965',
'121966',
'183277',
'183277',
'183277',
'183277',
'121967',
'121967',
'121967',
'121967',
'185539',
'185539',
'185539',
'185539',
'121970',
'185523',
'182861',
'183214',
'186072',
'186072',
'186072',
'186072',
'186072',
'185308',
'183255',
'185309',
'185309',
'185309',
'185321',
'121972',
'121975',
'185947',
'184717',
'184717',
'185560',
'184727',
'185332',
'185969',
'185969',
'183374',
'186299',
'186217',
'185347',
'185352',
'182720',
'183356',
'183356',
'121977',
'121978',
'121979',
'183137',
'183137',
'183137',
'121980',
'185362',
'185360',
'185376',
'182730',
'185552',
'185552',
'185552',
'185552',
'185552',
'185552',
'185552',
'185552',
'121982',
'185375',
'183400',
'184722',
'183273',
'183273',
'185843',
'184603',
'184719',
'121984',
'121984',
'184733',
'184733',
'185412',
'121985',
'183206',
'183242',
'183280',
'183280',
'121986',
'185413',
'184740',
'184740',
'184740',
'184740',
'184740',
'184740',
'184740',
'184740',
'184740',
'184740',
'184740',
'184740',
'184740',
'184639',
'184639',
'183209',
'184729',
'184729',
'184729',
'121987',
'183203',
'184739',
'185479',
'121988',
'182718',
'182718',
'184738',
'184666',
'184666',
'183246',
'183211',
'184737',
'184737',
'185446',
'183204',
'121989',
'185584',
'121990',
'121990',
'121990',
'182716',
'185450',
'185841',
'185841',
'185464',
'121992',
'121993',
'121993',
'121993',
'183213',
'183213',
'121994',
'183208',
'183208',
'183395',
'183395',
'185476',
'184734',
'184734',
'121995',
'183202',
'183388',
'121996',
'182857',
'121998',
'183210',
'185958',
'184748',
'186333',
'186333',
'185575',
'185517',
'185517',
'184746',
'121999',
'121999',
'185498',
'122000',
'122000',
'122001',
'182745',
'182745',
'185602',
'122004',
'122004',
'122004',
'122004',
'122004',
'122004',
'182735',
'182735',
'122006',
'185612',
'185612',
'185612',
'122008',
'185608',
'122009',
'183205',
'182842',
'185884',
'185884',
'185614',
'122013',
'122014',
'122016',
'184752',
'184752',
'184752',
'184752',
'122017',
'122017',
'122018',
'182841',
'182841',
'122020',
'122021',
'122022',
'122022',
'184750',
'122023',
'122028',
'185641',
'122030',
'183278',
'122033',
'122033',
'122033',
'182733',
'182744',
'182744',
'122035',
'184753',
'184753',
'185700',
'122039',
'122044',
'185840',
'122045',
'122045',
'122047',
'122048',
'184773',
'122049',
'185650',
'185650',
'184769',
'122052',
'185847',
'122053',
'183265',
'183226',
'122054',
'122054',
'122054',
'122054',
'122055',
'187360',
'187360',
'187360',
'187360',
'182847',
'185687',
'184642',
'122057',
'122058',
'184766',
'122060',
'182741',
'183227',
'183227',
'122062',
'183218',
'122064',
'122064',
'122064',
'122064',
'122064',
'122064',
'122064',
'122064',
'122065',
'122065',
'122065',
'122067',
'185852',
'122069',
'184786',
'184783',
'122070',
'122071',
'122071',
'182748',
'185876',
'122075',
'185870',
'122076',
'186192',
'186192',
'186192',
'186192',
'184779',
'185733',
'122077',
'122077',
'182867',
'122080',
'122080',
'122081',
'183383',
'122084',
'183389',
'122087',
'122092',
'182858',
'183222',
'122095',
'122095',
'183376',
'184645',
'185867',
'122098',
'185893',
'122099',
'122101',
'122101',
'122101',
'182845',
'185890',
'185892',
'122105',
'182843',
'122112',
'122113',
'122113',
'122114',
'122116',
'122118',
'183381',
'122119',
'122121',
'122124',
'122133',
'184800',
'184800',
'182879',
'122139',
'122139',
'122140',
'122141',
'122143',
'184801',
'122144',
'122145',
'122145',
'185997',
'122147',
'122147',
'122149',
'122149',
'122149',
'122149',
'122149',
'185790',
'122152',
'183099',
'183099',
'122153',
'122154',
'122156',
'122156',
'122156',
'122156',
'122158',
'122158',
'183394',
'183394',
'122161',
'122161',
'122161',
'122161',
'122161',
'185859',
'122162',
'122164',
'122165',
'183276',
'122167',
'122167',
'122167',
'122170',
'122172',
'122173',
'122174',
'122178',
'122180',
'122186',
'122187',
'122189',
'122192',
'122192',
'122192',
'122194',
'182732',
'182732',
'122196',
'183244',
'122197',
'122201',
'122201',
'122202',
'122204',
'122205',
'184826',
'163628',
'122208',
'122209',
'122213',
'122213',
'122213',
'122214',
'182873',
'122215',
'122218',
'122218',
'122218',
'122219',
'122220',
'122220',
'122221',
'122222',
'122222',
'122223',
'122224',
'122226',
'122227',
'122229',
'122230',
'183167',
'122231',
'122232',
'122234',
'122235',
'122236',
'122236',
'122236',
'183163',
'122237',
'122238',
'122239',
'122241',
'122242',
'122242',
'122242',
'122242',
'122242',
'122242',
'122242',
'122242',
'122242',
'122243',
'122244',
'122245',
'122247',
'122248',
'182878',
'122251',
'122252',
'122253',
'122254',
'122254',
'122255',
'122255',
'122255',
'122255',
'122256',
'122256',
'122257',
'122257',
'182750',
'182750',
'122258',
'122259',
'122260',
'122260',
'122262',
'122263',
'122265',
'122267',
'122268',
'122271',
'122271',
'122271',
'122271',
'122271',
'122274',
'183281',
'122275')
