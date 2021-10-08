# 説明　　
このWorkflowは、TreasureDataのデータコネクターで外部にデータを送信する際に、データ量が大きすぎて送信できない場合に使うWorkflowです。  
  
# 構成　　
1. 送信データが`TD_TIME_RANGE`で日時で分割できる場合の送信
  
2. 送信するデータにtimeカラムでの分割処理ができない場合、NTILE関数でランダムで各レコードに番号をふり、送信していきます。Window関数を使用している都合上、データ量が膨大な場合処理に時間がかかります。
  
# 変数設定  
```
  td:
    database: td_sandbox  →各処理データが格納されるデータベース名
  db: DATABASE_NAME　→送信元になるデータのデータベース名
  tbl: TABLE_NAME　→送信元になるデータテーブル名
  cols: time,td_ssc_id　→送信するカラム名をカンマ区切りで記載
  use_time_range: true　→TD_TIME_RANGEで分割できる場合true,できない場合false
  non_time_range:　→以下の設定はTIME_RANGEで分割できない場合設定する項目です
  - table_snippet: send_data_20211008　→中間テーブル用のTABLE_NAME用
    start_date: 2020-10-01　→送信するデータの集計スタート日時
    end_date: 2021-10-08　→送信するデータの集計エンド日時
    tile_num: 10　→分割数
```
　　
# TILEで分割する場合の注意  
`query/create_send_data.sql`でデータの分割をしています。このWorkflowサンプルは送信するデータも時系列データで取得する前提でSQL構成されていますが、送信したいデータに合わせて適宜こちらのSQLを変更してください。
  
# Connectorの設定  
今回のサンプルはBigqueryコネクタでデータを送信する場合のサンプルです。適宜コネクタに合わせて変更してください。  
設定サンプルは以下をご参照ください。  
https://github.com/treasure-data/treasure-boxes/tree/master/td
