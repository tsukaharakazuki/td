WITH 


t1 AS 
(
  SELECT
    time ,
    td_client_id ,
    url_extract_host(td_referrer) AS td_ref_host ,
    td_referrer
  FROM 
    YOUR_DATA_BASE 
  WHERE
    TD_PARSE_AGENT(td_user_agent) ['category'] <> 'crawler'
    AND td_global_id != '00000000-0000-4000-8000-000000000000'
    AND not regexp_like(td_browser, '^(?:Googlebot(?:-.*)?|BingPreview|bingbot|YandexBot|PingdomBot)$')
    AND td_host != 'gtm-msr.appspot.com'
    AND td_global_id is not NULL
    AND td_global_id <> 'undefined'
    AND TD_INTERVAL(time, '-1d', 'JST')
),


t2 AS
(
  SELECT
    td_ref_host ,
    CASE 
      --クエリを回しながらリファラで出てくるアドレスを分解して判定追加していく
      --WHEN td_ref_host = 'xxxxxxxxx' THEN 'XXXXXXX'

      --
      WHEN td_ref_host = 'google.com' THEN 'Google(com)'
      WHEN td_ref_host = 'www.google.com' THEN 'Google(com)'
      WHEN td_ref_host = 'googleapis.com' THEN 'Google(com)'
      WHEN td_ref_host = 'google.co.jp' THEN 'Google(jp)'
      WHEN td_ref_host = 'www.google.co.jp' THEN 'Google(jp)'
      WHEN td_ref_host = 'cse.google.com' THEN 'Google(CustomeSearch)'
      WHEN td_ref_host = 'cse.google.co.jp' THEN 'Google(CustomeSearch)'
      WHEN td_ref_host = 'news.google.com' THEN 'Google(News)'
      WHEN td_ref_host = 'www.googleapis.com' THEN 'Google(ChromeApp)'
      WHEN td_ref_host = 'translate.googleusercontent.com' THEN 'Google(Translate)'
      WHEN td_ref_host = 'mail.google.com' THEN 'Google(G-Mail)'
      WHEN td_ref_host = 'ampproject.org' THEN 'Google(Amp)'
      WHEN td_ref_host = 'com.google.android.googlequicksearchbox' THEN 'Android'
      WHEN td_ref_host = 'com.google.android.gm' THEN 'Android'
      WHEN td_ref_host = 'www.youtube.com' THEN 'YouTube'
      WHEN td_ref_host = 'youtube.com' THEN 'YouTube'
      WHEN td_ref_host = 'search.yahoo.co.jp' THEN 'Yahoo!(Search)'
      WHEN td_ref_host = 'r.search.yahoo.com' THEN 'Yahoo!(Search)'
      WHEN td_ref_host = 'search.yahoo.com' THEN 'Yahoo!(Search)'
      WHEN td_ref_host = 'headlines.yahoo.co.jp' THEN 'Yahoo!(Headlines)'
      WHEN td_ref_host = 'mail.yahoo.co.jp' THEN 'Yahoo!(Mail)'
      WHEN td_ref_host LIKE '%mail.yahoo.co.jp' THEN 'Yahoo!(Mail)'
      WHEN td_ref_host = 'news.yahoo.co.jp' THEN 'Yahoo!(News)'
      WHEN td_ref_host = 'yahoo.co.jp' THEN 'Yahoo!'
      WHEN td_ref_host = 's.yimg.jp' THEN 'Yahoo!(画像)'
      WHEN td_ref_host = 'auctions.yahoo.co.jp' THEN 'Yahoo!(ヤフオク)'
      WHEN td_ref_host LIKE '%.search.yahoo.com' THEN 'Yahoo!(Search)'
      WHEN td_ref_host = 't.co' THEN 'Twitter'
      WHEN td_ref_host = 'com.twitter.android' THEN 'Twitter'
      WHEN td_ref_host = 'm.facebook.com' THEN 'Facebook'
      WHEN td_ref_host = 'l.facebook.com' THEN 'Facebook'
      WHEN td_ref_host = 'lm.facebook.com' THEN 'Facebook'
      WHEN td_ref_host = 'www.facebook.com' THEN 'Facebook'
      WHEN td_ref_host = 'ja-jp.facebook.com' THEN 'Facebook'
      WHEN td_ref_host = 'facebook.com' THEN 'Facebook'
      WHEN td_ref_host = 'l.messenger.com' THEN 'Facebook(Messenger)'
      WHEN td_ref_host = 'instagram.com' THEN 'Instagram'
      WHEN td_ref_host = 'l.instagram.com' THEN 'Instagram'
      WHEN td_ref_host = 'www.bing.com' THEN 'bing'
      WHEN td_ref_host = 'bing.com' THEN 'bing'
      WHEN td_ref_host = 'cn.bing.com' THEN 'bing'
      WHEN td_ref_host = 'search.smt.docomo.ne.jp' THEN 'Docomo'
      WHEN td_ref_host LIKE '%docomo.ne.jp' THEN 'Docomo'
      WHEN td_ref_host = 'sp-web.search.auone.jp' THEN 'au'
      WHEN td_ref_host = 'www.pinterest.com' THEN 'Pinterest'
      WHEN td_ref_host = 'pinterest.com' THEN 'Pinterest'
      WHEN td_ref_host = 'www.pinterest.jp' THEN 'Pinterest'
      WHEN td_ref_host = 'www-pinterest-jp.cdn.ampproject.org' THEN 'Pinterest'
      WHEN td_ref_host LIKE 'www.pinterest.%' THEN 'Pinterest'
      WHEN td_ref_host = 'www.smartnews.com' THEN 'SmartNews'
      WHEN td_ref_host = 'gunosy.com' THEN 'gunosy'
      WHEN td_ref_host = 'websearch.rakuten.co.jp' THEN 'Rakuten'
      WHEN td_ref_host = 'rakuten.co.jp' THEN 'Rakuten'
      WHEN td_ref_host = 'mobss.jword.jp' THEN 'jword'   
      WHEN td_ref_host = 'jwsearch.jword.jp' THEN 'jword'  
      WHEN td_ref_host = 'news.line.me' THEN 'Line(news)'
      WHEN td_ref_host = 'antenna.jp' THEN 'antenna'
      WHEN td_ref_host = 'jp.antenna.app' THEN 'antenna'
      WHEN td_ref_host = 'newstopics.jp' THEN 'ニュートピ'
      WHEN td_ref_host = 'newspicks.com' THEN 'NewsPicks'
      WHEN td_ref_host = 'mixi.jp' THEN 'mixi'
      WHEN td_ref_host = 'goo.ne.jp' THEN 'goo'
      WHEN td_ref_host = 'news.goo.ne.jp' THEN 'goo'
      WHEN td_ref_host = 'search.goo.ne.jp' THEN 'goo'
      WHEN td_ref_host = 'green.goo.ne.jp' THEN 'goo'
      WHEN td_ref_host = 'green.search.goo.ne.jp' THEN 'goo'
      WHEN td_ref_host = 'news-goo-ne-jp.cdn.ampproject.org' THEN 'goo'
      WHEN td_ref_host LIKE '%excite.co.jp' THEN 'excite'
      WHEN td_ref_host LIKE '%nifty.com' THEN 'nifty'
      WHEN td_ref_host = 'cgi.search.biglobe.ne.jp' THEN 'Biglobe'
      WHEN td_ref_host = 'biglobe.ne.jp' THEN 'Biglobe'
      WHEN td_ref_host = 'www.so-net.ne.jp' THEN 'so-net'
      WHEN td_ref_host = 'mail.ocn.jp' THEN 'Ocn(Mail)'
      WHEN td_ref_host = 'googleads.g.doubleclick.net' THEN 'Google広告'
      WHEN td_ref_host = 'duckduckgo.com' THEN 'DuckDuckGo'
      WHEN td_ref_host = 'nortonsafe.search.ask.com' THEN 'NortonSafeSearch'
      WHEN td_ref_host = 'feedly.com' THEN 'Feedly'    
      WHEN td_ref_host = 'com.twitpane' THEN 'TwitPane'    
      WHEN td_ref_host = 'www.linkedin.com' THEN 'Linkedin'
      WHEN td_ref_host = 'note.com' THEN 'Note'  
      WHEN td_ref_host = 'note.mu' THEN 'Note'
      WHEN td_ref_host = 'com.slack' THEN 'slack'
      WHEN td_ref_host LIKE '%popin.cc' THEN 'popIn'
      WHEN td_ref_host = 'dsp.logly.co.jp' THEN 'LOGLY(DSP)'
      WHEN td_ref_host = 'logly.co.jp' THEN 'LOGLY'
      WHEN td_ref_host = 'transition.meltwater.com' THEN 'Meltwater'  
      WHEN td_ref_host = 'may.2chan.net' THEN 'ふたばちゃんねる'  
      WHEN td_ref_host = 'ameblo.jp' THEN 'ameblo' 
      WHEN td_ref_host = 'prtimes.jp' THEN 'PR TIMES'    
      WHEN td_ref_host = 'prtimes-jp.cdn.ampproject.org' THEN 'PR TIMES'   
      WHEN td_ref_host = 'trilltrill.jp' THEN 'TRILL'
      WHEN td_ref_host = 'locari.jp' THEN 'Locari'
      WHEN td_ref_host = 'radiko.jp' THEN 'radiko'
      WHEN td_ref_host = 'rajiko.jp' THEN 'radiko'
      WHEN td_ref_host = 'news.j-wave.co.jp' THEN 'radiko(News)'
      WHEN td_ref_host = 'news-radiko-jp.cdn.ampproject.org' THEN 'radiko(News)'
      WHEN td_ref_host = 'b.hatena.ne.jp' THEN 'Hatena'
      WHEN td_ref_host = 't.pia.jp' THEN 'PIA'      
      WHEN td_ref_host = 'www.spotifypremium.jp' THEN 'Spotify'
      WHEN td_ref_host LIKE '%wikipedia.org' THEN 'wikipedia'
      WHEN td_ref_host = 'www.inoreader.com' THEN '　Inoreader'
      WHEN td_ref_host = 'rsch.jp' THEN 'リサーチパネル'
      WHEN td_ref_host = 'tmall.wamgame.jp' THEN 'Tモール'
      WHEN td_ref_host = 'aramame.net' THEN 'あらまめ2ch'
      WHEN td_ref_host = 'uzulife.biz' THEN 'NAPBIZ'
      WHEN td_ref_host = 'ad-contents.jp' THEN '簡単レシピ動画まとめ'
      WHEN td_ref_host = 'app.couples.lv' THEN 'COUPLES'
      WHEN td_ref_host = 'pokemon-matome.net' THEN 'ぽけりん'
      WHEN td_ref_host = 'bakusai.com' THEN '爆サイ.com'
      WHEN td_ref_host = 'm.one.impact-ad.jp' THEN 'MarketOne'
      WHEN td_ref_host = 'p-birthday' THEN 'Petit Birthday'
      WHEN td_ref_host = 'ast.client.jp' THEN 'DIVINATION★LINK'
      WHEN td_ref_host = 'toutiao.com' THEN '今日头条'
      WHEN td_ref_host LIKE '%magazine-data.com' THEN 'ファッション雑誌ガイド'
      WHEN td_ref_host = 'patentsalon' THEN 'パテントサロン'
      WHEN td_ref_host LIKE '%macromill.com' THEN 'macromill' 
      WHEN td_ref_host LIKE '%msn.com' THEN 'msn'
      WHEN td_ref_host = 'taboola.com' THEN 'taboola'
      WHEN td_ref_host = 't.umblr' THEN 'tumblr'    
      WHEN td_ref_host = 'traffic.outbrain' THEN 'Outbrain'
      WHEN td_ref_host = 'paid.outbrain' THEN 'Outbrain(paid)'
      WHEN td_ref_host = 'search.myway.' THEN 'MyWay(search)'
      WHEN td_ref_host = 'search.ask' THEN 'ask'
      WHEN td_ref_host = 'workplace' THEN 'workplace'    
      WHEN td_ref_host = 'surveymonkey' THEN 'surveymonkey'
      WHEN td_ref_host = 'sansan.com' THEN 'sansan'
      WHEN td_ref_host = 'cybozu.co.jp' THEN 'cybozu'
      WHEN td_ref_host LIKE '%surveymonkey.com' THEN 'surveymonkey'
      WHEN td_ref_host = 'www.chance.com' THEN 'チャンスイット'    
      WHEN td_ref_host = 'mv-sp.gsj.bz' THEN 'ミュージック ヴィレッジ'
      WHEN td_ref_host = 'speee-ad.akamaized.net' THEN 'SPEEE AD'
      WHEN td_ref_host = 'content-click.amanad.adtdp.com' THEN 'adtech studio(CA)'
      WHEN td_ref_host = 'www.knshow.com' THEN '懸賞生活'
      WHEN td_ref_host = 'news.mixi.jp' THEN 'mixiニュース'
      WHEN td_ref_host = 'www.arugoworks.net' THEN 'Arugoworks'    
      WHEN td_ref_host = 'www.ghibli.jp' THEN 'スタジオジブリ'
      WHEN td_ref_host = 'news.mynavi.jp' THEN 'マイナビニュース'
      WHEN td_ref_host = 'blog.livedoor.jp' THEN 'ライブドアブログ'
      WHEN td_ref_host = 'www.e-nexco.co.jp' THEN 'NEXCO東日本'    
      WHEN td_ref_host = 'www.ken-kaku.com' THEN '懸賞当確'
      WHEN td_ref_host = 'news.ameba.jp' THEN 'アメーバニュース'
      WHEN td_ref_host = 'news.livedoor.com' THEN 'ライブドアニュース'
      WHEN td_ref_host = 'itest.5ch.net' THEN '5ちゃんねる'    
      WHEN td_ref_host = 'radiotuner.jp' THEN 'ラジオ局周波数 全国版'
      WHEN td_ref_host = 'www.yoku-ataru.com' THEN 'よく当たるコム'
      WHEN td_ref_host = 'www.1101.com' THEN 'ほぼ日刊イトイ新聞'
      WHEN td_ref_host = 'admin-official.line.me' THEN 'LINE'
      WHEN td_ref_host = 'lineblog.me' THEN 'LINEブログ'
      WHEN td_ref_host LIKE 'www.google.%' THEN 'Google(Other)'
      WHEN td_ref_host = '' THEN 'Non Referer' 
      WHEN NULL THEN 'Non Referer' 
      ELSE 'Others' 
    END AS td_referrer_name 
  FROM 
    t1
)


SELECT
  td_ref_host , 
  td_referrer_name ,
  COUNT(*) AS cnt
FROM 
  t2
WHERE 
  td_referrer_name ='Others'
GROUP BY 
  1,2
ORDER BY 
  cnt DESC
