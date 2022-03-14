# はじめに  
このWorkflowは`td_js_sdk`で取得したWebアクセスログを加工し、その後の集計などがしやすいように加工するものです。  

# 変数設定  
`config/params.yml`で集計する該当データの変数設定をしてください。  
この処理で、`td_cookie`という1stPartyCookieを優先順位で組み直されたカラムが生成されます。サーバーサイドCookieを取得している場合は下記の設定のままでいいですが、取得していない場合は、任意の1stPartyCookieを`primary_cookie`,`sub_cookie`に指定してください。
```
proc_firsttime: true #WFの初回実行
session_term: 1800 #秒数→セッショナイズする間隔設定
media:
  sample_1: #このパラメータは集計には関係ないですが、わかりやすいサイト名などを指定してください。
    media_name: sample_1 #集計されたデータ内にmedia_nameカラムが追加されます。その中に入る値です。（日本語可）
    firsttime_flag: true #true or false #trueにすると、過去文含めたすべてのデータの再集計をします。
    regular_span: 1h #定期実行（regular）処理で実行される期間指定です。1h->1時間 or 1d->1日 スケジューリングの設定を合わせて実装ください。
    # Pageviwe設定
    log_db: YOUR_WEB_LOG_DB #set web_log database
    log_tb: YOUR_WEB_LOG_TB #set web_log table
    primary_cookie: td_ssc_id #td_ssc_id or td_client_id
    sub_cookie: td_client_id
    td_ssc_id: td_ssc_id #td_ssc_id未取得の場合 "''"
    user_id: user_id #set user_id column未取得の場合 "''"
    pv_columns:
      columns:
        - text #追加カラムがない場合未記載
    # Click設定
    check_click: true
    click_db: YOUR_CLICK_LOG_DB
    click_tb: YOUR_CLICK_LOG_TB
    click_col: click_url
    primary_cookie_click: td_ssc_id #td_ssc_id or td_client_id
    sub_cookie_click: td_client_id
    td_ssc_id_click: td_ssc_id #td_ssc_id未取得の場合 "''"
    user_id_click: "''" #set user_id column未取得の場合 "''"
    click_columns:
      columns:
        - text #追加カラムがない場合未記載
    # 読了設定
    check_read: true
    read_db: YOUR_READ_LOG_DB
    read_tb: YOUR_READ_LOG_TB
    read_col: scroll_depth_threshold
    primary_cookie_read: td_ssc_id #td_ssc_id or td_client_id
    sub_cookie_read: td_client_id
    td_ssc_id_read: td_ssc_id #td_ssc_id未取得の場合 "''"
    user_id_read: "''" #set user_id column未取得の場合 "''"
    read_columns:
      columns:
        - text #追加カラムがない場合未記載
    # 設定したすべてのカスタムカラム設定
    all_columns:
      columns:
        - click_url # クリック集計している場合
        #- read # 読了集計している場合
        - text #追加カラムがない場合未記載
```
  
# 出力カラム. 
| カラム名| 内容 |
----|---- 
|time|アクセスされたunixtime|
|media_name|変数で指定したメディア名|
|td_data_type|pageview or click or read|
|access_date_time|YYYY-MM-DD HH:mm:ss|
|access_date|YYYY-MM-DD|
|access_hour|HH|
|week|週番号|
|diw|曜日|
|ampm|AM or PM|
|session_start_time|セッション開始unixtime|
|session_end_time|セッション終了unixtime|
|session_id|セッションID|
|session_num|セッション番号|
|td_cookie|集約された1stPartyCookie|
|td_client_id|td_client_id|
|td_global_id|td_global_id|
|td_ssc_id|td_ssc_id|
|user_id|変数で指定したユーザーIDカラムの内容|
|utm_campaign|URLパラメータから分解したutm_campaign|
|utm_medium|URLパラメータから分解したutm_medium|
|utm_source|URLパラメータから分解したutm_source|
|utm_term|URLパラメータから分解したutm_term|
|td_source|CASE文で振り分けたソース情報|
|td_medium|CASE文で振り分けたメディア情報|
|td_referrer|生のリファラ|
|td_ref_host|リファラのホスト|
|td_ref_name|CASE文で振り分けたリファラ情報|
|td_ref_name_sub|CASE文で振り分けたリファラ情報|
|td_url|URL|
|article_key|host + path|
|td_host|HOST|
|td_path|PATH|
|td_title|ページタイトル|
|td_description|ページディスクリプション|
|td_ip|IPアドレス|
|td_os|OS|
|td_user_agent|ユーザーエージェント|
|td_browser|ブラウザ|
|td_screen|スクリーンサイズ|
|td_viewport|ビューサイズ|
|ua_os|ユーザーエージェントから抽出したOS|
|ua_vendor|ユーザーエージェントから抽出したベンダー|
|ua_os_version|ユーザーエージェントから抽出したOSバージョン|
|ua_browser|ユーザーエージェントから抽出したブラウザ|
|ua_category|pc or smartphone|
|ip_country|IPアドレスから分解した国名|
|ip_prefectures|IPアドレスから分解した都道府県名|
|ip_city|IPアドレスから分解した都市名|
|click_url|変数で指定したクリックURLカラム|
  
# 追加推奨  
pathの情報などで分類できる記事分類などがあれば、このWorkflowで分解しておくことで集計しやすい状態にしておくことができます。
