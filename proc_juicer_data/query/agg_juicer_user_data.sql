SELECT
  td_global_id ,
  MAX_BY(age_estimate , time) AS age_estimate ,
  MAX_BY(sex_estimate , time) AS sex_estimate ,
  MAX_BY(flg_sex_estimate , time) AS flg_sex_estimate ,
  MAX_BY(age_confirm , time) AS age_confirm ,
  MAX_BY(sex_confirm , time) AS sex_confirm ,
  MAX_BY(flg_sex_confirm , time) AS flg_sex_confirm ,
  MAX_BY(pref_id , time) AS pref_id ,
  MAX_BY(pref_name_ja , time) AS pref_name_ja 
FROM
  union_juicer_user_data
GROUP BY
  1