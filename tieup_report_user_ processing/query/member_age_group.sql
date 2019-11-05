SELECT
  age_group AS member_age_group ,
  sex AS member_age_group_sex ,
  COUNT(1) AS member_age_group_cnt ,
  'member_age_group' AS label
FROM
  user_${td.each.db_client_name}_${td.each.db_label}
GROUP BY
  1,2
