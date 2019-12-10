WITH

t0 AS
(
SELECT
   cdp_customer_id
  ,td_interest_word
FROM
  cdp_audience_${master_segment}.customers CROSS JOIN UNNEST(td_interest_words) AS t(td_interest_word)
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
   COUNT(*) AS ky_cnt
  ,td_interest_word
  ,'' AS dum
FROM
  t0
GROUP BY
  2
ORDER BY
  1 DESC
),

t2 AS
(
SELECT
   ky_cnt
  ,td_interest_word
  ,RANK() OVER( PARTITION BY dum ORDER BY ky_cnt DESC) AS rnk
FROM
  t1
)

SELECT
   ky_cnt
  ,td_interest_word AS ky_name
  ,'ky' AS label
FROM
  t2
WHERE
  rnk <= 200
