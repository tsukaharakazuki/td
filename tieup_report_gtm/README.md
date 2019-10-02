# はじめに

このWorkflowは、メディア企業向けにタイアップ広告のレポートを半自動的に生成するWorkflowサンプルです。  


# 準備

## GTMでスクロール距離、Click計測の設定

通常のpageviewトラッキングとは別で、スクロール距離、クリックの計測を実施する必要があります。
　
データ取得の設定については、担当までお問い合わせください。


## TDへのdig/queryファイルアップロード

digファイル、queryファイルをダウンロードいただき、CLIからTD環境にアップロードをお願いします。
　
First, please upload your workflow project by `td wf push` command.
```
# Upload
$ td wf push tieup_report_gtm
```


## 結果出力DBの作成

このサンプルでは`tie_up_report`というDBにデータを出力しています。


## 地図表示用対照表のアップロード

`jp_dev_mst.csv`をTDコンソールからデータベース`tie_up_report`にアップロードしてください。
　
TDのUDFでIPアドレスを分解すると、都道府県パースが可能ですが、ダッシュボードの地図で表示させるために表記揺れが存在します。こちらのデータで変換作業を取り込んでいます。
※すでにダッシュボード用などでアップロードしている場合、そちらを設定いただいても構いません。

## データセット準備

`_export:`にて環境におけるデータ定義をする必要があります。

- サンプル
```
_export:
  td:
    database: tie_up_report
  user_id: user_id #ユーザーIDがある場合カラム名を指定
  log_db: sample_log_db #ウェブログが蓄積されるDB名
  log_tb: sample_log_tb #ウェブログが蓄積されるテーブル名
  ls_db: tie_up_report
  ls_tb: tie_up_list
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

## 集計するページリストの準備

今回は`sample_tieup_list`というデータをcsvで作成し、TDに手動アップロードしています。
リストの中身は以下の構成で作成されています。
※`c-1`-`c-5`は記事のよっては全て指定しない場合があります。その場合は、`hoge`を記入してください。

```
article_id	-> td_pathの中からユニークに記事を特定できる文字列
start_date	-> 集計開始日
end_date	-> 集計終了日
db_client_name	-> table名に表示
db_label	-> table名に表示
c_1	-> クリックカウントの際にカウントするURL(今回は5個まで設定※増やすことも可能です。)
c_2	-> クリックカウントの際にカウントするURL(今回は5個まで設定※増やすことも可能です。)
c_3	-> クリックカウントの際にカウントするURL(今回は5個まで設定※増やすことも可能です。)
c_4	-> クリックカウントの際にカウントするURL(今回は5個まで設定※増やすことも可能です。)
c_5	-> クリックカウントの際にカウントするURL(今回は5個まで設定※増やすことも可能です。)
ls_page_url	-> ダッシュボード内で表示するURL
ls_client_name_jp	-> ダッシュボード内で表示するクライアント名
ls_page_title	-> ダッシュボード内で表示する該当タイアップ記事タイトル
```

## ダッシュボードの作成

今回はGoogleが提供するダッシュボードツール`データポータル`を使って可視化をしています。TDレポーティングなどでの可視化も可能です。
　
データの取得もとはdatatankを指定しています。
　
※datatankはTDが提供するPostgreSQL環境です。（Googleシートなどでも運用可能ですが、日時更新でリレーションが欠損するといった運用上の注意点が存在ます。）

[サンプルダッシュボード](https://datastudio.google.com/open/1MHYfrBTWqVa1nC-VRHhnzbAyPpVi7Uff)
