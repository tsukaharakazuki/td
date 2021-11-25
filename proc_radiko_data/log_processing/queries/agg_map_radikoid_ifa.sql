SELECT
  radiko_id ,
  device ,
  ifa ,
  MAX(last_access_time) AS last_access_time ,
  MAX(TD_TIME_PARSE(last_access_time, 'JST')) AS time
FROM
  ${in_radiko_db}.in_map_radikoid_ifa
GROUP BY
  1,2,3