WITH

t1 AS
(
SELECT
   time
  ,td_client_id
  ,url_extract_host(td_referrer) AS ref_host
  ,td_referrer
FROM
  bh_${td.each.db_client_name}_${td.each.db_label}
WHERE
  regexp_like(td_path,'${td.each.article_id}')
),

t2 AS
(
SELECT
  time ,
  ref_host ,
  TD_SESSIONIZE_WINDOW(time, 900) OVER (PARTITION BY td_client_id ORDER BY time) AS session_id ,
  td_client_id,
  CASE
   WHEN ref_host LIKE 'www.inoreader.com' THEN '　Inoreader'
   WHEN ref_host LIKE '%rsch.jp%' THEN 'リサーチパネル'
   WHEN ref_host LIKE '%tmall.wamgame.jp%' THEN 'Tモール'
   WHEN ref_host LIKE '%aramame.net%' THEN 'あらまめ2ch'
   WHEN ref_host LIKE '%uzulife.biz%' THEN 'NAPBIZ'
   WHEN ref_host LIKE '%ad-contents.jp%' THEN '簡単レシピ動画まとめ'
   WHEN ref_host LIKE 'app.couples.lv' THEN 'COUPLES'
   WHEN ref_host LIKE 'pokemon-matome.net' THEN 'ぽけりん'
   WHEN ref_host LIKE 'dsp.logly.co.jp' THEN 'LOGLY(DSP)'
   WHEN ref_host LIKE 'bakusai.com' THEN '爆サイ.com'
   WHEN ref_host LIKE 'm.one.impact-ad.jp' THEN 'MarketOne'
   WHEN ref_host LIKE '%smartnews%' THEN 'SmartNews'
   WHEN ref_host LIKE '%search.yahoo%' THEN 'Yahoo!(search)'
   WHEN ref_host LIKE '%headlines.yahoo%' THEN 'Yahoo!(headlines)'
   WHEN ref_host LIKE '%mail.yahoo%' THEN 'Yahoo!(mail)'
   WHEN ref_host LIKE '%google.com%' THEN 'Google(com)'
   WHEN ref_host LIKE '%googleapis.com%' THEN 'Google(com)'
   WHEN ref_host LIKE '%google.co.jp%' THEN 'Google(jp)'
   WHEN ref_host LIKE '%google.android%' THEN 'Android'
   WHEN ref_host LIKE '%popin%' THEN 'popIn'
   WHEN ref_host LIKE '%yahoo%' THEN 'Yahoo!'
   WHEN ref_host LIKE '%docomo%' THEN 'Docomo'
   WHEN ref_host LIKE '%t.co%' THEN 'Twitter'
   WHEN ref_host LIKE '%news.line%' THEN 'Line(news)'
   WHEN ref_host LIKE '%antenna%' THEN 'antenna'
   WHEN ref_host LIKE '%instagram%' THEN 'Instagram'
   WHEN ref_host LIKE '%gunosy%' THEN 'gunosy'
   WHEN ref_host LIKE '%auone%' THEN 'au'
   WHEN ref_host LIKE '%facebook%' THEN 'Facebook'
   WHEN ref_host LIKE '%p-birthday%' THEN 'Petit Birthday'
   WHEN ref_host LIKE '%ast.client.jp%' THEN 'DIVINATION★LINK'
   WHEN ref_host LIKE '%toutiao%' THEN '今日头条'
   WHEN ref_host LIKE '%naver%' THEN 'NAVERまとめ'
   WHEN ref_host LIKE '%bing%' THEN 'bing'
   WHEN ref_host LIKE '%pinterest%' THEN 'Pinterest'
   WHEN ref_host LIKE '%magazine-data%' THEN 'ファッション雑誌ガイド'
   WHEN ref_host LIKE '%s.yimg.jp%' THEN 'Yahoo!(画像)'
   WHEN ref_host LIKE '%ameblo%' THEN 'ameblo'
   WHEN ref_host LIKE '%magacol%' THEN 'magacol'
   WHEN ref_host LIKE '%rakuten%' THEN '楽天'
   WHEN ref_host LIKE '%trilltrill%' THEN 'TRILL'
   WHEN ref_host LIKE '%goo.ne.jp%' THEN 'goo'
   WHEN ref_host LIKE '%wikipedia%' THEN 'wikipedia'
   WHEN ref_host LIKE '%jword%' THEN 'jword'   
   WHEN ref_host LIKE '%wwdjapan%' THEN 'WWD JAPAN'
   WHEN ref_host LIKE '%traffic.outbrain%' THEN 'Outbrain'
   WHEN ref_host LIKE '%newspicks%' THEN 'NewsPicks'
   WHEN ref_host LIKE '%twitter%' THEN 'Twitter'
   WHEN ref_host LIKE '%patentsalon%' THEN 'パテントサロン'
   WHEN ref_host LIKE '%feedly%' THEN 'feedly'
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
   WHEN ref_host LIKE '%meltwater%' THEN 'meltwater'
   WHEN ref_host LIKE '%t.umblr%' THEN 'tumblr'    
   WHEN ref_host LIKE '%paid.outbrain%' THEN 'Outbrain(paid)'
   WHEN ref_host LIKE '%search.myway.%' THEN 'MyWay(search)'
   WHEN ref_host LIKE '%biglobe%' THEN 'biglobe'
   WHEN ref_host LIKE '%search.ask%' THEN 'ask'
   WHEN ref_host LIKE '%workplace%' THEN 'workplace'    
   WHEN ref_host LIKE '%surveymonkey%' THEN 'surveymonkey'
   WHEN ref_host LIKE '%sansan%' THEN 'sansan'
   WHEN ref_host LIKE '%messenger%' THEN 'Facebook messenger'
   WHEN ref_host LIKE '%cybozu%' THEN 'cybozu'
   WHEN ref_host LIKE '%prtimes%' THEN 'PR TIMES'    
   WHEN ref_host LIKE '%surveymonkey%' THEN 'surveymonkey'
   WHEN ref_host LIKE '%radiko%' THEN 'radiko'
   WHEN ref_host LIKE '%www.chance.com%' THEN 'チャンスイット'    
   WHEN ref_host LIKE '%mv-sp.gsj.bz%' THEN 'ミュージック ヴィレッジ'
   WHEN ref_host LIKE 'speee-ad.akamaized.net' THEN 'SPEEE AD'
   WHEN ref_host LIKE 'content-click.amanad.adtdp.com' THEN 'adtech studio(CA)'
   WHEN ref_host LIKE 'www.knshow.com' THEN '懸賞生活'
   WHEN ref_host LIKE 'news.mixi.jp' THEN 'mixiニュース'
   WHEN ref_host LIKE 'www.arugoworks.net' THEN 'Arugoworks'    
   WHEN ref_host LIKE 'www.ghibli.jp' THEN 'スタジオジブリ'
   WHEN ref_host LIKE 'news.mynavi.jp' THEN 'マイナビニュース'
   WHEN ref_host LIKE 'blog.livedoor.jp' THEN 'ライブドアブログ'
   WHEN ref_host LIKE 'www.e-nexco.co.jp' THEN 'NEXCO東日本'    
   WHEN ref_host LIKE 'www.ken-kaku.com' THEN '懸賞当確'
   WHEN ref_host LIKE 'news.ameba.jp' THEN 'アメーバニュース'
   WHEN ref_host LIKE 'news.livedoor.com' THEN 'ライブドアニュース'
   WHEN ref_host LIKE 'itest.5ch.net' THEN '5ちゃんねる'    
   WHEN ref_host LIKE 'radiotuner.jp' THEN 'ラジオ局周波数 全国版'
   WHEN ref_host LIKE 'www.yoku-ataru.com' THEN 'よく当たるコム'
   WHEN ref_host LIKE 'www.1101.com' THEN 'ほぼ日刊イトイ新聞'
   WHEN ref_host LIKE 'admin-official.line.me' THEN 'LINE'
   WHEN ref_host LIKE 'lineblog.me' THEN 'LINEブログ'
   WHEN ref_host = '' THEN 'Non Referer' 
   WHEN NULL THEN 'Non Referer'
   ELSE 'Others'
   END AS td_referrer_name
FROM
  t1
),

t3 AS (
SELECT
   time
  ,row_number() over (partition by session_id order by time ASC) as older
  ,session_id
  ,td_client_id
  ,td_referrer_name
FROM t2
)

SELECT
   td_referrer_name AS bh_ref_name
  ,COUNT(td_client_id) AS bh_ref_cnt
  ,'bh_ref' AS label
FROM t3
WHERE older = 1
GROUP BY 1
