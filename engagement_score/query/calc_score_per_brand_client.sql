WITH

score_table AS
(
SELECT
  device_id,
  id_type,
  media,
  recency,
  frequency,
  volume,
  log10(frequency * SQRT(volume)* (28 + recency + 1)) AS engagement_score
FROM
  (
  SELECT
    ${cookie_1} AS device_id,
    '${cookie_1}' AS id_type,
    split_part(td_path, '/', 2) AS media, --どこでパースするかはメディアごとに異なります。またメディアIDカラムがある場合メディアIDカラムをセット
    CAST(TRUNCATE((MAX(time)- TO_UNIXTIME(now()))/ 86400) AS INT) AS recency,
    COUNT(DISTINCT TD_TIME_FORMAT(time,'yyyy-MM-dd','JST')) AS frequency,
    COUNT(DISTINCT td_path) AS volume
  FROM
    ${log_db}.${log_tb}
  WHERE
    TD_TIME_RANGE(time,
      TD_TIME_FORMAT(CAST(TO_UNIXTIME(now()) AS BIGINT)- (60 * 60 * 24 * 7 * 4),'yyyy-MM-dd','JST'),
      TD_TIME_FORMAT(CAST(TO_UNIXTIME(now()) AS BIGINT)- (60 * 60 * 24 * 1),'yyyy-MM-dd','JST')
    )
    AND td_host = '${check_host}'
    AND TD_PARSE_AGENT(td_user_agent) ['category'] <> 'crawler'
    AND td_client_id != '00000000-0000-4000-8000-000000000000'
    AND NOT regexp_like(td_browser, '^(?:Googlebot(?:-.*)?|BingPreview|bingbot|YandexBot|PingdomBot)$')
    AND td_host != 'gtm-msr.appspot.com'
    AND td_client_id is not NULL
    AND td_client_id <> 'undefined'
  GROUP BY
    1,2,3
  )
)

SELECT
  device_id,
  id_type,
  ROW_NUMBER() OVER(PARTITION BY device_id　ORDER BY　engagement_score DESC) AS priority,
  media,
  recency,
  frequency,
  volume,
  engagement_score
FROM
  score_table
