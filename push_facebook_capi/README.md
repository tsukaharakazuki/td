# はじめに  
Facebook conversion APIにTDのコネクタを使いデータを定期送信するWorkflowです。  

# 設定  
1. params.yml設定  
複数ブランドを持っている場合、この設定を追加していくことで送信する内容やコネクタを変えることができます。  
```
- brand_name: brand_a #任意
  log_db: brand_a_db #Dabtabase名
  log_tbl: brand_a_tbl #固定
  connector: brand_a_capi_connector #該当ブランドのCAPIコネクタ名
  cnv_conditions: (td_path='/ordercomplete' OR td_path='/thanks')
  event_name: Purchase
  currency: JPY
  action_source: website
  price_col: price
  email_col: email
  event_id_col: event_id
```
  
2. p0001_create_base_data.sql設定  
このSQLは顧客ごとに内容が変わると考えています。送信する値や、例えばemailアドレスは別のテーブルからJoinしないといけない場合があるなど、適宜変更する必要があります。  

3. p0010_insert_push_log.sql設定  
`2`で変更した最終アウトプットカラムと、送信日をStoreします。この処理は過去に遡ってどのようなCnvデータがFacebookに送信されたかを確認するために必要です。  

4. p9000_push_fb.sql設定  
このSQLも、実際送信したい値に変更してください。