# はじめに

このWorkflowは、ダッシュボード用の基礎データを集計するWorkflowのサンプルです。WeblogカラムにログインIDカラムがある場合は、ログインユーザーのPV/UUも集計可能です。

# 準備

## TDへのdig/queryファイルアップロード

First, please upload your workflow project by `td wf push` command.
```
# Upload
$ td wf push dashboard_wf
```

## 結果出力DBの作成

このサンプルでは`bi_report`というDBにデータを出力しています。

## 地図表示用対照表のアップロード

`jp_dev_mst.csv`をTDコンソールから`bi_report`にアップロードしてください。
TDのUDFでIPアドレスを分解すると、都道府県パースが可能ですが、ダッシュボードの地図で表示させるために表記揺れが存在します。こちらのデータで変換作業を取り込んでいます。

## データセット準備

このWorkflowセットは8つの異なるdigで構成されています。（実行スケジュールのタイミングが異なります）
それぞれ、`_export:`にて環境におけるデータ定義をする必要があります。

- サンプル
```
_export:
  td:
    database: bi_report
  log_database: sample #ウェブログが蓄積されるDB名
  log_table: sample #ウェブログが蓄積されるテーブル名
  user_id: user_id #ユーザーIDがある場合カラム名を指定
  dev_mst_db: bi_report
  dev_mst_tb: jp_dev_mst
  master_segment: xxxxx #キーワード、興味関心カテゴリの付与をする場合、事前にMaster Segmentの作成
  check_host: #hostを指定する場合記入
  ref_exception: #集計から除外する流入元を指定する場合記入
  login_check: false #true or false / ログインIDがある場合は true　ない場合は　false
```
