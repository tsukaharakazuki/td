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
   WHEN ref_host LIKE '%smartnews%' THEN 'SmartNews'
   WHEN ref_host LIKE 'funq.jp' THEN 'FUNQ'
   WHEN ref_host LIKE 'www.bicycleclub.jp' THEN 'BiCYCLE CLUB'
   WHEN ref_host LIKE 'www.ei-publishing.co.jp' THEN 'エイ出版社'
   WHEN ref_host LIKE 'www.runningstyle.jp' THEN 'RUNNING style'
   WHEN ref_host LIKE 'www.mono-log.jp' THEN 'bs mono-log'
   WHEN ref_host LIKE 'buono-web.jp' THEN 'buono'
   WHEN ref_host LIKE 'www.fukaya-nagoya.co.jp' THEN 'Fukaya Co., LTD.'
   WHEN ref_host LIKE 'mullerjapan.com' THEN 'OMULLER'
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
   WHEN ref_host LIKE 'search.ask%' THEN 'ask'
   WHEN ref_host LIKE '%workplace%' THEN 'workplace'
   WHEN ref_host LIKE '%surveymonkey%' THEN 'surveymonkey'
   WHEN ref_host LIKE '%sansan%' THEN 'sansan'
   WHEN ref_host LIKE '%messenger%' THEN 'Facebook messenger'
   WHEN ref_host LIKE '%cybozu%' THEN 'cybozu'
   WHEN ref_host LIKE '%prtimes%' THEN 'PR TIMES'
   WHEN ref_host LIKE '%surveymonkey%' THEN 'surveymonkey'
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
