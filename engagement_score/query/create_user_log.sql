WITH

base_log AS
(
SELECT
  time ,
  ${cookie} ,
  td_global_id ,
  td_referrer ,
  td_url ,
  td_host ,
  td_path ,
  td_title ,
  td_description ,
  td_ip ,
  td_user_agent ,
  td_browser 
FROM
  ${base_db}.${base_tb}
WHERE
  TD_INTERVAL(time, '-30d/now', 'JST')
)


SELECT
  a.time ,
  b.${key_id} ,
  a.${cookie} ,
  a.td_global_id ,
  a.td_referrer ,
  a.td_url ,
  a.td_host ,
  a.td_path ,
  a.td_title ,
  a.td_description ,
  a.td_ip ,
  a.td_user_agent ,
  a.td_browser 
FROM
  base_log a
INNER JOIN
  ${key_id}_${cookie}_map b
ON
  a.${cookie} = b.${cookie}