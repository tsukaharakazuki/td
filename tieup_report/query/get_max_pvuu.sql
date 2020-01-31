SELECT 
  'SELECT '|| ARRAY_JOIN(
    ARRAY_AGG(
      'MAX('|| column_name|| ') AS '|| column_name
    ),
    ','
  )|| ' FROM '|| table_name|| ' GROUP BY id' AS sql_contents
FROM
  information_schema.columns
WHERE
  table_schema = '${database}'
  AND table_name = 'pvuu_total_tmp_${td.each.db_client_name}_${td.each.db_label}'
GROUP BY
  table_name
