WITH t0 AS (
  SELECT
    td_cookie ,
    td_client_id
  FROM
    ${media[params].output_db}.tmp_l1_map_td_cookie_td_crient_id
  UNION ALL
  SELECT
    td_cookie ,
    td_client_id
  FROM
    ${media[params].log_db}.${media[params].weblog_tbl}
  WHERE 
    TD_INTERVAL(time, '-1d/now', 'JST')
  GROUP BY
    1,2
)

SELECT
  td_cookie ,
  td_client_id
FROM
  t0
GROUP BY
  1,2