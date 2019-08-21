WITH

t0 AS
(
SELECT
   time
  ,td_client_id
  ,${user_id} AS user_id
  ,td_host
  ,td_title
FROM
  ${log_database}.${log_table}
WHERE
  --td_host IN ('${check_host}') AND
  TD_TIME_RANGE(time, td_time_format(TD_SCHEDULED_TIME(), 'yyyy-MM-dd', 'JST'), NULL, 'JST') AND
  TD_PARSE_AGENT(td_user_agent) ['category'] <> 'crawler' AND
  td_client_id != '00000000-0000-4000-8000-000000000000' AND
  NOT regexp_like(td_browser, '^(?:Googlebot(?:-.*)?|BingPreview|bingbot|YandexBot|PingdomBot)$') AND
  td_host != 'gtm-msr.appspot.com' AND
  td_client_id is not NULL AND
  td_client_id <> 'undefined'
  --AND NOT REGEXP_LIKE (url_extract_host(td_referrer) ,'${ref_exception}')
),

t1 AS
(
SELECT
   td_title
  ,td_host
  ,COUNT(*) AS pv
  ,COUNT(DISTINCT td_client_id) AS uu
  ,COUNT(user_id) AS login_pv
  ,COUNT(DISTINCT user_id) AS login_uu
FROM
  t0
GROUP BY 1,2
)

SELECT
   rnk
  ,td_title
  ,pv
  ,uu
  ,login_pv
  ,login_uu
FROM
  (
  SELECT
     row_number() over (order by pv desc) as rnk
    ,td_title
    ,pv
    ,uu
    ,login_pv
    ,login_uu
  FROM
    t1
  )
WHERE rnk <= 100
