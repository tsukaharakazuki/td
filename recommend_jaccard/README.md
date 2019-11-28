# はじめに
  
このWorkflowは、アクセスログの閲覧傾向から記事Aと記事Bに置ける閲覧の重なりを元に、記事同士の類似を係数化するものです。
  
# Jaccard係数
  
基礎となる集計はJaccard係数です。
  
<img src="https://github.com/tsukaharakazuki/image/blob/master/jaccard_1.png"
 alt="Jaccard" title="Jaccard" width="400" height="400" />
  
二つの記事の相関を測るにあたり、
  
`両方の記事を見たユニークユーザー / 両方の記事の閲覧総ユニークユーザー`
  
という計算式で係数を算出します。係数の最大は`1`で、`1`に近いほど類似している（同じユーザーが見ている）という判断が可能です。
　　
# digファイルの変数設定
  
以下の変数を変更することで、それぞれの環境に合わせて算出が可能です。
  
```
_export:
  td:
    database: recommend
  log_db: sample #set web_log database
  log_tb: sample #set web_log table
  days: 7
  base_pv_cnt: 1000
  article_id: td_path
  article_check: article_type
  cookie_type: td_client_id
```
  
|項目           |内容                               |
|--------------|-----------------------------------|
|log_db        |集計するトランザクションログが存在するDB    |
|log_tb        |集計するトランザクションログが存在するテーブル|
|days          |集計対象期間（日）                     |
|base_pv_cnt   |足切りPV数                          |
|article_id    |比較対象とするカラム                   |
|article_check |記事を特定できるカラムが存在する場合指定   |
|cookie_type   |集計対象cookie(ユーザーID)カラム       |
