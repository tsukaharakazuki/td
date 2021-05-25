WITH avg AS (
  SELECT
    AVG(pv) AS pv_avg , --平均PVの1/3
    AVG(pv) / 3 AS avg_onetherd , --平均PVの1/3
    'a' AS dum
  FROM (
    SELECT
      TD_TIME_FORMAT(time, 'yyyy-MM-dd', 'JST') AS day ,
      COUNT(*) AS pv
    FROM
      ${brand.log_db}.${brand.log_tbl}
    WHERE
      TD_INTERVAL(time, '-3M/now', 'JST')
    GROUP BY
      1
    )
)

, yesterday AS (
  SELECT
    TD_TIME_FORMAT(time, 'yyyy-MM-dd', 'JST') AS check_date ,
    COUNT(*) AS pv_yesterday , 
    'a' AS dum
  FROM
    ${brand.log_db}.${brand.log_tbl}
  WHERE
    TD_INTERVAL(time, '-1d', 'JST')
  GROUP BY  1
)


SELECT
  b.check_date ,
  a.pv_avg ,
  a.avg_onetherd ,
  b.pv_yesterday ,
  CASE
    WHEN a.avg_onetherd > b.pv_yesterday THEN 'true'
    WHEN a.avg_onetherd <= b.pv_yesterday THEN 'false'
  END flag ,
  '${brand.brand_name}' AS brand_name
FROM
  avg a
INNER JOIN
  yesterday b
ON
  a.dum = b.dum