WITH

s1 AS 
(
SELECT
   time
  ,td_host
  ,td_client_id 
  ,url_extract_host(td_referrer) AS ref_host
FROM
  ${log_database}.${log_table}
WHERE
  --td_host IN ('${check_host}') AND
  --NOT REGEXP_LIKE (url_extract_host(td_referrer) ,'${ref_exception}') AND
  TD_PARSE_AGENT(td_user_agent) ['category'] <> 'crawler' AND
  td_client_id != '00000000-0000-4000-8000-000000000000' AND
  NOT regexp_like(td_browser, '^(?:Googlebot(?:-.*)?|BingPreview|bingbot|YandexBot|PingdomBot)$') AND
  td_host != 'gtm-msr.appspot.com' AND
  td_client_id is not NULL AND
  td_client_id <> 'undefined' AND
  TD_TIME_RANGE(time, td_time_format(TD_SCHEDULED_TIME(), 'yyyy-MM-dd', 'JST'), NULL, 'JST')
),

t1 AS 
(
SELECT
   time
  ,TD_SESSIONIZE_WINDOW(time, 900) OVER (PARTITION BY td_client_id ORDER BY time) AS session_id
  ,td_host
  ,td_client_id 
  ,CASE 
    WHEN ref_host LIKE '%smartnews%' THEN 'SmartNews'
    WHEN ref_host LIKE '%storyweb%' THEN 'STORY'
    WHEN ref_host LIKE '%kokode%' THEN 'kokode'
    WHEN ref_host LIKE '%classy-online%' THEN 'CLASSY'
    WHEN ref_host LIKE '%hers-web%' THEN 'HERS'
    WHEN ref_host LIKE '%search.yahoo%' THEN 'Yahoo!(search)'
    WHEN ref_host LIKE '%headlines.yahoo%' THEN 'Yahoo!(headlines)'
    WHEN ref_host LIKE '%mail.yahoo%' THEN 'Yahoo!(mail)'
    WHEN ref_host LIKE '%google.com%' THEN 'Google(com)'
    WHEN ref_host LIKE '%googleapis.com%' THEN 'Google(com)'
    WHEN ref_host LIKE '%google.co.jp%' THEN 'Google(jp)'
    WHEN ref_host LIKE '%veryweb%' THEN 'Very'
    WHEN ref_host LIKE '%google.android%' THEN 'Android'
    WHEN ref_host LIKE '%jj-jj%' THEN 'JJ'
    WHEN ref_host LIKE '%popin%' THEN 'popIn'
    WHEN ref_host LIKE '%mart-magazin%' THEN 'Mart'
    WHEN ref_host LIKE '%classy-online%' THEN 'CLASSY'
    WHEN ref_host LIKE '%yahoo%' THEN 'Yahoo!'
    WHEN ref_host LIKE '%be-story%' THEN '美ST'
    WHEN ref_host LIKE '%facebook%' THEN 'Facebook'
    WHEN ref_host LIKE '%bisweb%' THEN 'bis'
    WHEN ref_host LIKE '%docomo%' THEN 'Docomo'
    WHEN ref_host LIKE '%t.co%' THEN 'Twitter'
    WHEN ref_host LIKE '%news.line%' THEN 'Line(news)'
    WHEN ref_host LIKE '%antenna%' THEN 'antenna'
    WHEN ref_host LIKE '%instagram%' THEN 'Instagram'
    WHEN ref_host LIKE '%gunosy%' THEN 'gunosy'
    WHEN ref_host LIKE '%auone%' THEN 'au'
    WHEN ref_host LIKE '%facebook%' THEN 'Facebook'
    WHEN ref_host LIKE '%p-birthday%' THEN 'Petit Birthday'
    WHEN ref_host LIKE '%toriizaka46%' THEN '欅坂46まとめきんぐだむ'
    WHEN ref_host LIKE '%ast.client.jp%' THEN 'DIVINATION★LINK'
    WHEN ref_host LIKE '%toutiao%' THEN '今日头条'
    WHEN ref_host LIKE '%naver%' THEN 'NAVERまとめ'
    WHEN ref_host LIKE '%bing%' THEN 'bing'
    WHEN ref_host LIKE '%keyakizaka46ch.jp%' THEN '欅坂46/日向坂46まとめちゃんねる'
    WHEN ref_host LIKE '%p-birthday%' THEN 'Petit Birthday'
    WHEN ref_host LIKE '%pinterest%' THEN 'Pinterest'
    WHEN ref_host LIKE '%magazine-data%' THEN 'ファッション雑誌ガイド'
    WHEN ref_host LIKE '%momocafe%' THEN 'momocafe'
    WHEN ref_host LIKE '%s.yimg.jp%' THEN 'Yahoo!(画像)'
    WHEN ref_host LIKE '%ameblo%' THEN 'ameblo'
    WHEN ref_host LIKE '%magacol%' THEN 'magacol'
    WHEN ref_host LIKE '%rakuten%' THEN '楽天'
    WHEN ref_host LIKE '%trilltrill%' THEN 'TRILL'
    WHEN ref_host LIKE '%goo.ne.jp%' THEN 'goo'
    WHEN ref_host LIKE '%wikipedia%' THEN 'wikipedia'
    WHEN ref_host LIKE '%bimajo.jp%' THEN '美ST'
    WHEN ref_host LIKE '%jword%' THEN 'jword'   
    WHEN ref_host LIKE '%wwdjapan%' THEN 'WWD JAPAN'
    WHEN ref_host LIKE '%traffic.outbrain%' THEN 'Outbrain'
    WHEN ref_host LIKE '%newspicks%' THEN 'NewsPicks'
    WHEN ref_host LIKE '%twitter%' THEN 'Twitter'
    WHEN ref_host LIKE '%patentsalon%' THEN 'パテントサロン'
    WHEN ref_host LIKE '%feedly%' THEN 'feedly'
    WHEN ref_host LIKE '%wwd.local%' THEN 'WWD JAPAN'
    WHEN ref_host LIKE '%macromill%' THEN 'macromill' 
    WHEN ref_host LIKE '%note.mu%' THEN 'note'
    WHEN ref_host LIKE '%twitpane%' THEN 'TwitPane'
    WHEN ref_host LIKE '%msn%' THEN 'msn'
    WHEN ref_host LIKE '%nifty%' THEN 'nifty'
    WHEN ref_host LIKE '%excite%' THEN 'excite'
    WHEN ref_host LIKE '%slack%' THEN 'slack'
    WHEN ref_host LIKE '%linkedin%' THEN 'Linkedin'
    WHEN ref_host LIKE '%liginc%' THEN 'LIG'    
    WHEN ref_host LIKE '%youtube%' THEN 'YouTube'
    WHEN ref_host LIKE '%so-net%' THEN 'so-net'
    WHEN ref_host LIKE '%Slack%' THEN 'slack'
    WHEN ref_host LIKE '%taboola%' THEN 'taboola'
    WHEN ref_host LIKE '%hatena%' THEN 'hatena'
    WHEN ref_host LIKE '%wwd.com%' THEN 'WWD.com'
    WHEN ref_host LIKE '%meltwater%' THEN 'meltwater'
    WHEN ref_host LIKE '%t.umblr%' THEN 'tumblr'    
    WHEN ref_host LIKE '%paid.outbrain%' THEN 'Outbrain(paid)'
    WHEN ref_host LIKE '%search.myway.%' THEN 'MyWay(search)'
    WHEN ref_host LIKE '%biglobe%' THEN 'biglobe'
    WHEN ref_host LIKE '%tkzoe.com%' THEN 'tkzoe.com'
    WHEN ref_host LIKE '%search.ask%' THEN 'ask'
    WHEN ref_host LIKE '%workplace%' THEN 'workplace'    
    WHEN ref_host LIKE '%surveymonkey%' THEN 'surveymonkey'
    WHEN ref_host LIKE '%sansan%' THEN 'sansan'
    WHEN ref_host LIKE '%messenger%' THEN 'Facebook messenger'
    WHEN ref_host LIKE '%cybozu%' THEN 'cybozu'
    WHEN ref_host LIKE '%prtimes%' THEN 'PR TIMES'    
    WHEN ref_host LIKE '%surveymonkey%' THEN 'surveymonkey'
    WHEN ref_host LIKE 'www.tfm.co.jp' THEN 'TFM'
    WHEN ref_host LIKE '%park.gsj.mobi%' THEN 'JFN PARK'    
    WHEN ref_host LIKE '%tfm-plus.gsj.mobi%' THEN 'TOKYO FM+'
    WHEN ref_host LIKE '%sky.tfm%' THEN 'Skyrocket company'
    WHEN ref_host LIKE '%lock.tfm%' THEN 'SCHOOL OF ROCK!'
    WHEN ref_host LIKE '%radiko%' THEN 'radiko'
    WHEN ref_host LIKE '%www.chance.com%' THEN 'チャンスイット'    
    WHEN ref_host LIKE '%mv-sp.gsj.bz%' THEN 'ミュージック ヴィレッジ'
    WHEN ref_host LIKE 'speee-ad.akamaized.net' THEN 'Speee AD'
    WHEN ref_host LIKE 'www.fmnagano.co.jp' THEN 'FM NAGOYA'    
    WHEN ref_host LIKE 'www.fm-sanin.co.jp' THEN 'FM SANIN'
    WHEN ref_host LIKE 'www.jfn.co.jp' THEN 'JFN'
    WHEN ref_host LIKE 'hfm.jp' THEN 'HIROSHIMA FM'
    WHEN ref_host LIKE 'www.hinatazaka46.com' THEN '日向坂46公式サイト'
    WHEN ref_host LIKE 'www.fmosaka.net' THEN 'FM OSAKA'    
    WHEN ref_host LIKE 'content-click.amanad.adtdp.com' THEN 'adtech studio(CA)'
    WHEN ref_host LIKE 'www.joyfm.co.jp' THEN 'JOY FM'
    WHEN ref_host LIKE 'hellofive.jp' THEN 'HELLO FIVE'    
    WHEN ref_host LIKE 'www.keyakizaka46.com' THEN '欅坂46公式サイト'
    WHEN ref_host LIKE 'www.berry.co.jp' THEN 'RADIO BERRY'
    WHEN ref_host LIKE 'www.fmtoyama.co.jp' THEN 'FM TOYAMA'
    WHEN ref_host LIKE 'www.fmf.co.jp' THEN 'ふくしまFM'
    WHEN ref_host LIKE 'www.rfm.co.jp' THEN 'エフエム山形'    
    WHEN ref_host LIKE 'www.kiss-fm.co.jp' THEN 'Kiss FM KOBE'
    WHEN ref_host LIKE 'www.joeufm.co.jp' THEN 'FM愛媛'
    WHEN ref_host LIKE 'hellofive.jp' THEN 'エフエム岐阜'    
    WHEN ref_host LIKE 'www.hokto-kinoko.co.jp' THEN 'ホクト'
    WHEN ref_host LIKE 'www.knshow.com' THEN '懸賞生活'
    WHEN ref_host LIKE 'news.mixi.jp' THEN 'mixiニュース'
    WHEN ref_host LIKE 'www.fmsaga.co.jp' THEN 'FM SAGA'
    WHEN ref_host LIKE 'www.japanfmnetwork.com' THEN '全国FM放送協議会'    
    WHEN ref_host LIKE 'www.fmy.co.jp' THEN 'エフエム山口'
    WHEN ref_host LIKE 'www.fmkochi.com' THEN 'FM高知'
    WHEN ref_host LIKE 'www.arugoworks.net' THEN 'Arugoworks'    
    WHEN ref_host LIKE '771.fm' THEN 'Date FM'
    WHEN ref_host LIKE 'www.ghibli.jp' THEN 'スタジオジブリ'
    WHEN ref_host LIKE '%fmmie.jp' THEN 'FM三重'
    WHEN ref_host LIKE 'www.fm-akita.co.jp' THEN 'エフエム秋田'
    WHEN ref_host LIKE 'www.fmoita.co.jp' THEN 'エフエム大分'    
    WHEN ref_host LIKE 'www.fmfukui.jp' THEN 'FM福井'
    WHEN ref_host LIKE 'www.air-g.co.jp' THEN 'FM北海道'
    WHEN ref_host LIKE 'www.afb.co.jp' THEN 'エフエム青森'    
    WHEN ref_host LIKE 'news.mynavi.jp' THEN 'マイナビニュース'
    WHEN ref_host LIKE 'm.tribe-m.jp' THEN 'EXILE TRIBE'
    WHEN ref_host LIKE 'blog.livedoor.jp' THEN 'ライブドアブログ'
    WHEN ref_host LIKE 'kaisurf.com' THEN '甲斐よしひろ公式サイト'
    WHEN ref_host LIKE 'www.e-nexco.co.jp' THEN 'NEXCO東日本'    
    WHEN ref_host LIKE 'www2.jfn.co.jp' THEN 'JFN'
    WHEN ref_host LIKE 'www.datefm.co.jp' THEN 'エフエム仙台'
    WHEN ref_host LIKE 'sp.spimo.net' THEN 'SPITZ mobile'    
    WHEN ref_host LIKE 'www.bumpofchicken.com' THEN 'BUMP OF CHICKEN official website'
    WHEN ref_host LIKE 'www.ken-kaku.com' THEN '懸賞当確'
    WHEN ref_host LIKE 'www.keitai.fm' THEN 'Meet The Music'
    WHEN ref_host LIKE 'www.bs-log.com' THEN 'BsLOG'
    WHEN ref_host LIKE 'www.fmniigata.com' THEN 'FM新潟'    
    WHEN ref_host LIKE 'www.mizukinana.jp' THEN '水樹奈々公式サイト'
    WHEN ref_host LIKE 'news.ameba.jp' THEN 'アメーバニュース'
    WHEN ref_host LIKE 'fma.co.jp' THEN '@FM'    
    WHEN ref_host LIKE 'momoclozamurai.xxxblog.jp' THEN 'ももクロ侍'
    WHEN ref_host LIKE 'news.livedoor.com' THEN 'ライブドアニュース'
    WHEN ref_host LIKE 'keyakizaka46matomemory.net' THEN '欅坂46まとめもりー'
    WHEN ref_host LIKE 'www.sakuradadori.com' THEN '桜田通公式サイト'
    WHEN ref_host LIKE 'hiragana46matome.com' THEN '日向坂46まとめきんぐだむ'    
    WHEN ref_host LIKE '%k-mix.co.jp' THEN 'K-MIX'
    WHEN ref_host LIKE 'rikakoaida.com' THEN '逢田梨香子公式サイト'
    WHEN ref_host LIKE 'itest.5ch.net' THEN '5ちゃんねる'    
    WHEN ref_host LIKE 'radiotuner.jp' THEN 'ラジオ局周波数 全国版'
    WHEN ref_host LIKE 'www.yoku-ataru.com' THEN 'よく当たるコム'
    WHEN ref_host LIKE 'lovelivematocha.com' THEN 'ラブライブ!まとめちゃんねる!!'
    WHEN ref_host LIKE 'fmk.fm' THEN 'FM熊本'
    WHEN ref_host LIKE 'fmfukuoka.co.jp' THEN 'FM福岡'    
    WHEN ref_host LIKE 'fm807.jp' THEN 'FM徳島'
    WHEN ref_host LIKE 'shineeworld-j.smtown-fc.jp' THEN 'SHINeeWORLDJ'
    WHEN ref_host LIKE 'www.fmokinawa.co.jp' THEN 'FM沖縄'    
    WHEN ref_host LIKE 'shishamo.biz' THEN 'SHISHAMO公式サイト'
    WHEN ref_host LIKE 'www.myufm.jp' THEN 'FM鹿児島'
    WHEN ref_host LIKE 'www.1101.com' THEN 'ほぼ日刊イトイ新聞'
    WHEN ref_host LIKE 'kyary.asobisystem.com' THEN 'きゃりーぱみゅぱみゅ公式サイト'
    WHEN ref_host LIKE 'fmsp.amob.jp' THEN '福山雅治オフィシャルサイト'    
    WHEN ref_host LIKE 'admin-official.line.me' THEN 'LINE'
    WHEN ref_host LIKE 'www.fmgunma.com' THEN 'FM群馬'
    WHEN ref_host LIKE 'www.fmnagasaki.co.jp' THEN 'FM長崎'    
    WHEN ref_host LIKE 'www.fm807.jp' THEN 'FM徳島'
    WHEN ref_host LIKE 'rockinon.com' THEN 'rockinon'
    WHEN ref_host LIKE 'www.fmkagawa.co.jp' THEN 'FM香川'
    WHEN ref_host LIKE 'www.toysfactory.co.jp' THEN 'TOYS FACTORY'
    WHEN ref_host LIKE 'gendai.ismedia.jp' THEN '現代ビジネス'    
    WHEN ref_host LIKE 'www.docodemo.fm' THEN 'ドコデモFM'
    WHEN ref_host LIKE 'lineblog.me' THEN 'LINEブログ'
    WHEN ref_host LIKE 'www.hiroshima-fm.co.jp' THEN 'HIROSHIMA FM'
    WHEN ref_host LIKE 'www.fm-okayama.co.jp' THEN 'FM岡山'
    WHEN ref_host LIKE 'www.fmii.co.jp' THEN 'FM岩手'
    WHEN ref_host LIKE 'www.fmgifu.com' THEN 'FM岐阜'    
    WHEN ref_host LIKE '%jfn.co.jp' THEN 'JFN'     
    WHEN ref_host LIKE 'fmosaka.net' THEN 'FM OH!'
    WHEN ref_host = '' THEN 'Non Referer' 
    WHEN NULL THEN 'Non Referer' 
    ELSE 'Others' 
    END AS td_referrer_name 
FROM s1
),

t2 AS (
SELECT
   time
  ,row_number() over (partition by session_id order by time ASC) as older
  ,session_id
  ,td_host
  ,td_client_id 
  ,td_referrer_name
FROM t1
)

SELECT
   td_host
  ,td_referrer_name
  ,COUNT(td_client_id) AS cnt
FROM t2
WHERE older = 1
GROUP BY 1,2