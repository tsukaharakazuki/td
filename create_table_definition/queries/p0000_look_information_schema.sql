SELECT 
  table_schema AS database_name ,
  table_name ,
  column_name ,
  data_type ,
  ordinal_position 
FROM
  information_schema.columns
WHERE
  table_schema <> 'information_schema'