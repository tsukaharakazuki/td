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
),


t3 AS
(
SELECT
  0 AS pc_rd_time_ky 
UNION
SELECT
  10 AS pc_rd_time_ky 
UNION
SELECT
  20 AS pc_rd_time_ky
UNION
SELECT
  30 AS pc_rd_time_ky 
UNION
SELECT
  40 AS pc_rd_time_ky 
UNION
SELECT
  50 AS pc_rd_time_ky 
UNION
SELECT
  60 AS pc_rd_time_ky 
UNION
SELECT
  70 AS pc_rd_time_ky 
UNION
SELECT
  80 AS pc_rd_time_ky
UNION
SELECT
  90 AS pc_rd_time_ky 
UNION
SELECT
  100 AS pc_rd_time_ky 
)


SELECT
  a.pc_rd_time_ky ,
  b.pc_rd_avg_browsing_time ,
  b.pc_rd_var_browsing_time ,
  b.label
FROM 
  t3 AS a
LEFT JOIN
  (
  SELECT
    CAST(read_depth AS bigint) AS pc_rd_time_ky,
    AVG(diff) AS pc_rd_avg_browsing_time,
    VARIANCE(diff) AS pc_rd_var_browsing_time ,
    'pc_rd_avg' AS label
  FROM 
    t2
  GROUP BY 
    1
  ) AS b
ON 
  a.pc_rd_time_ky = b.pc_rd_time_ky
