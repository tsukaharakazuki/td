WITH

t1 AS
(
SELECT
  TD_TIME_FORMAT(time, 'yyyyMMdd', 'JST') AS d ,
  TD_TIME_FORMAT(time, 'HH', 'JST') AS h ,
  COUNT(*) AS pv ,
  COUNT(DISTINCT ${key_id}) AS uu
FROM
  base_${td.each.db_client_name}_${td.each.db_label}
WHERE
  ${td.each.check_host_flag}td_host IN ('${td.each.check_host}') AND
  regexp_like(td_path,'${td.each.article_id}') AND
  TD_TIME_RANGE(time,
    '${td.each.start_date}',
    '${td.each.end_date}',
    'JST') 
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
