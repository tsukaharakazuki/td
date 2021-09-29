SELECT
  time ,
  td_global_id ,
  category_id_large ,
  category_name ,
  action_type ,
  action_type_name ,
  cv_times
FROM
  ${juicer_db}.juicer_category_large_${target_month}