SELECT
  uaip_vendor ,
  label ,
  SUM(uaip_cnt) AS uaip_vendor_cnt
FROM 
  uaip_${td.each.db_client_name}_${td.each.db_label}
GROUP BY
  1,2
