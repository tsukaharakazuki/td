WITH base AS (
  SELECT
    ${by_cate.colmuns} AS by_category ,
    ${media[params].key_id} AS device_id ,
    '${by_cate.category_type}' AS by_category_type ,
    '${media[params].key_id}' AS device_id_type ,
    CAST(TRUNCATE((MAX(time)- TO_UNIXTIME(now()))/ 86400) AS INT) AS recency ,
    COUNT(DISTINCT TD_TIME_FORMAT(time,'yyyy-MM-dd','JST')) AS frequency ,
    COUNT(${media[params].engagement_vols}) AS volume
    ${(Object.prototype.toString.call(media[params].add_engagement_calc.sql) === '[object Array]')?','+media[params].add_engagement_calc.sql.join():''}
  FROM
    ${media[params].calc_log_db}.${media[params].calc_log_tbl}
  WHERE
    ${by_cate.where_condition}
  GROUP BY
    1,2
)

SELECT
  * ,
  ntile(10) OVER (PARTITION BY by_category ORDER BY engagement_score DESC) AS decile
FROM (
  SELECT
    * ,
    log10(frequency * SQRT(volume)* (${td.last_results.progress} + recency + 1)) AS engagement_score
  FROM
    base
)
