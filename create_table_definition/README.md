# はじめに  
このWorkflowはTreadureData内に存在するDatabase,Tableを参照し、カラムの説明とサンプルデータを追記したテーブル定義データを作成し、Googleスプレッドシートにシート別で出力するまでの一連の流れをまとめたWorkflowです。
  
#  Query設定  
## list_db_tbl.sql  
```
SELECT 
  table_schema AS database_name ,
  table_name 
FROM
  information_schema.columns
WHERE
  NOT regexp_like(table_schema,'cdp_audience')
  AND table_schema <> 'information_schema'
  --注意：他のWorkflowの実行タイミングなどで、中間テーブルなどが途中でDropされる場合エラーが出ることがあるので、モニタリング及スプレッドシート出力するテーブルは限定することを推奨
  AND table_schema = 'database1' --サンプルフィルタリング
GROUP BY
  1,2
ORDER BY
  1,2
```
  
`AND table_schema = 'database1' --サンプルフィルタリング`  
この部分に集計対象にしたいDatabaseやTableを追加していくことで集計対象データを絞ることが可能です。一連の処理は`information_schema`を使ってリストの読み込みを行っているため、Workflowが実行されたタイミングの全てのDatabaseが参照されてしまいます。そのため、他の処理が実行されている中で作られた中間テーブルなどが、この処理の途中でDropされる場合などでエラーが出るため、ここでのフィルタリングを推奨します。  

## p0001_columns_info.sql  
```
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
    ('td_client_id', '1st Party Cookie(Docment Cookie)', 'cccccccc-9685-4eb1-9876-a1a1a1a1a1a1a') ,
    ('td_global_id', '3rd Party Cookie(Docment Cookie)', 'gggggggg-9685-4eb1-9876-a1a1a1a1a1a1a') ,
    ('td_ssc_id', '1st Party cookie(Server Side Cookie)', '01F2QEABCAAAAAAAAAAAAAAAAA') ,
    ('td_viewport', 'ビューポイントサイズ', '480x790') 
    --追加がある場合以下に記入
    --入力例：, ('カラム名', '説明', 'サンプルデータ') 
    --, ('', '', '') 
) as cols(col_name, col_info, sample);
```
  
この処理は、テーブル横断でカラムの項目が共通になるデータの説明とサンプルデータを準備する処理です。すでに`td_js_sdk`で取得されるデフォルト項目の説明について、及、`time` については記載してあります。  

## p0101_columns_other_table_info.sql  
```
SELECT 
  * 
FROM (
  VALUES 
    ('database1', 'table1', 'col1', '説明1', 'サンプルデータ') 
    , ('database1', 'table1', 'col2', '説明2', 'サンプルデータ') 
    , ('database1', 'table2', 'col1', '説明3', 'サンプルデータ') 
    , ('database1', 'table2', 'col2', '説明4', 'サンプルデータ') 
    --カラムが追加になったら以下をコピペして追加していく
    --入力例：, ('データベース名', 'テーブル名', 'カラム名', '説明', 'サンプルデータ') 
    --, ('', '', '', '', '') 
) as cols(database_name, table_name, col_name, col_info, sample);
```
  
この処理は、Database,Tableごとに意味合いが異なるカラムの設定処理です。このデータ処理がメインになります。この処理は上記のようにSQLで作ることもできますが、`csv`や`Googleスプレッドシート`にマスタを用意しておいて、TreasureDataに取り込むフローに修正することも可能です。
  
## create_table_definition.dig  
Googleスプレッドシートへの出力設定  
```
+to_google_sheets:
  td_for_each>: config/list_db_tbl.sql
  _do:
    +dist_table_info:
      td>: queries/p9000_table_info.sql
      result_connection: YOUR_GOOGLE_SHEETS_CONNECTER_NAME
      result_settings:
        spreadsheet_folder: YOUR_GOOGLE_DRIVE_FOLDER_KEY
        spreadsheet_title: "TreasureData_テーブル定義書_${td.each.database_name}"
        sheet_title: "${td.each.table_name}"
        mode: truncate
```
この処理では2点変更ポイントがあります。  
`result_connection: YOUR_GOOGLE_SHEETS_CONNECTER_NAME`  
事前にデータカタログからスプレッドシートのコネクタを作成してください。その際に設定したコネクタの名前を記入してください。  
  
`spreadsheet_folder: YOUR_GOOGLE_DRIVE_FOLDER_KEY`  
送信するデータを格納するフォルダを設定することを推奨します。スプレッドシートのURLの末尾にフォルダIDが存在するのでそのIDを記載してください。  
`https://drive.google.com/drive/folders/`**1SFu-VlPzugAR0gru68SXMVAAAAAAAAAA**  
**1SFu-VlPzugAR0gru68SXMVAAAAAAAAAA**この部分がフォルダIDになります。  

# テーブルのレコードカウント  
処理の中で`cnt_record`というTableが作成されます。スプレッドシートに書き出す処理はいれていませんが、追加することは可能です。  
`all_record`というフラグで、集計対象になっているTableのレコードを足し上げた値が入るようになっています。
