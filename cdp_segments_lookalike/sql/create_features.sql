select
  cookie as uid
  ,td_path as ftr
  ,cast(count(*) as double) / sum(count(*)) over(partition by cookie) as val
from
  ${access_log_db}.${access_log_tb}
where
  td_time_range(time, '${moment(session_date).add(-1 * ml.n_days, "days").format("YYYY-MM-DD")}', '${session_date}', 'JST')
group by
  1,2

union all

select
  cookie as uid
  ,max_by(td_os, n) as ftr
  ,1 as val
from (
  select
    cookie
    ,td_os
    ,count(*) as n
  from
    ${access_log_db}.${access_log_tb}
  where
    td_time_range(time, '${moment(session_date).add(-1 * ml.n_days, "days").format("YYYY-MM-DD")}', '${session_date}', 'JST')
  group by
    1,2
) t
group by
  1

union all

select
  cookie as uid
  ,td_ref_name as ftr
  ,cast(count(*) as double) / sum(count(*)) over(partition by cookie) as val
from
  ${access_log_db}.${access_log_tb}
where
  td_time_range(time, '${moment(session_date).add(-1 * ml.n_days, "days").format("YYYY-MM-DD")}', '${session_date}', 'JST')
group by
  1,2

union all

select
  cookie as uid
  ,max_by(prefectures, n) as ftr
  ,1 as val
from (
  select
    cookie
    ,prefectures
    ,count(*) as n
  from
    ${access_log_db}.${access_log_tb}
  where
    td_time_range(time, '${moment(session_date).add(-1 * ml.n_days, "days").format("YYYY-MM-DD")}', '${session_date}', 'JST')
  group by
    1,2
) t
group by
  1