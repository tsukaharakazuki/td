SELECT
  duration_days ,
  COUNT(1) AS duration_days_cnt ,
  'duration_days' AS label
FROM 
  user_mst
GROUP BY 
  1