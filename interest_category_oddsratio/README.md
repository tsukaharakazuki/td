# はじめに

このWorkflowはodds比を用いて、ユーザー（or ブラウザ）に対して、アクセスログから興味関心の傾向値を算出します。

# digの変数設定
  
以下の変数を変更することで、それぞれの環境に合わせて算出が可能です。
  
```
_export:
  td:
    database: engagement_score
  log_db: sample_db
  log_tb: sample_tb
  user_id: userid
  cookie: td_client_id
  category_col: category
  article_col: td_path
  days: 28
  category_flag: 'ニュース','経済','エンタメ','スポーツ','国内','国際'
  check_host: sample.jp
```
  
|項目           |内容                               |
|--------------|-----------------------------------|
|log_db        |集計するトランザクションログが存在するDB    |
|log_tb        |集計するトランザクションログが存在するテーブル|
|user_id       |ユーザーIDカラム                      |
|cookie 　　　  |cookieカラム                         |
|category_col  |カテゴリ分類するカラム                   |
|article_col　 |記事カラム                           |
|days　　　　   |集計対象期間                         |
|category_flag　|カテゴリカラム内の分類するカテゴリ         |
|check_host　  |ホストを指定する場合                   |
 
