WITH

t1 AS
(
SELECT
   TD_TIME_PARSE(TD_TIME_FORMAT(time,'yyyy-MM-dd','JST')) AS time
  ,os
  ,vendor
  ,os_version
  ,browser
  ,category
  ,country
  ,city
  ,pf
  ,COUNT(*) AS uaip_cnt
FROM
  (
  SELECT
     time
    ,os
    ,vendor
    ,os_version
    ,browser
    ,category
    ,country
    ,city
    ,pf
    ,row_number() over (partition by session_id order by time DESC) AS newer
  FROM
    (
    SELECT
       time
      ,TD_SESSIONIZE_WINDOW(time, 1800) OVER (PARTITION BY td_client_id ORDER BY time) as session_id
      ,element_at(TD_PARSE_AGENT(td_user_agent), 'os') AS os
      ,element_at(TD_PARSE_AGENT(td_user_agent), 'vendor') AS vendor
      ,element_at(TD_PARSE_AGENT(td_user_agent), 'os_version') AS os_version
      ,element_at(TD_PARSE_AGENT(td_user_agent), 'name') AS browser
      ,element_at(TD_PARSE_AGENT(td_user_agent), 'category') AS category
      ,TD_IP_TO_COUNTRY_NAME(td_ip) AS country
      ,TD_IP_TO_CITY_NAME(td_ip) AS city
      ,TD_IP_TO_LEAST_SPECIFIC_SUBDIVISION_NAME(td_ip) AS pf
    FROM
      ${log_db}.${log_tb}
    WHERE
    td_host IN ('${check_host}') AND
    regexp_like(td_path,'${td.each.article_id}') AND
    TD_TIME_RANGE(time,
      TD_TIME_FORMAT(time,'${td.each.start_date}','JST'),
      TD_TIME_FORMAT(time,'${td.each.end_date}','JST'),
      'JST') AND
    TD_PARSE_AGENT(td_user_agent) ['category'] <> 'crawler' AND
    td_client_id != '00000000-0000-4000-8000-000000000000' AND
    NOT regexp_like(td_browser, '^(?:Googlebot(?:-.*)?|BingPreview|bingbot|YandexBot|PingdomBot)$') AND
    td_host != 'gtm-msr.appspot.com' AND
    td_client_id is not NULL AND
    td_client_id <> 'undefined'
    )
  )
WHERE
  newer = 1
GROUP BY 1,2,3,4,5,6,7,8,9
)

SELECT
   a.time
  ,a.os AS uaip_os
  ,a.uaip_cnt
  ,a.vendor AS uaip_vendor
  ,a.os_version AS uaip_os_ver
  ,a.browser AS uaip_browser
  ,a.category AS uaip_category
  ,a.country AS uaip_country
  ,a.city AS uaip_city
  ,a.pf AS uaip_pf
  ,b.div_name_en AS uaip_div_name_en
  , 'uaip' AS label
FROM
  t1 AS a
LEFT JOIN ${dev_mst_db}.${dev_mst_tb} AS b
ON a.pf = b.div_name_jp
