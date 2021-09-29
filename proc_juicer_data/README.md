# 説明
  
このWorkflowは、Juicerから提供を受ける3rdPartyDataの月次集計処理用です。  
初回データについては、すでに提供を受けている分について、`union_hoge`のSQLに一括で記載していただくことで過去データ分のプロセッシングを実行します。以降は毎月20日に追加分の差分処理を実行します。  
`agg_hogehoge`というTableが最終的なアウトプットTableになります。
  
# 変数設定
  
```
_export:
  td:
    database: l1_juicer
  firsttime: true
  juicer_db: juicer_db #set juicer database
  target_month: ${moment(session_date).add(-2, 'month').format("YYYYMM")}
```
     
database: `データが出力されるDatabase名`
  
firsttime: `初回実行時：true 毎月実行時:false`
  
juicer_db: `Juicerから提供されるデータが入っているDatabase名` #set juicer database
  
target_month: `毎月変更されるTable名変数なので変更不要`
