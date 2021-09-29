SELECT
  time ,
  td_global_id ,
  age_estimate ,
  sex_estimate ,
  CASE 
    WHEN sex_estimate = '1' THEN 'M' 
    WHEN sex_estimate = '2' THEN 'F' 
    ELSE NULL
  END AS flg_sex_estimate ,
  age_confirm ,
  sex_confirm ,
  CASE 
    WHEN sex_confirm = '1' THEN 'M' 
    WHEN sex_confirm = '2' THEN 'F' 
    ELSE NULL
  END AS flg_sex_confirm ,
  pref_id ,
  pref_name_ja
FROM
  ${juicer_db}.juicer_user_data_${target_month}