SELECT
  td_cookie ,
  td_client_id
FROM
  ${media[params].log_db}.${media[params].weblog_tbl}
--WHERE
--  td_cookie_type = 'td_ssc_id'
GROUP BY
  1,2