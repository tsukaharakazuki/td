SELECT 
  * 
FROM (
  VALUES 
    ('database1', 'table1', 'col1', '説明1', 'サンプルデータ') 
    , ('database1', 'table1', 'col2', '説明2', 'サンプルデータ') 
    , ('database1', 'table2', 'col1', '説明3', 'サンプルデータ') 
    , ('database1', 'table2', 'col2', '説明4', 'サンプルデータ') 
    --カラムが追加になったら以下をコピペして追加していく
    --入力例：, ('データベース名', 'テーブル名', 'カラム名', '説明', 'サンプルデータ') 
    --, ('', '', '', '', '') 
) as cols(database_name, table_name, col_name, col_info, sample);