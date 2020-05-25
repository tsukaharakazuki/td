SELECT
  ${counts.designation} ,
  COUNT(*) AS ${counts.designation}_cnt ,
  '${counts.designation}' AS label
FROM
  user_mst
GROUP BY
  1
