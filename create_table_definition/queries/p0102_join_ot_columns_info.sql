SELECT
  a.database_name ,
  a.table_name ,
  a.column_name ,
  a.data_type ,
  IF(a.col_info is NULL ,b.col_info ,a.col_info) AS col_info ,
  IF(a.sample is NULL ,b.sample ,a.sample) AS sample ,
  a.ordinal_position 
FROM
  data_common a
LEFT JOIN
  ot_columns_info b
ON
  a.column_name = b.col_name
  AND a.database_name = b.database_name
  AND a.table_name = b.table_name