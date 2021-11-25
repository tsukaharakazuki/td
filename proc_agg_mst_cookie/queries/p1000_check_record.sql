SELECT
  count(1) > 0
FROM
  ${in_db}.${in_tbl}
WHERE
  time > TD_DATE_TRUNC('day', ${session_unixtime}, 'JST')