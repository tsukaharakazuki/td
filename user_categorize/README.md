# はじめに
  
このWorkflowは、ロイヤルユーザーを定義し、各種分析、セグメント抽出を簡単にするためのベース抽出をするものです。
  
# 域値設定
  
`user_categorize.dig`にて、各種期間を任意で設定してください。
  
```
_export:
  td:
    database: user_categorize
  log_db: web_db #set web_log database
  log_tb: web_tb #set web_log table
  user_id: user_id #set user_id column
  pv_threshold: 2 #毎週何PV以上接触している場合フラグを立てるか
  back_week: 4 #上記のPVを何週間連続で達成しているか
```
