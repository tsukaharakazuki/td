select
  count(*) > 0
from
  ${in_radiko_db}.in_user
where
  time = ${session_unixtime}
