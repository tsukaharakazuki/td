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
GROUP BY 1,2
 ),


t2 AS
(
SELECT
  h,
  AVG(pv) AS avg_pv ,
  AVG(uu) AS avg_uu ,
  AVG(pv) + SQRT(VARIANCE(pv)) as upper,
  AVG(pv) - SQRT(VARIANCE(pv)) as lower
FROM 
  t1
GROUP BY 
  1
),


u1 AS
(
SELECT
  root_id ,
  TD_TIME_FORMAT(MIN_BY(time,time), 'yyyyMMdd', 'JST') AS d ,
  TD_TIME_FORMAT(MIN_BY(time,time), 'HH', 'JST') AS h ,
  max(read_rate) AS max_rd
FROM
  rd_${td.each.db_client_name}_${td.each.db_label}
WHERE
  regexp_like(td_path,'${td.each.article_id}')
GROUP BY 
  1
ORDER BY 
  1,2,3
),


u2 AS
(
SELECT
  h,
  AVG(max_rd) AS avg_rd
FROM 
  u1
GROUP BY 
  1
)


SELECT
  a.h AS avg_hour ,
  a.avg_pv ,
  a.avg_uu ,
  a.upper AS avg_upper ,
  a.lower AS avg_lower ,
  b.avg_rd ,
  'avg_hour' AS label
FROM 
  t2 AS a
LEFT JOIN 
  u2 AS b
ON 
  a.h = b.h
