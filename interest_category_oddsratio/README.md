# はじめに

このWorkflowはodds比を用いて、ユーザー（or ブラウザ）に対して、アクセスログから興味関心の傾向値を算出します。
  
# odds比
   
・ オッズ
  
ある事象の起こる確率を`p`として、`p/(1 − p)`の値をいう。
  
・ オッズ比
  
オッズ比はある事象の、1つの群ともう1つの群とにおけるオッズの比として定義される。事象の両群における確率を p（第1群）、q（第2群）とすれば、オッズ比は
  
![odds](https://github.com/tsukaharakazuki/image/blob/master/oddsratio.png?raw=true "odds")
  
オッズ比が1とは、対象とする条件あるいは事象の起こりやすさが両群で同じということであり、1より大きい（小さい）とは、条件あるいは事象が第1群（第2群）でより起こりやすいということである。オッズ比は必ず0以上である。第1群（第2群）のオッズが0に近づけばオッズ比は0（∞）に近づく。
  
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
 
