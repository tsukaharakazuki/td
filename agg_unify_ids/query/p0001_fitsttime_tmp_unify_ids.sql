WITH basic AS (
  SELECT
    time ,
    td_host AS basic_host ,
    cookie AS basic_cookie ,
    td_ip ,
    td_user_agent 
  FROM
    ${log_db}.${log_tbl}
  WHERE
    td_ref_host <> ''
    AND session_num = 1
)

, referer AS (
  SELECT
    time ,
    td_host AS referer_host ,
    cookie AS referer_cookie ,
    td_ip ,
    td_user_agent ,
    url_extract_host(click_url) AS click_host 
  FROM
    ${log_db}.${click_log_tbl}
  WHERE
    url_extract_host(click_url) <> ''
)

SELECT
  a.basic_host ,
  a.basic_cookie ,
  b.referer_host ,
  b.referer_cookie ,
  a.td_ip ,
  a.td_user_agent 
FROM
  basic a
INNER JOIN
  referer b
ON
  a.basic_host = b.click_host
  AND a.basic_cookie <> b.referer_cookie
  AND a.td_ip = b.td_ip
  AND a.td_user_agent = b.td_user_agent
  AND a.time - b.time BETWEEN 0 AND 20