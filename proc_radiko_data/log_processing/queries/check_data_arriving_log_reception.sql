SELECT
  count(*) > 0
FROM
  enriched_listening_log_reception
WHERE
  TD_TIME_RANGE(time, 
  '${moment(session_date).add(-1, "days").format("YYYY-MM-DD")} 05:00:00', 
  '${session_date} 05:00:00', 
  'JST')