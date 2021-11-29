SELECT
  time ,
  TD_TIME_FORMAT(time, 'yyyy-MM-dd', 'JST') AS send_date ,
  segment_name ,
  brands ,
  ${list_id_col} AS ids 
FROM
  ${list_db}.${list_tbl}