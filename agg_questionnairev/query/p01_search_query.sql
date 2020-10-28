SELECT 
  ARRAY_JOIN(
    ARRAY_AGG(
        column_name
      ),
      ','
  ) AS sql_contents
FROM
  information_schema.columns
WHERE
  table_schema = '${enq_db}'
  AND table_name = 'loop_column_${enq_name}'
GROUP BY
  table_name