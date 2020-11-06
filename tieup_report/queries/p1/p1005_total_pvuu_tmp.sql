SELECT
  td_host ,
  COUNT(*) AS pv ,
  COUNT(DISTINCT ${key_id}) AS uu ,
  'abcd1234' AS id 
FROM
  base_${td.each.db_client_name}_${td.each.db_label}
WHERE
  ${td.each.check_host_flag}td_host IN ('${td.each.check_host}') AND
  regexp_like(td_path,'${td.each.article_id}') AND
  TD_TIME_RANGE(time,
    '${td.each.start_date}',
    '${td.each.end_date}',
    'JST') 
GROUP BY
  1
