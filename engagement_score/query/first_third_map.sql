SELECT
  ${key_id} ,
  td_global_id
FROM
  ${log_db}.${log_tb}
WHERE
  TD_INTERVAL(time, '-360d/now', 'JST')
GROUP BY
  1,2