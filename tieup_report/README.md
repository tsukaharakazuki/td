# はじめに

このWorkflowは、メディア企業向けにタイアップ広告レポートを半自動的に生成するWorkflowサンプルです。  
  
ECサイトの各商品ページごとのトラッキングなどにも応用可能です。
  
# 準備

## GTMでスクロール距離、Click計測の設定

通常のpageviewトラッキングとは別に、スクロール距離、クリックの計測を実施する必要があります。
  
データ取得の設定については、担当までお問い合わせください。

  
## TDへのdig/queryファイルアップロード

digファイル、queryファイルをダウンロードし、CLIからTD環境にアップロードしてください。
  
First, please upload your workflow project by `td wf push` command.
```
# Upload
$ td wf push tieup_report_processing
```

  
## 結果出力DBの作成

このサンプルでは`tie_up_report`というDBにデータを出力しています。

  
## 地図表示用対照表のアップロード

`jp_dev_mst.csv`をTDコンソールからデータベース`tie_up_report`にアップロードしてください。
  
TDのUDFでIPアドレスを分解すると、都道府県パースが可能ですが、ダッシュボードの地図で表示させるために表記揺れが存在します。こちらのデータで変換作業を取り込んでいます。
  
※すでにダッシュボード用などでアップロードしている場合、そちらのテーブルを指定してください。

```
  dev_mst_db: tie_up_report
  dev_mst_tb: jp_dev_mst
```
  
## データセット準備

`config/params.yml`にてWF環境におけるデータ定義をする必要があります。

- サンプル
```
---
user_id: user_id #ユーザーIDがある場合カラム名を指定
log_db: sample_log_db #ウェブログが蓄積されるDB名
log_tb: sample_log_tb #ウェブログが蓄積されるテーブル名
ls_db: tie_up_report
ls_tb: sample_tieup_list
ls_tmp: tieup_list_tmp #Googleスプレッドシートから送信されるリストデータの事前処理テーブル。GAS(GoogleAppScript)で指定しているtmpテーブルと揃える必要があります。
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

今回は`sample_tieup_list`というデータをGoogleスプレッドシートで作成し、TDにアップロードしています。
リストの中身は以下の構成で作成されています。
  
※`c-1`-`c-5`は記事よにっては全て指定しない場合があります。その場合は、`hoge`を入力してください。

```
article_id	-> td_pathの中からユニークに記事を特定できる文字列
start_date	-> 集計開始日 ※yyyy-MM-dd
end_date	-> 集計終了日 ※yyyy-MM-dd
db_client_name	-> table名に表示 ※アルファベット小文字a-z,[_]アンダーバーのみ
db_label	-> table名に表示 ※アルファベット小文字a-z,[_]アンダーバーのみ
c_1	-> クリックカウントの際にカウントするURL(今回は5個まで設定※増やすことも可能です。)
c_2	-> クリックカウントの際にカウントするURL
c_3	-> クリックカウントの際にカウントするURL
c_4	-> クリックカウントの際にカウントするURL
c_5	-> クリックカウントの際にカウントするURL
ls_page_url	-> ダッシュボード内で表示するURL
ls_client_name_jp	-> ダッシュボード内で表示するクライアント名 ※日本語可
ls_page_title	-> ダッシュボード内で表示する該当タイアップ記事タイトル ※日本語可
```
  
## GoogleスプレッドシートからTDに集計リストデータをアップロード
  
1.スクリプトエディタを選択
![スクリプトエディタ選択](https://github.com/tsukaharakazuki/image/blob/master/tieup_gs_1.png?raw=true "スクリプトエディタ")
  
[サンプルリスト](https://docs.google.com/spreadsheets/d/1uuwHBj_CSeaWT9JMWbdC8eewNEWrLQS1R8Lxp1yNEc0/edit?usp=sharing)
  
サンプルも公開しています。ポイントは全てstring(書式なしテキスト)形式で作成することです。 
  
2.GoogleAppScriptの編集
![スクリプトエディタ編集](https://github.com/tsukaharakazuki/image/blob/master/tieup_gs_2.png?raw=true "スクリプトエディタ編集")
  
3.GoogleAppScriptの実行
![スクリプトエディタ実行](https://github.com/tsukaharakazuki/image/blob/master/tieup_gs_3.png?raw=true "スクリプトエディタ実行")
  
初回実行次はGoogle認証が立ち上がります。認証をしていただくとスクリプトが動きますので完了です。2回目以降は実行のみでリストのアップロードが実行されます。
  
※特に実行完了等のポップアップは出ませんので、実行後はTDにデータアップロードされているか確認してください。`FluentD`でデータ送信を実行していますのでアペンドのみでのデータ転送になります。今回の処理では一度tmpテーブルにデータを送信し、Workflowでtmpテーブルのデータの有無を確認して処理の分かちをしています。リストが更新されていなくても毎日の処理に影響はございません。
  
# ダッシュボードの作成
  
今回はGoogleが提供するダッシュボードツール`データポータル`を使って可視化をしています。`TreasureReporting`での可視化も可能です。
  
可視化するデータは`Googleスプレッドシート`に格納しています。
  
[サンプルダッシュボード](https://datastudio.google.com/open/1OPjVTE12iBTv5Q8EAQ0Fi3eN1Rvqk_rU)
  
## データソースの接続とデータ型の変更

1. 作成をクリック
![作成をクリック](https://github.com/tsukaharakazuki/image/blob/master/datasauce_gs_01.png?raw=true "作成をクリック")
  
2. データソースをクリック
![データソースをクリック](https://github.com/tsukaharakazuki/image/blob/master/datasauce_gs_02.png?raw=true "データソースをクリック")

3. Googleスプレッドシートを選択
![Googleスプレッドシート](https://github.com/tsukaharakazuki/image/blob/master/datasauce_gs_03.png?raw=true "Googleスプレッドシート")

4. 接続情報
![接続情報](https://github.com/tsukaharakazuki/image/blob/master/datasauce_gs_04.png?raw=true "接続情報")

5. データ型の変更(時(hh)->数値)
![時(hh)->数値](https://github.com/tsukaharakazuki/image/blob/master/datasauce_gs_05.png?raw=true "時(hh)->数値")
　
6. レポートのサンプルからコピーしたいデータの設定
![コピー](https://github.com/tsukaharakazuki/image/blob/master/datasauce_gs_06.png?raw=true "コピー")
  
ダッシュボードはこちらからご確認ください。
[サンプルダッシュボードに移動](https://datastudio.google.com/open/1OPjVTE12iBTv5Q8EAQ0Fi3eN1Rvqk_rU)
  
## グラフ概要
  
1. 表紙(リストから表紙情報を取得し表示しています)
  
![表紙](https://github.com/tsukaharakazuki/image/blob/master/report_image_01.png?raw=true "表紙")
  
2. 概要シート(PV・UU、UAなど大まかなアクセスの概要を表示します。)
  
![概要](https://github.com/tsukaharakazuki/image/blob/master/report_image_02.png?raw=true "概要")
  
3. 流入元・遷移先・キーワード・カテゴリ(アクセスログから流入元・遷移先を集計。CDPの機能で分解したキーワードとカテゴリのランキングも掲載)
  
![流入元・遷移先・キーワード・カテゴリ](https://github.com/tsukaharakazuki/image/blob/master/report_image_03.png?raw=true "流入元・遷移先・キーワード・カテゴリ")
  
4. 読了(読了計測をしている場合、読了集計を表示)
  
![読了](https://github.com/tsukaharakazuki/image/blob/master/report_image_04.png?raw=true "読了")
  
5. ユーザー行動(タイアップ閲覧者のメディア内行動を集計)
  
![ユーザー行動](https://github.com/tsukaharakazuki/image/blob/master/report_image_05.png?raw=true "ユーザー行動")
  
6. 時間毎平均・読了(1日を24時間扱いで、時間毎の平均アクセスを集計)
  
![時間毎平均・読了](https://github.com/tsukaharakazuki/image/blob/master/report_image_06.png?raw=true "時間毎平均・読了")
  
7. クリック・曜日アクセス・PC/SP(クリック計測をしている場合、指定したクリックURL毎のカウント、曜日毎のアクセスを集計)
  
![クリック・曜日アクセス・PC/SP](https://github.com/tsukaharakazuki/image/blob/master/report_image_07.png?raw=true "クリック・曜日アクセス・PC/SP")
  
