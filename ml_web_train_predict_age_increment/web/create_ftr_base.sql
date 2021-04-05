select
  ${uid} AS uid ,
  ${key_cookie} AS cookie ,
  td_os ,
  td_host ,
  td_path 
from
  ${access_log_db}.${access_log_tb}
where
  td_time_range(time, 
    '${moment(date).add(-1 * ml.n_days, "days").format("YYYY-MM-DD")}', 
    '${date}', 
    'JST')