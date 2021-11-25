WITH t0 AS (
  SELECT 
    time ,
    ${td.last_results.set_columns}
  FROM
    ${in_db}.${in_tbl}
)

SELECT
  MAX(time) AS time ,
  ${td.last_results.set_columns}
FROM
  t0
GROUP BY
  ${td.last_results.set_columns}