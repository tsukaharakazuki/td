WITH t0 AS (
  SELECT
    td_ms_id ,
    ${pred.colmuns} AS val ,
    CASE
      WHEN COUNT(*) = 1 THEN 'views_1'
      WHEN COUNT(*) BETWEEN 2 AND 5 THEN 'views_5'
      WHEN COUNT(*) BETWEEN 6 AND 15 THEN 'views_15'
      WHEN COUNT(*) BETWEEN 16 AND 30 THEN 'views_30'
      WHEN COUNT(*) BETWEEN 31 AND 50 THEN 'views_50'
      WHEN COUNT(*) >= 51 THEN 'views_over50'
    END key 
  FROM
    ${media[params].output_db}.l2_master_segment_behavior
  WHERE
    ${pred.colmuns} <> ''
    AND ${pred.colmuns} IS NOT NULL
  GROUP BY 
    1,2
)

, t1 AS (
  SELECT
    td_ms_id ,
    key ,
    ARRAY_AGG(val) AS vals
  FROM
    t0
  GROUP BY
    1,2
)


SELECT 
  td_ms_id,
  MAX(CASE WHEN key = 'views_1' THEN vals END) AS views_1_${pred.colmuns} ,
  MAX(CASE WHEN key = 'views_5' THEN vals END) AS views_5_${pred.colmuns} ,
  MAX(CASE WHEN key = 'views_15' THEN vals END) AS views_15_${pred.colmuns} ,
  MAX(CASE WHEN key = 'views_30' THEN vals END) AS views_30_${pred.colmuns} ,
  MAX(CASE WHEN key = 'views_50' THEN vals END) AS views_50_${pred.colmuns} ,
  MAX(CASE WHEN key = 'views_over50' THEN vals END) AS views_over50_${pred.colmuns}
FROM 
  t1
GROUP BY
  1
