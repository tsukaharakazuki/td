select
  count(*) > 0
from
  ${in_radiko_db}.in_user
where
  TD_DATE_TRUNC('day', time, 'JST')  = ${session_unixtime}
