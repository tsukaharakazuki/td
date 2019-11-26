SELECT
  uaip_div_name_en AS uaip_pf ,
  label ,
  SUM(uaip_cnt) AS uaip_pf_cnt
FROM 
  uaip_${td.each.db_client_name}_${td.each.db_label}
GROUP BY
  1,2
