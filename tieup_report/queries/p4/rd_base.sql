SELECT
  time ,
  ${key_id} ,
  td_title,
  td_host ,
  td_path ,
  td_user_agent ,
  td_sessionize_window(time, 600) OVER(PARTITION BY td_client_id,td_path ORDER BY time) AS root_id,
  ${rd_col} AS read_rate
FROM
  ${rd_db}.${rd_tb}
WHERE
  ${td.each.check_host_flag}td_host IN ('${td.each.check_host}') AND
  TD_TIME_RANGE(time,
    '${td.each.start_date}',
    '${td.each.end_date}',
    'JST') AND
  TD_PARSE_AGENT(td_user_agent) ['category'] <> 'crawler' AND
  td_client_id != '00000000-0000-4000-8000-000000000000' AND
  NOT regexp_like(td_browser, '^(?:Googlebot(?:-.*)?|BingPreview|bingbot|YandexBot|PingdomBot)$') AND
  td_host != 'gtm-msr.appspot.com' AND
  td_client_id is not NULL AND
  td_client_id <> 'undefined'
