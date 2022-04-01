SELECT
  * ,
  CAST(TO_UNIXTIME(NOW()) AS BIGINT)AS td_proc_date
FROM
  ${apps[params].output_db}.tmp_agg_applog_regular
