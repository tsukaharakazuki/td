# はじめに  
TDI(TresureData Insight)のDatamodelセットアップから、UI上で加工できるようにするための行程です。  

# 流れ  
1. `datamodel.yml`のファイル作成  
```
name: DATA_MODEL_NAME #名前を変更
apikey: "YOUR_TD_API_KEY" # Master API key for data ingestion
# elasticube or live, default elasticube for initial release, will only accept elasticube,
# possibly will need to accept live soon as we will expect to meet performance issue
type: elasticube
# will be deprecated but it's required now
schedule: dummy
# user email whom this datamodel should be shared with
shared_users:
#Data_modelをシェアしたいTDユーザーのアドレスを設定
  - hogehoge@hogehoge.com #自分のアカウントも入れる
datamodel:
  datasets:
    sample_datasets: # dataset name
      type: presto # only presot right now
      database: sample_datasets # database name
      tables:
        nasdaq: # table name
          columns:
            time:
              type: int
```
1. ディレクトリを`datamodel.yml`に移動し、以下を実行。（TDのAPI KEYをセット。）*Tokyoリージョンの場合はエンドポイントも変更。  
```
curl -X POST --data-urlencode "yaml=$(cat datamodel.yml)" \
-H 'Authorization: TD1 YOUR_TD_API_KEY' \
https://api.treasuredata.com/reporting/datamodels
```
この際、送信が成功した際に出力される`oid`を記録しておく。
1. Datamodel編集用のWorkflowファイルをインストール。  
1. Workflowの編集  
a. `tdi_create_dataset_from_specific_tables`の編集  
```
_export:
  td:
    database: YOUR_DATABASE #データの送信情報を保管するデータベース名
  conf:
    endpoint: "https://api.treasuredata.com" # OR "https://api.treasuredata.co.jp"
    dm_id: "YOUR_OID"　#oidを記載
    dbn: "tsuka_demo"
    timestamp_col: "'day'" #複数選択可(yyyy-MM-dd HH:mm:ss.z)Timestanpとして設定したいカラム名を記述
  !include : 'config/tables.yml'
```
  
b. `config/tables.yml`の編集  
```
targets:
- tbn: pageviews #追加したいテーブルを以下に記載
- tbn: clickviews
```
  
# 備考  
TDI自体はまだ未提供ですのでお待ちください。2020/10/08
