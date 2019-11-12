SELECT
  age AS member_age,
  sex AS member_age_sex ,
  COUNT(1) AS member_age_cnt ,
  'attribute' AS label
FROM
  user_${td.each.db_client_name}_${td.each.db_label}
GROUP BY
  1,2
