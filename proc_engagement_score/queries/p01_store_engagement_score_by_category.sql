SELECT
  * ,
  ${by_cate.colmuns} AS by_category ,
  '${by_cate.colmuns}' AS by_category_type ,
  '${proc_dt}' AS proc_date
FROM
  ${env.db}.${env.tbl}