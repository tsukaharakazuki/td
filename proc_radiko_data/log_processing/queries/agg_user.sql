SELECT
  user_key_hash AS user_key ,
  MAX_BY(gender, time) AS gender ,
  MAX_BY(is_male, time) AS is_male ,
  MAX_BY(member_type, time) AS member_type ,
  MAX_BY(age, time) AS age ,
  MAX_BY(area, time) AS area 
FROM
  ${in_radiko_db}.in_user
GROUP BY
  1