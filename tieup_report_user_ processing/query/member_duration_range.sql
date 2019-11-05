SELECT
  duration_range AS member_duration_range,
  sex AS member_duration_range_sex ,
  COUNT(1) AS member_duration_range_cnt ,
  'member_duration_range' AS label
FROM
  user_${td.each.db_client_name}_${td.each.db_label}
GROUP BY
  1,2
