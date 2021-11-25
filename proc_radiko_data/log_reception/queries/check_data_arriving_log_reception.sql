select
  count(*) > 0
from
  ${in_radiko_db}.in_listening_log_reception
WHERE
  TD_TIME_RANGE(time, '${moment(session_date).add(-1, "days").format("YYYY-MM-DD")} 05:00:00', '${session_date} 05:00:00', 'jst')
