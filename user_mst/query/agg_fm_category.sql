SELECT
  fm_category ,
  COUNT(1) AS fm_category_cnt ,
  'fm_category' AS label
FROM 
  user_mst
GROUP BY 
  1