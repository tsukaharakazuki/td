SELECT
  ROUND(engagement_score * 10) / 10 as score,
  COUNT(*) AS score_population ,
  ${key_id} AS score_key
FROM
  engagement_score_${key_id}
GROUP BY
  1
;
