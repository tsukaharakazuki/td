SELECT
  ${counts.designation} ,
  COUNT(*) AS ${counts.designation}_cnt ,
  '${counts.designation}' AS label
FROM
  agg_user_mst
GROUP BY
  1
