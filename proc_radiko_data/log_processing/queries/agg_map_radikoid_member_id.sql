SELECT
  uid AS radiko_id ,
  user_key_hash AS user_key ,
  MAX(last_access_time) AS last_access_time ,
  MAX(TD_TIME_PARSE(last_access_time, 'JST')) AS time
FROM
  ${in_radiko_db}.in_map_radikoid_member_id
GROUP BY
  1,2