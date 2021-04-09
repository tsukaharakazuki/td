SELECT 
  * 
FROM (
  VALUES 
    ('time', 'UNIXタイム', '1617807600') , 
    ('td_url', 'URL', 'https://www.hoge.co.jp') , 
    ('td_charset', '文字コード', 'utf-8') ,
    ('td_description', 'ディスクリプション', 'ディスクリプションの内容が入ります') ,
    ('td_browser_version', 'ブラウザバージョン', '89.0.4389') ,
    ('td_os', 'OS', 'Windows') ,
    ('td_ip', 'IPアドレス', '11.11.111.111') ,
    ('td_browser', 'ブラウザ情報', 'Mobile Safari') ,
    ('td_referrer', 'リファラURL', 'https://yahoo.co.jp/') ,
    ('td_version', 'td_js_sdkバージョン', '2.5.0') ,
    ('td_title', 'サイトタイトル', 'Webサイトのタイトル情報が入ります') ,
    ('td_language', 'PC言語設定', 'ja-jp') ,
    ('td_color', 'モニター色彩情報', '32-bit') ,
    ('td_os_version', 'OSバージョン', '11.1.0') ,
    ('td_user_agent', 'ユーザーエージェント', 'Mozilla/5.0 (iPhone; CPU iPhone OS 14_4 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) GSA/152.1.363973642 Mobile/15E148 Safari/604.1') ,
    ('td_platform', 'プラットフォーム', 'Win32') ,
    ('td_host', 'URLホスト', 'www.hoge.co.jp') ,
    ('td_path', 'URLパス', '/article/') ,
    ('td_screen', 'スクリーンサイズ', '800x600') ,
    ('td_client_id', '1st Party cookie(Docment Cookie)', 'cccccccc-9685-4eb1-9876-a1a1a1a1a1a1a') ,
    ('td_global_id', '3rd Party cookie(Docment Cookie)', 'gggggggg-9685-4eb1-9876-a1a1a1a1a1a1a') ,
    ('td_ssc_id', '1st Party cookie(Server Side Cookie)', '01F2QEABCAAAAAAAAAAAAAAAAA') ,
    ('td_viewport', 'ビューポイントサイズ', '480x790') 
    --追加がある場合以下に記入
    --入力例：, ('カラム名', '説明', 'サンプルデータ') 
    --, ('', '', '') 
) as cols(col_name, col_info, sample);