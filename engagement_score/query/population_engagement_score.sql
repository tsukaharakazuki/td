SELECT
  ROUND(engagement_score * 10) / 10 as score,
  COUNT(*) AS population
FROM
  engagement_score_${key_id}
GROUP BY
  1
;
