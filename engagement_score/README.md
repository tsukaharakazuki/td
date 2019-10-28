# はじめに
  
## エンゲージメントスコアの算出
  
このWorkflowはWebアクセス履歴を元に、ユーザーのエンゲージメントスコアを算出するものです。
  
![RFV](https://github.com/tsukaharakazuki/image/blob/master/rfv.png?raw=true "RFV")
　　
メディアごとに、細かい集計ロジックの調整は必要になりますが、ベースとなるデータを作成し、チューニングを楽にすることが可能です。
  
# 準備
  
`_export:`にてWF環境におけるデータ定義をする必要があります。

- サンプル
```
_export:
  td:
    database: engagement_score #結果を出力するDB
  log_db: sample_db #アクセスログが存在するDB
  log_tb: sample_tb #アクセスログTable
  cookie_1: td_client_id #1st Party cookieを指定
  cookie_2: td_global_id #3rd Party cookieを指定
  check_host: sample.jp #集計するデータのホストを指定（ない場合は記載しないでください）
  seg_score_accidental_low: 1 #エンゲージメントスコアを元にセグメントわけをする閾値（accidental -> low）
  seg_score_low_middle: 1.5 #エンゲージメントスコアを元にセグメントわけをする閾値（low -> middle）
  seg_score_middle_loyal: 2.3 #エンゲージメントスコアを元にセグメントわけをする閾値（middle -> loyal）
  multi_media_check: false #true or false / 一つのドメインで他メディア展開している場合trueに
```



