SELECT
  TD_TIME_FORMAT(time, 'yyyy-MM-dd HH:mm:00', 'JST') AS tdi_time ,
  COUNT(*) AS pv ,
  COUNT(DISTINCT ${primary_cookie}) AS uu  ,
  COUNT(DISTINCT session_id) AS session ,
  '2days_ago' AS term 
FROM
  base
WHERE
  TD_TIME_RANGE(time, 
    TD_TIME_ADD(TD_SCHEDULED_TIME(),'-2d','JST'), 
    TD_TIME_ADD(TD_SCHEDULED_TIME(),'-1d','JST'), 
    'JST'
  )
GROUP BY
  1