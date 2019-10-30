SELECT
  duration_range ,
  sex AS duration_range_sex ,
  COUNT(1) AS duration_range_cnt ,
  'duration_range' AS label
FROM 
  user_mst
GROUP BY 
  1,2
