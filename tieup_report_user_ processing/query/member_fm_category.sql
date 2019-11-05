SELECT
  fm_category  AS member_fm_category ,
  sex AS member_fm_sex ,
  COUNT(1) AS member_fm_category_cnt ,
  'member_fm_category' AS label
FROM
  user_${td.each.db_client_name}_${td.each.db_label}
GROUP BY
  1,2
