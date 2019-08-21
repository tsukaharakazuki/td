WITH

t1 AS (
SELECT
  time
 ,td_client_id
 ,${user_id} AS user_id
FROM
  ${log_database}.${log_table}
WHERE
  --td_host IN ('${check_host}') AND
  --NOT REGEXP_LIKE (url_extract_host(td_referrer) ,'${ref_exception}') AND
  TD_TIME_RANGE(time, TD_TIME_ADD(TD_SCHEDULED_TIME(), '-80d'), TD_SCHEDULED_TIME(), 'JST') AND
  TD_PARSE_AGENT(td_user_agent) ['category'] <> 'crawler' AND
  td_client_id != '00000000-0000-4000-8000-000000000000' AND
  NOT regexp_like(td_browser, '^(?:Googlebot(?:-.*)?|BingPreview|bingbot|YandexBot|PingdomBot)$') AND
  td_host != 'gtm-msr.appspot.com' AND
  td_client_id is not NULL AND
  td_client_id <> 'undefined'
)

SELECT
 'yesterday' AS period
 ,COUNT(*) AS pv
 ,COUNT(DISTINCT td_client_id) AS uu
 ,COUNT(user_id) AS login_pv
 ,COUNT(DISTINCT user_id) AS login_uu
FROM t1
WHERE
  TD_INTERVAL(time, '-1d' ,'JST')
GROUP BY 1

UNION ALL

SELECT
 'this_week' AS period
 ,COUNT(*) AS pv
 ,COUNT(DISTINCT td_client_id) AS uu
 ,COUNT(user_id) AS login_pv
 ,COUNT(DISTINCT user_id) AS login_uu
FROM t1
WHERE
  TD_TIME_RANGE(time, 
    td_time_format(TD_SCHEDULED_TIME() - cast(td_time_format(TD_SCHEDULED_TIME(), 'u', 'JST') as integer) * 3600 * 24,
    'yyyy-MM-dd', 'JST'), NULL,
    'JST')
GROUP BY 1

UNION ALL

SELECT
 'last_week' AS period
 ,COUNT(*) AS pv
 ,COUNT(DISTINCT td_client_id) AS uu
 ,COUNT(user_id) AS login_pv
 ,COUNT(DISTINCT user_id) AS login_uu
FROM t1
WHERE
  TD_INTERVAL(time, '-1w' ,'JST')
GROUP BY 1

UNION ALL

SELECT
 'this_month' AS period
 ,COUNT(*) AS pv
 ,COUNT(DISTINCT td_client_id) AS uu
 ,COUNT(user_id) AS login_pv
 ,COUNT(DISTINCT user_id) AS login_uu
FROM t1
WHERE
  TD_TIME_RANGE(
     time,
     TD_TIME_FORMAT( TD_DATE_TRUNC('month',TD_SCHEDULED_TIME(),'JST'),'yyyy-MM-dd HH:mm:ss', 'JST'),
     TD_TIME_FORMAT( TD_SCHEDULED_TIME(),'yyyy-MM-dd HH:mm:ss', 'JST'),
     'JST'
   )
GROUP BY 1

UNION ALL

SELECT
 'last_month' AS period
 ,COUNT(*) AS pv
 ,COUNT(DISTINCT td_client_id) AS uu
 ,COUNT(user_id) AS login_pv
 ,COUNT(DISTINCT user_id) AS login_uu
FROM t1
WHERE
  TD_INTERVAL(time, '-1M' ,'JST')
GROUP BY 1
