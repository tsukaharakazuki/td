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
  
可視化するデータは`datatank`に格納しています。
  
※datatankはTDが提供するPostgreSQL環境です。（Googleシートなどでも運用可能ですが、日時更新でリレーションが欠損するといった運用上の注意点が存在ます。）

[サンプルダッシュボード](https://datastudio.google.com/open/1Ee2RAukcUaFf4lzp43ieJamave6YUauJ)
  
## データソースの接続とデータ型の変更

1. PostgreSQLを選択
![データソース選択](https://github.com/tsukaharakazuki/image/blob/master/dataportal_1.png?raw=true "データソース")
  
2. Datatankとの接続設定
![接続設定](https://github.com/tsukaharakazuki/image/blob/master/dataportal_2.png?raw=true "データソース")

3. データ型の変更(hour_date)
![hour_date](https://github.com/tsukaharakazuki/image/blob/master/dataportal_3.png?raw=true "hour_date")

4. データ型の変更(uaip_div_name_en)
![uaip_div_name_en](https://github.com/tsukaharakazuki/image/blob/master/dataportal_4.png?raw=true "uaip_div_name_en")

5. データ型の変更(テキスト->数値)
![テキスト->数値](https://github.com/tsukaharakazuki/image/blob/master/dataportal_5.png?raw=true "テキスト->数値")
　
## グラフ設定

1. 概要シート(このシートでは、PV・UU、UAなど大まかなアクセスの概要を表示します。)
  
   1. 基礎情報：クライアント/タイトル/URL
    ![画像1](https://github.com/tsukaharakazuki/image/blob/master/dataportal_graph_1.png?raw=true "画像1")
    
   2. NULLを除去する必要があるので、以下の設定でフィルタ設定してください。
    ![画像2](https://github.com/tsukaharakazuki/image/blob/master/dataportal_graph_2.png?raw=true "画像2")
   
   3. PV/UU/平均読了時間
    ![画像３](https://github.com/tsukaharakazuki/image/blob/master/dataportal_graph_3.png?raw=true "画像３")   
   
   4. 時間毎のPV/UU推移
    ![画像4](https://github.com/tsukaharakazuki/image/blob/master/dataportal_graph_4.png?raw=true "画像4")  
   
   5. アクセス地域
    ![画像5](https://github.com/tsukaharakazuki/image/blob/master/dataportal_graph_5.png?raw=true "画像5")  
   
   6. カテゴリ/ブラウザ/OS
    ![画像6](https://github.com/tsukaharakazuki/image/blob/master/dataportal_graph_6.png?raw=true "画像6")     

2. 流入元・遷移先・興味関心シート
  
   1. 流入元・遷移先・キーワード
    ![画像7](https://github.com/tsukaharakazuki/image/blob/master/dataportal_graph_7.png?raw=true "画像7") 
    
   2. 関心カテゴリ
    ![画像8](https://github.com/tsukaharakazuki/image/blob/master/dataportal_graph_8.png?raw=true "画像8")    
  
3. 読了率シート
  
   1. 読了率
    ![画像9](https://github.com/tsukaharakazuki/image/blob/master/dataportal_graph_9.png?raw=true "画像9")   
  
4. 閲覧者記事分析
  
   1. 該当記事閲覧者のメディア内記事閲覧カウント
    ![画像10](https://github.com/tsukaharakazuki/image/blob/master/dataportal_graph_10.png?raw=true "画像10")  
  
5. 時間帯毎平均閲覧・読了シート（このシートは2つのグラフを重ねて表現しています）
  
   1. 平均PV（棒グラフ）
    ![画像11](https://github.com/tsukaharakazuki/image/blob/master/dataportal_graph_11.png?raw=true "画像11")  
  
   2. 平均読了率（折れ線グラフ）
    ![画像12](https://github.com/tsukaharakazuki/image/blob/master/dataportal_graph_12.png?raw=true "画像12")  
  
6. クリック集計シート
  
   1. クリック集計
    ![画像13](https://github.com/tsukaharakazuki/image/blob/master/dataportal_graph_13.png?raw=true "画像13")  
