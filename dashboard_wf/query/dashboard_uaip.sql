WITH

t1 AS
(
SELECT
   TD_TIME_PARSE(TD_TIME_FORMAT(time,'yyyy-MM-dd','JST')) AS time
  ,td_host
  ,os
  ,vendor
  ,os_version
  ,browser
  ,category
  ,country
  ,city
  ,pf
  ,COUNT(os) AS count_os
  ,COUNT(vendor) AS count_vendor
  ,COUNT(os_version) AS count_os_version
  ,COUNT(browser) AS count_browser
  ,COUNT(category) AS count_category
  ,COUNT(country) AS count_country
  ,COUNT(city) AS count_city
  ,COUNT(pf) AS count_pf
FROM
  (
  SELECT
     time
    ,td_host
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
      ,td_host
      ,element_at(TD_PARSE_AGENT(td_user_agent), 'os') AS os
      ,element_at(TD_PARSE_AGENT(td_user_agent), 'vendor') AS vendor
      ,element_at(TD_PARSE_AGENT(td_user_agent), 'os_version') AS os_version
      ,element_at(TD_PARSE_AGENT(td_user_agent), 'name') AS browser
      ,element_at(TD_PARSE_AGENT(td_user_agent), 'category') AS category
      ,TD_IP_TO_COUNTRY_NAME(td_ip) AS country
      ,TD_IP_TO_CITY_NAME(td_ip) AS city
      ,TD_IP_TO_LEAST_SPECIFIC_SUBDIVISION_NAME(td_ip) AS pf
    FROM
      ${log_database}.${log_table}
    WHERE
      --td_host IN ('${check_host}') AND
      --NOT REGEXP_LIKE (url_extract_host(td_referrer) ,'${ref_exception}') AND
      TD_PARSE_AGENT(td_user_agent) ['category'] <> 'crawler' AND
      td_client_id != '00000000-0000-4000-8000-000000000000'  AND
      NOT regexp_like(td_browser, '^(?:Googlebot(?:-.*)?|BingPreview|bingbot|YandexBot|PingdomBot)$') AND
      td_host != 'gtm-msr.appspot.com' AND
      td_client_id is not NULL AND
      td_client_id <> 'undefined' AND
      TD_TIME_RANGE(time, TD_TIME_ADD(TD_SCHEDULED_TIME(), '-300d'), TD_SCHEDULED_TIME(), 'JST')
    )
  )
WHERE newer = 1
GROUP BY 1,2,3,4,5,6,7,8,9,10
)

SELECT
   a.time
  ,a.td_host
  ,a.os
  ,a.count_os
  ,a.vendor
  ,a.count_vendor
  ,a.os_version
  ,a.count_os_version
  ,a.browser
  ,a.count_browser
  ,a.category
  ,a.count_category
  ,a.country
  ,a.count_country
  ,a.city
  ,a.count_city
  ,a.pf
  ,a.count_pf
  ,b.div_name_en
FROM t1 AS a
LEFT JOIN ${dev_mst_db}.${dev_mst_tb} AS b
ON a.pf = b.div_name_jp
