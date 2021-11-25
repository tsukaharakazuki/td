WITH t0 AS (
  SELECT 
    time ,
    ${td.last_results.set_columns}
  FROM
    ${in_db}.${in_tbl}
  WHERE
    TD_INTERVAL(time, '-1d/now', 'JST')
)

SELECT
  MAX(time) AS time ,
  ${td.last_results.set_columns}
FROM
  t0
GROUP BY
  ${td.last_results.set_columns}