# はじめに
  
## エンゲージメントスコアの算出
  
このWorkflowはWebアクセス履歴を元に、ユーザーのエンゲージメントスコアを算出するものです。
  
![RFV](https://github.com/tsukaharakazuki/image/blob/master/rfv.png?raw=true "RFV")
  
メディアごとに、細かい集計ロジックの調整は必要になりますが、ベースとなるデータを作成し、チューニングを楽にすることが可能です。
  
# 準備
  
`config/variables.dig`にてWF環境におけるデータ定義をしてください。

- サンプル
```
---
media:
  bland_name:
    media_name: sample
    output_db: td_sandbox
    calc_log_db: weblog_db
    calc_log_tbl: weblog_tbl
    # エンゲージメントスコア_KEY_IDカラム
    key_id: td_ssc_id
    # エンゲージメントスコア_ボリュームカラム
    engagement_vols: DISTINCT td_path 
    # エンゲージメントスコア出力追加設定
    add_engagement_calc:
      sql: 
        - ARRAY_AGG(DISTINCT ranking) FILTER(WHERE ranking IS NOT NULL) AS ranking
    # エンゲージメントスコア_カテゴリを分けた集計設定
    check_by_category: true
    by_category_dataset:
      - colmuns: item
        dest_db_name: item
        category_type: item
        where_condition: item is not NULL AND item <> ''
      - colmuns: item||' | '||category
        dest_db_name: item_category
        category_type: item_category
        where_condition: item is not NULL AND item <> '' AND category is not NULL AND category <> ''
```
  
1. 変更不要点  
`media:`  
は、  
`for_each>: params: ${Object.keys(media)}`  
の変数を取得しにいくKeyになっているため変更しない。  

1. for_each設定  
`bland_name:`  
複数のサイトログが別々のテーブルに入っている場合、この`bland_name`を変更して、以下の変数を変えたものを複製することで、同一WFで複数Tableを跨いだ処理が実行される。  

変数設定　　
| key | value |
----|---- 
|media_name|ブランド名、メディア名などを入力（英数小文字、_アンダーバーのみ）|
|output_db|出力されたデータが書き出させるデータベース名|
|calc_log_db|エンゲージメントスコアを計算するアクセスログが格納されているデータベース名|
|calc_log_tbl|エンゲージメントスコアを計算するアクセスログが格納されているテーブル名|
|key_id|cookieやモバイル広告IDなどエンゲージメントスコアを算出する最小粒度ID|
|engagement_vols|エンゲージメントスコア算出ロジックにおけるボリューム設定|
|add_engagement_calc|エンゲージメントスコアと一緒に集計処理したいカラムがある場合記入|
|check_by_category|true/false カテゴリごとのスコア計算を行う場合true|
|by_category_dataset|どのカラムをkeyとしてカテゴリ分解してスコア算出するか設定。複数存在する場合別々で処理実行|
  
# 出力されるデータ
  
- engagement_score_all
  
  アクセスログテーブルに入っているすべての期間分で集計したエンゲージメントスコア。
  
- engagement_score_28d
  
  直近28日分のアクセスログで集計したエンゲージメントスコア。
  
- engagement_score_all_by_category
  
  カテゴリーごとの集計をONにした場合生成される。アクセスログテーブルに入っているすべての期間分で集計したエンゲージメントスコア。
   
- engagement_score_28d_by_category
  
  カテゴリーごとの集計をONにした場合生成される。直近28日分のアクセスログで集計したエンゲージメントスコア。
  
