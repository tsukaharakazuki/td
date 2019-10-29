# はじめに
  
このWorkflowは、処理前の会員データをCDPで使いやすい形に変換するものです。
  
合わせて、会員を集計し可視化するベース集計も実行します。
　　
# データセット準備
  
`_export:`にてWF環境におけるデータ定義をする必要があります。

- サンプル
```
_export:
  td:
    database: tie_up_report
  user_id: user_id #ユーザーIDがある場合カラム名を指定
  log_db: sample_log_db #ウェブログが蓄積されるDB名
  log_tb: sample_log_tb #ウェブログが蓄積されるテーブル名
  ls_db: tie_up_report
  ls_tb: sample_tieup_list
  click_db: sample_click_db #クリックログが蓄積されるDB名
  click_tb: sample_click_tb #クリックログが蓄積されるテーブル名
  click_col: click_url #クリックログが格納されるカラム名
  rd_db: sample_rd_db #読了ログが蓄積されるDB名
  rd_tb: sample_rd_tb #読了ログが蓄積されるテーブル名
  rd_col: scroll_depth_threshold #読了ログが格納されるカラム名
  dev_mst_db: tie_up_report
  dev_mst_tb: jp_dev_mst
  master_segment: 'xxxxx' #キーワード、興味関心カテゴリの付与をする場合、事前にMaster Segmentの作成
  check_host: www.treasuredata.co.jp #hostを指定する場合記入
  click_check: true #クリック集計を実行する場合>true　ない場合>false
  rd_check: true #読了率集計を実行する場合>true　ない場合>false
```

