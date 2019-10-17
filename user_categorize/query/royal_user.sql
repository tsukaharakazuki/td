WITH

t0 AS
(
SELECT
  time ,
  CASE
    WHEN COUNT(td_client_id) OVER (PARTITION BY td_client_id , TD_TIME_FORMAT(time,'ww','JST')) >= ${pv_threshold} THEN 1
    ELSE 0
    END AS cntt ,
  td_client_id ,
  td_global_id ,
  ${user_id} AS user_id ,
  td_url ,
  td_host ,
  td_path ,
  td_ip ,
  td_user_agent ,
  TD_TIME_FORMAT(time,'yyyy','JST') AS year ,
  TD_TIME_FORMAT(time,'ww','JST') AS week_num
FROM ${log_db}.${log_tb}
WHERE
  TD_TIME_RANGE( time,
    NULL,
    TD_DATE_TRUNC('week',TD_SCHEDULED_TIME(),'JST'),
    'JST')
  AND TD_PARSE_AGENT(td_user_agent) ['category'] <> 'crawler'
  AND td_client_id != '00000000-0000-4000-8000-000000000000'
  AND not regexp_like(td_browser, '^(?:Googlebot(?:-.*)?|BingPreview|bingbot|YandexBot|PingdomBot)$')
  AND td_host != 'gtm-msr.appspot.com'
  AND td_client_id is not NULL
  AND td_client_id <> 'undefined'
  AND article_editor <> ''
),


t1 AS
(
SELECT
  td_client_id ,
  --user_id ,
  week_num
FROM
  (
    SELECT
      td_client_id ,
      --user_id ,
      week_num ,
      ROW_NUMBER() OVER (PARTITION BY td_client_id ORDER BY week_num DESC) AS rank
    FROM
    (
      SELECT
        td_client_id ,
        --user_id ,
        week_num
      FROM
        t0
      WHERE
        cntt = 1
      GROUP BY
        td_client_id ,
        week_num
    )
  )
WHERE
  rank = ${back_week}
)


SELECT
  td_client_id
  --,user_id 
FROM
  t1
WHERE
  week_num = TD_TIME_FORMAT(TD_TIME_ADD(TD_SCHEDULED_TIME(),'-${back_week}w','JST'),'ww','JST')
