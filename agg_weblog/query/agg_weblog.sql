WITH

t1 AS
(
SELECT
  time ,
  td_client_id ,
  td_global_id ,
--  td_ssc_id ,
--  event_type ,
  parse_url(td_url,'QUERY','utm_source') as utm_source ,
  parse_url(td_url,'QUERY','utm_medium') as utm_medium ,
  td_referrer ,
  parse_url(td_referrer, 'HOST') AS td_ref_host ,
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
  TD_PARSE_AGENT(td_user_agent) ['category'] <> 'crawler' AND
  td_client_id != '00000000-0000-4000-8000-000000000000' AND
  td_browser NOT RLIKE '^(?:Googlebot(?:-.*)?|BingPreview|bingbot|YandexBot|PingdomBot)$' AND
  td_host != 'gtm-msr.appspot.com' AND
  td_client_id is not NULL AND
  td_client_id <> 'undefined'
)

-- DIGDAG_INSERT_LINE

SELECT
  time ,
  td_client_id ,
  td_global_id ,
--  td_ssc_id ,
--  event_type ,
  utm_source ,
  utm_medium ,
  td_referrer ,
  td_ref_host ,
  CASE
   WHEN td_ref_host RLIKE '%creativecdn%' THEN 'Adobe Creative Cloud' 
   WHEN td_ref_host RLIKE '%ampproject%' THEN 'AMPページ'
   WHEN td_ref_host RLIKE '%criteo%' THEN 'criteo'
   WHEN td_ref_host RLIKE '%logly%' THEN 'logly'
   WHEN td_ref_host RLIKE '%outlook.live.com%' THEN 'outlook'
   WHEN td_ref_host RLIKE '%google%' THEN 'google'
   WHEN td_ref_host RLIKE '%www.tripadvisor%' THEN 'tripadvisor'
   WHEN td_ref_host RLIKE '%amanad%' THEN 'amana'
   WHEN td_ref_host RLIKE '%webdigital.dmr.st%' THEN 'webdigital.dmr.st'
   WHEN td_ref_host RLIKE '%js02.jposting.net%' THEN 'jposting'
   WHEN td_ref_host RLIKE '%clrclo.xsrv.jp%' THEN 'Coubic (クービック)'
   WHEN td_ref_host RLIKE '%logly%' THEN 'logly'
   WHEN td_ref_host RLIKE 'www.inoreader.com' THEN '　Inoreader'
   WHEN td_ref_host RLIKE '%rsch.jp%' THEN 'リサーチパネル'
   WHEN td_ref_host RLIKE '%tmall.wamgame.jp%' THEN 'Tモール'
   WHEN td_ref_host RLIKE '%aramame.net%' THEN 'あらまめ2ch'
   WHEN td_ref_host RLIKE '%uzulife.biz%' THEN 'NAPBIZ'
   WHEN td_ref_host RLIKE '%ad-contents.jp%' THEN '簡単レシピ動画まとめ'
   WHEN td_ref_host RLIKE 'app.couples.lv' THEN 'COUPLES'
   WHEN td_ref_host RLIKE 'pokemon-matome.net' THEN 'ぽけりん'
   WHEN td_ref_host RLIKE 'dsp.logly.co.jp' THEN 'LOGLY(DSP)'
   WHEN td_ref_host RLIKE 'bakusai.com' THEN '爆サイ.com'
   WHEN td_ref_host RLIKE 'm.one.impact-ad.jp' THEN 'MarketOne'
   WHEN td_ref_host RLIKE '%smartnews%' THEN 'SmartNews'
   WHEN td_ref_host RLIKE '%search.yahoo%' THEN 'Yahoo!(search)'
   WHEN td_ref_host RLIKE '%headlines.yahoo%' THEN 'Yahoo!(headlines)'
   WHEN td_ref_host RLIKE '%mail.yahoo%' THEN 'Yahoo!(mail)'
   WHEN td_ref_host RLIKE '%google.com%' THEN 'Google(com)'
   WHEN td_ref_host RLIKE '%googleapis.com%' THEN 'Google(com)'
   WHEN td_ref_host RLIKE '%google.co.jp%' THEN 'Google(jp)'
   WHEN td_ref_host RLIKE '%google.android%' THEN 'Android'
   WHEN td_ref_host RLIKE '%popin%' THEN 'popIn'
   WHEN td_ref_host RLIKE '%yahoo%' THEN 'Yahoo!'
   WHEN td_ref_host RLIKE '%docomo%' THEN 'Docomo'
   WHEN td_ref_host RLIKE '%t.co%' THEN 'Twitter'
   WHEN td_ref_host RLIKE '%news.line%' THEN 'Line(news)'
   WHEN td_ref_host RLIKE '%antenna%' THEN 'antenna'
   WHEN td_ref_host RLIKE '%instagram%' THEN 'Instagram'
   WHEN td_ref_host RLIKE '%gunosy%' THEN 'gunosy'
   WHEN td_ref_host RLIKE '%auone%' THEN 'au'
   WHEN td_ref_host RLIKE '%facebook%' THEN 'Facebook'
   WHEN td_ref_host RLIKE '%p-birthday%' THEN 'Petit Birthday'
   WHEN td_ref_host RLIKE '%ast.client.jp%' THEN 'DIVINATION★LINK'
   WHEN td_ref_host RLIKE '%toutiao%' THEN '今日头条'
   WHEN td_ref_host RLIKE '%naver%' THEN 'NAVERまとめ'
   WHEN td_ref_host RLIKE '%bing%' THEN 'bing'
   WHEN td_ref_host RLIKE '%pinterest%' THEN 'Pinterest'
   WHEN td_ref_host RLIKE '%magazine-data%' THEN 'ファッション雑誌ガイド'
   WHEN td_ref_host RLIKE '%s.yimg.jp%' THEN 'Yahoo!(画像)'
   WHEN td_ref_host RLIKE '%ameblo%' THEN 'ameblo'
   WHEN td_ref_host RLIKE '%magacol%' THEN 'magacol'
   WHEN td_ref_host RLIKE '%rakuten%' THEN '楽天'
   WHEN td_ref_host RLIKE '%trilltrill%' THEN 'TRILL'
   WHEN td_ref_host RLIKE '%goo.ne.jp%' THEN 'goo'
   WHEN td_ref_host RLIKE '%wikipedia%' THEN 'wikipedia'
   WHEN td_ref_host RLIKE '%jword%' THEN 'jword'   
   WHEN td_ref_host RLIKE '%traffic.outbrain%' THEN 'Outbrain'
   WHEN td_ref_host RLIKE '%newspicks%' THEN 'NewsPicks'
   WHEN td_ref_host RLIKE '%twitter%' THEN 'Twitter'
   WHEN td_ref_host RLIKE '%patentsalon%' THEN 'パテントサロン'
   WHEN td_ref_host RLIKE '%feedly%' THEN 'feedly'
   WHEN td_ref_host RLIKE '%macromill%' THEN 'macromill' 
   WHEN td_ref_host RLIKE '%note.mu%' THEN 'note'
   WHEN td_ref_host RLIKE '%twitpane%' THEN 'TwitPane'
   WHEN td_ref_host RLIKE '%msn%' THEN 'msn'
   WHEN td_ref_host RLIKE '%nifty%' THEN 'nifty'
   WHEN td_ref_host RLIKE '%excite%' THEN 'excite'
   WHEN td_ref_host RLIKE '%slack%' THEN 'slack'
   WHEN td_ref_host RLIKE '%linkedin%' THEN 'Linkedin'
   WHEN td_ref_host RLIKE '%liginc%' THEN 'LIG'    
   WHEN td_ref_host RLIKE '%youtube%' THEN 'YouTube'
   WHEN td_ref_host RLIKE '%so-net%' THEN 'so-net'
   WHEN td_ref_host RLIKE '%Slack%' THEN 'slack'
   WHEN td_ref_host RLIKE '%taboola%' THEN 'taboola'
   WHEN td_ref_host RLIKE '%hatena%' THEN 'hatena'
   WHEN td_ref_host RLIKE '%meltwater%' THEN 'meltwater'
   WHEN td_ref_host RLIKE '%t.umblr%' THEN 'tumblr'    
   WHEN td_ref_host RLIKE '%paid.outbrain%' THEN 'Outbrain(paid)'
   WHEN td_ref_host RLIKE '%search.myway.%' THEN 'MyWay(search)'
   WHEN td_ref_host RLIKE '%biglobe%' THEN 'biglobe'
   WHEN td_ref_host RLIKE '%search.ask%' THEN 'ask'
   WHEN td_ref_host RLIKE '%workplace%' THEN 'workplace'    
   WHEN td_ref_host RLIKE '%surveymonkey%' THEN 'surveymonkey'
   WHEN td_ref_host RLIKE '%sansan%' THEN 'sansan'
   WHEN td_ref_host RLIKE '%messenger%' THEN 'Facebook messenger'
   WHEN td_ref_host RLIKE '%cybozu%' THEN 'cybozu'
   WHEN td_ref_host RLIKE '%prtimes%' THEN 'PR TIMES'    
   WHEN td_ref_host RLIKE '%surveymonkey%' THEN 'surveymonkey'
   WHEN td_ref_host RLIKE '%radiko%' THEN 'radiko'
   WHEN td_ref_host RLIKE '%www.chance.com%' THEN 'チャンスイット'    
   WHEN td_ref_host RLIKE '%mv-sp.gsj.bz%' THEN 'ミュージック ヴィレッジ'
   WHEN td_ref_host RLIKE 'speee-ad.akamaized.net' THEN 'SPEEE AD'
   WHEN td_ref_host RLIKE 'content-click.amanad.adtdp.com' THEN 'adtech studio(CA)'
   WHEN td_ref_host RLIKE 'www.knshow.com' THEN '懸賞生活'
   WHEN td_ref_host RLIKE 'news.mixi.jp' THEN 'mixiニュース'
   WHEN td_ref_host RLIKE 'www.arugoworks.net' THEN 'Arugoworks'    
   WHEN td_ref_host RLIKE 'www.ghibli.jp' THEN 'スタジオジブリ'
   WHEN td_ref_host RLIKE 'news.mynavi.jp' THEN 'マイナビニュース'
   WHEN td_ref_host RLIKE 'blog.livedoor.jp' THEN 'ライブドアブログ'
   WHEN td_ref_host RLIKE 'www.e-nexco.co.jp' THEN 'NEXCO東日本'    
   WHEN td_ref_host RLIKE 'www.ken-kaku.com' THEN '懸賞当確'
   WHEN td_ref_host RLIKE 'news.ameba.jp' THEN 'アメーバニュース'
   WHEN td_ref_host RLIKE 'news.livedoor.com' THEN 'ライブドアニュース'
   WHEN td_ref_host RLIKE 'itest.5ch.net' THEN '5ちゃんねる'    
   WHEN td_ref_host RLIKE 'radiotuner.jp' THEN 'ラジオ局周波数 全国版'
   WHEN td_ref_host RLIKE 'www.yoku-ataru.com' THEN 'よく当たるコム'
   WHEN td_ref_host RLIKE 'www.1101.com' THEN 'ほぼ日刊イトイ新聞'
   WHEN td_ref_host RLIKE 'admin-official.line.me' THEN 'LINE'
   WHEN td_ref_host RLIKE 'lineblog.me' THEN 'LINEブログ'
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
