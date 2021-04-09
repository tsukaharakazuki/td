SELECT
  a.database_name ,
  a.table_name ,
  a.column_name ,
  a.data_type ,
  b.col_info ,
  b.sample ,
  a.ordinal_position 
FROM
  tmp_information_schema a
LEFT JOIN
  common_columns_info b
ON
  a.column_name = b.col_name