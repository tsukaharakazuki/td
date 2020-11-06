WITH


base_this_month AS
(
  SELECT
    ${indicator}
  FROM
    base
  WHERE
    TD_TIME_RANGE(
      time , 
      TD_TIME_PARSE(CAST(DATE_ADD('month', ${i}, CAST(TD_TIME_FORMAT(TD_TIME_PARSE('${target_start}', 'JST'), 'yyyy-MM-dd', 'JST') as date)) AS VARCHAR)) , 
      TD_TIME_PARSE(CAST(DATE_ADD('month', ${i + 1}, CAST(TD_TIME_FORMAT(TD_TIME_PARSE('${target_start}', 'JST'), 'yyyy-MM-dd', 'JST') as date)) AS VARCHAR)) , 
      'JST'
      )
  GROUP BY
    1
)


SELECT
  COUNT(*) AS diff_cnt_cus_${indicator} ,
  CAST(DATE_ADD('month', ${i}, CAST(TD_TIME_FORMAT(TD_TIME_PARSE('${target_start}', 'JST'), 'yyyy-MM-dd', 'JST') as date)) AS VARCHAR) AS month
FROM
  (
    SELECT
      a.${indicator} ,
      b.${indicator} AS diff
    FROM
      base_this_month a
    LEFT JOIN
      tmp_diff_${indicator} b
    ON
      a.${indicator} = b.${indicator}
  )
WHERE
  diff is NULL
