SELECT
  column_name AS column_contents
FROM
  information_schema.columns
WHERE
  table_schema = '${database}'
  AND table_name = 'mst_key'
  AND column_name <> 'key'
  AND column_name <> 'time'
  AND column_name NOT LIKE 'next_%'
GROUP BY
  column_name