WITH

s1 AS
(
SELECT
   time
  ,td_title
  ,td_description
  ,td_url
  ,td_global_id
  ,td_client_id
  ,regexp_extract(td_referrer , '^(.+?)://(.+?):?(\d+)?(/.*)?$', 2) AS ref_host
  ,td_referrer
  ,${user_id} AS user_id
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
  td_client_id <> 'undefined' AND
  TD_TIME_RANGE(time, TD_TIME_ADD(TD_SCHEDULED_TIME(), '-2d'), TD_SCHEDULED_TIME(), 'JST')
),

t1 AS (
SELECT
   time
  ,TD_SESSIONIZE_WINDOW(time, 900) OVER (PARTITION BY td_client_id ORDER BY time) AS session_id
  ,td_title
  ,td_description
  ,td_url
  ,td_client_id
  ,ref_host
  ,td_referrer
  ,user_id
FROM s1
),

t2 AS (
SELECT
   time
  ,row_number() over (partition by session_id order by time ASC) as older
  ,session_id
  ,td_title
  ,td_description
  ,td_url
  ,td_client_id
  ,ref_host
  ,td_referrer
  ,user_id
FROM t1
)

SELECT
   TD_TIME_PARSE(TD_TIME_FORMAT(time,'yyyy-MM-dd HH:00:00','JST')) AS time
  ,td_title
  ,td_description
  ,td_url
  ,td_client_id
  ,ref_host
  ,td_referrer
  ,user_id
  ,COUNT(td_client_id) AS cnt
FROM t2
WHERE older = 1
GROUP BY 1,2,3,4,5,6,7
