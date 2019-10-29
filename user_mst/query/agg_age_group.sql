SELECT
  age_group ,
  COUNT(1) AS age_group_cnt ,
  'age_group' AS label
FROM 
  user_mst
GROUP BY 
  1