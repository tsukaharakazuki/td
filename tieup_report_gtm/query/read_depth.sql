WITH

t1 AS
(
SELECT
  article_id,
  COUNT(*) AS "0",
  SUM(CASE
      WHEN (read_depth >= 10) THEN 1 ELSE 0 END) AS "10",
  SUM(CASE
      WHEN (read_depth >= 20) THEN 1 ELSE 0 END) AS "20",
  SUM(CASE
      WHEN (read_depth >= 30) THEN 1 ELSE 0 END) AS "30",
  SUM(CASE
      WHEN (read_depth >= 40) THEN 1 ELSE 0 END) AS "40",
  SUM(CASE
      WHEN (read_depth >= 50) THEN 1 ELSE 0 END) AS "50",
  SUM(CASE
      WHEN (read_depth >= 60) THEN 1 ELSE 0 END) AS "60",
  SUM(CASE
      WHEN (read_depth >= 70) THEN 1 ELSE 0 END) AS "70",
  SUM(CASE
      WHEN (read_depth >= 80) THEN 1 ELSE 0 END) AS "80",
  SUM(CASE
      WHEN (read_depth >= 90) THEN 1 ELSE 0 END) AS "90",
  SUM(CASE
      WHEN (read_depth = 100) THEN 1 ELSE 0 END) AS "100",
  SUM(instance) AS content_viewed
FROM
(
  SELECT
    td_path AS article_id ,
    root_id,
    max(read_rate) as read_depth,
    1 as instance
  FROM
    rd_${td.each.db_client_name}_${td.each.db_label}
  WHERE
    regexp_like(td_path,'${td.each.article_id}')
  GROUP BY
    td_path,
    root_id
)
GROUP BY
  article_id
)

SELECT '0' AS dp_key, "0" AS dp_value, 'rd' AS label FROM t1
UNION ALL
SELECT '10' AS dp_key, "10" AS dp_value, 'rd' AS label FROM t1
UNION ALL
SELECT '20' AS dp_key, "20" AS dp_value, 'rd' AS label FROM t1
UNION ALL
SELECT '30' AS dp_key, "30" AS dp_value, 'rd' AS label FROM t1
UNION ALL
SELECT '40' AS dp_key, "40" AS dp_value, 'rd' AS label FROM t1
UNION ALL
SELECT '50' AS dp_key, "50" AS dp_value, 'rd' AS label FROM t1
UNION ALL
SELECT '60' AS dp_key, "60" AS dp_value, 'rd' AS label FROM t1
UNION ALL
SELECT '70' AS dp_key, "70" AS dp_value, 'rd' AS label FROM t1
UNION ALL
SELECT '80' AS dp_key, "80" AS dp_value, 'rd' AS label FROM t1
UNION ALL
SELECT '90' AS dp_key, "90" AS dp_value, 'rd' AS label FROM t1
UNION ALL
SELECT '100' AS dp_key, "100" AS dp_value, 'rd' AS label FROM t1
