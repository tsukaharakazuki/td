SELECT
  tmp_diff_days + 1 AS diff_days
FROM
  (
    SELECT
      date_diff(
        'month'
        ,cast(TD_TIME_FORMAT(TD_TIME_PARSE('${target_start}', 'JST'), 'yyyy-MM-dd', 'JST') as date)
        ,cast(TD_TIME_FORMAT(TD_SCHEDULED_TIME(), 'yyyy-MM-dd', 'JST') as date)
      ) AS tmp_diff_days
  )