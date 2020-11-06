SELECT
  COUNT(*) AS c_4_cnt ,
  '${td.each.c_4}' AS c_4 ,
  'abcd1234' AS id
FROM
  ${click_db}.${click_tb}
WHERE
  ${td.each.check_host_flag}td_host IN ('${td.each.check_host}') AND
  regexp_like(td_path,'${td.each.article_id}') AND
  ${click_col} <> '' AND
  regexp_like(${click_col},'${td.each.c_4}') AND
  TD_TIME_RANGE(time,
    '${td.each.start_date}',
    '${td.each.end_date}',
    'JST')
