WITH t1 AS (
  SELECT
    time ,
    TD_SESSIONIZE_WINDOW(time, ${session_term}) OVER (PARTITION BY ${media.primary_cookie} ORDER BY time) AS session_id ,
    IF(${media.primary_cookie} is not NULL, ${media.primary_cookie}, td_client_id) AS cookie ,
    td_client_id ,
    td_global_id ,
    ${media.check_td_ssc_id}  td_ssc_id ,
    ${media.check_user_id}  ${media.user_id} AS user_id ,
    url_extract_parameter(td_url, 'utm_campaign') AS utm_campaign ,
    url_extract_parameter(td_url, 'utm_medium') AS utm_medium ,
    url_extract_parameter(td_url, 'utm_source') AS utm_source ,
    url_extract_parameter(td_url, 'utm_term') AS utm_term , 
    td_referrer ,
    url_extract_host(td_referrer) AS td_ref_host ,
    td_url ,
    url_extract_host(td_url) AS td_host ,
    url_extract_path(td_url) AS td_path ,
    td_title ,
    td_description ,
    td_ip ,
    td_os ,
    td_user_agent ,
    td_browser ,
    td_screen ,
    td_viewport , 
    element_at(TD_PARSE_AGENT(td_user_agent), 'os') AS os ,
    element_at(TD_PARSE_AGENT(td_user_agent), 'vendor') AS vendor ,
    element_at(TD_PARSE_AGENT(td_user_agent), 'os_version') AS os_version ,
    element_at(TD_PARSE_AGENT(td_user_agent), 'name') AS browser ,
    element_at(TD_PARSE_AGENT(td_user_agent), 'category') AS category ,
    TD_IP_TO_COUNTRY_NAME(td_ip) AS country ,
    TD_IP_TO_LEAST_SPECIFIC_SUBDIVISION_NAME(td_ip) AS prefectures ,
    TD_IP_TO_CITY_NAME(td_ip) AS city                    
  FROM
    ${media.log_db}.${media.log_tb}
  WHERE
    TD_INTERVAL(time, '-1h', 'JST') AND
    TD_PARSE_AGENT(td_user_agent) ['category'] <> 'crawler' AND
    td_client_id != '00000000-0000-4000-8000-000000000000' AND
    NOT regexp_like(td_browser, '^(?:Googlebot(?:-.*)?|BingPreview|bingbot|YandexBot|PingdomBot)$') AND
    td_host != 'gtm-msr.appspot.com' AND
    td_client_id is not NULL AND
    td_client_id <> 'undefined'
    ${check_js_extension} AND action='view' AND category='page' 
)


SELECT
  time ,
  '${media.media_name}' AS media_name ,
  session_id ,
  row_number() over (partition by session_id order by time ASC) AS session_num ,
  cookie ,
  td_client_id ,
  td_global_id ,
  ${media.check_td_ssc_id}  td_ssc_id ,
  ${media.check_user_id}  user_id ,
  utm_campaign ,
  utm_medium ,
  utm_source ,
  utm_term ,
  td_referrer ,
  td_ref_host ,
  CASE
    WHEN td_ref_host = 'sin.creativecdn.com' THEN 'sin.creativecdn.com'
    WHEN td_ref_host = 'ads.as.criteo.com' THEN 'criteo'
    WHEN td_ref_host = 'mall.pitsquare.jp' THEN 'もらっトク！モール'
    WHEN td_ref_host = 'criteo.com' THEN 'criteo'
    WHEN td_ref_host = 'aax-fe-sin.amazon-adsystem.com' THEN 'Amazon'
    WHEN td_ref_host = 'www.jr-tgm.com' THEN 'JR Takashimaya GATETOWER MALL'
    WHEN td_ref_host = 'www.porta.co.jp' THEN 'Porta京都駅地下街'
    WHEN td_ref_host = 'www.0101.co.jp' THEN 'OIOI'
    WHEN td_ref_host = 'www.ginza-inz.co.jp' THEN 'GINZA INZ'
    WHEN td_ref_host = 'paid.outbrain.com' THEN 'outbrain'
    WHEN td_ref_host = 'outlook.live.com' THEN 'Outlook'
    WHEN td_ref_host = 'www.go1buy1.com' THEN 'Go1Buy1'
    WHEN td_ref_host = 'www.lumine.ne.jp' THEN 'LUMINE'
    WHEN td_ref_host = 'emifull.jp' THEN 'エミフルMASAKI'
    WHEN td_ref_host = 'connect.auone.jp' THEN 'auone'
    WHEN td_ref_host = 'mitsui-shopping-park.com' THEN '三井ショッピングパーク'
    WHEN td_ref_host = 'www.tenchika.com' THEN '天神地下街'
    WHEN td_ref_host = 'sbd-chat.ok-sky.com' THEN 'WEB接客OK SKY'
    WHEN td_ref_host = 's.kakaku.com' THEN '価格.com'
    WHEN td_ref_host = 'payments.amazon.co.jp' THEN 'amazon pay'
    WHEN td_ref_host = 'adtdp.com' THEN 'adtecstudio|サイバーエージェント'
    WHEN td_ref_host = 'fep.sps-system.com' THEN 'クレジットカード(SBPS)'
    WHEN td_ref_host = 'www.rebates.jp' THEN 'Rakuten Rebates'
    WHEN td_ref_host = 'www.lucua.jp' THEN 'LUCUA osaka'
    WHEN td_ref_host = 'www.e-paseode.com' THEN 'JP TOWER paseo'
    WHEN td_ref_host = '4meee.com' THEN '4MEEE'
    WHEN td_ref_host = 'www.takasakitb.co.jp' THEN 'TAKASAKI TERMINAL BUILDING'
    WHEN td_ref_host = 'admin.karte.io' THEN 'Karte'
    WHEN td_ref_host = 'sun-ste.com' THEN 'さんすて'
    WHEN td_ref_host = 'ad.as.amanad.adtdp.com' THEN 'adtecstudio|サイバーエージェント'
    WHEN td_ref_host = 'www.karuizawa-psp.jp' THEN '軽井沢プリンスショッピングプラザ'
    WHEN td_ref_host = 'www.h-sanbangai.com' THEN '阪急三番街'
    WHEN td_ref_host = 'www.stellarplace.net' THEN 'JP TOWER STELLAR PLACE'
    WHEN td_ref_host = 'www.atre.co.jp' THEN 'Atre'
    WHEN td_ref_host = 'mail.ocn.jp' THEN 'OCNメール'
    WHEN td_ref_host = 'tamaru.eposcard.co.jp' THEN 'EPOSポイントUPサイト'
    WHEN td_ref_host = 'www.ge-tokorozawa.com' THEN 'Grand Emio'
    WHEN td_ref_host = 'www.fesan-jp.com' THEN '盛岡駅ビルフェザン'
    WHEN td_ref_host = 'search.kakaku.com' THEN '価格.com'
    WHEN td_ref_host = 'www.nambacity.com' THEN 'namba CITY nankai'
    WHEN td_ref_host = 'keihan-mall.jp' THEN '京阪モール'
    WHEN td_ref_host = 'trc.taboola.com' THEN 'taboola'
    WHEN td_ref_host = 'creativecdn.com' THEN 'RTBHOUSE'
    WHEN td_ref_host = 'wm.sso.biglobe.ne.jp' THEN 'Biglobe'
    WHEN td_ref_host = 'www.granduo.jp' THEN 'グランデュオ'
    WHEN td_ref_host = 'admin.voice.zetacx.net' THEN 'ZETA VOICE|Admin'
    WHEN td_ref_host = 'kakaku.com' THEN '価格.com'
    WHEN td_ref_host = 'kuzuha-mall.com' THEN 'KUZUHA MALL'
    WHEN td_ref_host = 'riverside-senshu.com' THEN 'RIVERSIDE SENSHU'
    WHEN td_ref_host = 'karte-talk.io' THEN 'Karte'
    WHEN td_ref_host = 'themallsendai.com' THEN 'THE MALL仙台長町'
    WHEN td_ref_host = 'portal.auone.jp' THEN 'auone'
    WHEN td_ref_host = 'www.tennoji-mio.co.jp' THEN 'MIO TENNOJI'
    WHEN td_ref_host = 'www.mozo-wondercity.com' THEN 'mozo wonder city'
    WHEN td_ref_host = 'tsukuba.iias.jp' THEN 'iias TSUKUBA'
    WHEN td_ref_host = 'www.parche.co.jp' THEN 'JR静岡駅ビルPARCHE'
    WHEN td_ref_host = 'shonan.terracemall.com' THEN 'TerraceMall湘南'
    WHEN td_ref_host = 'okazaki-aeonmall.com' THEN 'イオンモール岡崎'
    WHEN td_ref_host = 'go1buy1.com' THEN 'Go1Buy1'
    WHEN td_ref_host = 'yappli.plus' THEN 'Yappli'
    WHEN td_ref_host = 'www2.fashion-guide.jp' THEN 'FASHION(繊維/流行)GUIDE'
    WHEN td_ref_host LIKE '%google%' THEN 'Google'
    WHEN td_ref_host LIKE '%doubleclick%' THEN 'Google'
    WHEN td_ref_host = 'ampproject.org' THEN 'Google'
    WHEN td_ref_host LIKE '%google.android%' THEN 'Android'
    WHEN td_ref_host LIKE '%youtube%' THEN 'YouTube'
    WHEN td_ref_host LIKE '%yahoo%' THEN 'Yahoo!'
    WHEN td_ref_host = 's.yimg.jp' THEN 'Yahoo!'
    WHEN td_ref_host = 'yimg.jp' THEN 'Yahoo!'
    WHEN td_ref_host = 't.co' THEN 'Twitter'
    WHEN td_ref_host LIKE '%twitter%' THEN 'Twitter'
    WHEN td_ref_host LIKE '%facebook%' THEN 'Facebook'
    WHEN td_ref_host = 'l.messenger.com' THEN 'Facebook'
    WHEN td_ref_host LIKE '%instagram%' THEN 'Instagram'
    WHEN td_ref_host LIKE '%bing%' THEN 'bing'
    WHEN td_ref_host LIKE '%docomo%' THEN 'Docomo'
    WHEN td_ref_host = 'sp-web.search.auone.jp' THEN 'au'
    WHEN td_ref_host LIKE '%pinterest%' THEN 'Pinterest'
    WHEN td_ref_host = 'www.smartnews.com' THEN 'SmartNews'
    WHEN td_ref_host = 'gunosy.com' THEN 'gunosy'
    WHEN td_ref_host LIKE '%rakuten.co.jp' THEN 'Rakuten'
    WHEN td_ref_host = 'mobss.jword.jp' THEN 'jword'   
    WHEN td_ref_host = 'jwsearch.jword.jp' THEN 'jword'  
    WHEN td_ref_host LIKE '%line.me' THEN 'LINE'
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
    WHEN td_ref_host = '%ocn.jp' THEN 'Ocn'
    WHEN td_ref_host = 'googleads.g.doubleclick.net' THEN 'GoogleAds'
    WHEN td_ref_host = 'duckduckgo.com' THEN 'DuckDuckGo'
    WHEN td_ref_host = 'nortonsafe.search.ask.com' THEN 'NortonSafeSearch'
    WHEN td_ref_host = 'feedly.com' THEN 'Feedly'    
    WHEN td_ref_host = 'com.twitpane' THEN 'TwitPane'    
    WHEN td_ref_host = 'www.linkedin.com' THEN 'Linkedin'
    WHEN td_ref_host = 'note.com' THEN 'Note'  
    WHEN td_ref_host = 'note.mu' THEN 'Note'
    WHEN td_ref_host = 'com.slack' THEN 'slack'
    WHEN td_ref_host LIKE '%popin.cc' THEN 'popIn'
    WHEN td_ref_host LIKE '%logly.co.jp' THEN 'LOGLY'
    WHEN td_ref_host = 'transition.meltwater.com' THEN 'Meltwater'  
    WHEN td_ref_host = 'may.2chan.net' THEN 'ふたばちゃんねる'  
    WHEN td_ref_host = 'ameblo.jp' THEN 'ameblo' 
    WHEN td_ref_host = 'prtimes.jp' THEN 'PR TIMES'    
    WHEN td_ref_host = 'prtimes-jp.cdn.ampproject.org' THEN 'PR TIMES'   
    WHEN td_ref_host = 'trilltrill.jp' THEN 'TRILL'
    WHEN td_ref_host = 'locari.jp' THEN 'Locari'
    WHEN td_ref_host = 'radiko.jp' THEN 'radiko'
    WHEN td_ref_host = 'rajiko.jp' THEN 'radiko'
    WHEN td_ref_host = 'news-radiko-jp.cdn.ampproject.org' THEN 'radiko'
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
    WHEN td_ref_host LIKE '%magazine-data.com' THEN 'ファッション雑誌ガイド'
    WHEN td_ref_host = 'patentsalon' THEN 'パテントサロン'
    WHEN td_ref_host LIKE '%macromill.com' THEN 'macromill' 
    WHEN td_ref_host LIKE '%msn.com' THEN 'msn'
    WHEN td_ref_host = 'taboola.com' THEN 'taboola'
    WHEN td_ref_host = 't.umblr' THEN 'tumblr'    
    WHEN td_ref_host LIKE '%outbrain' THEN 'Outbrain'
    WHEN td_ref_host = 'search.myway.com' THEN 'MyWay'
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
    WHEN td_ref_host = 'com.Slack' THEN 'slack'
    WHEN td_ref_host LIKE '%toutiao.com' THEN '今日头条'
    WHEN td_ref_host LIKE 'woman-excite-co-jp%' THEN 'ウーマンエキサイト'
    WHEN td_ref_host = 'lin.ee' THEN 'LINE'
    WHEN td_ref_host = 'ima.goo.ne.jp' THEN 'goo いまトピ'
    WHEN td_ref_host = '' THEN 'Non Referer' 
    WHEN td_ref_host is NULL THEN 'Non Referer' 
    ELSE 'Others' 
  END AS td_ref_name ,
  CASE
    WHEN td_ref_host = 'google.com' THEN 'com'
    WHEN td_ref_host = 'www.google.com' THEN 'com'
    WHEN td_ref_host = 'googleapis.com' THEN 'com'
    WHEN td_ref_host = 'google.co.jp' THEN 'jp'
    WHEN td_ref_host = 'www.google.co.jp' THEN 'jp'
    WHEN td_ref_host = 'cse.google.com' THEN 'CustomeSearch'
    WHEN td_ref_host = 'cse.google.co.jp' THEN 'CustomeSearch'
    WHEN td_ref_host = 'news.google.com' THEN 'News'
    WHEN td_ref_host = 'www.googleapis.com' THEN 'ChromeApp'
    WHEN td_ref_host = 'translate.googleusercontent.com' THEN 'Translate'
    WHEN td_ref_host = 'mail.google.com' THEN 'GMail'
    WHEN td_ref_host = 'ampproject.org' THEN 'Amp'
    WHEN td_ref_host = 'googleads.g.doubleclick.net' THEN 'GoogleAds'
    WHEN td_ref_host = 'tpc.googlesyndication.com' THEN 'GoogleAds'
    WHEN td_ref_host = 'doubleclick.net' THEN 'GoogleAds'
    WHEN td_ref_host = 'www.googleadservices.com' THEN 'GoogleAds'
    WHEN td_ref_host = 'secureframe.doubleclick.net' THEN 'GoogleAds'
    WHEN td_ref_host = 'ads.google.com' THEN 'GoogleAds'
    WHEN td_ref_host = 'partner.googleadservices.com' THEN 'GoogleAds'
    WHEN td_ref_host LIKE '%safeframe.googlesyndication.com' THEN 'GoogleAds'
    WHEN td_ref_host LIKE '%adspreview.googleusercontent.com' THEN 'GoogleAds'
    WHEN td_ref_host = 'search.yahoo.co.jp' THEN 'Search'
    WHEN td_ref_host = 'r.search.yahoo.com' THEN 'Search'
    WHEN td_ref_host = 'search.yahoo.com' THEN 'Search'
    WHEN td_ref_host = 'headlines.yahoo.co.jp' THEN 'Headlines'
    WHEN td_ref_host = 'mail.yahoo.co.jp' THEN 'Mail'
    WHEN td_ref_host LIKE '%mail.yahoo.co.jp' THEN 'Mail'
    WHEN td_ref_host = 'news.yahoo.co.jp' THEN 'News'
    WHEN td_ref_host = 's.yimg.jp' THEN '画像'
    WHEN td_ref_host = 'yimg.jp' THEN '画像'
    WHEN td_ref_host = 'auctions.yahoo.co.jp' THEN 'ヤフオク'
    WHEN td_ref_host LIKE '%.search.yahoo.com' THEN 'Search'
    WHEN td_ref_host = 'l.messenger.com' THEN 'Messenger'
    WHEN td_ref_host = 'news.line.me' THEN 'News'
    WHEN td_ref_host = 'mail.ocn.jp' THEN 'Mail'
    WHEN td_ref_host = 'dsp.logly.co.jp' THEN 'DSP'
    WHEN td_ref_host = 'news-radiko-jp.cdn.ampproject.org' THEN 'News'
    WHEN td_ref_host = 'paid.outbrain' THEN 'Paid'
    ELSE NULL
  END AS td_ref_name_sub ,
  td_url ,
  td_host||td_path AS article_key ,
  td_host ,
  td_path ,
  td_title ,
  td_description ,
  td_ip ,
  td_os ,
  td_user_agent ,
  td_browser ,
  td_screen ,
  td_viewport ,
  os ,
  vendor ,
  os_version ,
  browser ,
  category ,
  country ,
  prefectures ,
  CASE
    WHEN prefectures = 'Aichi' THEN 'Aichi'
    WHEN prefectures = 'Akita' THEN 'Akita'
    WHEN prefectures = 'Aomori' THEN 'Aomori'
    WHEN prefectures = 'Ehime' THEN 'Ehime'
    WHEN prefectures = 'Gifu' THEN 'Gifu'
    WHEN prefectures = 'Gunma' THEN 'Gunma'
    WHEN prefectures = 'Hiroshima' THEN 'Hiroshima'
    WHEN prefectures = 'Hokkaido' THEN 'Hokkaido'
    WHEN prefectures = 'Fukui' THEN 'Fukui'
    WHEN prefectures = 'Fukuoka' THEN 'Fukuoka'
    WHEN prefectures = 'Fukushima-ken' THEN 'Fukushima'
    WHEN prefectures = 'Hyōgo' THEN 'Hyogo'
    WHEN prefectures = 'Ibaraki' THEN 'Ibaraki'
    WHEN prefectures = 'Ishikawa' THEN 'Ishikawa'
    WHEN prefectures = 'Iwate' THEN 'Iwate'
    WHEN prefectures = 'Kagawa' THEN 'Kagawa'
    WHEN prefectures = 'Kagoshima' THEN 'Kagoshima'
    WHEN prefectures = 'Kanagawa' THEN 'Kanagawa'
    WHEN prefectures = 'Kochi' THEN 'Kochi'
    WHEN prefectures = 'Kumamoto' THEN 'Kumamoto'
    WHEN prefectures = 'Kyoto' THEN 'Kyoto'
    WHEN prefectures = 'Mie' THEN 'Mie'
    WHEN prefectures = 'Miyagi' THEN 'Miyagi'
    WHEN prefectures = 'Miyazaki' THEN 'Miyazaki'
    WHEN prefectures = 'Nagano' THEN 'Nagano'
    WHEN prefectures = 'Nagasaki' THEN 'Nagasaki'
    WHEN prefectures = 'Nara' THEN 'Nara'
    WHEN prefectures = 'Niigata' THEN 'Niigata'
    WHEN prefectures = 'Oita' THEN 'Oita'
    WHEN prefectures = 'Okayama' THEN 'Okayama'
    WHEN prefectures = 'Okinawa' THEN 'Okinawa'
    WHEN prefectures = 'Ōsaka' THEN 'Osaka'
    WHEN prefectures = 'Saga' THEN 'Saga'
    WHEN prefectures = 'Saitama' THEN 'Saitama'
    WHEN prefectures = 'Shiga' THEN 'Shiga'
    WHEN prefectures = 'Shimane' THEN 'Shimane'
    WHEN prefectures = 'Shizuoka' THEN 'Shizuoka'
    WHEN prefectures = 'Chiba' THEN 'Chiba'
    WHEN prefectures = 'Tochigi' THEN 'Tochigi'
    WHEN prefectures = 'Tokushima' THEN 'Tokushima'
    WHEN prefectures = 'Tokyo' THEN 'Tokyo'
    WHEN prefectures = 'Tottori' THEN 'Tottori'
    WHEN prefectures = 'Toyama' THEN 'Toyama'
    WHEN prefectures = 'Wakayama' THEN 'Wakayama'
    WHEN prefectures = 'Yamagata' THEN 'Yamagata'
    WHEN prefectures = 'Yamaguchi' THEN 'Yamaguchi'
    WHEN prefectures = 'Yamanashi' THEN 'Yamanashi'
    ELSE prefectures
  END map_prefectures ,
  city 
FROM
  t1
