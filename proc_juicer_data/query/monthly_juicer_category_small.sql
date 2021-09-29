SELECT
  time ,
  td_global_id ,
  category_id_small ,
  category_name ,
  action_type ,
  action_type_name ,
  cv_times
FROM
  ${juicer_db}.juicer_category_small_${target_month}