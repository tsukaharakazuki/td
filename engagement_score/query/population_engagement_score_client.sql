SELECT
  ROUND(engagement_score * 10) / 10 as score,
  COUNT(*) AS population
FROM
  engagement_score_client
GROUP BY
  1
;
