SELECT
  a.time 
  , a.td_client_id 
  , a.td_global_id 
  ${check_td_ssc_id}, a.td_ssc_id 
  , b.google_gid
FROM
  ${base_log_db}.${base_log_tb} a
LEFT JOIN
  (
    SELECT
      ${check_google_gid} ,
      MAX(google_gid) AS google_gid
    FROM
      ${ggi_db}.${ggi_tb}
    GROUP BY
      1
  ) b
ON
  a.${gid_join_key} = b.${gid_join_key}
WHERE
  TD_TIME_RANGE(
    a.time , 
    '${target_start}', 
    TD_SCHEDULED_TIME() , 
    'JST'
    )