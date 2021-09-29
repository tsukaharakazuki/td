SELECT
  time ,
  td_global_id ,
  CAST(age_estimate AS bigint) AS age_estimate ,
  CAST(sex_estimate AS bigint) AS sex_estimate ,
  CASE 
    WHEN sex_estimate = '1' THEN 'M' 
    WHEN sex_estimate = '2' THEN 'F' 
    ELSE NULL
  END AS flg_sex_estimate ,
  CAST(age_confirm AS bigint) AS age_confirm ,
  CAST(sex_confirm AS bigint) AS sex_confirm ,
  CASE 
    WHEN sex_confirm = '1' THEN 'M' 
    WHEN sex_confirm = '2' THEN 'F' 
    ELSE NULL
  END AS flg_sex_confirm ,
  CAST(pref_id AS bigint) AS pref_id ,
  pref_name_ja
FROM
  ${juicer_db}.juicer_user_data_202010

--202102（上）と202103（下）でデータ型が異なるカラムが存在します。上下２つのSQLを使い分けて記載してください。

UNION ALL

SELECT
  time ,
  td_global_id ,
  age_estimate ,
  sex_estimate ,
  CASE 
    WHEN sex_estimate = 1 THEN 'M' 
    WHEN sex_estimate = 2 THEN 'F' 
    ELSE NULL
  END AS flg_sex_estimate ,
  age_confirm ,
  sex_confirm ,
  CASE 
    WHEN sex_confirm = 1 THEN 'M' 
    WHEN sex_confirm = 2 THEN 'F' 
    ELSE NULL
  END AS flg_sex_confirm ,
  pref_id ,
  pref_name_ja
FROM
  ${juicer_db}.juicer_user_data_202103

--下に初回テーブル分をUNION