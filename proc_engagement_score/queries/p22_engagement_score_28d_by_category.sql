WITH base AS (
  SELECT
    ${by_cate.colmuns} ,
    ${media[params].key_id} AS device_id ,
    '${media[params].key_id}' AS device_id_type ,
    CAST(TRUNCATE((MAX(time)- TO_UNIXTIME(now()))/ 86400) AS INT) AS recency ,
    COUNT(DISTINCT TD_TIME_FORMAT(time,'yyyy-MM-dd','JST')) AS frequency ,
    COUNT(${media[params].engagement_vols}) AS volume
    ${(Object.prototype.toString.call(media[params].add_engagement_calc.sql) === '[object Array]')?','+media[params].add_engagement_calc.sql.join():''}
  FROM
    ${media[params].calc_log_db}.${media[params].calc_log_tbl}
  WHERE
    TD_TIME_RANGE(time,
      TD_TIME_FORMAT(CAST(TO_UNIXTIME(now()) AS BIGINT)- (60 * 60 * 24 * 7 * 4), 'yyyy-MM-dd', 'JST'),
      TD_TIME_FORMAT(CAST(TO_UNIXTIME(now()) AS BIGINT)- (60 * 60 * 24 * 1), 'yyyy-MM-dd', 'JST')
    )
    AND ${by_cate.colmuns} is not NULL
    AND ${by_cate.colmuns} <> ''
  GROUP BY
    1,2
)

SELECT
  * ,
  ntile(10) OVER (ORDER BY engagement_score DESC) AS decile
FROM (
  SELECT
    * ,
    log10(frequency * SQRT(volume)* (28 + recency + 1)) AS engagement_score
  FROM
    base
)