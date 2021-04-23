WITH t0 AS (
  SELECT
    cookie AS device_id,
    'cookie' AS id_type,
    CAST(
      floor((MAX(time)- TD_SCHEDULED_TIME())/ 86400) 
    AS INT) AS recency,
    COUNT(DISTINCT TD_TIME_FORMAT(time,'yyyy-MM-dd','JST')) AS frequency,
    COUNT(DISTINCT td_path) AS volume
  FROM
    agg_weblog_all
  GROUP BY
    1
)

, score_table AS (
  SELECT
    device_id,
    id_type,
    recency,
    frequency,
    volume,
    log10(frequency * SQRT(volume)* (365 + recency + 1)) AS engagement_score
  FROM
    t0
)

-- DIGDAG_INSERT_LINE

SELECT
  device_id,
  id_type,
  recency,
  frequency,
  volume,
  engagement_score
FROM
  score_table
