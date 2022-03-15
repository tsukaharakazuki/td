WITH base AS (
  SELECT
    td_ms_id ,
    CAST(TRUNCATE((MAX(time)- TO_UNIXTIME(now()))/ 86400) AS INT) AS recency ,
    COUNT(DISTINCT TD_TIME_FORMAT(time,'yyyy-MM-dd','JST')) AS frequency ,
    COUNT(DISTINCT engagement_vols) AS volume
    ${(Object.prototype.toString.call(media[params].add_engagement_calc.columns) === '[object Array]')?','+media[params].add_engagement_calc.columns.join():''}
  FROM
    ${media[params].output_db}.l2_master_segment_behavior
  GROUP BY
    1
)

SELECT
  * ,
  ntile(10) OVER (ORDER BY engagement_score DESC) AS decile
FROM (
  SELECT
    * ,
    log10(frequency * SQRT(volume)* (${td.last_results.progress} + recency + 1)) AS engagement_score
  FROM
    base
)
