SELECT 
  table_schema AS database_name ,
  table_name 
FROM
  information_schema.columns
WHERE
  NOT regexp_like(table_schema,'cdp_audience')
  AND table_schema <> 'information_schema'
  --注意：他のWorkflowの実行タイミングなどで、中間テーブルなどが途中でDropされる場合エラーが出ることがあるので、モニタリング及スプレッドシート出力するテーブルは限定することを推奨
  AND table_schema = 'database1' --サンプルフィルタリング
GROUP BY
  1,2
ORDER BY
  1,2