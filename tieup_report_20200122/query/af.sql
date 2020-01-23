WITH

t0 AS
(
SELECT
   cdp_customer_id
  ,td_affinity_categorie
FROM
  cdp_audience_${master_segment}.customers 
CROSS JOIN 
   UNNEST(td_affinity_categories) AS t(td_affinity_categorie)
WHERE
  td_client_id IN
  (
  SELECT
    DISTINCT td_client_id
  FROM
    ${log_db}.${log_tb}
  WHERE
    regexp_like(td_path,'${td.each.article_id}') AND
    TD_TIME_RANGE(time,
      '${td.each.start_date}',
      '${td.each.end_date}',
      'JST') AND
    TD_PARSE_AGENT(td_user_agent) ['category'] <> 'crawler' AND
    td_client_id != '00000000-0000-4000-8000-000000000000' AND
    NOT regexp_like(td_browser, '^(?:Googlebot(?:-.*)?|BingPreview|bingbot|YandexBot|PingdomBot)$') AND
    td_host != 'gtm-msr.appspot.com' AND
    td_client_id is not NULL AND
    td_client_id <> 'undefined'
  )
),

t1 AS
(
SELECT
   COUNT(*) AS af_cnt
  ,td_affinity_categorie
  ,'' AS dum
FROM
  t0
GROUP BY 
   2
ORDER BY 
   1 DESC
)

SELECT
   af_cnt
  ,td_affinity_categorie AS af_name
  ,'af' AS label
FROM
  t1
