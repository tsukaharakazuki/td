SELECT
  * ,
  '${proc_dt}' AS proc_date
FROM
  ${env.db}.${env.tbl}
