SELECT
  * ,
  UNIX_TIMESTAMP() AS td_proc_date
FROM
  ${apps[params].output_db}.tmp_agg_applog_first
