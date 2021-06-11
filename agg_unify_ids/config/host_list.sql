SELECT 
  basic_host AS host , 
  REPLACE(
    REPLACE(basic_host, '.', '_')
  , '-', '_') 
  AS host_name 
FROM 
  tmp_unify_ids 
GROUP BY 
  basic_host