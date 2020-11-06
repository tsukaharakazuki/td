SELECT
  os AS uaip_os ,
  vendor AS uaip_vendor ,
  os_version AS uaip_os_ver ,
  browser AS uaip_browser ,
  category AS uaip_category ,
  country AS uaip_country ,
  city AS uaip_city ,
  map_prefectures AS uaip_pf ,
  COUNT(*) AS uaip_cnt ,
  'uaip' AS label
FROM
  base_${td.each.db_client_name}_${td.each.db_label}
WHERE
  ${td.each.check_host_flag}td_host IN ('${td.each.check_host}') AND
  regexp_like(td_path,'${td.each.article_id}') AND
  TD_TIME_RANGE(time,
    '${td.each.start_date}',
    '${td.each.end_date}',
    'JST') 
WHERE
  session_num = 1
GROUP BY
  1,2,3,4,5,6,7,8,9
