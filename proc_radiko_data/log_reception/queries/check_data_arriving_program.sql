select
  count(*) > 0 
from
  ${in_radiko_db}.in_program
where
  date = '${moment(session_date).format("YYYYMMDD")}'
