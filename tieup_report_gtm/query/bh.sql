SELECT
   time
  ,td_platform
  ,td_title
  ,td_browser
  ,td_description
  ,td_path
  ,td_user_agent
  ,td_global_id
  ,td_ip
  ,td_client_id
  ,td_os
  ,td_host
  ,td_url
  ,td_referrer
  -- ,COALESCE(NULLIF(${user_id},''), NULL) AS user_id
FROM
  ${log_db}.${log_tb}
WHERE
  td_host IN ('${check_host}') AND
  TD_TIME_RANGE(time,
    '${td.each.start_date}',
    '${td.each.end_date}',
    'JST') AND
  td_client_id IN
  (
  SELECT
    DISTINCT td_client_id
  FROM
    ${log_db}.${log_tb}
  WHERE
    regexp_like(td_path,'${td.each.article_id}') AND
    TD_TIME_RANGE(time,
      TD_TIME_FORMAT(time,'${td.each.start_date}','JST'),
      TD_TIME_FORMAT(time,'${td.each.end_date}','JST'),
      'JST') AND
    TD_PARSE_AGENT(td_user_agent) ['category'] <> 'crawler' AND
    td_client_id != '00000000-0000-4000-8000-000000000000' AND
    NOT regexp_like(td_browser, '^(?:Googlebot(?:-.*)?|BingPreview|bingbot|YandexBot|PingdomBot)$') AND
    td_host != 'gtm-msr.appspot.com' AND
    td_client_id is not NULL AND
    td_client_id <> 'undefined'
  )
