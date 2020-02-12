# はじめに
このWorkflowは、いくつかのネットワークから提供されるレポートを、整形しBIなどで可視化しやすい状態に加工するものです。

# 前提条件
1. サンプルは、`a`,`b`,`c`という3つのネットワークからレポートが提供されています。  
1. コンテンツのタイトルなどがネットワークごとに異なる想定で、一旦マスタを作成し、集計後にJOINするフローを採用しています。  

# config設定
`config/params.yml`で定義設定をしています.  

```
base_db: multi_report
list_db: list_database #リストが入っているDB
list_tb: list #リストのテーブル
interval: 7　#何日分の処理を実行するか。

↓ここで各ネットワークごとのカラム設定をしています。
network:
- name: a #ネットワーク名
  platform_id: 1111 #リストに存在するプラットフォーム判定ID
  tb: log_network_a #レポートの該当テーブル
  device_col: device #デバイスカラム
  key_id_col: id_a #どのコンテンツIDを採用するか
  view_col: view #Viewカラム
  imp_col: impression #Impカラム
  view_sec_col: seconds #閲覧時間カラム
- name: b
  platform_id: 2222
  tb: log_network_b
  device_col: device
  key_id_col: id_b
  view_col: view
  imp_col: impression
  view_sec_col: seconds
- name: c
  platform_id: 3333
  tb: log_network_c
  device_col: device
  key_id_col: id_c
  view_col: view
  imp_col: impression
  view_sec_col: seconds
```
