SELECT
  time 
  , td_client_id 
  , td_global_id 
  ${check_td_ssc_id}, td_ssc_id 
FROM
  ${base_log_db}.${base_log_tb} a
WHERE
  TD_TIME_RANGE(
    time , 
    '${target_start}', 
    TD_SCHEDULED_TIME() , 
    'JST'
    )