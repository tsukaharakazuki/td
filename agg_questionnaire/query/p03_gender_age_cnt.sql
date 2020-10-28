SELECT
  genderage_flag ,
  gender ,
  age_group ,
  gender||'_'||age_group AS genderage ,
  COUNT(*) AS cnt ,
  'genderage' AS label
FROM
  agg_${enq_name}
WHERE
  gender is not NULL
  AND age_group is not NULL
GROUP BY
  1,2,3,4