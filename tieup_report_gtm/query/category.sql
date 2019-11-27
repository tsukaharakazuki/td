SELECT
  uaip_category ,
  label ,
  SUM(uaip_cnt) AS uaip_category_cnt
FROM 
  uaip_${td.each.db_client_name}_${td.each.db_label}
GROUP BY
  1,2