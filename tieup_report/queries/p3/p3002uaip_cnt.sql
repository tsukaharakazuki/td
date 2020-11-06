SELECT
  uaip_${indicator} ,
  label ,
  SUM(uaip_cnt) AS uaip_${indicator}_cnt
FROM 
  uaip_${td.each.db_client_name}_${td.each.db_label}
GROUP BY
  1,2
