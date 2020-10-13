SELECT
  TD_TIME_FORMAT(time, 'yyyy-MM-dd 00:00:00', 'JST') AS tdi_time ,
  COUNT(*) AS pv ,
  COUNT(DISTINCT ${primary_cookie}) AS uu ,
  COUNT(DISTINCT session_id) AS session 
FROM
  base
WHERE
  TD_INTERVAL(time, '-365d', 'JST')
GROUP BY
  1