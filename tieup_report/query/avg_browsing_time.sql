WITH

t1 AS
(
SELECT
  article_id,
  AVG(browsing_time) AS avg_browsing_time,
  VARIANCE(browsing_time) AS var_browsing_time
FROM
(
  SELECT
    article_id ,
    1.0*diff AS browsing_time
  FROM
  (
    -- URLを整形 (presto) --
    SELECT
      td_path AS article_id ,
      LEAD(time) OVER (PARTITION BY td_client_id ORDER BY time) - time AS diff
    FROM ${log_db}.${log_tb}
    WHERE
      td_host IN ('${td.each.check_host}') AND
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
    ORDER BY time
  ) t1
  WHERE 1.0*diff < 600
) t
GROUP BY article_id
ORDER BY avg_browsing_time DESC
)

SELECT
  avg_browsing_time ,
  var_browsing_time ,
  'avg_browsing_time' AS label
FROM t1
