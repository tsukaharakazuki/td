SELECT
  COUNT(1) AS table_record ,
  '${td.each.database_name}' AS database_name ,
  '${td.each.table_name}' AS table_name
FROM
  ${td.each.database_name}.${td.each.table_name}
