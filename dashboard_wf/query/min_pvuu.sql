SELECT
  td_host
 ,TD_TIME_PARSE(TD_TIME_FORMAT(time,'yyyy-MM-dd HH:mm:00','JST')) AS time
 ,COUNT(*) AS pv
 ,COUNT(DISTINCT td_client_id) AS uu
-- ,COUNT(user_id) AS login_pv
-- ,COUNT(DISTINCT user_id) AS login_uu
FROM
  (
  SELECT
     time
    ,td_client_id
    ,td_host
  -- ,${user_id} AS user_id
  FROM
    ${log_database}.${log_table}
  WHERE
    --td_host IN ('${check_host}') AND
    --NOT REGEXP_LIKE (url_extract_host(td_referrer) ,'${ref_exception}') AND
    TD_PARSE_AGENT(td_user_agent) ['category'] <> 'crawler' AND
    td_client_id != '00000000-0000-4000-8000-000000000000' AND
    NOT regexp_like(td_browser, '^(?:Googlebot(?:-.*)?|BingPreview|bingbot|YandexBot|PingdomBot)$') AND
    td_host != 'gtm-msr.appspot.com' AND
    td_client_id is not NULL AND
    td_client_id <> 'undefined'
    --↓２回目実行から有効化
    --AND TD_TIME_RANGE(time, TD_TIME_ADD(TD_SCHEDULED_TIME(), '-18m'), TD_TIME_ADD(TD_SCHEDULED_TIME(), '-8m'), 'JST')
  )
GROUP BY 1,2
