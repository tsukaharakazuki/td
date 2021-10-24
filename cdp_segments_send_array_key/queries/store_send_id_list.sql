SELECT
  time ,
  TD_TIME_FORMAT(time, 'yyyy-MM-dd', 'JST') AS send_date ,
  ${base_id_col} ,
  ${segment_name_col}
FROM
  ${cdp_segments_db}.${cdp_segments_tbl}