SELECT
  ${indicator}
FROM
  base
WHERE
  TD_TIME_RANGE(
    time , 
    NULL , 
    TD_TIME_PARSE(CAST(DATE_ADD('month', ${i}, CAST(TD_TIME_FORMAT(TD_TIME_PARSE('${target_start}', 'JST'), 'yyyy-MM-dd', 'JST') as date)) AS VARCHAR)) , 
    'JST'
    )
GROUP BY
  1