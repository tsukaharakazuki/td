SELECT
  prefecture ,
  COUNT(1) AS prefecture_cnt ,
  'prefecture' AS label
FROM 
  user_mst
GROUP BY 
  1