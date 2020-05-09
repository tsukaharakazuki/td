WITH

t1 AS
(
SELECT
  TD_TIME_PARSE(TD_TIME_FORMAT(time,'yyyy-MM-dd','JST')) AS time ,
  os ,
  vendor ,
  os_version ,
  browser ,
  category ,
  country ,
  city ,
  pf ,
  COUNT(*) AS uaip_cnt
FROM
  (
  SELECT
    time ,
    os ,
    vendor ,
    os_version ,
    browser ,
    category ,
    country ,
    city ,
    pf ,
    row_number() OVER (PARTITION BY  io_session_id ORDER BY time ASC) AS older
  FROM
    (
    SELECT
      time ,
      TD_SESSIONIZE_WINDOW(time, 1800) OVER (PARTITION BY ${key_id} ORDER BY time) as io_session_id ,
      element_at(TD_PARSE_AGENT(td_user_agent), 'os') AS os ,
      element_at(TD_PARSE_AGENT(td_user_agent), 'vendor') AS vendor ,
      element_at(TD_PARSE_AGENT(td_user_agent), 'os_version') AS os_version ,
      element_at(TD_PARSE_AGENT(td_user_agent), 'name') AS browser ,
      element_at(TD_PARSE_AGENT(td_user_agent), 'category') AS category ,
      TD_IP_TO_COUNTRY_NAME(td_ip) AS country ,
      TD_IP_TO_CITY_NAME(td_ip) AS city ,
      TD_IP_TO_LEAST_SPECIFIC_SUBDIVISION_NAME(td_ip) AS pf
    FROM
      base_${td.each.db_client_name}_${td.each.db_label}
    WHERE
      ${td.each.check_host_flag}td_host IN ('${td.each.check_host}') AND
      regexp_like(td_path,'${td.each.article_id}') AND
      TD_TIME_RANGE(time,
        '${td.each.start_date}',
        '${td.each.end_date}',
        'JST') 
    )
  )
WHERE
  older = 1
GROUP BY
  1,2,3,4,5,6,7,8,9
)

SELECT
  a.time ,
  a.os AS uaip_os ,
  a.uaip_cnt ,
  a.vendor AS uaip_vendor ,
  a.os_version AS uaip_os_ver ,
  a.browser AS uaip_browser ,
  a.category AS uaip_category ,
  a.country AS uaip_country ,
  a.city AS uaip_city ,
  a.pf AS uaip_pf ,
  b.div_name_en AS uaip_div_name_en ,
  'uaip' AS label
FROM
  t1 AS a
LEFT JOIN
  ${dev_mst_db}.${dev_mst_tb} AS b
ON
  a.pf = b.div_name_jp
