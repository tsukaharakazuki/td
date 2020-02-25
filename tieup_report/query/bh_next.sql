WITH

t1 AS
(
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
  --,COALESCE(NULLIF(${user_id},''), NULL) AS user_id
FROM
  ${log_db}.${log_tb}
WHERE
  td_host IN ('${td.each.check_host}') AND
  regexp_like(td_referrer,'${td.each.article_id}') AND
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
      '${td.each.start_date}',
      '${td.each.end_date}',
      'JST') AND
    TD_PARSE_AGENT(td_user_agent) ['category'] <> 'crawler' AND
    td_client_id != '00000000-0000-4000-8000-000000000000' AND
    NOT regexp_like(td_browser, '^(?:Googlebot(?:-.*)?|BingPreview|bingbot|YandexBot|PingdomBot)$') AND
    td_host != 'gtm-msr.appspot.com' AND
    td_client_id is not NULL AND
    td_client_id <> 'undefined'
  )
),

t2 AS
(
SELECT
   time
  ,TD_SESSIONIZE_WINDOW(time, 900) OVER (PARTITION BY td_client_id ORDER BY time) AS session_id
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
  --,COALESCE(NULLIF(${user_id},''), NULL) AS user_id
FROM t1
),

t3 AS
(
SELECT
   time
  ,row_number() over (partition by session_id order by time ASC) as older
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
  --,COALESCE(NULLIF(${user_id},''), NULL) AS user_id
FROM t2
)

SELECT
  bh_next_title ,
  bh_next_cnt ,
  label 
FROM
  (
  SELECT
    bh_next_title ,
    bh_next_cnt ,
    label ,
    RANK() OVER(PARTITION BY label ORDER BY bh_next_cnt DESC) AS rnk
  FROM
    (
    SELECT
      td_title AS bh_next_title ,
      COUNT(*) AS bh_next_cnt ,
      'bh_next' AS label
    FROM
      t3
    WHERE
      NOT regexp_like(td_url,'${td.each.article_id}')
      AND older = 1
    GROUP BY 
      1
    )
  )
WHERE
  rnk <= 200
