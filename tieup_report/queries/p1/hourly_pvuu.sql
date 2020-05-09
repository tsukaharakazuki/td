WITH

t1 AS
(
SELECT
  td_host ,
  TD_TIME_PARSE(TD_TIME_FORMAT(time,'yyyy-MM-dd HH:00:00','JST')) AS time ,
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
),


t2 AS
(
SELECT
  time ,
  TD_TIME_FORMAT(time, 'yyyy-MM-dd HH:mm:ss', 'JST') AS hour_date ,
  TD_TIME_FORMAT(time,'EEEE','JST') AS hour_day_of_the_week ,
  td_host AS hour_host,
  pv AS hour_pv ,
  uu AS hour_uu ,
  'hour_pvuu' AS label
FROM 
   t1
)


SELECT
  time ,
  hour_date ,
  CASE
    WHEN  hour_day_of_the_week = 'Monday' THEN '1_Monday'
    WHEN  hour_day_of_the_week = 'Tuesday' THEN '2_Tuesday'
    WHEN  hour_day_of_the_week = 'Wednesday' THEN '3_Wednesday'
    WHEN  hour_day_of_the_week = 'Thursday' THEN '4_Thursday'
    WHEN  hour_day_of_the_week = 'Friday' THEN '5_Friday'
    WHEN  hour_day_of_the_week = 'Saturday' THEN '6_Saturday'
    WHEN  hour_day_of_the_week = 'Sunday' THEN '7_Sunday'   
  END hour_day_of_the_week ,
  hour_host ,
  hour_pv ,
  hour_uu ,
  label
FROM 
   t2
