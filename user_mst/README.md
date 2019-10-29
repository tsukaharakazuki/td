# はじめに
  
このWorkflowは、処理前の会員データをCDPで使いやすい形に変換するものです。
  
合わせて、会員を集計し可視化するベース集計も実行します。
　　
# データセット準備
  
`_export:`にてWF環境におけるデータ定義をする必要があります。

- サンプル
```
_export:
  td:
    database: user_mst　#結果出力DB
  user_mst_db: user_data　#処理前の会員データ保存DB
  user_mst_tb: base_user_data　#処理前の会員データテーブル
  id: id　#会員IDカラム(JSでアクセスログから取得するID)
  email: email #e-mailカラム
  birthday: birthday #誕生日カラム
  sex: sex #性別カラム
  regist_day: regist_day #会員登録日カラム
  prefecture: prefecture #都道府県カラム
  address_1: address_1 #住所カラム
  address_2: address_2 #住所カラム
  address_3: address_3 #住所カラム
  first_name: first_name #性カラム
  last_name: last_name #名カラム
  phone: phone #電話番号カラム
  zip_code: zip_code #郵便番号カラム
```
  
今回のサンプルでは以下のようなデータセットを変換しています。企業ごとに会員データの持ち方は変わりますので、queryの変更は必要です。
  
[サンプルデータセット:base_user_data](https://github.com/tsukaharakazuki/td/blob/master/user_mst/base_user_data.csv)
  
# データ加工のポイント
  
今回のサンプルでは以下の変換を実施しています。
  
- id
  
'1' -> '00000001'
  
アクセスログとJOINするために、全ての桁巣を８桁に揃えています。


