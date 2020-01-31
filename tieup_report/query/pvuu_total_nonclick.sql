WITH

t1 AS
(
SELECT
   td_host
  ,COUNT(*) AS pv
  ,COUNT(DISTINCT td_client_id) AS uu
  --,COUNT(user_id) AS login_pv
  --,COUNT(DISTINCT user_id) AS login_uu
FROM
  (
  SELECT
     time
    ,td_client_id
    ,td_host
    --,COALESCE(NULLIF(${user_id},''), NULL) AS user_id
  FROM
    ${log_db}.${log_tb}
  WHERE
    td_host IN ('${check_host}') AND
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
GROUP BY 1
)

SELECT
  td_host AS total_pvuu_host,
  pv AS total_pv ,
  uu AS total_uu ,
  'total_pvuu' AS label
FROM t1
