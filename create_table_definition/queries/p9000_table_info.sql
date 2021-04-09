SELECT
  database_name AS "データベース名" ,
  table_name AS "テーブル名"  ,
  column_name AS "カラム名"  ,
  data_type AS "データ型"  ,
  col_info AS "詳細"  ,
  sample AS "サンプルデータ"  ,
  ordinal_position AS "カラム順"  
FROM
  table_difinition
WHERE
  database_name = '${td.each.database_name}'
  AND table_name = '${td.each.table_name}'
ORDER BY
  ordinal_position ASC