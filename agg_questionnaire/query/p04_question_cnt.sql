SELECT
  q${i + 1} ,
  COUNT(*) AS cnt ,
  'q${i + 1}' AS label
FROM
  agg_${enq_name}
GROUP BY
  1