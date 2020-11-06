SELECT
  td_ref_name AS bh_ref_name ,
  COUNT(${key_id}) AS bh_ref_cnt ,
  COUNT(${key_id}) AS ref_pv ,
  COUNT(DISTINCT ${key_id}) AS ref_uu ,
  'bh_ref' AS label
FROM
  bh_${td.each.db_client_name}_${td.each.db_label}
WHERE
  ${td.each.check_host_flag}td_host IN ('${td.each.check_host}') AND
  regexp_like(td_path,'${td.each.article_id}') AND
  TD_TIME_RANGE(time,
    '${td.each.start_date}',
    '${td.each.end_date}',
    'JST') AND
  session_num = 1
GROUP BY 
  1
