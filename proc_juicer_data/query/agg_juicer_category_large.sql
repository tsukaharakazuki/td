SELECT
  td_global_id ,
  category_id_large ,
  category_name ,
  MAX_BY(action_type , time) AS action_type ,
  MAX_BY(action_type_name , time) AS action_type_name ,
  MAX_BY(cv_times , time) AS cv_times 
FROM
  union_juicer_category_large
GROUP BY
  1,2,3