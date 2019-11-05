SELECT
  sex AS member_sex,
  COUNT(1) AS member_sex_cnt ,
  'member_sex' AS label
FROM 
  user_${td.each.db_client_name}_${td.each.db_label}
GROUP BY 
  1