WITH

t1 AS
(
SELECT
  td_path AS article_id ,
  root_id ,
  read_rate ,
  1.0*MAX(time) OVER (PARTITION BY root_id) - 1.0*MIN(time) OVER (PARTITION BY root_id) AS diff
FROM
  rd_${td.each.db_client_name}_${td.each.db_label}
WHERE
  regexp_like(td_path,'${td.each.article_id}') AND
  TD_PARSE_AGENT(td_user_agent) ['category'] = 'pc'
),


t2 AS
(
SELECT
  article_id ,
  root_id ,
  CASE
    WHEN (read_depth = 0) THEN '0'
    WHEN (read_depth = 10) THEN '10'
    WHEN (read_depth = 20) THEN '20'
    WHEN (read_depth = 30) THEN '30'
    WHEN (read_depth = 40) THEN '40'
    WHEN (read_depth = 50) THEN '50'
    WHEN (read_depth = 60) THEN '60'
    WHEN (read_depth = 70) THEN '70'
    WHEN (read_depth = 80) THEN '80'
    WHEN (read_depth = 90) THEN '90'
    WHEN (read_depth = 100) THEN '100'
    ELSE NULL
  END AS read_depth ,
  diff ,
  instance
FROM
(
  SELECT
    article_id ,
    root_id,
    max(read_rate) as read_depth,
    diff ,
    1 as instance
  FROM
    t1
  WHERE
    diff <= 3600
  GROUP BY
    article_id ,
    root_id ,
    diff
)
)


SELECT
  read_depth AS pc_rd_time_ky ,
  AVG(diff) AS pc_rd_avg_browsing_time ,
  VARIANCE(diff) AS pc_rd_var_browsing_time ,
  'pc_rd_avg' AS label
FROM t2
GROUP BY 1
