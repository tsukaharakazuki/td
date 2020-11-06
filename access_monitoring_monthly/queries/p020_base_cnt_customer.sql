SELEC
  TD_TIME_FORMAT(time, 'yyyy-MM-01', 'JST') AS month 
  , COUNT(DISTINCT td_client_id) AS cnt_td_client_id 
  , COUNT(DISTINCT td_global_id) AS cnt_td_global_id 
  ${check_google_gid}, COUNT(DISTINCT google_gid) AS cnt_google_gid 
  ${check_td_ssc_id}, COUNT(DISTINCT td_ssc_ud) AS cnt_td_ssc_ud
FROM
  base
WHERE
  TD_TIME_RANGE(
    time , 
    '${target_start}', 
    TD_SCHEDULED_TIME(), 
    'JST'
    )
GROUP BY
  1