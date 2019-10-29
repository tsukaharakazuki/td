SELECT
  sex ,
  COUNT(1) AS sex_cnt ,
  'sex' AS label
FROM 
  user_mst
GROUP BY 
  1