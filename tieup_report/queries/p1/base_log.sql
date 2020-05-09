WITH

t1 AS
(
SELECT
  time ,
  TD_SESSIONIZE_WINDOW(time, ${session_lange}) OVER (PARTITION BY ${key_id} ORDER BY time) AS session_id ,
${td_ssc_id_flag}  td_ssc_id ,
  td_client_id ,
  td_global_id ,
--  event_type ,
  url_extract_parameter(td_url, 'utm_source') AS utm_source ,
  url_extract_parameter(td_url, 'utm_medium') AS utm_medium ,
  td_referrer ,
  url_extract_host(td_referrer) AS td_ref_host ,
  td_url ,
  td_host ,
  td_path ,
  td_title ,
  td_description ,
  td_ip ,
  td_os ,
  td_user_agent ,
  td_browser ,
  td_screen ,
  td_viewport 
FROM
  ${log_db}.${log_tb}
WHERE
  TD_TIME_RANGE(time,
    '${td.each.start_date}',
    '${td.each.end_date}',
    'JST') AND
  TD_PARSE_AGENT(td_user_agent) ['category'] <> 'crawler' AND
  td_client_id != '00000000-0000-4000-8000-000000000000' AND
  NOT regexp_like(td_browser, '^(?:Googlebot(?:-.*)?|BingPreview|bingbot|YandexBot|PingdomBot)$') AND
  td_host != 'gtm-msr.appspot.com' AND
  td_client_id is not NULL AND
  td_client_id <> 'undefined'
)


SELECT
  time ,
  session_id ,
  ROW_NUMBER() OVER (PARTITION BY session_id ORDER BY time ASC) AS session_num ,
${td_ssc_id_flag}  td_ssc_id ,
  td_client_id ,
  td_global_id ,
--  event_type ,
  utm_source ,
  utm_medium ,
  td_referrer ,
  td_ref_host ,
  CASE
   --
   --ここに判定したいリファラの内容を追加
   --
   WHEN td_ref_host LIKE '%creativecdn%' THEN 'Adobe Creative Cloud' 
   WHEN td_ref_host LIKE '%ampproject%' THEN 'AMPページ'
   WHEN td_ref_host LIKE '%criteo%' THEN 'criteo'
   WHEN td_ref_host LIKE '%logly%' THEN 'logly'
   WHEN td_ref_host LIKE '%outlook.live.com%' THEN 'outlook'
   WHEN td_ref_host LIKE '%google%' THEN 'google'
   WHEN td_ref_host LIKE '%www.tripadvisor%' THEN 'tripadvisor'
   WHEN td_ref_host LIKE '%amanad%' THEN 'amana'
   WHEN td_ref_host LIKE '%webdigital.dmr.st%' THEN 'webdigital.dmr.st'
   WHEN td_ref_host LIKE '%js02.jposting.net%' THEN 'jposting'
   WHEN td_ref_host LIKE '%clrclo.xsrv.jp%' THEN 'Coubic (クービック)'
   WHEN td_ref_host LIKE '%logly%' THEN 'logly'
   WHEN td_ref_host LIKE 'www.inoreader.com' THEN 'Inoreader'
   WHEN td_ref_host LIKE '%rsch.jp%' THEN 'リサーチパネル'
   WHEN td_ref_host LIKE '%tmall.wamgame.jp%' THEN 'Tモール'
   WHEN td_ref_host LIKE '%aramame.net%' THEN 'あらまめ2ch'
   WHEN td_ref_host LIKE '%uzulife.biz%' THEN 'NAPBIZ'
   WHEN td_ref_host LIKE '%ad-contents.jp%' THEN '簡単レシピ動画まとめ'
   WHEN td_ref_host LIKE 'app.couples.lv' THEN 'COUPLES'
   WHEN td_ref_host LIKE 'pokemon-matome.net' THEN 'ぽけりん'
   WHEN td_ref_host LIKE 'dsp.logly.co.jp' THEN 'LOGLY(DSP)'
   WHEN td_ref_host LIKE 'bakusai.com' THEN '爆サイ.com'
   WHEN td_ref_host LIKE 'm.one.impact-ad.jp' THEN 'MarketOne'
   WHEN td_ref_host LIKE '%smartnews%' THEN 'SmartNews'
   WHEN td_ref_host LIKE '%search.yahoo%' THEN 'Yahoo!(search)'
   WHEN td_ref_host LIKE '%headlines.yahoo%' THEN 'Yahoo!(headlines)'
   WHEN td_ref_host LIKE '%mail.yahoo%' THEN 'Yahoo!(mail)'
   WHEN td_ref_host LIKE '%google.com%' THEN 'Google(com)'
   WHEN td_ref_host LIKE '%googleapis.com%' THEN 'Google(com)'
   WHEN td_ref_host LIKE '%google.co.jp%' THEN 'Google(jp)'
   WHEN td_ref_host LIKE '%google.android%' THEN 'Android'
   WHEN td_ref_host LIKE '%popin%' THEN 'popIn'
   WHEN td_ref_host LIKE '%yahoo%' THEN 'Yahoo!'
   WHEN td_ref_host LIKE '%docomo%' THEN 'Docomo'
   WHEN td_ref_host LIKE '%t.co%' THEN 'Twitter'
   WHEN td_ref_host LIKE '%news.line%' THEN 'Line(news)'
   WHEN td_ref_host LIKE '%antenna%' THEN 'antenna'
   WHEN td_ref_host LIKE '%instagram%' THEN 'Instagram'
   WHEN td_ref_host LIKE '%gunosy%' THEN 'gunosy'
   WHEN td_ref_host LIKE '%auone%' THEN 'au'
   WHEN td_ref_host LIKE '%facebook%' THEN 'Facebook'
   WHEN td_ref_host LIKE '%p-birthday%' THEN 'Petit Birthday'
   WHEN td_ref_host LIKE '%ast.client.jp%' THEN 'DIVINATION★LINK'
   WHEN td_ref_host LIKE '%toutiao%' THEN '今日头条'
   WHEN td_ref_host LIKE '%naver%' THEN 'NAVERまとめ'
   WHEN td_ref_host LIKE '%bing%' THEN 'bing'
   WHEN td_ref_host LIKE '%pinterest%' THEN 'Pinterest'
   WHEN td_ref_host LIKE '%magazine-data%' THEN 'ファッション雑誌ガイド'
   WHEN td_ref_host LIKE '%s.yimg.jp%' THEN 'Yahoo!(画像)'
   WHEN td_ref_host LIKE '%ameblo%' THEN 'ameblo'
   WHEN td_ref_host LIKE '%magacol%' THEN 'magacol'
   WHEN td_ref_host LIKE '%rakuten%' THEN '楽天'
   WHEN td_ref_host LIKE '%trilltrill%' THEN 'TRILL'
   WHEN td_ref_host LIKE '%goo.ne.jp%' THEN 'goo'
   WHEN td_ref_host LIKE '%wikipedia%' THEN 'wikipedia'
   WHEN td_ref_host LIKE '%jword%' THEN 'jword'   
   WHEN td_ref_host LIKE '%traffic.outbrain%' THEN 'Outbrain'
   WHEN td_ref_host LIKE '%newspicks%' THEN 'NewsPicks'
   WHEN td_ref_host LIKE '%twitter%' THEN 'Twitter'
   WHEN td_ref_host LIKE '%patentsalon%' THEN 'パテントサロン'
   WHEN td_ref_host LIKE '%feedly%' THEN 'feedly'
   WHEN td_ref_host LIKE '%macromill%' THEN 'macromill' 
   WHEN td_ref_host LIKE '%note.mu%' THEN 'note'
   WHEN td_ref_host LIKE '%twitpane%' THEN 'TwitPane'
   WHEN td_ref_host LIKE '%msn%' THEN 'msn'
   WHEN td_ref_host LIKE '%nifty%' THEN 'nifty'
   WHEN td_ref_host LIKE '%excite%' THEN 'excite'
   WHEN td_ref_host LIKE '%slack%' THEN 'slack'
   WHEN td_ref_host LIKE '%linkedin%' THEN 'Linkedin'
   WHEN td_ref_host LIKE '%liginc%' THEN 'LIG'    
   WHEN td_ref_host LIKE '%youtube%' THEN 'YouTube'
   WHEN td_ref_host LIKE '%so-net%' THEN 'so-net'
   WHEN td_ref_host LIKE '%Slack%' THEN 'slack'
   WHEN td_ref_host LIKE '%taboola%' THEN 'taboola'
   WHEN td_ref_host LIKE '%hatena%' THEN 'hatena'
   WHEN td_ref_host LIKE '%meltwater%' THEN 'meltwater'
   WHEN td_ref_host LIKE '%t.umblr%' THEN 'tumblr'    
   WHEN td_ref_host LIKE '%paid.outbrain%' THEN 'Outbrain(paid)'
   WHEN td_ref_host LIKE '%search.myway.%' THEN 'MyWay(search)'
   WHEN td_ref_host LIKE '%biglobe%' THEN 'biglobe'
   WHEN td_ref_host LIKE '%search.ask%' THEN 'ask'
   WHEN td_ref_host LIKE '%workplace%' THEN 'workplace'    
   WHEN td_ref_host LIKE '%surveymonkey%' THEN 'surveymonkey'
   WHEN td_ref_host LIKE '%sansan%' THEN 'sansan'
   WHEN td_ref_host LIKE '%messenger%' THEN 'Facebook messenger'
   WHEN td_ref_host LIKE '%cybozu%' THEN 'cybozu'
   WHEN td_ref_host LIKE '%prtimes%' THEN 'PR TIMES'    
   WHEN td_ref_host LIKE '%surveymonkey%' THEN 'surveymonkey'
   WHEN td_ref_host LIKE '%radiko%' THEN 'radiko'
   WHEN td_ref_host LIKE '%www.chance.com%' THEN 'チャンスイット'    
   WHEN td_ref_host LIKE '%mv-sp.gsj.bz%' THEN 'ミュージック ヴィレッジ'
   WHEN td_ref_host LIKE 'speee-ad.akamaized.net' THEN 'SPEEE AD'
   WHEN td_ref_host LIKE 'content-click.amanad.adtdp.com' THEN 'adtech studio(CA)'
   WHEN td_ref_host LIKE 'www.knshow.com' THEN '懸賞生活'
   WHEN td_ref_host LIKE 'news.mixi.jp' THEN 'mixiニュース'
   WHEN td_ref_host LIKE 'www.arugoworks.net' THEN 'Arugoworks'    
   WHEN td_ref_host LIKE 'www.ghibli.jp' THEN 'スタジオジブリ'
   WHEN td_ref_host LIKE 'news.mynavi.jp' THEN 'マイナビニュース'
   WHEN td_ref_host LIKE 'blog.livedoor.jp' THEN 'ライブドアブログ'
   WHEN td_ref_host LIKE 'www.e-nexco.co.jp' THEN 'NEXCO東日本'    
   WHEN td_ref_host LIKE 'www.ken-kaku.com' THEN '懸賞当確'
   WHEN td_ref_host LIKE 'news.ameba.jp' THEN 'アメーバニュース'
   WHEN td_ref_host LIKE 'news.livedoor.com' THEN 'ライブドアニュース'
   WHEN td_ref_host LIKE 'itest.5ch.net' THEN '5ちゃんねる'    
   WHEN td_ref_host LIKE 'radiotuner.jp' THEN 'ラジオ局周波数 全国版'
   WHEN td_ref_host LIKE 'www.yoku-ataru.com' THEN 'よく当たるコム'
   WHEN td_ref_host LIKE 'www.1101.com' THEN 'ほぼ日刊イトイ新聞'
   WHEN td_ref_host LIKE 'admin-official.line.me' THEN 'LINE'
   WHEN td_ref_host LIKE 'lineblog.me' THEN 'LINEブログ'
   WHEN td_ref_host = '' THEN 'Non Referer' 
   WHEN td_ref_host is NULL THEN 'Non Referer'
   ELSE 'other'
  END AS td_ref_name ,
  td_url ,
  td_host ,
  td_path ,
  td_title ,
  td_description ,
  td_ip ,
  td_os ,
  td_user_agent ,
  td_browser ,
  td_screen ,
  td_viewport 
FROM
  t1