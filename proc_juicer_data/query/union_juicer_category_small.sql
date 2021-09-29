SELECT
  time ,
  td_global_id ,
  category_id_small ,
  category_name ,
  action_type ,
  action_type_name ,
  cv_times
FROM
  ${juicer_db}.juicer_category_small_202010

UNION ALL

SELECT
  time ,
  td_global_id ,
  category_id_small ,
  category_name ,
  action_type ,
  action_type_name ,
  cv_times
FROM
  ${juicer_db}.juicer_category_small_202011

--下に初回テーブル分をUNION