WITH

t1 AS
(
SELECT
  TD_TIME_FORMAT(time, 'yyyyMMdd', 'JST') AS d ,
  TD_TIME_FORMAT(time, 'HH', 'JST') AS h ,
  COUNT(*) AS pv ,
  COUNT(DISTINCT td_client_id) AS uu
FROM
  ${log_db}.${log_tb}
WHERE
  td_host IN ('${td.each.check_host}') AND
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
GROUP BY 
  1,2
 )


SELECT
  h AS avg_hour ,
  AVG(pv) AS avg_pv ,
  AVG(uu) AS avg_uu ,
  AVG(pv) + SQRT(VARIANCE(pv)) AS avg_upper,
  AVG(pv) - SQRT(VARIANCE(pv)) AS avg_lower ,
  'avg_hour' AS label
FROM 
  t1
GROUP BY 
  1
