SELECT
  age ,
  COUNT(1) AS age_cnt ,
  'age' AS label
FROM 
  user_mst
GROUP BY 
  1